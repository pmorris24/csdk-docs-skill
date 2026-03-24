================================================================================
# CROSS-FRAMEWORK EMBEDDING WORKFLOW REFERENCE
================================================================================

This section maps the core Compose SDK embedding workflow across React, Angular,
and Vue. All three frameworks support the same capabilities but use different
patterns (hooks vs services vs composables).

## The Core Embedding Workflow

The Compose SDK "decomposed dashboard" pattern has 4 steps:

1. **Fetch** a dashboard definition from Sisense by OID
2. **Translate** the dashboard model into framework-renderable widget props
3. **Render** individual widgets in your own custom layout
4. **Query** raw data via JAQL for custom components that aren't dashboard widgets

---

## Step 1: Fetch Dashboard Model

### React
```tsx
import { useGetDashboardModel } from '@sisense/sdk-ui';

const { dashboard, isLoading, isError } = useGetDashboardModel({
  dashboardOid: '69af2a2d88988f584e3ea433',
  includeWidgets: true,
  includeFilters: true,
});
```

dModel } from '@sisense/sdk-ui';

const { dashboard, isLoading, isError } = useGetDashboardModel({
  dashboardOid: '69af2a2d88988f584e3ea433',
  includeWidgets: true,
  includeFilters: true,
});
```

### Angular
```typescript
import { DashboardService, DashboardModel } from '@sisense/sdk-ui-angular';

@Component({ /* ... */ })
export class MyComponent implements OnInit {
  dashboardModel: DashboardModel | undefined;

  constructor(private dashboardService: DashboardService) {}

  async ngOnInit() {
    this.dashboardModel = await this.dashboardService.getDashboardModel(
      '69af2a2d88988f584e3ea433',
      { includeWidgets: true, includeFilters: true }
    );
  }
}
```

### Vue
```vue
<script setup lang="ts">
import { useGetDashboardModel } from '@sisense/sdk-ui-vue';

const { dashboard, isLoading, isError } = useGetDashboardModel({
  dashboardOid: '69af2a2d88988f584e3ea433',
  includeWidgets: true,
  includeFilters: true,
});
</script>
```

---

## Step 2: Translate to Renderable Props

### React
```tsx
import { dashboardModelTranslator, useComposedDashboard } from '@sisense/sdk-ui';

// Option A: Simple translation (no cross-filtering coordination)
const dashboardProps = dashboard
  ? dashboardModelTranslator.toDashboardProps(dashboard)
  : null;

// Option B: Composed dashboard (adds cross-filtering, drill coordination)
const { dashboard: composedDashboard, filters, setFilters } = useComposedDashboard({
  ...dashboardModelTranslator.toDashboardProps(dashboard),
});
```

ard (adds cross-filtering, drill coordination)
const { dashboard: composedDashboard, filters, setFilters } = useComposedDashboard({
  ...dashboardModelTranslator.toDashboardProps(dashboard),
});
```

### Angular
```typescript
import {
  DashboardService,
  dashboardModelTranslator,
  type DashboardProps,
} from '@sisense/sdk-ui-angular';

@Component({ /* ... */ })
export class MyComponent implements OnInit, OnDestroy {
  dashboardProps: DashboardProps | undefined;
  private composedDashboard: ReturnType<DashboardService['createComposedDashboard']> | undefined;
  dashboard$: Observable<DashboardProps> | undefined;

  constructor(private dashboardService: DashboardService) {}

  async ngOnInit() {
    const dashboardModel = await this.dashboardService.getDashboardModel(
      '69af2a2d88988f584e3ea433',
      { includeWidgets: true, includeFilters: true }
    );

    // Option A: Simple translation
    this.dashboardProps = dashboardModelTranslator.toDashboardProps(dashboardModel);

    // Option B: Composed dashboard (cross-filtering, drill coordination)
    const initialDashboard = dashboardModelTranslator.toDashboardProps(dashboardModel);
    this.composedDashboard = this.dashboardService.createComposedDashboard(initialDashboard);
    this.dashboard$ = this.composedDashboard.dashboard$;
  }

  ngOnDestroy() {
    this.composedDashboard?.destroy();
  }
}
```

rd = this.dashboardService.createComposedDashboard(initialDashboard);
    this.dashboard$ = this.composedDashboard.dashboard$;
  }

  ngOnDestroy() {
    this.composedDashboard?.destroy();
  }
}
```

### Vue
```vue
<script setup lang="ts">
import {
  useGetDashboardModel,
  useComposedDashboard,
  dashboardModelTranslator,
} from '@sisense/sdk-ui-vue';
import { computed } from 'vue';

const { dashboard } = useGetDashboardModel({
  dashboardOid: '69af2a2d88988f584e3ea433',
  includeWidgets: true,
  includeFilters: true,
});

// Option A: Simple translation
const dashboardProps = computed(() =>
  dashboard.value ? dashboardModelTranslator.toDashboardProps(dashboard.value) : null
);

// Option B: Composed dashboard
const { dashboard: composedDashboard, filters, setFilters } = useComposedDashboard({
  ...dashboardModelTranslator.toDashboardProps(dashboard.value),
});
</script>
```

---

## Step 3: Render Widgets in Custom Layout

composedDashboard, filters, setFilters } = useComposedDashboard({
  ...dashboardModelTranslator.toDashboardProps(dashboard.value),
});
</script>
```

---

## Step 3: Render Widgets in Custom Layout

### React
```tsx
import { Widget } from '@sisense/sdk-ui';

// Render individual widgets from the translated props
const MyCustomLayout = ({ dashboardProps }) => {
  return (
    <div className="my-grid-layout">
      {dashboardProps.widgets.map((widgetProps) => (
        <div key={widgetProps.id} className="my-widget-card">
          <Widget {...widgetProps} />
        </div>
      ))}
    </div>
  );
};
```

You can also render a specific widget by ID from a Fusion dashboard:
```tsx
import { WidgetById } from '@sisense/sdk-ui';

<WidgetById
  widgetOid="widget-oid-here"
  dashboardOid="dashboard-oid-here"
/>
```

### Angular
```typescript
// In your component template:
// <csdk-widget
//   *ngFor="let widgetProps of dashboardProps.widgets"
//   [widgetType]="widgetProps.widgetType"
//   [chartType]="widgetProps.chartType"
//   [dataOptions]="widgetProps.dataOptions"
//   [dataSource]="widgetProps.dataSource"
//   [filters]="widgetProps.filters"
//   [title]="widgetProps.title"
// />

// Or render by widget OID:
// <csdk-widget-by-id
//   [widgetOid]="'widget-oid-here'"
//   [dashboardOid]="'dashboard-oid-here'"
// />
```

dgetProps.filters"
//   [title]="widgetProps.title"
// />

// Or render by widget OID:
// <csdk-widget-by-id
//   [widgetOid]="'widget-oid-here'"
//   [dashboardOid]="'dashboard-oid-here'"
// />
```

### Vue
```vue
<template>
  <div class="my-grid-layout">
    <div v-for="widgetProps in dashboardProps?.widgets" :key="widgetProps.id" class="my-widget-card">
      <Widget v-bind="widgetProps" />
    </div>
  </div>
</template>

<script setup lang="ts">
import { Widget } from '@sisense/sdk-ui-vue';
</script>
```

Or render by widget OID:
```vue
<WidgetById
  :widgetOid="'widget-oid-here'"
  :dashboardOid="'dashboard-oid-here'"
/>
```

---

## Step 4: Raw JAQL Queries for Custom Components

For custom KPI cards, tables, or any UI that isn't a Sisense dashboard widget.

idget-oid-here'"
  :dashboardOid="'dashboard-oid-here'"
/>
```

---

## Step 4: Raw JAQL Queries for Custom Components

For custom KPI cards, tables, or any UI that isn't a Sisense dashboard widget.

### React
```tsx
import { useExecuteQuery } from '@sisense/sdk-ui';
import { measureFactory, filterFactory } from '@sisense/sdk-data';
import * as DM from './sample-ecommerce';

const FleetSummaryCard = () => {
  const { data, isLoading, isError } = useExecuteQuery({
    dataSource: DM.DataSource,
    dimensions: [DM.Commerce.AgeRange],
    measures: [
      measureFactory.sum(DM.Commerce.Revenue, 'Total Revenue'),
      measureFactory.count(DM.Commerce.VisitId, 'Total Visits'),
    ],
    filters: [filterFactory.greaterThan(DM.Commerce.Revenue, 1000)],
  });

  if (isLoading) return <div>Loading...</div>;
  if (isError) return <div>Error</div>;

  return (
    <div>
      <h3>Fleet Summary</h3>
      <p>Rows: {data?.rows.length}</p>
      {/* Render your custom table/cards from data.rows and data.columns */}
    </div>
  );
};
```

r</div>;

  return (
    <div>
      <h3>Fleet Summary</h3>
      <p>Rows: {data?.rows.length}</p>
      {/* Render your custom table/cards from data.rows and data.columns */}
    </div>
  );
};
```

### Angular
```typescript
import { QueryService } from '@sisense/sdk-ui-angular';
import { measureFactory, filterFactory } from '@sisense/sdk-data';
import * as DM from './sample-ecommerce';

@Component({ /* ... */ })
export class FleetSummaryComponent implements OnInit {
  queryResult: any;

  constructor(private queryService: QueryService) {}

  async ngOnInit() {
    this.queryResult = await this.queryService.executeQuery({
      dataSource: DM.DataSource,
      dimensions: [DM.Commerce.AgeRange],
      measures: [
        measureFactory.sum(DM.Commerce.Revenue, 'Total Revenue'),
        measureFactory.count(DM.Commerce.VisitId, 'Total Visits'),
      ],
      filters: [filterFactory.greaterThan(DM.Commerce.Revenue, 1000)],
    });
  }
}
```

mmerce.Revenue, 'Total Revenue'),
        measureFactory.count(DM.Commerce.VisitId, 'Total Visits'),
      ],
      filters: [filterFactory.greaterThan(DM.Commerce.Revenue, 1000)],
    });
  }
}
```

### Vue
```vue
<script setup lang="ts">
import { useExecuteQuery } from '@sisense/sdk-ui-vue';
import { measureFactory, filterFactory } from '@sisense/sdk-data';
import * as DM from './sample-ecommerce';

const { data, isLoading, isError } = useExecuteQuery({
  dataSource: DM.DataSource,
  dimensions: [DM.Commerce.AgeRange],
  measures: [
    measureFactory.sum(DM.Commerce.Revenue, 'Total Revenue'),
    measureFactory.count(DM.Commerce.VisitId, 'Total Visits'),
  ],
  filters: [filterFactory.greaterThan(DM.Commerce.Revenue, 1000)],
});
</script>

<template>
  <div v-if="isLoading">Loading...</div>
  <div v-else-if="isError">Error</div>
  <div v-else>
    <h3>Fleet Summary</h3>
    <p>Rows: {{ data?.rows.length }}</p>
  </div>
</template>
```

---

late>
  <div v-if="isLoading">Loading...</div>
  <div v-else-if="isError">Error</div>
  <div v-else>
    <h3>Fleet Summary</h3>
    <p>Rows: {{ data?.rows.length }}</p>
  </div>
</template>
```

---

## Framework Equivalence Quick Reference

| Capability | React (sdk-ui) | Angular (sdk-ui-angular) | Vue (sdk-ui-vue) |
|---|---|---|---|
| **Context Provider** | `<SisenseContextProvider>` | `SisenseContextModule` | `<SisenseContextProvider>` |
| **Fetch Dashboard** | `useGetDashboardModel()` hook | `DashboardService.getDashboardModel()` | `useGetDashboardModel()` composable |
| **Fetch All Dashboards** | `useGetDashboardModels()` | `DashboardService.getDashboardModels()` | `useGetDashboardModels()` |
| **Translate Model** | `dashboardModelTranslator.toDashboardProps()` | `dashboardModelTranslator.toDashboardProps()` | `dashboardModelTranslator.toDashboardProps()` |
| **Composed Dashboard** | `useComposedDashboard()` hook | `DashboardService.createComposedDashboard()` | `useComposedDashboard()` composable |
| **Render Widget** | `<Widget>` component | `<csdk-widget>` component | `<Widget>` component |
| **Render by OID** | `<WidgetById>` component | `<csdk-widget-by-id>` component | `<WidgetById>` component |
| **Execute Query** | `useExecuteQuery()` hook | `QueryService.executeQuery()` | `useExecuteQuery()` composable |
| **Query by Widget ID** | `useExecuteQueryByWidgetId()` | `QueryService.executeQueryByWidgetId()` | `useExecuteQueryByWidgetId()` |
| **Chart Component** | `<Chart>` | `<csdk-chart>` | `<Chart>` |
| **Dashboard Component** | `<Dashboard>` | `<csdk-dashboard>` | `<Dashboard>` |
| **Dashboard by OID** | `<DashboardById>` | `<csdk-dashboard-by-id>` | `<DashboardById>` |
| **AI Chatbot** | `<Chatbot>` (from sdk-ui/ai) | `SdkAiModule` | `<Chatbot>` (from sdk-ui-vue/ai) |

---

| **Dashboard by OID** | `<DashboardById>` | `<csdk-dashboard-by-id>` | `<DashboardById>` |
| **AI Chatbot** | `<Chatbot>` (from sdk-ui/ai) | `SdkAiModule` | `<Chatbot>` (from sdk-ui-vue/ai) |

---

## Key Packages by Framework

| Package | Description |
|---|---|
| `@sisense/sdk-data` | Shared across all frameworks. Data model types, `measureFactory`, `filterFactory`, `analyticsFactory` |
| `@sisense/sdk-ui` | React components and hooks |
| `@sisense/sdk-ui-angular` | Angular components, directives, and services |
| `@sisense/sdk-ui-vue` | Vue components and composables |
| `@sisense/sdk-cli` | CLI tool for generating TypeScript data models from Sisense instance |

# API Reference: sdk-ui-angular

Package: @sisense/sdk-ui-angular

# Module sdk-ui-angular

omposables |
| `@sisense/sdk-cli` | CLI tool for generating TypeScript data models from Sisense instance |

# API Reference: sdk-ui-angular

Package: @sisense/sdk-ui-angular

# Module sdk-ui-angular

## Charts

Angular components and utilities for working with charts

- [AreaChartComponent](charts/class.AreaChartComponent.md)
- [AreamapChartComponent](charts/class.AreamapChartComponent.md)
- [AreaRangeChartComponent](charts/class.AreaRangeChartComponent.md)
- [BarChartComponent](charts/class.BarChartComponent.md)
- [BoxplotChartComponent](charts/class.BoxplotChartComponent.md)
- [boxWhiskerProcessResult](charts/function.boxWhiskerProcessResult.md) - Utility function that combines box whisker data and outliers data
- [CalendarHeatmapChartComponent](charts/class.CalendarHeatmapChartComponent.md)
- [ChartComponent](charts/class.ChartComponent.md) - Common component for rendering charts of different types including table
- [ColumnChartComponent](charts/class.ColumnChartComponent.md)
- [FunnelChartComponent](charts/class.FunnelChartComponent.md)
- [IndicatorChartComponent](charts/class.IndicatorChartComponent.md)
- [LineChartComponent](charts/class.LineChartComponent.md)
- [PieChartComponent](charts/class.PieChartComponent.md)
- [PolarChartComponent](charts/class.PolarChartComponent.md)
- [ScatterChartComponent](charts/class.ScatterChartComponent.md)
- [ScattermapChartComponent](charts/class.ScattermapChartComponent.md)
- [StreamgraphChartComponent](charts/class.StreamgraphChartComponent.md)
- [SunburstChartComponent](charts/class.SunburstChartComponent.md)
- [TreemapChartComponent](charts/class.TreemapChartComponent.md)

eamgraphChartComponent](charts/class.StreamgraphChartComponent.md)
- [SunburstChartComponent](charts/class.SunburstChartComponent.md)
- [TreemapChartComponent](charts/class.TreemapChartComponent.md)

## Data Grids

Angular components for data grids

- [PivotTableComponent](data-grids/class.PivotTableComponent.md)
- [TableComponent](data-grids/class.TableComponent.md)

## Drilldown

Angular components for creating drilldown experiences

- [ContextMenuComponent](drilldown/class.ContextMenuComponent.md)
- [DrilldownBreadcrumbsComponent](drilldown/class.DrilldownBreadcrumbsComponent.md)
- [DrilldownWidgetComponent](drilldown/class.DrilldownWidgetComponent.md)

## Filter Tiles

Angular filter tile components

- [CriteriaFilterTileComponent](filter-tiles/class.CriteriaFilterTileComponent.md)
- [DateRangeFilterTileComponent](filter-tiles/class.DateRangeFilterTileComponent.md)
- [FiltersPanelComponent](filter-tiles/class.FiltersPanelComponent.md)
- [FilterTileComponent](filter-tiles/class.FilterTileComponent.md) - Facade component rendering a filter tile based on filter type
- [MemberFilterTileComponent](filter-tiles/class.MemberFilterTileComponent.md)
- [RelativeDateFilterTileComponent](filter-tiles/class.RelativeDateFilterTileComponent.md)

er tile based on filter type
- [MemberFilterTileComponent](filter-tiles/class.MemberFilterTileComponent.md)
- [RelativeDateFilterTileComponent](filter-tiles/class.RelativeDateFilterTileComponent.md)

## Contexts

Angular context modules, services, and variables

- [SdkUiModule](contexts/class.SdkUiModule.md)
- [SISENSE\_CONTEXT\_CONFIG\_TOKEN](contexts/variable.SISENSE_CONTEXT_CONFIG_TOKEN.md)
- [SisenseContextService](contexts/class.SisenseContextService.md)
- [THEME\_CONFIG\_TOKEN](contexts/variable.THEME_CONFIG_TOKEN.md)
- [ThemeService](contexts/class.ThemeService.md)

## Queries

Angular query service

- [QueryService](queries/class.QueryService.md)

## Dashboards

Angular components and utilities for working with dashboards

- [ChartWidgetComponent](dashboards/class.ChartWidgetComponent.md)
- [CustomWidgetsService](dashboards/class.CustomWidgetsService.md)
- [DashboardComponent](dashboards/class.DashboardComponent.md)
- [dashboardHelpers](dashboards/namespace.dashboardHelpers/index.md) - Utility functions to manipulate dashboard elements
- [extractDimensionsAndMeasures](dashboards/function.extractDimensionsAndMeasures.md)
- [PivotTableWidgetComponent](dashboards/class.PivotTableWidgetComponent.md)
- [WidgetComponent](dashboards/class.WidgetComponent.md)

ndMeasures](dashboards/function.extractDimensionsAndMeasures.md)
- [PivotTableWidgetComponent](dashboards/class.PivotTableWidgetComponent.md)
- [WidgetComponent](dashboards/class.WidgetComponent.md)

## Fusion Assets

Angular components, services, and utilities for working with Fusion dashboards, widgets, queries, and formulas

- [DashboardByIdComponent](fusion-assets/class.DashboardByIdComponent.md) <Badge type="fusionEmbed" text="Fusion Embed" />
- [DashboardModel](fusion-assets/interface.DashboardModel.md) <Badge type="fusionEmbed" text="Fusion Embed" />
- [dashboardModelTranslator](fusion-assets/namespace.dashboardModelTranslator/index.md) <Badge type="fusionEmbed" text="Fusion Embed" /> - Utility functions to translate a Fusion dashboard model from and to other dashboard data structures
- [DashboardService](fusion-assets/class.DashboardService.md) <Badge type="fusionEmbed" text="Fusion Embed" />
- [FormulaService](fusion-assets/class.FormulaService.md) <Badge type="fusionEmbed" text="Fusion Embed" />
- [HierarchyService](fusion-assets/class.HierarchyService.md) <Badge type="fusionEmbed" text="Fusion Embed" />
- [WidgetByIdComponent](fusion-assets/class.WidgetByIdComponent.md) <Badge type="fusionEmbed" text="Fusion Embed" />
- [WidgetModel](fusion-assets/interface.WidgetModel.md) <Badge type="fusionEmbed" text="Fusion Embed" />
- [widgetModelTranslator](fusion-assets/namespace.widgetModelTranslator/index.md) <Badge type="fusionEmbed" text="Fusion Embed" /> - Utility functions to translate a Fusion widget model from and to other widget data structures
- [WidgetService](fusion-assets/class.WidgetService.md) <Badge type="fusionEmbed" text="Fusion Embed" />

Utility functions to translate a Fusion widget model from and to other widget data structures
- [WidgetService](fusion-assets/class.WidgetService.md) <Badge type="fusionEmbed" text="Fusion Embed" />

## Generative AI

Angular modules, components, and services for working with Generative AI features provided by Sisense Fusion
::: tip Note
For more information on requirements for enabling Generative AI features, please refer to the [Generative AI documentation](https://docs.sisense.com/main/SisenseLinux/genai.htm)
:::

- [AI\_CONTEXT\_CONFIG\_TOKEN](generative-ai/variable.AI_CONTEXT_CONFIG_TOKEN.md)
- [AiService](generative-ai/class.AiService.md)
- [ChatbotComponent](generative-ai/class.ChatbotComponent.md)
- [GetNlgInsightsComponent](generative-ai/class.GetNlgInsightsComponent.md)
- [SdkAiModule](generative-ai/class.SdkAiModule.md)

## Filters

- [FilterService](filters/class.FilterService.md)


## Contexts

# Contexts

Angular context modules, services, and variables

- [SdkUiModule](class.SdkUiModule.md)
- [SISENSE\_CONTEXT\_CONFIG\_TOKEN](variable.SISENSE_CONTEXT_CONFIG_TOKEN.md)
- [SisenseContextService](class.SisenseContextService.md)
- [THEME\_CONFIG\_TOKEN](variable.THEME_CONFIG_TOKEN.md)
- [ThemeService](class.ThemeService.md)

# Class SdkUiModule

SDK UI Module, which is a container for components.

s.SisenseContextService.md)
- [THEME\_CONFIG\_TOKEN](variable.THEME_CONFIG_TOKEN.md)
- [ThemeService](class.ThemeService.md)

# Class SdkUiModule

SDK UI Module, which is a container for components.

## Example

Example of importing `SdkUiModule` and injecting [SisenseContextConfig](../interfaces/interface.SisenseContextConfig.md) into your application:

```ts
export const SISENSE_CONTEXT_CONFIG: SisenseContextConfig = {
  url: "<instance url>", // replace with the URL of your Sisense instance
  token: "<api token>", // replace with the API token of your user account
  defaultDataSource: DM.DataSource,
};

@NgModule({
  imports: [
    BrowserModule,
    SdkUiModule,
  ],
  declarations: [AppComponent],
  providers: [
    { provide: SISENSE_CONTEXT_CONFIG_TOKEN, useValue: SISENSE_CONTEXT_CONFIG },
  ],
  bootstrap: [AppComponent],
})
```

## Constructors

### constructor

> **new SdkUiModule**(): [`SdkUiModule`](class.SdkUiModule.md)

#### Returns

[`SdkUiModule`](class.SdkUiModule.md)

# Class SisenseContextService

Service for managing Sisense Fusion context and client application lifecycle.

This service provides a centralized way to configure and manage the connection to a Sisense instance within Angular applications.

## Constructors

e Fusion context and client application lifecycle.

This service provides a centralized way to configure and manage the connection to a Sisense instance within Angular applications.

## Constructors

### constructor

> **new SisenseContextService**(`sisenseContextConfig`?): [`SisenseContextService`](class.SisenseContextService.md)

#### Parameters

| Parameter | Type |
| :------ | :------ |
| `sisenseContextConfig`? | [`SisenseContextConfig`](../interfaces/interface.SisenseContextConfig.md) |

#### Returns

[`SisenseContextService`](class.SisenseContextService.md)

## Methods

### getConfig

> **getConfig**(): [`SisenseContextConfig`](../interfaces/interface.SisenseContextConfig.md) \| `undefined`

Retrieves the current [SisenseContextConfig](../interfaces/interface.SisenseContextConfig.md) configuration object.

#### Returns

[`SisenseContextConfig`](../interfaces/interface.SisenseContextConfig.md) \| `undefined`

The current configuration object, or undefined if not yet configured

***

nfiguration object.

#### Returns

[`SisenseContextConfig`](../interfaces/interface.SisenseContextConfig.md) \| `undefined`

The current configuration object, or undefined if not yet configured

***

### setConfig

> **setConfig**(`config`): `Promise`\< `void` \>

Configures and initializes the Sisense context with the provided settings.

This method allows to establish a connection to a Sisense instance.
It could be used as runtime alternative to [SISENSE_CONTEXT_CONFIG_TOKEN](variable.SISENSE_CONTEXT_CONFIG_TOKEN.md) based configuration.

#### Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `config` | [`SisenseContextConfig`](../interfaces/interface.SisenseContextConfig.md) | Configuration object |

#### Returns

`Promise`\< `void` \>

Promise that resolves when configuration is complete (success or failure)

#### Example

Basic configuration:
```ts
await SisenseContextService.setConfig({
  url: 'https://your-sisense-instance.com',
  token: 'your-api-token',
  defaultDataSource: 'Sample ECommerce'
});
```

# Class ThemeService

Service for working with Sisense Fusion themes.

If no theme service is used, the current Fusion theme is applied by default.

## Constructors

urce: 'Sample ECommerce'
});
```

# Class ThemeService

Service for working with Sisense Fusion themes.

If no theme service is used, the current Fusion theme is applied by default.

## Constructors

### constructor

> **new ThemeService**(`sisenseContextService`, `themeConfig`?): [`ThemeService`](class.ThemeService.md)

#### Parameters

| Parameter | Type |
| :------ | :------ |
| `sisenseContextService` | [`SisenseContextService`](class.SisenseContextService.md) |
| `themeConfig`? | [`ThemeConfig`](../type-aliases/type-alias.ThemeConfig.md) |

#### Returns

[`ThemeService`](class.ThemeService.md)

## Methods

### updateThemeSettings

> **updateThemeSettings**(`theme`): `Promise`\< `void` \>

#### Parameters

| Parameter | Type |
| :------ | :------ |
| `theme` | [`ThemeSettings`](../interfaces/interface.ThemeSettings.md) \| `string` |

#### Returns

`Promise`\< `void` \>

# Variable SISENSE\_CONTEXT\_CONFIG\_TOKEN

> **`const`** **SISENSE\_CONTEXT\_CONFIG\_TOKEN**: `InjectionToken`\< [`SisenseContextConfig`](../interfaces/interface.SisenseContextConfig.md) \>

Token used to inject [SisenseContextConfig](../interfaces/interface.SisenseContextConfig.md) into your application

en`\< [`SisenseContextConfig`](../interfaces/interface.SisenseContextConfig.md) \>

Token used to inject [SisenseContextConfig](../interfaces/interface.SisenseContextConfig.md) into your application

## Example

Example of importing [SdkUiModule](class.SdkUiModule.md) and injecting [SisenseContextConfig](../interfaces/interface.SisenseContextConfig.md) into your application:

```ts
export const SISENSE_CONTEXT_CONFIG: SisenseContextConfig = {
  url: "<instance url>", // replace with the URL of your Sisense instance
  token: "<api token>", // replace with the API token of your user account
  defaultDataSource: DM.DataSource,
};

@NgModule({
  imports: [
    BrowserModule,
    SdkUiModule,
  ],
  declarations: [AppComponent],
  providers: [
    { provide: SISENSE_CONTEXT_CONFIG_TOKEN, useValue: SISENSE_CONTEXT_CONFIG },
  ],
  bootstrap: [AppComponent],
})
```

# Variable THEME\_CONFIG\_TOKEN

> **`const`** **THEME\_CONFIG\_TOKEN**: `InjectionToken`\< [`ThemeConfig`](../type-aliases/type-alias.ThemeConfig.md) \>

Token used to inject [ThemeConfig](../type-aliases/type-alias.ThemeConfig.md) into your application

CONFIG\_TOKEN**: `InjectionToken`\< [`ThemeConfig`](../type-aliases/type-alias.ThemeConfig.md) \>

Token used to inject [ThemeConfig](../type-aliases/type-alias.ThemeConfig.md) into your application

## Example

Example of injecting both [SisenseContextConfig](../interfaces/interface.SisenseContextConfig.md) and [ThemeConfig](../type-aliases/type-alias.ThemeConfig.md) into your application:

```ts
export const SISENSE_CONTEXT_CONFIG: SisenseContextConfig = {
  url: "<instance url>", // replace with the URL of your Sisense instance
  token: "<api token>", // replace with the API token of your user account
  defaultDataSource: DM.DataSource,
};

@NgModule({
  imports: [
    BrowserModule,
    SdkUiModule,
  ],
  declarations: [AppComponent],
  providers: [
    { provide: SISENSE_CONTEXT_CONFIG_TOKEN, useValue: SISENSE_CONTEXT_CONFIG },
    {
      provide: THEME_CONFIG_TOKEN,
      useValue: {
        // initial theme settings
      } as ThemeConfig,
    },
  ],
  bootstrap: [AppComponent],
})
```


## Charts

NSE_CONTEXT_CONFIG },
    {
      provide: THEME_CONFIG_TOKEN,
      useValue: {
        // initial theme settings
      } as ThemeConfig,
    },
  ],
  bootstrap: [AppComponent],
})
```


## Charts

# Charts

Angular components and utilities for working with charts

- [AreaChartComponent](class.AreaChartComponent.md)
- [AreamapChartComponent](class.AreamapChartComponent.md)
- [AreaRangeChartComponent](class.AreaRangeChartComponent.md)
- [BarChartComponent](class.BarChartComponent.md)
- [BoxplotChartComponent](class.BoxplotChartComponent.md)
- [boxWhiskerProcessResult](function.boxWhiskerProcessResult.md) - Utility function that combines box whisker data and outliers data
- [CalendarHeatmapChartComponent](class.CalendarHeatmapChartComponent.md)
- [ChartComponent](class.ChartComponent.md) - Common component for rendering charts of different types including table
- [ColumnChartComponent](class.ColumnChartComponent.md)
- [FunnelChartComponent](class.FunnelChartComponent.md)
- [IndicatorChartComponent](class.IndicatorChartComponent.md)
- [LineChartComponent](class.LineChartComponent.md)
- [PieChartComponent](class.PieChartComponent.md)
- [PolarChartComponent](class.PolarChartComponent.md)
- [ScatterChartComponent](class.ScatterChartComponent.md)
- [ScattermapChartComponent](class.ScattermapChartComponent.md)
- [StreamgraphChartComponent](class.StreamgraphChartComponent.md)
- [SunburstChartComponent](class.SunburstChartComponent.md)
- [TreemapChartComponent](class.TreemapChartComponent.md)

tComponent.md)
- [StreamgraphChartComponent](class.StreamgraphChartComponent.md)
- [SunburstChartComponent](class.SunburstChartComponent.md)
- [TreemapChartComponent](class.TreemapChartComponent.md)

# Class AreaChartComponent

A component similar to a [LineChartComponent](class.LineChartComponent.md),
but with filled in areas under each line and an option to display them as stacked.

ponent.md)

# Class AreaChartComponent

A component similar to a [LineChartComponent](class.LineChartComponent.md),
but with filled in areas under each line and an option to display them as stacked.

## Example

```html
   <csdk-area-chart
     [dataSet]="chart.dataSet"
     [dataOptions]="chart.dataOptions"
     [highlights]="filters"
     [beforeRender]="onBeforeRender"
     (dataPointClick)="logArguments($event)"
     (dataPointContextMenu)="logArguments($event)"
     (dataPointsSelect)="logArguments($event)"
   />
```
```ts
import { Component } from '@angular/core';
import { measureFactory, filterFactory, Filter } from '@sisense/sdk-data';
import * as DM from '../../assets/sample-healthcare-model';
import type { ChartType } from '@sisense/sdk-ui-angular';

@Component({
 selector: 'app-analytics',
 templateUrl: './analytics.component.html',
 styleUrls: ['./analytics.component.scss'],
})
export class AnalyticsComponent {
 DM = DM;
 filters = [filterFactory.members(DM.Divisions.Divison_name, ['Cardiology', 'Neurology'])];
 chart = {
   chartType: 'column' as ChartType,
   dataSet: DM.DataSource,
   dataOptions: {
     category: [DM.Divisions.Divison_name],
     value: [measureFactory.sum(DM.Admissions.Cost_of_admission)],
     breakBy: [],
   },
 };

 onBeforeRender(options: any) {
   console.log('beforeRender');
   console.log(options);
   return options;
 }

 logArguments(...args: any[]) {
   console.log(args);
 }
}
```
<img src="../../../img/angular-area-chart-example.png" width="800px" />

beforeRender');
   console.log(options);
   return options;
 }

 logArguments(...args: any[]) {
   console.log(args);
 }
}
```
<img src="../../../img/angular-area-chart-example.png" width="800px" />

## Constructors

### constructor

> **new AreaChartComponent**(): [`AreaChartComponent`](class.AreaChartComponent.md)

#### Returns

[`AreaChartComponent`](class.AreaChartComponent.md)

## Properties

# Constructors

### constructor

> **new AreaChartComponent**(): [`AreaChartComponent`](class.AreaChartComponent.md)

#### Returns

[`AreaChartComponent`](class.AreaChartComponent.md)

## Properties

### Data

#### dataSet

> **dataSet**: [`Data`](../../sdk-data/interfaces/interface.Data.md) \| [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md) \| `undefined`

Data set for a chart using one of the following options. If neither option is specified, the chart
will use the `defaultDataSource` specified in the parent `SisenseContextProvider`
component.

(1) Sisense data source name as a string. For example, `'Sample ECommerce'`. Typically, you
retrieve the data source name from a data model you create using the `get-data-model`
[command](https://developer.sisense.com/guides/sdk/guides/cli.html) of the Compose SDK CLI. The chart
connects to the data source, executes a query, and loads the data as specified in
`dataOptions`, `filters`, and `highlights`.

To learn more about using data from a Sisense data source, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#sisense-data).

OR

(2) Explicit [`Data`](../../sdk-data/interfaces/interface.Data.md), which is made up of an array of
[`Column`](../../sdk-data/interfaces/interface.Column.md) objects and a two-dimensional array of row data. This approach
allows the chart component to be used with any data you provide.

To learn more about using data from an external data source, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#explicit-data).

Example data in the proper format:

```ts
const sampleData = {
  columns: [
    { name: 'Years', type: 'date' },
    { name: 'Quantity', type: 'number' },
    { name: 'Units', type: 'number' },
  ],
  rows: [
    ['2019', 5500, 1500],
    ['2020', 4471, 7000],
    ['2021', 1812, 5000],
    ['2022', 5001, 6000],
    ['2023', 2045, 4000],
  ],
};
```

***

#### filters

> **filters**: [`FilterRelations`](../../sdk-data/interfaces/interface.FilterRelations.md) \| [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[] \| `undefined`

Filters to limit (or slice) a chart’s data using one of the following options.

(1) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) or [FilterRelations](../../sdk-data/interfaces/interface.FilterRelations.md) returned from filter factory functions, such as
[`greaterThan()`](../../sdk-data/factories/namespace.filterFactory/functions/function.greaterThan.md) and [`members()`](../../sdk-data/factories/namespace.filterFactory/functions/function.members.md).

Use this option for filters that do not require a UI to set them
or for filters where you will supply your own UI components or use pre-built UI components. This is the most common option.

To learn more about using filter factory functions to create filters, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-functions).

(2) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) controlled by filter UI components – for example [`MemberFilterTile`](../../sdk-ui/filter-tiles/function.MemberFilterTile.md).

Use this option for filters that you want your users to set using pre-built UI components.

To learn more about using filter UI components to create filters, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components).

***

#### highlights

> **highlights**: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[] \| `undefined`

Highlights based on filter criteria to apply to a chart using one of the following options.

NOTE that the filter dimensions used in highlights must match those defined in the
`dataOptions` of the chart. Otherwise, the filters will be applied as regular slice filters.

(1) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) returned from filter factory functions, such as
[`greaterThan()`](../../sdk-data/factories/namespace.filterFactory/functions/function.greaterThan.md) and [`members()`](../../sdk-data/factories/namespace.filterFactory/functions/function.members.md).

Use this option for highlights that do not require a UI to set them
or for highlights where you will supply your own UI components or use pre-built UI components. This is the most common option.

To learn more about using filter factory functions to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-functions-for-highlighting).

(2) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) controlled by filter UI components – for example [`MemberFilterTile`](../../sdk-ui/filter-tiles/function.MemberFilterTile.md).

Use this option for highlights that you want your users to set using pre-built UI components.

To learn more about using filter components to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components-for-highlighting).

ts.

To learn more about using filter components to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components-for-highlighting).

### Chart

#### dataOptions

> **dataOptions**: [`CartesianChartDataOptions`](../interfaces/interface.CartesianChartDataOptions.md)

Configurations for how to interpret and present a chart's data.

To learn more about using data options,
see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#dataoptions).

***

#### styleOptions

> **styleOptions**: [`AreaStyleOptions`](../interfaces/interface.AreaStyleOptions.md) \| `undefined`

Configurations for how to style and present a chart's data.

taoptions).

***

#### styleOptions

> **styleOptions**: [`AreaStyleOptions`](../interfaces/interface.AreaStyleOptions.md) \| `undefined`

Configurations for how to style and present a chart's data.

### Callbacks

#### beforeRender

> **beforeRender**: [`BeforeRenderHandler`](../type-aliases/type-alias.BeforeRenderHandler.md) \| `undefined`

A callback that allows you to customize the underlying chart element before it is rendered.
Use the `highchartsOptions` object that is passed to the callback to change
[options values](https://api.highcharts.com/highcharts/) and then return the modified options
object. The returned options are then used when rendering the chart.

This callback is not supported for Indicator Chart, Areamap Chart, Scattermap Chart, and Table.

For an example of how the `onBeforeRender` callback can be used, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#callbacks).

***

#### dataPointClick

> **dataPointClick**: `EventEmitter`\< [`DataPointEvent`](../type-aliases/type-alias.DataPointEvent.md) \>

A callback that allows you to customize what happens when a data point is clicked.

To learn more about callbacks, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#callbacks).

***

#### dataPointContextMenu

> **dataPointContextMenu**: `EventEmitter`\< [`DataPointEvent`](../type-aliases/type-alias.DataPointEvent.md) \>

A callback that allows you to customize what happens when a context menu is displayed for a data point.

To learn more about callbacks, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#callbacks).

***

#### dataPointsSelect

> **dataPointsSelect**: `EventEmitter`\< [`DataPointsEvent`](../type-aliases/type-alias.DataPointsEvent.md) \>

A callback that allows you to customize what happens when data points are selected.

To learn more about callbacks, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#callbacks).

***

#### dataReady

> **dataReady**: (`data`) => [`Data`](../../sdk-data/interfaces/interface.Data.md) \| `undefined`

A callback that allows to modify data immediately after it has been retrieved.
It can be used to inject modification of queried data.

a`](../../sdk-data/interfaces/interface.Data.md) \| `undefined`

A callback that allows to modify data immediately after it has been retrieved.
It can be used to inject modification of queried data.

# Class AreaRangeChartComponent

A component that displays a range of data over a given time period or across multiple categories.
It is particularly useful for visualizing the minimum and maximum values in a dataset, along with
the area between these values.

range of data over a given time period or across multiple categories.
It is particularly useful for visualizing the minimum and maximum values in a dataset, along with
the area between these values.

## Example

```html
   <csdk-area-range-chart
     [dataSet]="chart.dataSet"
     [dataOptions]="chart.dataOptions"
     [highlights]="filters"
     [beforeRender]="onBeforeRender"
     (dataPointClick)="logArguments($event)"
     (dataPointContextMenu)="logArguments($event)"
     (dataPointsSelect)="logArguments($event)"
   />
```
```ts
import { Component } from '@angular/core';
import { measureFactory, filterFactory, Filter } from '@sisense/sdk-data';
import * as DM from '../../assets/sample-healthcare-model';
import type { ChartType, RangeChartDataOptions } from '@sisense/sdk-ui-angular';

@Component({
 selector: 'app-analytics',
 templateUrl: './analytics.component.html',
 styleUrls: ['./analytics.component.scss'],
})
export class AnalyticsComponent {
 DM = DM;
 filters = [filterFactory.members(DM.Divisions.Divison_name, ['Cardiology', 'Neurology'])];
 chart = {
   chartType: 'arearange' as ChartType,
   dataSet: DM.DataSource,
   dataOptions: {
     category: [DM.Admissions.Admission_Time.Years],
     value: [
       {
           title: 'Admission Cost Range',
           upperBound: measureFactory.multiply(
             measureFactory.sum(DM.Admissions.Cost_of_admission, 'Lower Admission'),
             0.6,
           ),
           lowerBound: measureFactory.multiply(
             measureFactory.sum(DM.Admissions.Cost_of_admission, 'Upper Admission'),
             1.4,
            ),
       }
     ],
     breakBy: [],
   } as RangeChartDataOptions,
 };

 onBeforeRender(options: any) {
   console.log('beforeRender');
   console.log(options);
   return options;
 }

 logArguments(...args: any[]) {
   console.log(args);
 }
}
```
<img src="../../../img/angular-area-range-chart-example.png" width="800px" />

Render');
   console.log(options);
   return options;
 }

 logArguments(...args: any[]) {
   console.log(args);
 }
}
```
<img src="../../../img/angular-area-range-chart-example.png" width="800px" />

## Constructors

### constructor

> **new AreaRangeChartComponent**(): [`AreaRangeChartComponent`](class.AreaRangeChartComponent.md)

#### Returns

[`AreaRangeChartComponent`](class.AreaRangeChartComponent.md)

## Properties

ructor

> **new AreaRangeChartComponent**(): [`AreaRangeChartComponent`](class.AreaRangeChartComponent.md)

#### Returns

[`AreaRangeChartComponent`](class.AreaRangeChartComponent.md)

## Properties

### Data

#### dataSet

> **dataSet**: [`Data`](../../sdk-data/interfaces/interface.Data.md) \| [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md) \| `undefined`

Data set for a chart using one of the following options. If neither option is specified, the chart
will use the `defaultDataSource` specified in the parent `SisenseContextProvider`
component.

(1) Sisense data source name as a string. For example, `'Sample ECommerce'`. Typically, you
retrieve the data source name from a data model you create using the `get-data-model`
[command](https://developer.sisense.com/guides/sdk/guides/cli.html) of the Compose SDK CLI. The chart
connects to the data source, executes a query, and loads the data as specified in
`dataOptions`, `filters`, and `highlights`.

To learn more about using data from a Sisense data source, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#sisense-data).

OR

(2) Explicit [`Data`](../../sdk-data/interfaces/interface.Data.md), which is made up of an array of
[`Column`](../../sdk-data/interfaces/interface.Column.md) objects and a two-dimensional array of row data. This approach
allows the chart component to be used with any data you provide.

To learn more about using data from an external data source, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#explicit-data).

Example data in the proper format:

```ts
const sampleData = {
  columns: [
    { name: 'Years', type: 'date' },
    { name: 'Quantity', type: 'number' },
    { name: 'Units', type: 'number' },
  ],
  rows: [
    ['2019', 5500, 1500],
    ['2020', 4471, 7000],
    ['2021', 1812, 5000],
    ['2022', 5001, 6000],
    ['2023', 2045, 4000],
  ],
};
```

***

#### filters

> **filters**: [`FilterRelations`](../../sdk-data/interfaces/interface.FilterRelations.md) \| [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[] \| `undefined`

Filters to limit (or slice) a chart’s data using one of the following options.

(1) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) or [FilterRelations](../../sdk-data/interfaces/interface.FilterRelations.md) returned from filter factory functions, such as
[`greaterThan()`](../../sdk-data/factories/namespace.filterFactory/functions/function.greaterThan.md) and [`members()`](../../sdk-data/factories/namespace.filterFactory/functions/function.members.md).

Use this option for filters that do not require a UI to set them
or for filters where you will supply your own UI components or use pre-built UI components. This is the most common option.

To learn more about using filter factory functions to create filters, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-functions).

(2) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) controlled by filter UI components – for example [`MemberFilterTile`](../../sdk-ui/filter-tiles/function.MemberFilterTile.md).

Use this option for filters that you want your users to set using pre-built UI components.

To learn more about using filter UI components to create filters, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components).

***

#### highlights

> **highlights**: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[] \| `undefined`

Highlights based on filter criteria to apply to a chart using one of the following options.

NOTE that the filter dimensions used in highlights must match those defined in the
`dataOptions` of the chart. Otherwise, the filters will be applied as regular slice filters.

(1) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) returned from filter factory functions, such as
[`greaterThan()`](../../sdk-data/factories/namespace.filterFactory/functions/function.greaterThan.md) and [`members()`](../../sdk-data/factories/namespace.filterFactory/functions/function.members.md).

Use this option for highlights that do not require a UI to set them
or for highlights where you will supply your own UI components or use pre-built UI components. This is the most common option.

To learn more about using filter factory functions to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-functions-for-highlighting).

(2) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) controlled by filter UI components – for example [`MemberFilterTile`](../../sdk-ui/filter-tiles/function.MemberFilterTile.md).

Use this option for highlights that you want your users to set using pre-built UI components.

To learn more about using filter components to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components-for-highlighting).

ts.

To learn more about using filter components to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components-for-highlighting).

### Chart

#### dataOptions

> **dataOptions**: [`RangeChartDataOptions`](../interfaces/interface.RangeChartDataOptions.md)

Configurations for how to interpret and present the data passed to the chart

***

#### styleOptions

> **styleOptions**: [`AreaRangeStyleOptions`](../interfaces/interface.AreaRangeStyleOptions.md) \| `undefined`

Configurations for how to style and present a chart's data.

t

***

#### styleOptions

> **styleOptions**: [`AreaRangeStyleOptions`](../interfaces/interface.AreaRangeStyleOptions.md) \| `undefined`

Configurations for how to style and present a chart's data.

### Callbacks

#### beforeRender

> **beforeRender**: [`BeforeRenderHandler`](../type-aliases/type-alias.BeforeRenderHandler.md) \| `undefined`

A callback that allows you to customize the underlying chart element before it is rendered.
Use the `highchartsOptions` object that is passed to the callback to change
[options values](https://api.highcharts.com/highcharts/) and then return the modified options
object. The returned options are then used when rendering the chart.

This callback is not supported for Indicator Chart, Areamap Chart, Scattermap Chart, and Table.

For an example of how the `onBeforeRender` callback can be used, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#callbacks).

***

#### dataPointClick

> **dataPointClick**: `EventEmitter`\< [`DataPointEvent`](../type-aliases/type-alias.DataPointEvent.md) \>

A callback that allows you to customize what happens when a data point is clicked.

To learn more about callbacks, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#callbacks).

***

#### dataPointContextMenu

> **dataPointContextMenu**: `EventEmitter`\< [`DataPointEvent`](../type-aliases/type-alias.DataPointEvent.md) \>

A callback that allows you to customize what happens when a context menu is displayed for a data point.

To learn more about callbacks, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#callbacks).

***

#### dataPointsSelect

> **dataPointsSelect**: `EventEmitter`\< [`DataPointsEvent`](../type-aliases/type-alias.DataPointsEvent.md) \>

A callback that allows you to customize what happens when data points are selected.

To learn more about callbacks, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#callbacks).

***

#### dataReady

> **dataReady**: (`data`) => [`Data`](../../sdk-data/interfaces/interface.Data.md) \| `undefined`

A callback that allows to modify data immediately after it has been retrieved.
It can be used to inject modification of queried data.

a`](../../sdk-data/interfaces/interface.Data.md) \| `undefined`

A callback that allows to modify data immediately after it has been retrieved.
It can be used to inject modification of queried data.

# Class AreamapChartComponent

An Angular component that allows to visualize geographical data as polygons on a map.

## Example

```html
   <csdk-areamap-chart
     [dataSet]="areamapChart.dataSet"
     [dataOptions]="areamapChart.dataOptions"
     [styleOptions]="areamapChart.styleOptions"
     (dataPointClick)="logArguments($event)"
   />
```

```ts
import { Component } from '@angular/core';
import { measureFactory } from '@sisense/sdk-data';
import * as DM from '../../assets/sample-ecommerce';

@Component({
 selector: 'app-analytics',
 templateUrl: './analytics.component.html',
 styleUrls: ['./analytics.component.scss'],
})
export class AnalyticsComponent {
 areamapChart = {
   dataSet: DM.DataSource,
   dataOptions: {
     geo: [DM.Country.Country],
     color: [measureFactory.sum(DM.Commerce.Revenue, 'Color by Revenue')],
   } as AreamapChartDataOptions,
   styleOptions: {
     mapType: 'world',
   } as AreamapStyleOptions,
 };

 logArguments(...args: any[]) {
   console.log(args);
 }
}
```
<img src="../../../img/angular-areamap-chart-example.png" width="800px" />

## Constructors

### constructor

> **new AreamapChartComponent**(): [`AreamapChartComponent`](class.AreamapChartComponent.md)

#### Returns

[`AreamapChartComponent`](class.AreamapChartComponent.md)

# Constructors

### constructor

> **new AreamapChartComponent**(): [`AreamapChartComponent`](class.AreamapChartComponent.md)

#### Returns

[`AreamapChartComponent`](class.AreamapChartComponent.md)

## Properties

### constructor

> **new AreamapChartComponent**(): [`AreamapChartComponent`](class.AreamapChartComponent.md)

#### Returns

[`AreamapChartComponent`](class.AreamapChartComponent.md)

## Properties

### Data

#### dataSet

> **dataSet**: [`Data`](../../sdk-data/interfaces/interface.Data.md) \| [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md) \| `undefined`

Data set for a chart using one of the following options. If neither option is specified, the chart
will use the `defaultDataSource` specified in the parent `SisenseContextProvider`
component.

(1) Sisense data source name as a string. For example, `'Sample ECommerce'`. Typically, you
retrieve the data source name from a data model you create using the `get-data-model`
[command](https://developer.sisense.com/guides/sdk/guides/cli.html) of the Compose SDK CLI. The chart
connects to the data source, executes a query, and loads the data as specified in
`dataOptions`, `filters`, and `highlights`.

To learn more about using data from a Sisense data source, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#sisense-data).

OR

(2) Explicit [`Data`](../../sdk-data/interfaces/interface.Data.md), which is made up of an array of
[`Column`](../../sdk-data/interfaces/interface.Column.md) objects and a two-dimensional array of row data. This approach
allows the chart component to be used with any data you provide.

To learn more about using data from an external data source, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#explicit-data).

Example data in the proper format:

```ts
const sampleData = {
  columns: [
    { name: 'Years', type: 'date' },
    { name: 'Quantity', type: 'number' },
    { name: 'Units', type: 'number' },
  ],
  rows: [
    ['2019', 5500, 1500],
    ['2020', 4471, 7000],
    ['2021', 1812, 5000],
    ['2022', 5001, 6000],
    ['2023', 2045, 4000],
  ],
};
```

***

#### filters

> **filters**: [`FilterRelations`](../../sdk-data/interfaces/interface.FilterRelations.md) \| [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[] \| `undefined`

Filters to limit (or slice) a chart’s data using one of the following options.

(1) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) or [FilterRelations](../../sdk-data/interfaces/interface.FilterRelations.md) returned from filter factory functions, such as
[`greaterThan()`](../../sdk-data/factories/namespace.filterFactory/functions/function.greaterThan.md) and [`members()`](../../sdk-data/factories/namespace.filterFactory/functions/function.members.md).

Use this option for filters that do not require a UI to set them
or for filters where you will supply your own UI components or use pre-built UI components. This is the most common option.

To learn more about using filter factory functions to create filters, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-functions).

(2) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) controlled by filter UI components – for example [`MemberFilterTile`](../../sdk-ui/filter-tiles/function.MemberFilterTile.md).

Use this option for filters that you want your users to set using pre-built UI components.

To learn more about using filter UI components to create filters, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components).

***

#### highlights

> **highlights**: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[] \| `undefined`

Highlights based on filter criteria to apply to a chart using one of the following options.

NOTE that the filter dimensions used in highlights must match those defined in the
`dataOptions` of the chart. Otherwise, the filters will be applied as regular slice filters.

(1) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) returned from filter factory functions, such as
[`greaterThan()`](../../sdk-data/factories/namespace.filterFactory/functions/function.greaterThan.md) and [`members()`](../../sdk-data/factories/namespace.filterFactory/functions/function.members.md).

Use this option for highlights that do not require a UI to set them
or for highlights where you will supply your own UI components or use pre-built UI components. This is the most common option.

To learn more about using filter factory functions to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-functions-for-highlighting).

(2) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) controlled by filter UI components – for example [`MemberFilterTile`](../../sdk-ui/filter-tiles/function.MemberFilterTile.md).

Use this option for highlights that you want your users to set using pre-built UI components.

To learn more about using filter components to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components-for-highlighting).

ts.

To learn more about using filter components to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components-for-highlighting).

### Chart

#### dataOptions

> **dataOptions**: [`AreamapChartDataOptions`](../interfaces/interface.AreamapChartDataOptions.md)

Configurations for how to interpret and present the data passed to the chart

***

#### styleOptions

> **styleOptions**: [`AreamapStyleOptions`](../interfaces/interface.AreamapStyleOptions.md) \| `undefined`

Configurations for how to style and present a chart's data.

### Callbacks

#### dataPointClick

> **dataPointClick**: `EventEmitter`\< [`AreamapDataPointEvent`](../type-aliases/type-alias.AreamapDataPointEvent.md) \>

Click handler callback for a data point

***

#### dataReady

> **dataReady**: (`data`) => [`Data`](../../sdk-data/interfaces/interface.Data.md) \| `undefined`

A callback that allows to modify data immediately after it has been retrieved.
It can be used to inject modification of queried data.

# Class BarChartComponent

A component representing categorical data with horizontal rectangular bars,
whose lengths are proportional to the values that they represent.

odification of queried data.

# Class BarChartComponent

A component representing categorical data with horizontal rectangular bars,
whose lengths are proportional to the values that they represent.

## Example

```html
   <csdk-bar-chart
     [dataSet]="chart.dataSet"
     [dataOptions]="chart.dataOptions"
     [highlights]="filters"
     [beforeRender]="onBeforeRender"
     (dataPointClick)="logArguments($event)"
     (dataPointContextMenu)="logArguments($event)"
     (dataPointsSelect)="logArguments($event)"
   />
```

```ts
import { Component } from '@angular/core';
import { measureFactory, filterFactory } from '@sisense/sdk-data';
import * as DM from '../../assets/sample-healthcare-model';
import type { ChartType } from '@sisense/sdk-ui-angular';

@Component({
 selector: 'app-analytics',
 templateUrl: './analytics.component.html',
 styleUrls: ['./analytics.component.scss'],
})
export class AnalyticsComponent {
 DM = DM;
 filters = [filterFactory.members(DM.Divisions.Divison_name, ['Cardiology', 'Neurology'])];
 chart = {
   chartType: 'column' as ChartType,
   dataSet: DM.DataSource,
   dataOptions: {
     category: [DM.Divisions.Divison_name],
     value: [measureFactory.sum(DM.Admissions.Cost_of_admission)],
     breakBy: [],
   },
 };

 onBeforeRender(options: any) {
   console.log('beforeRender');
   console.log(options);
   return options;
 }

 logArguments(...args: any[]) {
   console.log(args);
 }
}
```
<img src="../../../img/angular-bar-chart-example.png" width="800px" />

'beforeRender');
   console.log(options);
   return options;
 }

 logArguments(...args: any[]) {
   console.log(args);
 }
}
```
<img src="../../../img/angular-bar-chart-example.png" width="800px" />

## Constructors

### constructor

> **new BarChartComponent**(): [`BarChartComponent`](class.BarChartComponent.md)

#### Returns

[`BarChartComponent`](class.BarChartComponent.md)

## Properties

/>

## Constructors

### constructor

> **new BarChartComponent**(): [`BarChartComponent`](class.BarChartComponent.md)

#### Returns

[`BarChartComponent`](class.BarChartComponent.md)

## Properties

### Data

#### dataSet

> **dataSet**: [`Data`](../../sdk-data/interfaces/interface.Data.md) \| [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md) \| `undefined`

Data set for a chart using one of the following options. If neither option is specified, the chart
will use the `defaultDataSource` specified in the parent `SisenseContextProvider`
component.

(1) Sisense data source name as a string. For example, `'Sample ECommerce'`. Typically, you
retrieve the data source name from a data model you create using the `get-data-model`
[command](https://developer.sisense.com/guides/sdk/guides/cli.html) of the Compose SDK CLI. The chart
connects to the data source, executes a query, and loads the data as specified in
`dataOptions`, `filters`, and `highlights`.

To learn more about using data from a Sisense data source, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#sisense-data).

OR

(2) Explicit [`Data`](../../sdk-data/interfaces/interface.Data.md), which is made up of an array of
[`Column`](../../sdk-data/interfaces/interface.Column.md) objects and a two-dimensional array of row data. This approach
allows the chart component to be used with any data you provide.

To learn more about using data from an external data source, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#explicit-data).

Example data in the proper format:

```ts
const sampleData = {
  columns: [
    { name: 'Years', type: 'date' },
    { name: 'Quantity', type: 'number' },
    { name: 'Units', type: 'number' },
  ],
  rows: [
    ['2019', 5500, 1500],
    ['2020', 4471, 7000],
    ['2021', 1812, 5000],
    ['2022', 5001, 6000],
    ['2023', 2045, 4000],
  ],
};
```

***

#### filters

> **filters**: [`FilterRelations`](../../sdk-data/interfaces/interface.FilterRelations.md) \| [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[] \| `undefined`

Filters to limit (or slice) a chart’s data using one of the following options.

(1) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) or [FilterRelations](../../sdk-data/interfaces/interface.FilterRelations.md) returned from filter factory functions, such as
[`greaterThan()`](../../sdk-data/factories/namespace.filterFactory/functions/function.greaterThan.md) and [`members()`](../../sdk-data/factories/namespace.filterFactory/functions/function.members.md).

Use this option for filters that do not require a UI to set them
or for filters where you will supply your own UI components or use pre-built UI components. This is the most common option.

To learn more about using filter factory functions to create filters, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-functions).

(2) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) controlled by filter UI components – for example [`MemberFilterTile`](../../sdk-ui/filter-tiles/function.MemberFilterTile.md).

Use this option for filters that you want your users to set using pre-built UI components.

To learn more about using filter UI components to create filters, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components).

***

#### highlights

> **highlights**: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[] \| `undefined`

Highlights based on filter criteria to apply to a chart using one of the following options.

NOTE that the filter dimensions used in highlights must match those defined in the
`dataOptions` of the chart. Otherwise, the filters will be applied as regular slice filters.

(1) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) returned from filter factory functions, such as
[`greaterThan()`](../../sdk-data/factories/namespace.filterFactory/functions/function.greaterThan.md) and [`members()`](../../sdk-data/factories/namespace.filterFactory/functions/function.members.md).

Use this option for highlights that do not require a UI to set them
or for highlights where you will supply your own UI components or use pre-built UI components. This is the most common option.

To learn more about using filter factory functions to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-functions-for-highlighting).

(2) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) controlled by filter UI components – for example [`MemberFilterTile`](../../sdk-ui/filter-tiles/function.MemberFilterTile.md).

Use this option for highlights that you want your users to set using pre-built UI components.

To learn more about using filter components to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components-for-highlighting).

ts.

To learn more about using filter components to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components-for-highlighting).

### Chart

#### dataOptions

> **dataOptions**: [`CartesianChartDataOptions`](../interfaces/interface.CartesianChartDataOptions.md)

Configurations for how to interpret and present a chart's data.

To learn more about using data options,
see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#dataoptions).

***

#### styleOptions

> **styleOptions**: [`StackableStyleOptions`](../interfaces/interface.StackableStyleOptions.md) \| `undefined`

Configurations for how to style and present a chart's data.

.

***

#### styleOptions

> **styleOptions**: [`StackableStyleOptions`](../interfaces/interface.StackableStyleOptions.md) \| `undefined`

Configurations for how to style and present a chart's data.

### Callbacks

#### beforeRender

> **beforeRender**: [`BeforeRenderHandler`](../type-aliases/type-alias.BeforeRenderHandler.md) \| `undefined`

A callback that allows you to customize the underlying chart element before it is rendered.
Use the `highchartsOptions` object that is passed to the callback to change
[options values](https://api.highcharts.com/highcharts/) and then return the modified options
object. The returned options are then used when rendering the chart.

This callback is not supported for Indicator Chart, Areamap Chart, Scattermap Chart, and Table.

For an example of how the `onBeforeRender` callback can be used, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#callbacks).

***

#### dataPointClick

> **dataPointClick**: `EventEmitter`\< [`DataPointEvent`](../type-aliases/type-alias.DataPointEvent.md) \>

A callback that allows you to customize what happens when a data point is clicked.

To learn more about callbacks, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#callbacks).

***

#### dataPointContextMenu

> **dataPointContextMenu**: `EventEmitter`\< [`DataPointEvent`](../type-aliases/type-alias.DataPointEvent.md) \>

A callback that allows you to customize what happens when a context menu is displayed for a data point.

To learn more about callbacks, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#callbacks).

***

#### dataPointsSelect

> **dataPointsSelect**: `EventEmitter`\< [`DataPointsEvent`](../type-aliases/type-alias.DataPointsEvent.md) \>

A callback that allows you to customize what happens when data points are selected.

To learn more about callbacks, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#callbacks).

***

#### dataReady

> **dataReady**: (`data`) => [`Data`](../../sdk-data/interfaces/interface.Data.md) \| `undefined`

A callback that allows to modify data immediately after it has been retrieved.
It can be used to inject modification of queried data.

a`](../../sdk-data/interfaces/interface.Data.md) \| `undefined`

A callback that allows to modify data immediately after it has been retrieved.
It can be used to inject modification of queried data.

# Class BoxplotChartComponent

An Angular component representing data in a way that visually describes the distribution
variability, and center of a data set along an axis.

ication of queried data.

# Class BoxplotChartComponent

An Angular component representing data in a way that visually describes the distribution
variability, and center of a data set along an axis.

## Example

```html
   <csdk-boxplot-chart
     [dataSet]="boxplotChart.dataSet"
     [dataOptions]="boxplotChart.dataOptions"
     [highlights]="boxplotChart.highlights"
     [beforeRender]="onBeforeRender"
     (dataPointClick)="logArguments($event)"
     (dataPointContextMenu)="logArguments($event)"
     (dataPointsSelect)="logArguments($event)"
   />
```

```ts
import { Component } from '@angular/core';
import { filterFactory } from '@sisense/sdk-data';
import type { BoxplotChartDataOptions } from '@sisense/sdk-ui-angular';
import * as DM from '../../assets/sample-healthcare-model';

@Component({
 selector: 'app-analytics',
 templateUrl: './analytics.component.html',
 styleUrls: ['./analytics.component.scss'],
})
export class AnalyticsComponent {
 boxplotChart = {
   dataSet: DM.DataSource,
   dataOptions: {
     category: [DM.Divisions.Divison_name],
     value: [DM.Admissions.TimeofStay],
     boxType: 'iqr',
     outliersEnabled: true,
   } as BoxplotChartDataOptions,
   highlights: [filterFactory.members(DM.Divisions.Divison_name, ['Cardiology', 'Neurology'])],
 };

 logArguments(...args: any[]) {
   console.log(args);
 }
}
```
<img src="../../../img/angular-boxplot-chart-example.png" width="800px" />

## Constructors

n_name, ['Cardiology', 'Neurology'])],
 };

 logArguments(...args: any[]) {
   console.log(args);
 }
}
```
<img src="../../../img/angular-boxplot-chart-example.png" width="800px" />

## Constructors

### constructor

> **new BoxplotChartComponent**(): [`BoxplotChartComponent`](class.BoxplotChartComponent.md)

#### Returns

[`BoxplotChartComponent`](class.BoxplotChartComponent.md)

## Properties

### constructor

> **new BoxplotChartComponent**(): [`BoxplotChartComponent`](class.BoxplotChartComponent.md)

#### Returns

[`BoxplotChartComponent`](class.BoxplotChartComponent.md)

## Properties

### Data

#### dataSet

> **dataSet**: [`Data`](../../sdk-data/interfaces/interface.Data.md) \| [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md) \| `undefined`

Data set for a chart using one of the following options. If neither option is specified, the chart
will use the `defaultDataSource` specified in the parent `SisenseContextProvider`
component.

(1) Sisense data source name as a string. For example, `'Sample ECommerce'`. Typically, you
retrieve the data source name from a data model you create using the `get-data-model`
[command](https://developer.sisense.com/guides/sdk/guides/cli.html) of the Compose SDK CLI. The chart
connects to the data source, executes a query, and loads the data as specified in
`dataOptions`, `filters`, and `highlights`.

To learn more about using data from a Sisense data source, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#sisense-data).

OR

(2) Explicit [`Data`](../../sdk-data/interfaces/interface.Data.md), which is made up of an array of
[`Column`](../../sdk-data/interfaces/interface.Column.md) objects and a two-dimensional array of row data. This approach
allows the chart component to be used with any data you provide.

To learn more about using data from an external data source, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#explicit-data).

Example data in the proper format:

```ts
const sampleData = {
  columns: [
    { name: 'Years', type: 'date' },
    { name: 'Quantity', type: 'number' },
    { name: 'Units', type: 'number' },
  ],
  rows: [
    ['2019', 5500, 1500],
    ['2020', 4471, 7000],
    ['2021', 1812, 5000],
    ['2022', 5001, 6000],
    ['2023', 2045, 4000],
  ],
};
```

***

#### filters

> **filters**: [`FilterRelations`](../../sdk-data/interfaces/interface.FilterRelations.md) \| [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[] \| `undefined`

Filters to limit (or slice) a chart’s data using one of the following options.

(1) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) or [FilterRelations](../../sdk-data/interfaces/interface.FilterRelations.md) returned from filter factory functions, such as
[`greaterThan()`](../../sdk-data/factories/namespace.filterFactory/functions/function.greaterThan.md) and [`members()`](../../sdk-data/factories/namespace.filterFactory/functions/function.members.md).

Use this option for filters that do not require a UI to set them
or for filters where you will supply your own UI components or use pre-built UI components. This is the most common option.

To learn more about using filter factory functions to create filters, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-functions).

(2) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) controlled by filter UI components – for example [`MemberFilterTile`](../../sdk-ui/filter-tiles/function.MemberFilterTile.md).

Use this option for filters that you want your users to set using pre-built UI components.

To learn more about using filter UI components to create filters, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components).

***

#### highlights

> **highlights**: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[] \| `undefined`

Highlights based on filter criteria to apply to a chart using one of the following options.

NOTE that the filter dimensions used in highlights must match those defined in the
`dataOptions` of the chart. Otherwise, the filters will be applied as regular slice filters.

(1) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) returned from filter factory functions, such as
[`greaterThan()`](../../sdk-data/factories/namespace.filterFactory/functions/function.greaterThan.md) and [`members()`](../../sdk-data/factories/namespace.filterFactory/functions/function.members.md).

Use this option for highlights that do not require a UI to set them
or for highlights where you will supply your own UI components or use pre-built UI components. This is the most common option.

To learn more about using filter factory functions to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-functions-for-highlighting).

(2) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) controlled by filter UI components – for example [`MemberFilterTile`](../../sdk-ui/filter-tiles/function.MemberFilterTile.md).

Use this option for highlights that you want your users to set using pre-built UI components.

To learn more about using filter components to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components-for-highlighting).

ts.

To learn more about using filter components to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components-for-highlighting).

### Chart

#### dataOptions

> **dataOptions**: [`BoxplotChartCustomDataOptions`](../type-aliases/type-alias.BoxplotChartCustomDataOptions.md) \| [`BoxplotChartDataOptions`](../type-aliases/type-alias.BoxplotChartDataOptions.md)

Configurations for how to interpret and present the data passed to the chart

***

#### styleOptions

> **styleOptions**: [`BoxplotStyleOptions`](../interfaces/interface.BoxplotStyleOptions.md) \| `undefined`

Configurations for how to style and present a chart's data.

chart

***

#### styleOptions

> **styleOptions**: [`BoxplotStyleOptions`](../interfaces/interface.BoxplotStyleOptions.md) \| `undefined`

Configurations for how to style and present a chart's data.

### Callbacks

#### beforeRender

> **beforeRender**: [`BeforeRenderHandler`](../type-aliases/type-alias.BeforeRenderHandler.md) \| `undefined`

A callback that allows you to customize the underlying chart element before it is rendered.
Use the `highchartsOptions` object that is passed to the callback to change
[options values](https://api.highcharts.com/highcharts/) and then return the modified options
object. The returned options are then used when rendering the chart.

This callback is not supported for Indicator Chart, Areamap Chart, Scattermap Chart, and Table.

For an example of how the `onBeforeRender` callback can be used, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#callbacks).

***

#### dataPointClick

> **dataPointClick**: `EventEmitter`\< [`BoxplotDataPointEvent`](../type-aliases/type-alias.BoxplotDataPointEvent.md) \>

Click handler callback for a data point

***

#### dataPointContextMenu

> **dataPointContextMenu**: `EventEmitter`\< [`BoxplotDataPointEvent`](../type-aliases/type-alias.BoxplotDataPointEvent.md) \>

Context menu handler callback for a data point

***

#### dataPointsSelect

> **dataPointsSelect**: `EventEmitter`\< [`BoxplotDataPointsEvent`](../type-aliases/type-alias.BoxplotDataPointsEvent.md) \>

Handler callback for selection of multiple data points

***

#### dataReady

> **dataReady**: (`data`) => [`Data`](../../sdk-data/interfaces/interface.Data.md) \| `undefined`

A callback that allows to modify data immediately after it has been retrieved.
It can be used to inject modification of queried data.

a`](../../sdk-data/interfaces/interface.Data.md) \| `undefined`

A callback that allows to modify data immediately after it has been retrieved.
It can be used to inject modification of queried data.

# Class CalendarHeatmapChartComponent

A component that visualizes values over days in a calendar-like view,
making it easy to identify daily patterns or anomalies

## Example

```html
   <csdk-calendar-heatmap-chart
     [dataSet]="chart.dataSet"
     [dataOptions]="chart.dataOptions"
     [highlights]="chart.highlights"
     [styleOptions]="chart.styleOptions"
   />
```
```ts
import { Component } from '@angular/core';
import { measureFactory, filterFactory } from '@sisense/sdk-data';
import * as DM from '../../assets/sample-ecommerce';
import type { CalendarHeatmapChartProps } from '@sisense/sdk-ui-angular';

@Component({
 selector: 'app-analytics',
 templateUrl: './analytics.component.html',
 styleUrls: ['./analytics.component.scss'],
})
export class AnalyticsComponent {
 DM = DM;
 chart = {
   dataSet: DM.DataSource,
   dataOptions: {
     date: DM.Commerce.Date.Days,
     value: measureFactory.sum(DM.Commerce.Cost),
   },
   highlights: [
     filterFactory.dateRange(
       DM.Commerce.Date.Days,
       '2009-11-29',
       '2009-12-15'
     ),
   ],
   styleOptions: {
     viewType: 'quarter',
   },
 };
}
```
<img src="../../../img/angular-calendar-heatmap-chart-example.png" width="800px" />

## Constructors

',
       '2009-12-15'
     ),
   ],
   styleOptions: {
     viewType: 'quarter',
   },
 };
}
```
<img src="../../../img/angular-calendar-heatmap-chart-example.png" width="800px" />

## Constructors

### constructor

> **new CalendarHeatmapChartComponent**(): [`CalendarHeatmapChartComponent`](class.CalendarHeatmapChartComponent.md)

#### Returns

[`CalendarHeatmapChartComponent`](class.CalendarHeatmapChartComponent.md)

## Properties

pChartComponent**(): [`CalendarHeatmapChartComponent`](class.CalendarHeatmapChartComponent.md)

#### Returns

[`CalendarHeatmapChartComponent`](class.CalendarHeatmapChartComponent.md)

## Properties

### Data

#### dataSet

> **dataSet**: [`Data`](../../sdk-data/interfaces/interface.Data.md) \| [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md) \| `undefined`

Data set for a chart using one of the following options. If neither option is specified, the chart
will use the `defaultDataSource` specified in the parent `SisenseContextProvider`
component.

(1) Sisense data source name as a string. For example, `'Sample ECommerce'`. Typically, you
retrieve the data source name from a data model you create using the `get-data-model`
[command](https://developer.sisense.com/guides/sdk/guides/cli.html) of the Compose SDK CLI. The chart
connects to the data source, executes a query, and loads the data as specified in
`dataOptions`, `filters`, and `highlights`.

To learn more about using data from a Sisense data source, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#sisense-data).

OR

(2) Explicit [`Data`](../../sdk-data/interfaces/interface.Data.md), which is made up of an array of
[`Column`](../../sdk-data/interfaces/interface.Column.md) objects and a two-dimensional array of row data. This approach
allows the chart component to be used with any data you provide.

To learn more about using data from an external data source, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#explicit-data).

Example data in the proper format:

```ts
const sampleData = {
  columns: [
    { name: 'Years', type: 'date' },
    { name: 'Quantity', type: 'number' },
    { name: 'Units', type: 'number' },
  ],
  rows: [
    ['2019', 5500, 1500],
    ['2020', 4471, 7000],
    ['2021', 1812, 5000],
    ['2022', 5001, 6000],
    ['2023', 2045, 4000],
  ],
};
```

***

#### filters

> **filters**: [`FilterRelations`](../../sdk-data/interfaces/interface.FilterRelations.md) \| [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[] \| `undefined`

Filters to limit (or slice) a chart’s data using one of the following options.

(1) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) or [FilterRelations](../../sdk-data/interfaces/interface.FilterRelations.md) returned from filter factory functions, such as
[`greaterThan()`](../../sdk-data/factories/namespace.filterFactory/functions/function.greaterThan.md) and [`members()`](../../sdk-data/factories/namespace.filterFactory/functions/function.members.md).

Use this option for filters that do not require a UI to set them
or for filters where you will supply your own UI components or use pre-built UI components. This is the most common option.

To learn more about using filter factory functions to create filters, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-functions).

(2) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) controlled by filter UI components – for example [`MemberFilterTile`](../../sdk-ui/filter-tiles/function.MemberFilterTile.md).

Use this option for filters that you want your users to set using pre-built UI components.

To learn more about using filter UI components to create filters, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components).

***

#### highlights

> **highlights**: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[] \| `undefined`

Highlights based on filter criteria to apply to a chart using one of the following options.

NOTE that the filter dimensions used in highlights must match those defined in the
`dataOptions` of the chart. Otherwise, the filters will be applied as regular slice filters.

(1) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) returned from filter factory functions, such as
[`greaterThan()`](../../sdk-data/factories/namespace.filterFactory/functions/function.greaterThan.md) and [`members()`](../../sdk-data/factories/namespace.filterFactory/functions/function.members.md).

Use this option for highlights that do not require a UI to set them
or for highlights where you will supply your own UI components or use pre-built UI components. This is the most common option.

To learn more about using filter factory functions to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-functions-for-highlighting).

(2) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) controlled by filter UI components – for example [`MemberFilterTile`](../../sdk-ui/filter-tiles/function.MemberFilterTile.md).

Use this option for highlights that you want your users to set using pre-built UI components.

To learn more about using filter components to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components-for-highlighting).

ts.

To learn more about using filter components to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components-for-highlighting).

### Chart

#### dataOptions

> **dataOptions**: [`CalendarHeatmapChartDataOptions`](../interfaces/interface.CalendarHeatmapChartDataOptions.md)

Configurations for how to interpret and present the data passed to the chart

***

#### styleOptions

> **styleOptions**: [`CalendarHeatmapStyleOptions`](../interfaces/interface.CalendarHeatmapStyleOptions.md) \| `undefined`

Configurations for how to style and present a chart's data.

styleOptions

> **styleOptions**: [`CalendarHeatmapStyleOptions`](../interfaces/interface.CalendarHeatmapStyleOptions.md) \| `undefined`

Configurations for how to style and present a chart's data.

### Callbacks

#### beforeRender

> **beforeRender**: [`BeforeRenderHandler`](../type-aliases/type-alias.BeforeRenderHandler.md) \| `undefined`

A callback that allows you to customize the underlying chart element before it is rendered.
Use the `highchartsOptions` object that is passed to the callback to change
[options values](https://api.highcharts.com/highcharts/) and then return the modified options
object. The returned options are then used when rendering the chart.

This callback is not supported for Indicator Chart, Areamap Chart, Scattermap Chart, and Table.

For an example of how the `onBeforeRender` callback can be used, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#callbacks).

***

#### dataPointClick

> **dataPointClick**: `EventEmitter`\< [`CalendarHeatmapDataPointEvent`](../type-aliases/type-alias.CalendarHeatmapDataPointEvent.md) \>

Click handler callback for a data point

***

#### dataPointContextMenu

> **dataPointContextMenu**: `EventEmitter`\< [`CalendarHeatmapDataPointEvent`](../type-aliases/type-alias.CalendarHeatmapDataPointEvent.md) \>

Context menu handler callback for a data point

***

#### dataPointsSelect

> **dataPointsSelect**: `EventEmitter`\< [`CalendarHeatmapDataPointsEvent`](../type-aliases/type-alias.CalendarHeatmapDataPointsEvent.md) \>

Handler callback for selection of multiple data points

***

#### dataReady

> **dataReady**: (`data`) => [`Data`](../../sdk-data/interfaces/interface.Data.md) \| `undefined`

A callback that allows to modify data immediately after it has been retrieved.
It can be used to inject modification of queried data.

a`](../../sdk-data/interfaces/interface.Data.md) \| `undefined`

A callback that allows to modify data immediately after it has been retrieved.
It can be used to inject modification of queried data.

# Class ChartComponent

An Angular component used for easily switching chart types or rendering multiple series of different chart types.

## Example

An example of using the `Chart` component to
plot a column chart of the Sample Healthcare data source hosted in a Sisense instance:

```html
<!--Component HTML template in .component.html-->
<csdk-chart
  [chartType]="chart.chartType"
  [dataSet]="chart.dataSet"
  [dataOptions]="chart.dataOptions"
  [filters]="chart.filters"
  [styleOptions]="chart.styleOptions"
/>
```

```ts
// Component behavior in .component.ts
chart = {
  chartType: 'column' as ChartType,
  dataSet: DM.DataSource,
  dataOptions: {
    category: [DM.Admissions.Admission_Time.Months],
    value: [measureFactory.count(DM.Admissions.Patient_ID, 'Total Patients')],
    breakBy: [],
  },
  filters: [filterFactory.members(DM.Doctors.Specialty, ['Oncology', 'Cardiology'])],
  styleOptions: {
    width: 800,
    height: 500,
    xAxis: {
      title: {
        text: 'Months',
        enabled: true,
      },
    },
    yAxis: {
      title: {
        text: 'Total Patients',
        enabled: true,
      },
    },
  },
};
```

<img src="../../../img/angular-chart-example.png" width="800px" />

## Implements

- `AfterViewInit`
- `OnChanges`
- `OnDestroy`

## Constructors

enabled: true,
      },
    },
  },
};
```

<img src="../../../img/angular-chart-example.png" width="800px" />

## Implements

- `AfterViewInit`
- `OnChanges`
- `OnDestroy`

## Constructors

### constructor

> **new ChartComponent**(`sisenseContextService`, `themeService`): [`ChartComponent`](class.ChartComponent.md)

Constructor for the `Chart` component.

#### Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `sisenseContextService` | [`SisenseContextService`](../contexts/class.SisenseContextService.md) | Sisense context service |
| `themeService` | [`ThemeService`](../contexts/class.ThemeService.md) | Theme service |

#### Returns

[`ChartComponent`](class.ChartComponent.md)

## Properties

ice.md) | Sisense context service |
| `themeService` | [`ThemeService`](../contexts/class.ThemeService.md) | Theme service |

#### Returns

[`ChartComponent`](class.ChartComponent.md)

## Properties

### Data

#### dataSet

> **dataSet**: [`Data`](../../sdk-data/interfaces/interface.Data.md) \| [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md) \| `undefined`

Data set for a chart using one of the following options. If neither option is specified, the chart
will use the `defaultDataSource` specified in the parent `SisenseContextProvider`
component.

(1) Sisense data source name as a string. For example, `'Sample ECommerce'`. Typically, you
retrieve the data source name from a data model you create using the `get-data-model`
[command](https://developer.sisense.com/guides/sdk/guides/cli.html) of the Compose SDK CLI. The chart
connects to the data source, executes a query, and loads the data as specified in
`dataOptions`, `filters`, and `highlights`.

To learn more about using data from a Sisense data source, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#sisense-data).

OR

(2) Explicit [`Data`](../../sdk-data/interfaces/interface.Data.md), which is made up of an array of
[`Column`](../../sdk-data/interfaces/interface.Column.md) objects and a two-dimensional array of row data. This approach
allows the chart component to be used with any data you provide.

To learn more about using data from an external data source, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#explicit-data).

Example data in the proper format:

```ts
const sampleData = {
  columns: [
    { name: 'Years', type: 'date' },
    { name: 'Quantity', type: 'number' },
    { name: 'Units', type: 'number' },
  ],
  rows: [
    ['2019', 5500, 1500],
    ['2020', 4471, 7000],
    ['2021', 1812, 5000],
    ['2022', 5001, 6000],
    ['2023', 2045, 4000],
  ],
};
```

***

#### filters

> **filters**: [`FilterRelations`](../../sdk-data/interfaces/interface.FilterRelations.md) \| [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[] \| `undefined`

Filters to limit (or slice) a chart’s data using one of the following options.

(1) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) or [FilterRelations](../../sdk-data/interfaces/interface.FilterRelations.md) returned from filter factory functions, such as
[`greaterThan()`](../../sdk-data/factories/namespace.filterFactory/functions/function.greaterThan.md) and [`members()`](../../sdk-data/factories/namespace.filterFactory/functions/function.members.md).

Use this option for filters that do not require a UI to set them
or for filters where you will supply your own UI components or use pre-built UI components. This is the most common option.

To learn more about using filter factory functions to create filters, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-functions).

(2) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) controlled by filter UI components – for example [`MemberFilterTile`](../../sdk-ui/filter-tiles/function.MemberFilterTile.md).

Use this option for filters that you want your users to set using pre-built UI components.

To learn more about using filter UI components to create filters, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components).

***

#### highlights

> **highlights**: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[] \| `undefined`

Highlights based on filter criteria to apply to a chart using one of the following options.

NOTE that the filter dimensions used in highlights must match those defined in the
`dataOptions` of the chart. Otherwise, the filters will be applied as regular slice filters.

(1) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) returned from filter factory functions, such as
[`greaterThan()`](../../sdk-data/factories/namespace.filterFactory/functions/function.greaterThan.md) and [`members()`](../../sdk-data/factories/namespace.filterFactory/functions/function.members.md).

Use this option for highlights that do not require a UI to set them
or for highlights where you will supply your own UI components or use pre-built UI components. This is the most common option.

To learn more about using filter factory functions to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-functions-for-highlighting).

(2) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) controlled by filter UI components – for example [`MemberFilterTile`](../../sdk-ui/filter-tiles/function.MemberFilterTile.md).

Use this option for highlights that you want your users to set using pre-built UI components.

To learn more about using filter components to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components-for-highlighting).

ts.

To learn more about using filter components to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components-for-highlighting).

### Chart

#### chartType

> **chartType**: [`ChartType`](../type-aliases/type-alias.ChartType.md)

Default chart type of each series.

***

#### dataOptions

> **dataOptions**: [`ChartDataOptions`](../type-aliases/type-alias.ChartDataOptions.md)

Configurations for how to interpret and present a chart's data.

To learn more about using data options,
see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#dataoptions).

***

#### styleOptions

> **styleOptions**: [`ChartStyleOptions`](../type-aliases/type-alias.ChartStyleOptions.md) \| `undefined`

Configurations for how to style and present a chart's data.

To learn more about using style options,
see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#styleoptions).

tions for how to style and present a chart's data.

To learn more about using style options,
see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#styleoptions).

### Callbacks

#### beforeRender

> **beforeRender**: [`BeforeRenderHandler`](../type-aliases/type-alias.BeforeRenderHandler.md) \| [`IndicatorBeforeRenderHandler`](../type-aliases/type-alias.IndicatorBeforeRenderHandler.md) \| `undefined`

A callback that allows you to customize the underlying chart element before it is rendered. The returned options are then used when rendering the chart.

This callback is not supported for Areamap Chart, Scattermap Chart, Table, and PivotTable.

***

#### dataPointClick

> **dataPointClick**: `EventEmitter`\< [`ChartDataPointClickEvent`](../type-aliases/type-alias.ChartDataPointClickEvent.md) \>

Click handler callback for a data point

***

#### dataPointContextMenu

> **dataPointContextMenu**: `EventEmitter`\< [`ChartDataPointContextMenuEvent`](../type-aliases/type-alias.ChartDataPointContextMenuEvent.md) \>

Context menu handler callback for a data point

***

#### dataPointsSelect

> **dataPointsSelect**: `EventEmitter`\< [`ChartDataPointsEvent`](../type-aliases/type-alias.ChartDataPointsEvent.md) \>

Handler callback for selection of multiple data points

***

#### dataReady

> **dataReady**: (`data`) => [`Data`](../../sdk-data/interfaces/interface.Data.md) \| `undefined`

A callback that allows to modify data immediately after it has been retrieved.
It can be used to inject modification of queried data.

a`](../../sdk-data/interfaces/interface.Data.md) \| `undefined`

A callback that allows to modify data immediately after it has been retrieved.
It can be used to inject modification of queried data.

### Constructor

#### sisenseContextService

> **sisenseContextService**: [`SisenseContextService`](../contexts/class.SisenseContextService.md)

Sisense context service

***

#### themeService

> **themeService**: [`ThemeService`](../contexts/class.ThemeService.md)

Theme service

# Class ColumnChartComponent

A component representing categorical data with vertical rectangular bars
whose heights are proportional to the values that they represent.

meService.md)

Theme service

# Class ColumnChartComponent

A component representing categorical data with vertical rectangular bars
whose heights are proportional to the values that they represent.

## Example

```html
   <csdk-column-chart
     [dataSet]="chart.dataSet"
     [dataOptions]="chart.dataOptions"
     [highlights]="filters"
     [beforeRender]="onBeforeRender"
     (dataPointClick)="logArguments($event)"
     (dataPointContextMenu)="logArguments($event)"
     (dataPointsSelect)="logArguments($event)"
   />
```
```ts
import { Component } from '@angular/core';
import { measureFactory, filterFactory } from '@sisense/sdk-data';
import * as DM from '../../assets/sample-healthcare-model';
import type { ChartType } from '@sisense/sdk-ui-angular';

@Component({
 selector: 'app-analytics',
 templateUrl: './analytics.component.html',
 styleUrls: ['./analytics.component.scss'],
})
export class AnalyticsComponent {
 DM = DM;
 filters = [filterFactory.members(DM.Divisions.Divison_name, ['Cardiology', 'Neurology'])];
 chart = {
   chartType: 'column' as ChartType,
   dataSet: DM.DataSource,
   dataOptions: {
     category: [DM.Divisions.Divison_name],
     value: [measureFactory.sum(DM.Admissions.Cost_of_admission)],
     breakBy: [],
   },
 };

 onBeforeRender(options: any) {
   console.log('beforeRender');
   console.log(options);
   return options;
 }

 logArguments(...args: any[]) {
   console.log(args);
 }
}
```
<img src="../../../img/angular-column-chart-example.png" width="800px" />

foreRender');
   console.log(options);
   return options;
 }

 logArguments(...args: any[]) {
   console.log(args);
 }
}
```
<img src="../../../img/angular-column-chart-example.png" width="800px" />

## Constructors

### constructor

> **new ColumnChartComponent**(): [`ColumnChartComponent`](class.ColumnChartComponent.md)

#### Returns

[`ColumnChartComponent`](class.ColumnChartComponent.md)

## Properties

tors

### constructor

> **new ColumnChartComponent**(): [`ColumnChartComponent`](class.ColumnChartComponent.md)

#### Returns

[`ColumnChartComponent`](class.ColumnChartComponent.md)

## Properties

### Data

#### dataSet

> **dataSet**: [`Data`](../../sdk-data/interfaces/interface.Data.md) \| [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md) \| `undefined`

Data set for a chart using one of the following options. If neither option is specified, the chart
will use the `defaultDataSource` specified in the parent `SisenseContextProvider`
component.

(1) Sisense data source name as a string. For example, `'Sample ECommerce'`. Typically, you
retrieve the data source name from a data model you create using the `get-data-model`
[command](https://developer.sisense.com/guides/sdk/guides/cli.html) of the Compose SDK CLI. The chart
connects to the data source, executes a query, and loads the data as specified in
`dataOptions`, `filters`, and `highlights`.

To learn more about using data from a Sisense data source, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#sisense-data).

OR

(2) Explicit [`Data`](../../sdk-data/interfaces/interface.Data.md), which is made up of an array of
[`Column`](../../sdk-data/interfaces/interface.Column.md) objects and a two-dimensional array of row data. This approach
allows the chart component to be used with any data you provide.

To learn more about using data from an external data source, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#explicit-data).

Example data in the proper format:

```ts
const sampleData = {
  columns: [
    { name: 'Years', type: 'date' },
    { name: 'Quantity', type: 'number' },
    { name: 'Units', type: 'number' },
  ],
  rows: [
    ['2019', 5500, 1500],
    ['2020', 4471, 7000],
    ['2021', 1812, 5000],
    ['2022', 5001, 6000],
    ['2023', 2045, 4000],
  ],
};
```

***

#### filters

> **filters**: [`FilterRelations`](../../sdk-data/interfaces/interface.FilterRelations.md) \| [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[] \| `undefined`

Filters to limit (or slice) a chart’s data using one of the following options.

(1) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) or [FilterRelations](../../sdk-data/interfaces/interface.FilterRelations.md) returned from filter factory functions, such as
[`greaterThan()`](../../sdk-data/factories/namespace.filterFactory/functions/function.greaterThan.md) and [`members()`](../../sdk-data/factories/namespace.filterFactory/functions/function.members.md).

Use this option for filters that do not require a UI to set them
or for filters where you will supply your own UI components or use pre-built UI components. This is the most common option.

To learn more about using filter factory functions to create filters, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-functions).

(2) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) controlled by filter UI components – for example [`MemberFilterTile`](../../sdk-ui/filter-tiles/function.MemberFilterTile.md).

Use this option for filters that you want your users to set using pre-built UI components.

To learn more about using filter UI components to create filters, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components).

***

#### highlights

> **highlights**: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[] \| `undefined`

Highlights based on filter criteria to apply to a chart using one of the following options.

NOTE that the filter dimensions used in highlights must match those defined in the
`dataOptions` of the chart. Otherwise, the filters will be applied as regular slice filters.

(1) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) returned from filter factory functions, such as
[`greaterThan()`](../../sdk-data/factories/namespace.filterFactory/functions/function.greaterThan.md) and [`members()`](../../sdk-data/factories/namespace.filterFactory/functions/function.members.md).

Use this option for highlights that do not require a UI to set them
or for highlights where you will supply your own UI components or use pre-built UI components. This is the most common option.

To learn more about using filter factory functions to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-functions-for-highlighting).

(2) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) controlled by filter UI components – for example [`MemberFilterTile`](../../sdk-ui/filter-tiles/function.MemberFilterTile.md).

Use this option for highlights that you want your users to set using pre-built UI components.

To learn more about using filter components to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components-for-highlighting).

ts.

To learn more about using filter components to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components-for-highlighting).

### Chart

#### dataOptions

> **dataOptions**: [`CartesianChartDataOptions`](../interfaces/interface.CartesianChartDataOptions.md)

Configurations for how to interpret and present a chart's data.

To learn more about using data options,
see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#dataoptions).

***

#### styleOptions

> **styleOptions**: [`StackableStyleOptions`](../interfaces/interface.StackableStyleOptions.md) \| `undefined`

Configurations for how to style and present a chart's data.

.

***

#### styleOptions

> **styleOptions**: [`StackableStyleOptions`](../interfaces/interface.StackableStyleOptions.md) \| `undefined`

Configurations for how to style and present a chart's data.

### Callbacks

#### beforeRender

> **beforeRender**: [`BeforeRenderHandler`](../type-aliases/type-alias.BeforeRenderHandler.md) \| `undefined`

A callback that allows you to customize the underlying chart element before it is rendered.
Use the `highchartsOptions` object that is passed to the callback to change
[options values](https://api.highcharts.com/highcharts/) and then return the modified options
object. The returned options are then used when rendering the chart.

This callback is not supported for Indicator Chart, Areamap Chart, Scattermap Chart, and Table.

For an example of how the `onBeforeRender` callback can be used, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#callbacks).

***

#### dataPointClick

> **dataPointClick**: `EventEmitter`\< [`DataPointEvent`](../type-aliases/type-alias.DataPointEvent.md) \>

A callback that allows you to customize what happens when a data point is clicked.

To learn more about callbacks, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#callbacks).

***

#### dataPointContextMenu

> **dataPointContextMenu**: `EventEmitter`\< [`DataPointEvent`](../type-aliases/type-alias.DataPointEvent.md) \>

A callback that allows you to customize what happens when a context menu is displayed for a data point.

To learn more about callbacks, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#callbacks).

***

#### dataPointsSelect

> **dataPointsSelect**: `EventEmitter`\< [`DataPointsEvent`](../type-aliases/type-alias.DataPointsEvent.md) \>

A callback that allows you to customize what happens when data points are selected.

To learn more about callbacks, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#callbacks).

***

#### dataReady

> **dataReady**: (`data`) => [`Data`](../../sdk-data/interfaces/interface.Data.md) \| `undefined`

A callback that allows to modify data immediately after it has been retrieved.
It can be used to inject modification of queried data.

a`](../../sdk-data/interfaces/interface.Data.md) \| `undefined`

A callback that allows to modify data immediately after it has been retrieved.
It can be used to inject modification of queried data.

# Class FunnelChartComponent

A component representing data progressively decreasing in size or quantity through a funnel shape.

en retrieved.
It can be used to inject modification of queried data.

# Class FunnelChartComponent

A component representing data progressively decreasing in size or quantity through a funnel shape.

## Example

```html
   <csdk-funnel-chart
     [dataSet]="chart.dataSet"
     [dataOptions]="chart.dataOptions"
     [highlights]="filters"
     [beforeRender]="onBeforeRender"
     (dataPointClick)="logArguments($event)"
     (dataPointContextMenu)="logArguments($event)"
     (dataPointsSelect)="logArguments($event)"
   />
```
```ts
import { Component } from '@angular/core';
import { measureFactory, filterFactory, Filter } from '@sisense/sdk-data';
import * as DM from '../../assets/sample-healthcare-model';
import type { ChartType } from '@sisense/sdk-ui-angular';
@Component({
 selector: 'app-analytics',
 templateUrl: './analytics.component.html',
 styleUrls: ['./analytics.component.scss'],
})
export class AnalyticsComponent {
 DM = DM;
 filters = [filterFactory.members(DM.Divisions.Divison_name, ['Cardiology', 'Neurology'])];
 chart = {
   chartType: 'column' as ChartType,
   dataSet: DM.DataSource,
   dataOptions: {
     category: [DM.Divisions.Divison_name],
     value: [measureFactory.sum(DM.Admissions.Cost_of_admission)],
     breakBy: [],
   },
 };

 onBeforeRender(options: any) {
   console.log('beforeRender');
   console.log(options);
   return options;
 }

 logArguments(...args: any[]) {
   console.log(args);
 }
}
```
<img src="../../../img/angular-funnel-chart-example.png" width="800px" />

foreRender');
   console.log(options);
   return options;
 }

 logArguments(...args: any[]) {
   console.log(args);
 }
}
```
<img src="../../../img/angular-funnel-chart-example.png" width="800px" />

## Constructors

### constructor

> **new FunnelChartComponent**(): [`FunnelChartComponent`](class.FunnelChartComponent.md)

#### Returns

[`FunnelChartComponent`](class.FunnelChartComponent.md)

## Properties

tors

### constructor

> **new FunnelChartComponent**(): [`FunnelChartComponent`](class.FunnelChartComponent.md)

#### Returns

[`FunnelChartComponent`](class.FunnelChartComponent.md)

## Properties

### Data

#### dataSet

> **dataSet**: [`Data`](../../sdk-data/interfaces/interface.Data.md) \| [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md) \| `undefined`

Data set for a chart using one of the following options. If neither option is specified, the chart
will use the `defaultDataSource` specified in the parent `SisenseContextProvider`
component.

(1) Sisense data source name as a string. For example, `'Sample ECommerce'`. Typically, you
retrieve the data source name from a data model you create using the `get-data-model`
[command](https://developer.sisense.com/guides/sdk/guides/cli.html) of the Compose SDK CLI. The chart
connects to the data source, executes a query, and loads the data as specified in
`dataOptions`, `filters`, and `highlights`.

To learn more about using data from a Sisense data source, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#sisense-data).

OR

(2) Explicit [`Data`](../../sdk-data/interfaces/interface.Data.md), which is made up of an array of
[`Column`](../../sdk-data/interfaces/interface.Column.md) objects and a two-dimensional array of row data. This approach
allows the chart component to be used with any data you provide.

To learn more about using data from an external data source, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#explicit-data).

Example data in the proper format:

```ts
const sampleData = {
  columns: [
    { name: 'Years', type: 'date' },
    { name: 'Quantity', type: 'number' },
    { name: 'Units', type: 'number' },
  ],
  rows: [
    ['2019', 5500, 1500],
    ['2020', 4471, 7000],
    ['2021', 1812, 5000],
    ['2022', 5001, 6000],
    ['2023', 2045, 4000],
  ],
};
```

***

#### filters

> **filters**: [`FilterRelations`](../../sdk-data/interfaces/interface.FilterRelations.md) \| [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[] \| `undefined`

Filters to limit (or slice) a chart’s data using one of the following options.

(1) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) or [FilterRelations](../../sdk-data/interfaces/interface.FilterRelations.md) returned from filter factory functions, such as
[`greaterThan()`](../../sdk-data/factories/namespace.filterFactory/functions/function.greaterThan.md) and [`members()`](../../sdk-data/factories/namespace.filterFactory/functions/function.members.md).

Use this option for filters that do not require a UI to set them
or for filters where you will supply your own UI components or use pre-built UI components. This is the most common option.

To learn more about using filter factory functions to create filters, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-functions).

(2) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) controlled by filter UI components – for example [`MemberFilterTile`](../../sdk-ui/filter-tiles/function.MemberFilterTile.md).

Use this option for filters that you want your users to set using pre-built UI components.

To learn more about using filter UI components to create filters, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components).

***

#### highlights

> **highlights**: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[] \| `undefined`

Highlights based on filter criteria to apply to a chart using one of the following options.

NOTE that the filter dimensions used in highlights must match those defined in the
`dataOptions` of the chart. Otherwise, the filters will be applied as regular slice filters.

(1) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) returned from filter factory functions, such as
[`greaterThan()`](../../sdk-data/factories/namespace.filterFactory/functions/function.greaterThan.md) and [`members()`](../../sdk-data/factories/namespace.filterFactory/functions/function.members.md).

Use this option for highlights that do not require a UI to set them
or for highlights where you will supply your own UI components or use pre-built UI components. This is the most common option.

To learn more about using filter factory functions to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-functions-for-highlighting).

(2) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) controlled by filter UI components – for example [`MemberFilterTile`](../../sdk-ui/filter-tiles/function.MemberFilterTile.md).

Use this option for highlights that you want your users to set using pre-built UI components.

To learn more about using filter components to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components-for-highlighting).

ts.

To learn more about using filter components to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components-for-highlighting).

### Chart

#### dataOptions

> **dataOptions**: [`CategoricalChartDataOptions`](../interfaces/interface.CategoricalChartDataOptions.md)

Configurations for how to interpret and present the data passed to the chart

***

#### styleOptions

> **styleOptions**: [`FunnelStyleOptions`](../interfaces/interface.FunnelStyleOptions.md) \| `undefined`

Configurations for how to style and present a chart's data.

e chart

***

#### styleOptions

> **styleOptions**: [`FunnelStyleOptions`](../interfaces/interface.FunnelStyleOptions.md) \| `undefined`

Configurations for how to style and present a chart's data.

### Callbacks

#### beforeRender

> **beforeRender**: [`BeforeRenderHandler`](../type-aliases/type-alias.BeforeRenderHandler.md) \| `undefined`

A callback that allows you to customize the underlying chart element before it is rendered.
Use the `highchartsOptions` object that is passed to the callback to change
[options values](https://api.highcharts.com/highcharts/) and then return the modified options
object. The returned options are then used when rendering the chart.

This callback is not supported for Indicator Chart, Areamap Chart, Scattermap Chart, and Table.

For an example of how the `onBeforeRender` callback can be used, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#callbacks).

***

#### dataPointClick

> **dataPointClick**: `EventEmitter`\< [`DataPointEvent`](../type-aliases/type-alias.DataPointEvent.md) \>

A callback that allows you to customize what happens when a data point is clicked.

To learn more about callbacks, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#callbacks).

***

#### dataPointContextMenu

> **dataPointContextMenu**: `EventEmitter`\< [`DataPointEvent`](../type-aliases/type-alias.DataPointEvent.md) \>

A callback that allows you to customize what happens when a context menu is displayed for a data point.

To learn more about callbacks, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#callbacks).

***

#### dataPointsSelect

> **dataPointsSelect**: `EventEmitter`\< [`DataPointsEvent`](../type-aliases/type-alias.DataPointsEvent.md) \>

A callback that allows you to customize what happens when data points are selected.

To learn more about callbacks, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#callbacks).

***

#### dataReady

> **dataReady**: (`data`) => [`Data`](../../sdk-data/interfaces/interface.Data.md) \| `undefined`

A callback that allows to modify data immediately after it has been retrieved.
It can be used to inject modification of queried data.

a`](../../sdk-data/interfaces/interface.Data.md) \| `undefined`

A callback that allows to modify data immediately after it has been retrieved.
It can be used to inject modification of queried data.

# Class IndicatorChartComponent

A component that provides various options for displaying one or two numeric values as a number, gauge or ticker.

can be used to inject modification of queried data.

# Class IndicatorChartComponent

A component that provides various options for displaying one or two numeric values as a number, gauge or ticker.

## Example

```html
   <csdk-indicator-chart
     [dataSet]="indicator.dataSet"
     [dataOptions]="indicator.dataOptions"
     [filters]="filters"
     [styleOptions]="indicator.styleOptions"
   />
```
```ts
import { Component } from '@angular/core';
import { measureFactory, filterFactory } from '@sisense/sdk-data';
import * as DM from '../../assets/sample-healthcare-model';
import type { IndicatorStyleOptions } from '@sisense/sdk-ui-angular';

@Component({
 selector: 'app-analytics',
 templateUrl: './analytics.component.html',
 styleUrls: ['./analytics.component.scss'],
})
export class AnalyticsComponent {
 DM = DM;
 filters = [filterFactory.members(DM.Divisions.Divison_name, ['Cardiology', 'Neurology'])];
 indicator = {
   dataSet: DM.DataSource,
   dataOptions: {
     value: [measureFactory.sum(DM.Admissions.Cost_of_admission)],
     secondary: [measureFactory.sum(DM.Admissions.Diagnosis_ID)],
   },
   styleOptions: {
     indicatorComponents: {
       title: {
         shouldBeShown: true,
         text: 'Total Cost_of_admission',
       },
       secondaryTitle: {
         text: 'Total Diagnosis_ID',
       },
       ticks: {
         shouldBeShown: true,
       },
       labels: {
         shouldBeShown: true,
       },
     },
     subtype: 'indicator/gauge',
     skin: 2,
   } as IndicatorStyleOptions,
 };

}
```
<img src="../../../img/angular-indicator-chart-example.png" width="800px" />

BeShown: true,
       },
     },
     subtype: 'indicator/gauge',
     skin: 2,
   } as IndicatorStyleOptions,
 };

}
```
<img src="../../../img/angular-indicator-chart-example.png" width="800px" />

## Constructors

### constructor

> **new IndicatorChartComponent**(): [`IndicatorChartComponent`](class.IndicatorChartComponent.md)

#### Returns

[`IndicatorChartComponent`](class.IndicatorChartComponent.md)

## Properties

ructor

> **new IndicatorChartComponent**(): [`IndicatorChartComponent`](class.IndicatorChartComponent.md)

#### Returns

[`IndicatorChartComponent`](class.IndicatorChartComponent.md)

## Properties

### Data

#### dataSet

> **dataSet**: [`Data`](../../sdk-data/interfaces/interface.Data.md) \| [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md) \| `undefined`

Data set for a chart using one of the following options. If neither option is specified, the chart
will use the `defaultDataSource` specified in the parent `SisenseContextProvider`
component.

(1) Sisense data source name as a string. For example, `'Sample ECommerce'`. Typically, you
retrieve the data source name from a data model you create using the `get-data-model`
[command](https://developer.sisense.com/guides/sdk/guides/cli.html) of the Compose SDK CLI. The chart
connects to the data source, executes a query, and loads the data as specified in
`dataOptions`, `filters`, and `highlights`.

To learn more about using data from a Sisense data source, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#sisense-data).

OR

(2) Explicit [`Data`](../../sdk-data/interfaces/interface.Data.md), which is made up of an array of
[`Column`](../../sdk-data/interfaces/interface.Column.md) objects and a two-dimensional array of row data. This approach
allows the chart component to be used with any data you provide.

To learn more about using data from an external data source, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#explicit-data).

Example data in the proper format:

```ts
const sampleData = {
  columns: [
    { name: 'Years', type: 'date' },
    { name: 'Quantity', type: 'number' },
    { name: 'Units', type: 'number' },
  ],
  rows: [
    ['2019', 5500, 1500],
    ['2020', 4471, 7000],
    ['2021', 1812, 5000],
    ['2022', 5001, 6000],
    ['2023', 2045, 4000],
  ],
};
```

***

#### filters

> **filters**: [`FilterRelations`](../../sdk-data/interfaces/interface.FilterRelations.md) \| [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[] \| `undefined`

Filters to limit (or slice) a chart’s data using one of the following options.

(1) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) or [FilterRelations](../../sdk-data/interfaces/interface.FilterRelations.md) returned from filter factory functions, such as
[`greaterThan()`](../../sdk-data/factories/namespace.filterFactory/functions/function.greaterThan.md) and [`members()`](../../sdk-data/factories/namespace.filterFactory/functions/function.members.md).

Use this option for filters that do not require a UI to set them
or for filters where you will supply your own UI components or use pre-built UI components. This is the most common option.

To learn more about using filter factory functions to create filters, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-functions).

(2) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) controlled by filter UI components – for example [`MemberFilterTile`](../../sdk-ui/filter-tiles/function.MemberFilterTile.md).

Use this option for filters that you want your users to set using pre-built UI components.

To learn more about using filter UI components to create filters, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components).

***

#### highlights

> **highlights**: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[] \| `undefined`

Highlights based on filter criteria to apply to a chart using one of the following options.

NOTE that the filter dimensions used in highlights must match those defined in the
`dataOptions` of the chart. Otherwise, the filters will be applied as regular slice filters.

(1) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) returned from filter factory functions, such as
[`greaterThan()`](../../sdk-data/factories/namespace.filterFactory/functions/function.greaterThan.md) and [`members()`](../../sdk-data/factories/namespace.filterFactory/functions/function.members.md).

Use this option for highlights that do not require a UI to set them
or for highlights where you will supply your own UI components or use pre-built UI components. This is the most common option.

To learn more about using filter factory functions to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-functions-for-highlighting).

(2) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) controlled by filter UI components – for example [`MemberFilterTile`](../../sdk-ui/filter-tiles/function.MemberFilterTile.md).

Use this option for highlights that you want your users to set using pre-built UI components.

To learn more about using filter components to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components-for-highlighting).

ts.

To learn more about using filter components to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components-for-highlighting).

### Chart

#### dataOptions

> **dataOptions**: [`IndicatorChartDataOptions`](../interfaces/interface.IndicatorChartDataOptions.md)

Configurations for how to interpret and present the data passed to the chart

***

#### styleOptions

> **styleOptions**: [`IndicatorStyleOptions`](../type-aliases/type-alias.IndicatorStyleOptions.md) \| `undefined`

Configurations for how to style and present a chart's data.

### Callbacks

#### beforeRender

> **beforeRender**: [`IndicatorBeforeRenderHandler`](../type-aliases/type-alias.IndicatorBeforeRenderHandler.md) \| `undefined`

A callback that allows you to customize the underlying indicator chart element before it is rendered.
The returned options are then used when rendering the chart.

***

#### dataReady

> **dataReady**: (`data`) => [`Data`](../../sdk-data/interfaces/interface.Data.md) \| `undefined`

A callback that allows to modify data immediately after it has been retrieved.
It can be used to inject modification of queried data.

# Class LineChartComponent

A component displaying data as a series of points connected by a line. Used to show trends or changes over time.

.
It can be used to inject modification of queried data.

# Class LineChartComponent

A component displaying data as a series of points connected by a line. Used to show trends or changes over time.

## Example

```html
   <csdk-line-chart
     [dataSet]="chart.dataSet"
     [dataOptions]="chart.dataOptions"
     [highlights]="filters"
     [beforeRender]="onBeforeRender"
     (dataPointClick)="logArguments($event)"
     (dataPointContextMenu)="logArguments($event)"
     (dataPointsSelect)="logArguments($event)"
   />
```
```ts
import { Component } from '@angular/core';
import { measureFactory, filterFactory, Filter } from '@sisense/sdk-data';
import * as DM from '../../assets/sample-healthcare-model';
import type { ChartType } from '@sisense/sdk-ui-angular';
@Component({
 selector: 'app-analytics',
 templateUrl: './analytics.component.html',
 styleUrls: ['./analytics.component.scss'],
})
export class AnalyticsComponent {
 DM = DM;
 filters = [filterFactory.members(DM.Divisions.Divison_name, ['Cardiology', 'Neurology'])];
 chart = {
   chartType: 'column' as ChartType,
   dataSet: DM.DataSource,
   dataOptions: {
     category: [DM.Divisions.Divison_name],
     value: [measureFactory.sum(DM.Admissions.Cost_of_admission)],
     breakBy: [],
   },
 };

 onBeforeRender(options: any) {
   console.log('beforeRender');
   console.log(options);
   return options;
 }

 logArguments(...args: any[]) {
   console.log(args);
 }
}
```
<img src="../../../img/angular-line-chart-example.png" width="800px" />

beforeRender');
   console.log(options);
   return options;
 }

 logArguments(...args: any[]) {
   console.log(args);
 }
}
```
<img src="../../../img/angular-line-chart-example.png" width="800px" />

## Constructors

### constructor

> **new LineChartComponent**(): [`LineChartComponent`](class.LineChartComponent.md)

#### Returns

[`LineChartComponent`](class.LineChartComponent.md)

## Properties

# Constructors

### constructor

> **new LineChartComponent**(): [`LineChartComponent`](class.LineChartComponent.md)

#### Returns

[`LineChartComponent`](class.LineChartComponent.md)

## Properties

### Data

#### dataOptions

> **dataOptions**: [`CartesianChartDataOptions`](../interfaces/interface.CartesianChartDataOptions.md)

Configurations for how to interpret and present a chart's data.

To learn more about using data options,
see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#dataoptions).

***

#### dataSet

> **dataSet**: [`Data`](../../sdk-data/interfaces/interface.Data.md) \| [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md) \| `undefined`

Data set for a chart using one of the following options. If neither option is specified, the chart
will use the `defaultDataSource` specified in the parent `SisenseContextProvider`
component.

(1) Sisense data source name as a string. For example, `'Sample ECommerce'`. Typically, you
retrieve the data source name from a data model you create using the `get-data-model`
[command](https://developer.sisense.com/guides/sdk/guides/cli.html) of the Compose SDK CLI. The chart
connects to the data source, executes a query, and loads the data as specified in
`dataOptions`, `filters`, and `highlights`.

To learn more about using data from a Sisense data source, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#sisense-data).

OR

(2) Explicit [`Data`](../../sdk-data/interfaces/interface.Data.md), which is made up of an array of
[`Column`](../../sdk-data/interfaces/interface.Column.md) objects and a two-dimensional array of row data. This approach
allows the chart component to be used with any data you provide.

To learn more about using data from an external data source, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#explicit-data).

Example data in the proper format:

```ts
const sampleData = {
  columns: [
    { name: 'Years', type: 'date' },
    { name: 'Quantity', type: 'number' },
    { name: 'Units', type: 'number' },
  ],
  rows: [
    ['2019', 5500, 1500],
    ['2020', 4471, 7000],
    ['2021', 1812, 5000],
    ['2022', 5001, 6000],
    ['2023', 2045, 4000],
  ],
};
```

***

#### filters

> **filters**: [`FilterRelations`](../../sdk-data/interfaces/interface.FilterRelations.md) \| [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[] \| `undefined`

Filters to limit (or slice) a chart’s data using one of the following options.

(1) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) or [FilterRelations](../../sdk-data/interfaces/interface.FilterRelations.md) returned from filter factory functions, such as
[`greaterThan()`](../../sdk-data/factories/namespace.filterFactory/functions/function.greaterThan.md) and [`members()`](../../sdk-data/factories/namespace.filterFactory/functions/function.members.md).

Use this option for filters that do not require a UI to set them
or for filters where you will supply your own UI components or use pre-built UI components. This is the most common option.

To learn more about using filter factory functions to create filters, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-functions).

(2) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) controlled by filter UI components – for example [`MemberFilterTile`](../../sdk-ui/filter-tiles/function.MemberFilterTile.md).

Use this option for filters that you want your users to set using pre-built UI components.

To learn more about using filter UI components to create filters, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components).

***

#### highlights

> **highlights**: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[] \| `undefined`

Highlights based on filter criteria to apply to a chart using one of the following options.

NOTE that the filter dimensions used in highlights must match those defined in the
`dataOptions` of the chart. Otherwise, the filters will be applied as regular slice filters.

(1) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) returned from filter factory functions, such as
[`greaterThan()`](../../sdk-data/factories/namespace.filterFactory/functions/function.greaterThan.md) and [`members()`](../../sdk-data/factories/namespace.filterFactory/functions/function.members.md).

Use this option for highlights that do not require a UI to set them
or for highlights where you will supply your own UI components or use pre-built UI components. This is the most common option.

To learn more about using filter factory functions to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-functions-for-highlighting).

(2) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) controlled by filter UI components – for example [`MemberFilterTile`](../../sdk-ui/filter-tiles/function.MemberFilterTile.md).

Use this option for highlights that you want your users to set using pre-built UI components.

To learn more about using filter components to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components-for-highlighting).

ts.

To learn more about using filter components to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components-for-highlighting).

### Chart

#### styleOptions

> **styleOptions**: [`LineStyleOptions`](../interfaces/interface.LineStyleOptions.md) \| `undefined`

Configurations for how to style and present a chart's data.

ing).

### Chart

#### styleOptions

> **styleOptions**: [`LineStyleOptions`](../interfaces/interface.LineStyleOptions.md) \| `undefined`

Configurations for how to style and present a chart's data.

### Callbacks

#### beforeRender

> **beforeRender**: [`BeforeRenderHandler`](../type-aliases/type-alias.BeforeRenderHandler.md) \| `undefined`

A callback that allows you to customize the underlying chart element before it is rendered.
Use the `highchartsOptions` object that is passed to the callback to change
[options values](https://api.highcharts.com/highcharts/) and then return the modified options
object. The returned options are then used when rendering the chart.

This callback is not supported for Indicator Chart, Areamap Chart, Scattermap Chart, and Table.

For an example of how the `onBeforeRender` callback can be used, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#callbacks).

***

#### dataPointClick

> **dataPointClick**: `EventEmitter`\< [`DataPointEvent`](../type-aliases/type-alias.DataPointEvent.md) \>

A callback that allows you to customize what happens when a data point is clicked.

To learn more about callbacks, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#callbacks).

***

#### dataPointContextMenu

> **dataPointContextMenu**: `EventEmitter`\< [`DataPointEvent`](../type-aliases/type-alias.DataPointEvent.md) \>

A callback that allows you to customize what happens when a context menu is displayed for a data point.

To learn more about callbacks, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#callbacks).

***

#### dataPointsSelect

> **dataPointsSelect**: `EventEmitter`\< [`DataPointsEvent`](../type-aliases/type-alias.DataPointsEvent.md) \>

A callback that allows you to customize what happens when data points are selected.

To learn more about callbacks, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#callbacks).

***

#### dataReady

> **dataReady**: (`data`) => [`Data`](../../sdk-data/interfaces/interface.Data.md) \| `undefined`

A callback that allows to modify data immediately after it has been retrieved.
It can be used to inject modification of queried data.

a`](../../sdk-data/interfaces/interface.Data.md) \| `undefined`

A callback that allows to modify data immediately after it has been retrieved.
It can be used to inject modification of queried data.

# Class PieChartComponent

A component representing data in a circular graph with the data shown as slices of a whole,
with each slice representing a proportion of the total.

ation of queried data.

# Class PieChartComponent

A component representing data in a circular graph with the data shown as slices of a whole,
with each slice representing a proportion of the total.

## Example

```html
   <csdk-pie-chart
     [dataSet]="chart.dataSet"
     [dataOptions]="chart.dataOptions"
     [highlights]="filters"
     [beforeRender]="onBeforeRender"
     (dataPointClick)="logArguments($event)"
     (dataPointContextMenu)="logArguments($event)"
     (dataPointsSelect)="logArguments($event)"
   />
```
```ts
import { Component } from '@angular/core';
import { measureFactory, filterFactory } from '@sisense/sdk-data';
import * as DM from '../../assets/sample-healthcare-model';
import type { ChartType } from '@sisense/sdk-ui-angular';

@Component({
 selector: 'app-analytics',
 templateUrl: './analytics.component.html',
 styleUrls: ['./analytics.component.scss'],
})
export class AnalyticsComponent {
 DM = DM;
 filters = [filterFactory.members(DM.Divisions.Divison_name, ['Cardiology', 'Neurology'])];
 chart = {
   chartType: 'column' as ChartType,
   dataSet: DM.DataSource,
   dataOptions: {
     category: [DM.Divisions.Divison_name],
     value: [measureFactory.sum(DM.Admissions.Cost_of_admission)],
     breakBy: [],
   },
 };

 onBeforeRender(options: any) {
   console.log('beforeRender');
   console.log(options);
   return options;
 }

 logArguments(...args: any[]) {
   console.log(args);
 }
}
```
<img src="../../../img/angular-pie-chart-example.png" width="800px" />

'beforeRender');
   console.log(options);
   return options;
 }

 logArguments(...args: any[]) {
   console.log(args);
 }
}
```
<img src="../../../img/angular-pie-chart-example.png" width="800px" />

## Constructors

### constructor

> **new PieChartComponent**(): [`PieChartComponent`](class.PieChartComponent.md)

#### Returns

[`PieChartComponent`](class.PieChartComponent.md)

## Properties

/>

## Constructors

### constructor

> **new PieChartComponent**(): [`PieChartComponent`](class.PieChartComponent.md)

#### Returns

[`PieChartComponent`](class.PieChartComponent.md)

## Properties

### Data

#### dataOptions

> **dataOptions**: [`CategoricalChartDataOptions`](../interfaces/interface.CategoricalChartDataOptions.md)

Configurations for how to interpret and present the data passed to the chart

***

#### dataSet

> **dataSet**: [`Data`](../../sdk-data/interfaces/interface.Data.md) \| [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md) \| `undefined`

Data set for a chart using one of the following options. If neither option is specified, the chart
will use the `defaultDataSource` specified in the parent `SisenseContextProvider`
component.

(1) Sisense data source name as a string. For example, `'Sample ECommerce'`. Typically, you
retrieve the data source name from a data model you create using the `get-data-model`
[command](https://developer.sisense.com/guides/sdk/guides/cli.html) of the Compose SDK CLI. The chart
connects to the data source, executes a query, and loads the data as specified in
`dataOptions`, `filters`, and `highlights`.

To learn more about using data from a Sisense data source, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#sisense-data).

OR

(2) Explicit [`Data`](../../sdk-data/interfaces/interface.Data.md), which is made up of an array of
[`Column`](../../sdk-data/interfaces/interface.Column.md) objects and a two-dimensional array of row data. This approach
allows the chart component to be used with any data you provide.

To learn more about using data from an external data source, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#explicit-data).

Example data in the proper format:

```ts
const sampleData = {
  columns: [
    { name: 'Years', type: 'date' },
    { name: 'Quantity', type: 'number' },
    { name: 'Units', type: 'number' },
  ],
  rows: [
    ['2019', 5500, 1500],
    ['2020', 4471, 7000],
    ['2021', 1812, 5000],
    ['2022', 5001, 6000],
    ['2023', 2045, 4000],
  ],
};
```

***

#### filters

> **filters**: [`FilterRelations`](../../sdk-data/interfaces/interface.FilterRelations.md) \| [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[] \| `undefined`

Filters to limit (or slice) a chart’s data using one of the following options.

(1) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) or [FilterRelations](../../sdk-data/interfaces/interface.FilterRelations.md) returned from filter factory functions, such as
[`greaterThan()`](../../sdk-data/factories/namespace.filterFactory/functions/function.greaterThan.md) and [`members()`](../../sdk-data/factories/namespace.filterFactory/functions/function.members.md).

Use this option for filters that do not require a UI to set them
or for filters where you will supply your own UI components or use pre-built UI components. This is the most common option.

To learn more about using filter factory functions to create filters, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-functions).

(2) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) controlled by filter UI components – for example [`MemberFilterTile`](../../sdk-ui/filter-tiles/function.MemberFilterTile.md).

Use this option for filters that you want your users to set using pre-built UI components.

To learn more about using filter UI components to create filters, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components).

***

#### highlights

> **highlights**: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[] \| `undefined`

Highlights based on filter criteria to apply to a chart using one of the following options.

NOTE that the filter dimensions used in highlights must match those defined in the
`dataOptions` of the chart. Otherwise, the filters will be applied as regular slice filters.

(1) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) returned from filter factory functions, such as
[`greaterThan()`](../../sdk-data/factories/namespace.filterFactory/functions/function.greaterThan.md) and [`members()`](../../sdk-data/factories/namespace.filterFactory/functions/function.members.md).

Use this option for highlights that do not require a UI to set them
or for highlights where you will supply your own UI components or use pre-built UI components. This is the most common option.

To learn more about using filter factory functions to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-functions-for-highlighting).

(2) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) controlled by filter UI components – for example [`MemberFilterTile`](../../sdk-ui/filter-tiles/function.MemberFilterTile.md).

Use this option for highlights that you want your users to set using pre-built UI components.

To learn more about using filter components to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components-for-highlighting).

ts.

To learn more about using filter components to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components-for-highlighting).

### Chart

#### styleOptions

> **styleOptions**: [`PieStyleOptions`](../interfaces/interface.PieStyleOptions.md) \| `undefined`

Configurations for how to style and present a chart's data.

hting).

### Chart

#### styleOptions

> **styleOptions**: [`PieStyleOptions`](../interfaces/interface.PieStyleOptions.md) \| `undefined`

Configurations for how to style and present a chart's data.

### Callbacks

#### beforeRender

> **beforeRender**: [`BeforeRenderHandler`](../type-aliases/type-alias.BeforeRenderHandler.md) \| `undefined`

A callback that allows you to customize the underlying chart element before it is rendered.
Use the `highchartsOptions` object that is passed to the callback to change
[options values](https://api.highcharts.com/highcharts/) and then return the modified options
object. The returned options are then used when rendering the chart.

This callback is not supported for Indicator Chart, Areamap Chart, Scattermap Chart, and Table.

For an example of how the `onBeforeRender` callback can be used, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#callbacks).

***

#### dataPointClick

> **dataPointClick**: `EventEmitter`\< [`DataPointEvent`](../type-aliases/type-alias.DataPointEvent.md) \>

A callback that allows you to customize what happens when a data point is clicked.

To learn more about callbacks, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#callbacks).

***

#### dataPointContextMenu

> **dataPointContextMenu**: `EventEmitter`\< [`DataPointEvent`](../type-aliases/type-alias.DataPointEvent.md) \>

A callback that allows you to customize what happens when a context menu is displayed for a data point.

To learn more about callbacks, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#callbacks).

***

#### dataPointsSelect

> **dataPointsSelect**: `EventEmitter`\< [`DataPointsEvent`](../type-aliases/type-alias.DataPointsEvent.md) \>

A callback that allows you to customize what happens when data points are selected.

To learn more about callbacks, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#callbacks).

***

#### dataReady

> **dataReady**: (`data`) => [`Data`](../../sdk-data/interfaces/interface.Data.md) \| `undefined`

A callback that allows to modify data immediately after it has been retrieved.
It can be used to inject modification of queried data.

a`](../../sdk-data/interfaces/interface.Data.md) \| `undefined`

A callback that allows to modify data immediately after it has been retrieved.
It can be used to inject modification of queried data.

# Class PolarChartComponent

A component comparing multiple categories/variables with a spacial perspective in a radial chart.

been retrieved.
It can be used to inject modification of queried data.

# Class PolarChartComponent

A component comparing multiple categories/variables with a spacial perspective in a radial chart.

## Example

```html
   <csdk-polar-chart
     [dataSet]="chart.dataSet"
     [dataOptions]="chart.dataOptions"
     [highlights]="filters"
     [beforeRender]="onBeforeRender"
     (dataPointClick)="logArguments($event)"
     (dataPointContextMenu)="logArguments($event)"
     (dataPointsSelect)="logArguments($event)"
   />
```
```ts
import { Component } from '@angular/core';
import { measureFactory, filterFactory } from '@sisense/sdk-data';
import * as DM from '../../assets/sample-healthcare-model';
import type { ChartType } from '@sisense/sdk-ui-angular';

@Component({
 selector: 'app-analytics',
 templateUrl: './analytics.component.html',
 styleUrls: ['./analytics.component.scss'],
})
export class AnalyticsComponent {
 DM = DM;
 filters = [filterFactory.members(DM.Divisions.Divison_name, ['Cardiology', 'Neurology'])];
 chart = {
   chartType: 'column' as ChartType,
   dataSet: DM.DataSource,
   dataOptions: {
     category: [DM.Divisions.Divison_name],
     value: [measureFactory.sum(DM.Admissions.Cost_of_admission)],
     breakBy: [],
   },
 };

 onBeforeRender(options: any) {
   console.log('beforeRender');
   console.log(options);
   return options;
 }

 logArguments(...args: any[]) {
   console.log(args);
 }
}
```
<img src="../../../img/angular-polar-chart-example.png" width="800px" />

eforeRender');
   console.log(options);
   return options;
 }

 logArguments(...args: any[]) {
   console.log(args);
 }
}
```
<img src="../../../img/angular-polar-chart-example.png" width="800px" />

## Constructors

### constructor

> **new PolarChartComponent**(): [`PolarChartComponent`](class.PolarChartComponent.md)

#### Returns

[`PolarChartComponent`](class.PolarChartComponent.md)

## Properties

structors

### constructor

> **new PolarChartComponent**(): [`PolarChartComponent`](class.PolarChartComponent.md)

#### Returns

[`PolarChartComponent`](class.PolarChartComponent.md)

## Properties

### Data

#### dataOptions

> **dataOptions**: [`CartesianChartDataOptions`](../interfaces/interface.CartesianChartDataOptions.md)

Configurations for how to interpret and present a chart's data.

To learn more about using data options,
see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#dataoptions).

***

#### dataSet

> **dataSet**: [`Data`](../../sdk-data/interfaces/interface.Data.md) \| [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md) \| `undefined`

Data set for a chart using one of the following options. If neither option is specified, the chart
will use the `defaultDataSource` specified in the parent `SisenseContextProvider`
component.

(1) Sisense data source name as a string. For example, `'Sample ECommerce'`. Typically, you
retrieve the data source name from a data model you create using the `get-data-model`
[command](https://developer.sisense.com/guides/sdk/guides/cli.html) of the Compose SDK CLI. The chart
connects to the data source, executes a query, and loads the data as specified in
`dataOptions`, `filters`, and `highlights`.

To learn more about using data from a Sisense data source, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#sisense-data).

OR

(2) Explicit [`Data`](../../sdk-data/interfaces/interface.Data.md), which is made up of an array of
[`Column`](../../sdk-data/interfaces/interface.Column.md) objects and a two-dimensional array of row data. This approach
allows the chart component to be used with any data you provide.

To learn more about using data from an external data source, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#explicit-data).

Example data in the proper format:

```ts
const sampleData = {
  columns: [
    { name: 'Years', type: 'date' },
    { name: 'Quantity', type: 'number' },
    { name: 'Units', type: 'number' },
  ],
  rows: [
    ['2019', 5500, 1500],
    ['2020', 4471, 7000],
    ['2021', 1812, 5000],
    ['2022', 5001, 6000],
    ['2023', 2045, 4000],
  ],
};
```

***

#### filters

> **filters**: [`FilterRelations`](../../sdk-data/interfaces/interface.FilterRelations.md) \| [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[] \| `undefined`

Filters to limit (or slice) a chart’s data using one of the following options.

(1) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) or [FilterRelations](../../sdk-data/interfaces/interface.FilterRelations.md) returned from filter factory functions, such as
[`greaterThan()`](../../sdk-data/factories/namespace.filterFactory/functions/function.greaterThan.md) and [`members()`](../../sdk-data/factories/namespace.filterFactory/functions/function.members.md).

Use this option for filters that do not require a UI to set them
or for filters where you will supply your own UI components or use pre-built UI components. This is the most common option.

To learn more about using filter factory functions to create filters, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-functions).

(2) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) controlled by filter UI components – for example [`MemberFilterTile`](../../sdk-ui/filter-tiles/function.MemberFilterTile.md).

Use this option for filters that you want your users to set using pre-built UI components.

To learn more about using filter UI components to create filters, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components).

***

#### highlights

> **highlights**: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[] \| `undefined`

Highlights based on filter criteria to apply to a chart using one of the following options.

NOTE that the filter dimensions used in highlights must match those defined in the
`dataOptions` of the chart. Otherwise, the filters will be applied as regular slice filters.

(1) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) returned from filter factory functions, such as
[`greaterThan()`](../../sdk-data/factories/namespace.filterFactory/functions/function.greaterThan.md) and [`members()`](../../sdk-data/factories/namespace.filterFactory/functions/function.members.md).

Use this option for highlights that do not require a UI to set them
or for highlights where you will supply your own UI components or use pre-built UI components. This is the most common option.

To learn more about using filter factory functions to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-functions-for-highlighting).

(2) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) controlled by filter UI components – for example [`MemberFilterTile`](../../sdk-ui/filter-tiles/function.MemberFilterTile.md).

Use this option for highlights that you want your users to set using pre-built UI components.

To learn more about using filter components to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components-for-highlighting).

ts.

To learn more about using filter components to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components-for-highlighting).

### Chart

#### styleOptions

> **styleOptions**: [`PolarStyleOptions`](../interfaces/interface.PolarStyleOptions.md) \| `undefined`

Configurations for how to style and present a chart's data.

g).

### Chart

#### styleOptions

> **styleOptions**: [`PolarStyleOptions`](../interfaces/interface.PolarStyleOptions.md) \| `undefined`

Configurations for how to style and present a chart's data.

### Callbacks

#### beforeRender

> **beforeRender**: [`BeforeRenderHandler`](../type-aliases/type-alias.BeforeRenderHandler.md) \| `undefined`

A callback that allows you to customize the underlying chart element before it is rendered.
Use the `highchartsOptions` object that is passed to the callback to change
[options values](https://api.highcharts.com/highcharts/) and then return the modified options
object. The returned options are then used when rendering the chart.

This callback is not supported for Indicator Chart, Areamap Chart, Scattermap Chart, and Table.

For an example of how the `onBeforeRender` callback can be used, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#callbacks).

***

#### dataPointClick

> **dataPointClick**: `EventEmitter`\< [`DataPointEvent`](../type-aliases/type-alias.DataPointEvent.md) \>

A callback that allows you to customize what happens when a data point is clicked.

To learn more about callbacks, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#callbacks).

***

#### dataPointContextMenu

> **dataPointContextMenu**: `EventEmitter`\< [`DataPointEvent`](../type-aliases/type-alias.DataPointEvent.md) \>

A callback that allows you to customize what happens when a context menu is displayed for a data point.

To learn more about callbacks, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#callbacks).

***

#### dataPointsSelect

> **dataPointsSelect**: `EventEmitter`\< [`DataPointsEvent`](../type-aliases/type-alias.DataPointsEvent.md) \>

A callback that allows you to customize what happens when data points are selected.

To learn more about callbacks, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#callbacks).

***

#### dataReady

> **dataReady**: (`data`) => [`Data`](../../sdk-data/interfaces/interface.Data.md) \| `undefined`

A callback that allows to modify data immediately after it has been retrieved.
It can be used to inject modification of queried data.

a`](../../sdk-data/interfaces/interface.Data.md) \| `undefined`

A callback that allows to modify data immediately after it has been retrieved.
It can be used to inject modification of queried data.

# Class ScatterChartComponent

A component displaying the distribution of two variables on an X-Axis, Y-Axis,
and two additional fields of data that are shown as colored circles scattered across the chart.

**Point**: A field that for each of its members a scatter point is drawn. The maximum amount of data points is 500.

**Size**: An optional field represented by the size of the circles.
If omitted, all scatter points are equal in size. If used, the circle sizes are relative to their values.

of data points is 500.

**Size**: An optional field represented by the size of the circles.
If omitted, all scatter points are equal in size. If used, the circle sizes are relative to their values.

## Example

```html
   <csdk-scatter-chart
     [dataSet]="scatter.dataSet"
     [dataOptions]="scatter.dataOptions"
     [highlights]="filters"
     [beforeRender]="onBeforeRender"
     (dataPointClick)="logArguments($event)"
     (dataPointContextMenu)="logArguments($event)"
     (dataPointsSelect)="logArguments($event)"
   />
```
```ts
import { Component } from '@angular/core';
import { measureFactory, filterFactory } from '@sisense/sdk-data';
import * as DM from '../../assets/sample-healthcare-model';

@Component({
 selector: 'app-analytics',
 templateUrl: './analytics.component.html',
 styleUrls: ['./analytics.component.scss'],
})
export class AnalyticsComponent {
 DM = DM;
 filters = [filterFactory.members(DM.Divisions.Divison_name, ['Cardiology', 'Neurology'])];
 scatter = {
   dataSet: DM.DataSource,
   dataOptions: {
     x: DM.Admissions.Room_ID,
     y: measureFactory.sum(DM.Admissions.Cost_of_admission),
   },
 };

 onBeforeRender(options: any) {
   console.log('beforeRender');
   console.log(options);
   return options;
 }

 logArguments(...args: any[]) {
   console.log(args);
 }
}
```
<img src="../../../img/angular-scatter-chart-example.png" width="800px" />

## Constructors

onsole.log(options);
   return options;
 }

 logArguments(...args: any[]) {
   console.log(args);
 }
}
```
<img src="../../../img/angular-scatter-chart-example.png" width="800px" />

## Constructors

### constructor

> **new ScatterChartComponent**(): [`ScatterChartComponent`](class.ScatterChartComponent.md)

#### Returns

[`ScatterChartComponent`](class.ScatterChartComponent.md)

## Properties

### constructor

> **new ScatterChartComponent**(): [`ScatterChartComponent`](class.ScatterChartComponent.md)

#### Returns

[`ScatterChartComponent`](class.ScatterChartComponent.md)

## Properties

### Data

#### dataOptions

> **dataOptions**: [`ScatterChartDataOptions`](../interfaces/interface.ScatterChartDataOptions.md)

Configurations for how to interpret and present the data passed to the chart

***

#### dataSet

> **dataSet**: [`Data`](../../sdk-data/interfaces/interface.Data.md) \| [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md) \| `undefined`

Data set for a chart using one of the following options. If neither option is specified, the chart
will use the `defaultDataSource` specified in the parent `SisenseContextProvider`
component.

(1) Sisense data source name as a string. For example, `'Sample ECommerce'`. Typically, you
retrieve the data source name from a data model you create using the `get-data-model`
[command](https://developer.sisense.com/guides/sdk/guides/cli.html) of the Compose SDK CLI. The chart
connects to the data source, executes a query, and loads the data as specified in
`dataOptions`, `filters`, and `highlights`.

To learn more about using data from a Sisense data source, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#sisense-data).

OR

(2) Explicit [`Data`](../../sdk-data/interfaces/interface.Data.md), which is made up of an array of
[`Column`](../../sdk-data/interfaces/interface.Column.md) objects and a two-dimensional array of row data. This approach
allows the chart component to be used with any data you provide.

To learn more about using data from an external data source, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#explicit-data).

Example data in the proper format:

```ts
const sampleData = {
  columns: [
    { name: 'Years', type: 'date' },
    { name: 'Quantity', type: 'number' },
    { name: 'Units', type: 'number' },
  ],
  rows: [
    ['2019', 5500, 1500],
    ['2020', 4471, 7000],
    ['2021', 1812, 5000],
    ['2022', 5001, 6000],
    ['2023', 2045, 4000],
  ],
};
```

***

#### filters

> **filters**: [`FilterRelations`](../../sdk-data/interfaces/interface.FilterRelations.md) \| [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[] \| `undefined`

Filters to limit (or slice) a chart’s data using one of the following options.

(1) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) or [FilterRelations](../../sdk-data/interfaces/interface.FilterRelations.md) returned from filter factory functions, such as
[`greaterThan()`](../../sdk-data/factories/namespace.filterFactory/functions/function.greaterThan.md) and [`members()`](../../sdk-data/factories/namespace.filterFactory/functions/function.members.md).

Use this option for filters that do not require a UI to set them
or for filters where you will supply your own UI components or use pre-built UI components. This is the most common option.

To learn more about using filter factory functions to create filters, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-functions).

(2) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) controlled by filter UI components – for example [`MemberFilterTile`](../../sdk-ui/filter-tiles/function.MemberFilterTile.md).

Use this option for filters that you want your users to set using pre-built UI components.

To learn more about using filter UI components to create filters, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components).

***

#### highlights

> **highlights**: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[] \| `undefined`

Highlights based on filter criteria to apply to a chart using one of the following options.

NOTE that the filter dimensions used in highlights must match those defined in the
`dataOptions` of the chart. Otherwise, the filters will be applied as regular slice filters.

(1) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) returned from filter factory functions, such as
[`greaterThan()`](../../sdk-data/factories/namespace.filterFactory/functions/function.greaterThan.md) and [`members()`](../../sdk-data/factories/namespace.filterFactory/functions/function.members.md).

Use this option for highlights that do not require a UI to set them
or for highlights where you will supply your own UI components or use pre-built UI components. This is the most common option.

To learn more about using filter factory functions to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-functions-for-highlighting).

(2) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) controlled by filter UI components – for example [`MemberFilterTile`](../../sdk-ui/filter-tiles/function.MemberFilterTile.md).

Use this option for highlights that you want your users to set using pre-built UI components.

To learn more about using filter components to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components-for-highlighting).

ts.

To learn more about using filter components to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components-for-highlighting).

### Chart

#### styleOptions

> **styleOptions**: [`ScatterStyleOptions`](../interfaces/interface.ScatterStyleOptions.md) \| `undefined`

Configurations for how to style and present a chart's data.

### Chart

#### styleOptions

> **styleOptions**: [`ScatterStyleOptions`](../interfaces/interface.ScatterStyleOptions.md) \| `undefined`

Configurations for how to style and present a chart's data.

### Callbacks

#### beforeRender

> **beforeRender**: [`BeforeRenderHandler`](../type-aliases/type-alias.BeforeRenderHandler.md) \| `undefined`

A callback that allows you to customize the underlying chart element before it is rendered.
Use the `highchartsOptions` object that is passed to the callback to change
[options values](https://api.highcharts.com/highcharts/) and then return the modified options
object. The returned options are then used when rendering the chart.

This callback is not supported for Indicator Chart, Areamap Chart, Scattermap Chart, and Table.

For an example of how the `onBeforeRender` callback can be used, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#callbacks).

***

#### dataPointClick

> **dataPointClick**: `EventEmitter`\< [`ScatterDataPointEvent`](../type-aliases/type-alias.ScatterDataPointEvent.md) \>

Click handler callback for a data point

***

#### dataPointContextMenu

> **dataPointContextMenu**: `EventEmitter`\< [`ScatterDataPointEvent`](../type-aliases/type-alias.ScatterDataPointEvent.md) \>

Context menu handler callback for a data point

***

#### dataPointsSelect

> **dataPointsSelect**: `EventEmitter`\< [`ScatterDataPointsEvent`](../type-aliases/type-alias.ScatterDataPointsEvent.md) \>

Handler callback for selection of multiple data points

***

#### dataReady

> **dataReady**: (`data`) => [`Data`](../../sdk-data/interfaces/interface.Data.md) \| `undefined`

A callback that allows to modify data immediately after it has been retrieved.
It can be used to inject modification of queried data.

a`](../../sdk-data/interfaces/interface.Data.md) \| `undefined`

A callback that allows to modify data immediately after it has been retrieved.
It can be used to inject modification of queried data.

# Class ScattermapChartComponent

An Angular component that allows to visualize geographical data as data points on a map.

has been retrieved.
It can be used to inject modification of queried data.

# Class ScattermapChartComponent

An Angular component that allows to visualize geographical data as data points on a map.

## Example

```html
   <csdk-scattermap-chart
     [dataSet]="scattermapChart.dataSet"
     [dataOptions]="scattermapChart.dataOptions"
     [styleOptions]="scattermapChart.styleOptions"
     (dataPointClick)="logArguments($event)"
   />
```
```ts
import { Component } from '@angular/core';
import { measureFactory, filterFactory } from '@sisense/sdk-data';
import type { ScattermapStyleOptions,ScattermapChartDataOptions } from '@sisense/sdk-ui-angular';
import * as DM from '../../assets/sample-ecommerce';

@Component({
 selector: 'app-analytics',
 templateUrl: './analytics.component.html',
 styleUrls: ['./analytics.component.scss'],
})
export class AnalyticsComponent {
 scattermapChart = {
   dataSet: DM.DataSource,
   dataOptions: {
     geo: [DM.Country.Country],
     size: measureFactory.sum(DM.Commerce.Cost, 'Size by Cost'),
     colorBy: {
       column: measureFactory.sum(DM.Commerce.Revenue, 'Color by Revenue'),
       color: 'green',
     },
     details: DM.Category.Category,
   } as ScattermapChartDataOptions,
   styleOptions: {
     markers: {
       fill: 'hollow-bold',
     },
   } as ScattermapStyleOptions,
 };

 logArguments(...args: any[]) {
   console.log(args);
 }
}
```
<img src="../../../img/angular-scattermap-chart-example.png" width="800px" />

## Constructors

},
   } as ScattermapStyleOptions,
 };

 logArguments(...args: any[]) {
   console.log(args);
 }
}
```
<img src="../../../img/angular-scattermap-chart-example.png" width="800px" />

## Constructors

### constructor

> **new ScattermapChartComponent**(): [`ScattermapChartComponent`](class.ScattermapChartComponent.md)

#### Returns

[`ScattermapChartComponent`](class.ScattermapChartComponent.md)

## Properties

r

> **new ScattermapChartComponent**(): [`ScattermapChartComponent`](class.ScattermapChartComponent.md)

#### Returns

[`ScattermapChartComponent`](class.ScattermapChartComponent.md)

## Properties

### Data

#### dataSet

> **dataSet**: [`Data`](../../sdk-data/interfaces/interface.Data.md) \| [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md) \| `undefined`

Data set for a chart using one of the following options. If neither option is specified, the chart
will use the `defaultDataSource` specified in the parent `SisenseContextProvider`
component.

(1) Sisense data source name as a string. For example, `'Sample ECommerce'`. Typically, you
retrieve the data source name from a data model you create using the `get-data-model`
[command](https://developer.sisense.com/guides/sdk/guides/cli.html) of the Compose SDK CLI. The chart
connects to the data source, executes a query, and loads the data as specified in
`dataOptions`, `filters`, and `highlights`.

To learn more about using data from a Sisense data source, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#sisense-data).

OR

(2) Explicit [`Data`](../../sdk-data/interfaces/interface.Data.md), which is made up of an array of
[`Column`](../../sdk-data/interfaces/interface.Column.md) objects and a two-dimensional array of row data. This approach
allows the chart component to be used with any data you provide.

To learn more about using data from an external data source, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#explicit-data).

Example data in the proper format:

```ts
const sampleData = {
  columns: [
    { name: 'Years', type: 'date' },
    { name: 'Quantity', type: 'number' },
    { name: 'Units', type: 'number' },
  ],
  rows: [
    ['2019', 5500, 1500],
    ['2020', 4471, 7000],
    ['2021', 1812, 5000],
    ['2022', 5001, 6000],
    ['2023', 2045, 4000],
  ],
};
```

***

#### filters

> **filters**: [`FilterRelations`](../../sdk-data/interfaces/interface.FilterRelations.md) \| [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[] \| `undefined`

Filters to limit (or slice) a chart’s data using one of the following options.

(1) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) or [FilterRelations](../../sdk-data/interfaces/interface.FilterRelations.md) returned from filter factory functions, such as
[`greaterThan()`](../../sdk-data/factories/namespace.filterFactory/functions/function.greaterThan.md) and [`members()`](../../sdk-data/factories/namespace.filterFactory/functions/function.members.md).

Use this option for filters that do not require a UI to set them
or for filters where you will supply your own UI components or use pre-built UI components. This is the most common option.

To learn more about using filter factory functions to create filters, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-functions).

(2) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) controlled by filter UI components – for example [`MemberFilterTile`](../../sdk-ui/filter-tiles/function.MemberFilterTile.md).

Use this option for filters that you want your users to set using pre-built UI components.

To learn more about using filter UI components to create filters, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components).

***

#### highlights

> **highlights**: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[] \| `undefined`

Highlights based on filter criteria to apply to a chart using one of the following options.

NOTE that the filter dimensions used in highlights must match those defined in the
`dataOptions` of the chart. Otherwise, the filters will be applied as regular slice filters.

(1) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) returned from filter factory functions, such as
[`greaterThan()`](../../sdk-data/factories/namespace.filterFactory/functions/function.greaterThan.md) and [`members()`](../../sdk-data/factories/namespace.filterFactory/functions/function.members.md).

Use this option for highlights that do not require a UI to set them
or for highlights where you will supply your own UI components or use pre-built UI components. This is the most common option.

To learn more about using filter factory functions to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-functions-for-highlighting).

(2) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) controlled by filter UI components – for example [`MemberFilterTile`](../../sdk-ui/filter-tiles/function.MemberFilterTile.md).

Use this option for highlights that you want your users to set using pre-built UI components.

To learn more about using filter components to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components-for-highlighting).

ts.

To learn more about using filter components to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components-for-highlighting).

### Chart

#### dataOptions

> **dataOptions**: [`ScattermapChartDataOptions`](../interfaces/interface.ScattermapChartDataOptions.md)

Configurations for how to interpret and present the data passed to the chart

***

#### styleOptions

> **styleOptions**: [`ScattermapStyleOptions`](../interfaces/interface.ScattermapStyleOptions.md) \| `undefined`

Configurations for how to style and present a chart's data.

### Callbacks

#### dataPointClick

> **dataPointClick**: `EventEmitter`\< [`ScattermapDataPointEvent`](../type-aliases/type-alias.ScattermapDataPointEvent.md) \>

Click handler callback for a data point

***

#### dataReady

> **dataReady**: (`data`) => [`Data`](../../sdk-data/interfaces/interface.Data.md) \| `undefined`

A callback that allows to modify data immediately after it has been retrieved.
It can be used to inject modification of queried data.

# Class StreamgraphChartComponent

A component that displays a streamgraph chart.

A streamgraph is a type of stacked area chart where areas are displaced around
a central axis. It is particularly effective for displaying volume across
different categories or over time with a relative scale that emphasizes
overall patterns and trends.

as are displaced around
a central axis. It is particularly effective for displaying volume across
different categories or over time with a relative scale that emphasizes
overall patterns and trends.

## Example

```html
   <csdk-streamgraph-chart
     [dataSet]="chart.dataSet"
     [dataOptions]="chart.dataOptions"
     [styleOptions]="chart.styleOptions"
     [highlights]="filters"
     [beforeRender]="onBeforeRender"
     (dataPointClick)="logArguments($event)"
     (dataPointContextMenu)="logArguments($event)"
     (dataPointsSelect)="logArguments($event)"
   />
```
```ts
import { Component } from '@angular/core';
import { measureFactory, filterFactory } from '@sisense/sdk-data';
import * as DM from '../../assets/sample-ecommerce';
import type { ChartType } from '@sisense/sdk-ui-angular';

@Component({
 selector: 'app-analytics',
 templateUrl: './analytics.component.html',
 styleUrls: ['./analytics.component.scss'],
})
export class AnalyticsComponent {
 DM = DM;
 filters = [filterFactory.members(DM.Category.Category, ['Electronics', 'Clothing'])];
 chart = {
   chartType: 'streamgraph' as ChartType,
   dataSet: DM.DataSource,
   dataOptions: {
     category: [DM.Commerce.Date.Quarters],
     value: [measureFactory.sum(DM.Commerce.Revenue, 'Revenue')],
     breakBy: [DM.Category.Category],
   },
   styleOptions: {
     width: 1200,
     height: 500,
   },
 };

 onBeforeRender(options: any) {
   console.log('beforeRender');
   console.log(options);
   return options;
 }

 logArguments(...args: any[]) {
   console.log(args);
 }
}
```

height: 500,
   },
 };

 onBeforeRender(options: any) {
   console.log('beforeRender');
   console.log(options);
   return options;
 }

 logArguments(...args: any[]) {
   console.log(args);
 }
}
```

## Constructors

### constructor

> **new StreamgraphChartComponent**(): [`StreamgraphChartComponent`](class.StreamgraphChartComponent.md)

#### Returns

[`StreamgraphChartComponent`](class.StreamgraphChartComponent.md)

## Properties

**new StreamgraphChartComponent**(): [`StreamgraphChartComponent`](class.StreamgraphChartComponent.md)

#### Returns

[`StreamgraphChartComponent`](class.StreamgraphChartComponent.md)

## Properties

### Data

#### dataSet

> **dataSet**: [`Data`](../../sdk-data/interfaces/interface.Data.md) \| [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md) \| `undefined`

Data set for a chart using one of the following options. If neither option is specified, the chart
will use the `defaultDataSource` specified in the parent `SisenseContextProvider`
component.

(1) Sisense data source name as a string. For example, `'Sample ECommerce'`. Typically, you
retrieve the data source name from a data model you create using the `get-data-model`
[command](https://developer.sisense.com/guides/sdk/guides/cli.html) of the Compose SDK CLI. The chart
connects to the data source, executes a query, and loads the data as specified in
`dataOptions`, `filters`, and `highlights`.

To learn more about using data from a Sisense data source, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#sisense-data).

OR

(2) Explicit [`Data`](../../sdk-data/interfaces/interface.Data.md), which is made up of an array of
[`Column`](../../sdk-data/interfaces/interface.Column.md) objects and a two-dimensional array of row data. This approach
allows the chart component to be used with any data you provide.

To learn more about using data from an external data source, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#explicit-data).

Example data in the proper format:

```ts
const sampleData = {
  columns: [
    { name: 'Years', type: 'date' },
    { name: 'Quantity', type: 'number' },
    { name: 'Units', type: 'number' },
  ],
  rows: [
    ['2019', 5500, 1500],
    ['2020', 4471, 7000],
    ['2021', 1812, 5000],
    ['2022', 5001, 6000],
    ['2023', 2045, 4000],
  ],
};
```

***

#### filters

> **filters**: [`FilterRelations`](../../sdk-data/interfaces/interface.FilterRelations.md) \| [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[] \| `undefined`

Filters to limit (or slice) a chart’s data using one of the following options.

(1) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) or [FilterRelations](../../sdk-data/interfaces/interface.FilterRelations.md) returned from filter factory functions, such as
[`greaterThan()`](../../sdk-data/factories/namespace.filterFactory/functions/function.greaterThan.md) and [`members()`](../../sdk-data/factories/namespace.filterFactory/functions/function.members.md).

Use this option for filters that do not require a UI to set them
or for filters where you will supply your own UI components or use pre-built UI components. This is the most common option.

To learn more about using filter factory functions to create filters, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-functions).

(2) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) controlled by filter UI components – for example [`MemberFilterTile`](../../sdk-ui/filter-tiles/function.MemberFilterTile.md).

Use this option for filters that you want your users to set using pre-built UI components.

To learn more about using filter UI components to create filters, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components).

***

#### highlights

> **highlights**: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[] \| `undefined`

Highlights based on filter criteria to apply to a chart using one of the following options.

NOTE that the filter dimensions used in highlights must match those defined in the
`dataOptions` of the chart. Otherwise, the filters will be applied as regular slice filters.

(1) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) returned from filter factory functions, such as
[`greaterThan()`](../../sdk-data/factories/namespace.filterFactory/functions/function.greaterThan.md) and [`members()`](../../sdk-data/factories/namespace.filterFactory/functions/function.members.md).

Use this option for highlights that do not require a UI to set them
or for highlights where you will supply your own UI components or use pre-built UI components. This is the most common option.

To learn more about using filter factory functions to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-functions-for-highlighting).

(2) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) controlled by filter UI components – for example [`MemberFilterTile`](../../sdk-ui/filter-tiles/function.MemberFilterTile.md).

Use this option for highlights that you want your users to set using pre-built UI components.

To learn more about using filter components to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components-for-highlighting).

ts.

To learn more about using filter components to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components-for-highlighting).

### Chart

#### dataOptions

> **dataOptions**: [`CartesianChartDataOptions`](../interfaces/interface.CartesianChartDataOptions.md)

Configurations for how to interpret and present a chart's data.

Streamgraph requires at least one category (X-axis) and one or more value measures.
Multiple series can be created using the `breakBy` property or by providing multiple
value measures.

To learn more about using data options,
see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#dataoptions).

***

#### styleOptions

> **styleOptions**: [`StreamgraphStyleOptions`](../interfaces/interface.StreamgraphStyleOptions.md) \| `undefined`

Configurations for how to style and present a chart's data.

**

#### styleOptions

> **styleOptions**: [`StreamgraphStyleOptions`](../interfaces/interface.StreamgraphStyleOptions.md) \| `undefined`

Configurations for how to style and present a chart's data.

### Callbacks

#### beforeRender

> **beforeRender**: [`BeforeRenderHandler`](../type-aliases/type-alias.BeforeRenderHandler.md) \| `undefined`

A callback that allows you to customize the underlying chart element before it is rendered.
Use the `highchartsOptions` object that is passed to the callback to change
[options values](https://api.highcharts.com/highcharts/) and then return the modified options
object. The returned options are then used when rendering the chart.

This callback is not supported for Indicator Chart, Areamap Chart, Scattermap Chart, and Table.

For an example of how the `onBeforeRender` callback can be used, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#callbacks).

***

#### dataPointClick

> **dataPointClick**: `EventEmitter`\< [`DataPointEvent`](../type-aliases/type-alias.DataPointEvent.md) \>

A callback that allows you to customize what happens when a data point is clicked.

To learn more about callbacks, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#callbacks).

***

#### dataPointContextMenu

> **dataPointContextMenu**: `EventEmitter`\< [`DataPointEvent`](../type-aliases/type-alias.DataPointEvent.md) \>

A callback that allows you to customize what happens when a context menu is displayed for a data point.

To learn more about callbacks, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#callbacks).

***

#### dataPointsSelect

> **dataPointsSelect**: `EventEmitter`\< [`DataPointsEvent`](../type-aliases/type-alias.DataPointsEvent.md) \>

A callback that allows you to customize what happens when data points are selected.

To learn more about callbacks, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#callbacks).

***

#### dataReady

> **dataReady**: (`data`) => [`Data`](../../sdk-data/interfaces/interface.Data.md) \| `undefined`

A callback that allows to modify data immediately after it has been retrieved.
It can be used to inject modification of queried data.

a`](../../sdk-data/interfaces/interface.Data.md) \| `undefined`

A callback that allows to modify data immediately after it has been retrieved.
It can be used to inject modification of queried data.

# Class SunburstChartComponent

A component displaying hierarchical data in the form of nested slices.
This type of chart can be used instead of a pie chart for comparing a large number of categories and sub-categories.

Component

A component displaying hierarchical data in the form of nested slices.
This type of chart can be used instead of a pie chart for comparing a large number of categories and sub-categories.

## Example

```html
   <csdk-sunburst-chart
     [dataSet]="chart.dataSet"
     [dataOptions]="chart.dataOptions"
     [highlights]="filters"
     [beforeRender]="onBeforeRender"
     (dataPointClick)="logArguments($event)"
     (dataPointContextMenu)="logArguments($event)"
     (dataPointsSelect)="logArguments($event)"
   />
```
```ts
import { Component } from '@angular/core';
import { measureFactory, filterFactory } from '@sisense/sdk-data';
import * as DM from '../../assets/sample-healthcare-model';
import type { ChartType } from '@sisense/sdk-ui-angular';

@Component({
 selector: 'app-analytics',
 templateUrl: './analytics.component.html',
 styleUrls: ['./analytics.component.scss'],
})
export class AnalyticsComponent {
 DM = DM;
 filters = [filterFactory.members(DM.Divisions.Divison_name, ['Cardiology', 'Neurology'])];
 chart = {
   chartType: 'column' as ChartType,
   dataSet: DM.DataSource,
   dataOptions: {
     category: [DM.Divisions.Divison_name],
     value: [measureFactory.sum(DM.Admissions.Cost_of_admission)],
     breakBy: [],
   },
 };

 onBeforeRender(options: any) {
   console.log('beforeRender');
   console.log(options);
   return options;
 }

 logArguments(...args: any[]) {
   console.log(args);
 }
}
```
<img src="../../../img/angular-sunburst-chart-example.png" width="800px" />

reRender');
   console.log(options);
   return options;
 }

 logArguments(...args: any[]) {
   console.log(args);
 }
}
```
<img src="../../../img/angular-sunburst-chart-example.png" width="800px" />

## Constructors

### constructor

> **new SunburstChartComponent**(): [`SunburstChartComponent`](class.SunburstChartComponent.md)

#### Returns

[`SunburstChartComponent`](class.SunburstChartComponent.md)

## Properties

constructor

> **new SunburstChartComponent**(): [`SunburstChartComponent`](class.SunburstChartComponent.md)

#### Returns

[`SunburstChartComponent`](class.SunburstChartComponent.md)

## Properties

### Data

#### dataSet

> **dataSet**: [`Data`](../../sdk-data/interfaces/interface.Data.md) \| [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md) \| `undefined`

Data set for a chart using one of the following options. If neither option is specified, the chart
will use the `defaultDataSource` specified in the parent `SisenseContextProvider`
component.

(1) Sisense data source name as a string. For example, `'Sample ECommerce'`. Typically, you
retrieve the data source name from a data model you create using the `get-data-model`
[command](https://developer.sisense.com/guides/sdk/guides/cli.html) of the Compose SDK CLI. The chart
connects to the data source, executes a query, and loads the data as specified in
`dataOptions`, `filters`, and `highlights`.

To learn more about using data from a Sisense data source, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#sisense-data).

OR

(2) Explicit [`Data`](../../sdk-data/interfaces/interface.Data.md), which is made up of an array of
[`Column`](../../sdk-data/interfaces/interface.Column.md) objects and a two-dimensional array of row data. This approach
allows the chart component to be used with any data you provide.

To learn more about using data from an external data source, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#explicit-data).

Example data in the proper format:

```ts
const sampleData = {
  columns: [
    { name: 'Years', type: 'date' },
    { name: 'Quantity', type: 'number' },
    { name: 'Units', type: 'number' },
  ],
  rows: [
    ['2019', 5500, 1500],
    ['2020', 4471, 7000],
    ['2021', 1812, 5000],
    ['2022', 5001, 6000],
    ['2023', 2045, 4000],
  ],
};
```

***

#### filters

> **filters**: [`FilterRelations`](../../sdk-data/interfaces/interface.FilterRelations.md) \| [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[] \| `undefined`

Filters to limit (or slice) a chart’s data using one of the following options.

(1) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) or [FilterRelations](../../sdk-data/interfaces/interface.FilterRelations.md) returned from filter factory functions, such as
[`greaterThan()`](../../sdk-data/factories/namespace.filterFactory/functions/function.greaterThan.md) and [`members()`](../../sdk-data/factories/namespace.filterFactory/functions/function.members.md).

Use this option for filters that do not require a UI to set them
or for filters where you will supply your own UI components or use pre-built UI components. This is the most common option.

To learn more about using filter factory functions to create filters, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-functions).

(2) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) controlled by filter UI components – for example [`MemberFilterTile`](../../sdk-ui/filter-tiles/function.MemberFilterTile.md).

Use this option for filters that you want your users to set using pre-built UI components.

To learn more about using filter UI components to create filters, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components).

***

#### highlights

> **highlights**: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[] \| `undefined`

Highlights based on filter criteria to apply to a chart using one of the following options.

NOTE that the filter dimensions used in highlights must match those defined in the
`dataOptions` of the chart. Otherwise, the filters will be applied as regular slice filters.

(1) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) returned from filter factory functions, such as
[`greaterThan()`](../../sdk-data/factories/namespace.filterFactory/functions/function.greaterThan.md) and [`members()`](../../sdk-data/factories/namespace.filterFactory/functions/function.members.md).

Use this option for highlights that do not require a UI to set them
or for highlights where you will supply your own UI components or use pre-built UI components. This is the most common option.

To learn more about using filter factory functions to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-functions-for-highlighting).

(2) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) controlled by filter UI components – for example [`MemberFilterTile`](../../sdk-ui/filter-tiles/function.MemberFilterTile.md).

Use this option for highlights that you want your users to set using pre-built UI components.

To learn more about using filter components to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components-for-highlighting).

ts.

To learn more about using filter components to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components-for-highlighting).

### Chart

#### dataOptions

> **dataOptions**: [`CategoricalChartDataOptions`](../interfaces/interface.CategoricalChartDataOptions.md)

Configurations for how to interpret and present the data passed to the chart

***

#### styleOptions

> **styleOptions**: [`SunburstStyleOptions`](../interfaces/interface.SunburstStyleOptions.md) \| `undefined`

Configurations for how to style and present a chart's data.

art

***

#### styleOptions

> **styleOptions**: [`SunburstStyleOptions`](../interfaces/interface.SunburstStyleOptions.md) \| `undefined`

Configurations for how to style and present a chart's data.

### Callbacks

#### beforeRender

> **beforeRender**: [`BeforeRenderHandler`](../type-aliases/type-alias.BeforeRenderHandler.md) \| `undefined`

A callback that allows you to customize the underlying chart element before it is rendered.
Use the `highchartsOptions` object that is passed to the callback to change
[options values](https://api.highcharts.com/highcharts/) and then return the modified options
object. The returned options are then used when rendering the chart.

This callback is not supported for Indicator Chart, Areamap Chart, Scattermap Chart, and Table.

For an example of how the `onBeforeRender` callback can be used, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#callbacks).

***

#### dataPointClick

> **dataPointClick**: `EventEmitter`\< [`DataPointEvent`](../type-aliases/type-alias.DataPointEvent.md) \>

A callback that allows you to customize what happens when a data point is clicked.

To learn more about callbacks, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#callbacks).

***

#### dataPointContextMenu

> **dataPointContextMenu**: `EventEmitter`\< [`DataPointEvent`](../type-aliases/type-alias.DataPointEvent.md) \>

A callback that allows you to customize what happens when a context menu is displayed for a data point.

To learn more about callbacks, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#callbacks).

***

#### dataPointsSelect

> **dataPointsSelect**: `EventEmitter`\< [`DataPointsEvent`](../type-aliases/type-alias.DataPointsEvent.md) \>

A callback that allows you to customize what happens when data points are selected.

To learn more about callbacks, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#callbacks).

***

#### dataReady

> **dataReady**: (`data`) => [`Data`](../../sdk-data/interfaces/interface.Data.md) \| `undefined`

A callback that allows to modify data immediately after it has been retrieved.
It can be used to inject modification of queried data.

a`](../../sdk-data/interfaces/interface.Data.md) \| `undefined`

A callback that allows to modify data immediately after it has been retrieved.
It can be used to inject modification of queried data.

# Class TreemapChartComponent

A component displaying hierarchical data in the form of nested rectangles.
This type of chart can be used instead of a column chart for comparing a large number of categories and sub-categories.

nt

A component displaying hierarchical data in the form of nested rectangles.
This type of chart can be used instead of a column chart for comparing a large number of categories and sub-categories.

## Example

```html
   <csdk-treemap-chart
     [dataSet]="chart.dataSet"
     [dataOptions]="chart.dataOptions"
     [highlights]="filters"
     [beforeRender]="onBeforeRender"
     (dataPointClick)="logArguments($event)"
     (dataPointContextMenu)="logArguments($event)"
     (dataPointsSelect)="logArguments($event)"
   />
```
```ts
import { Component } from '@angular/core';
import { measureFactory, filterFactory } from '@sisense/sdk-data';
import type { ChartType } from '@sisense/sdk-ui-angular';
import * as DM from '../../assets/sample-healthcare-model';

@Component({
 selector: 'app-analytics',
 templateUrl: './analytics.component.html',
 styleUrls: ['./analytics.component.scss'],
})
export class AnalyticsComponent {
 DM = DM;
 filters = [filterFactory.members(DM.Divisions.Divison_name, ['Cardiology', 'Neurology'])];
 chart = {
   chartType: 'column' as ChartType,
   dataSet: DM.DataSource,
   dataOptions: {
     category: [DM.Divisions.Divison_name],
     value: [measureFactory.sum(DM.Admissions.Cost_of_admission)],
     breakBy: [],
   },
 };

 onBeforeRender(options: any) {
   console.log('beforeRender');
   console.log(options);
   return options;
 }

 logArguments(...args: any[]) {
   console.log(args);
 }
}
```
<img src="../../../img/angular-treemap-chart-example.png" width="800px" />

oreRender');
   console.log(options);
   return options;
 }

 logArguments(...args: any[]) {
   console.log(args);
 }
}
```
<img src="../../../img/angular-treemap-chart-example.png" width="800px" />

## Constructors

### constructor

> **new TreemapChartComponent**(): [`TreemapChartComponent`](class.TreemapChartComponent.md)

#### Returns

[`TreemapChartComponent`](class.TreemapChartComponent.md)

## Properties

### constructor

> **new TreemapChartComponent**(): [`TreemapChartComponent`](class.TreemapChartComponent.md)

#### Returns

[`TreemapChartComponent`](class.TreemapChartComponent.md)

## Properties

### Data

#### dataSet

> **dataSet**: [`Data`](../../sdk-data/interfaces/interface.Data.md) \| [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md) \| `undefined`

Data set for a chart using one of the following options. If neither option is specified, the chart
will use the `defaultDataSource` specified in the parent `SisenseContextProvider`
component.

(1) Sisense data source name as a string. For example, `'Sample ECommerce'`. Typically, you
retrieve the data source name from a data model you create using the `get-data-model`
[command](https://developer.sisense.com/guides/sdk/guides/cli.html) of the Compose SDK CLI. The chart
connects to the data source, executes a query, and loads the data as specified in
`dataOptions`, `filters`, and `highlights`.

To learn more about using data from a Sisense data source, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#sisense-data).

OR

(2) Explicit [`Data`](../../sdk-data/interfaces/interface.Data.md), which is made up of an array of
[`Column`](../../sdk-data/interfaces/interface.Column.md) objects and a two-dimensional array of row data. This approach
allows the chart component to be used with any data you provide.

To learn more about using data from an external data source, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#explicit-data).

Example data in the proper format:

```ts
const sampleData = {
  columns: [
    { name: 'Years', type: 'date' },
    { name: 'Quantity', type: 'number' },
    { name: 'Units', type: 'number' },
  ],
  rows: [
    ['2019', 5500, 1500],
    ['2020', 4471, 7000],
    ['2021', 1812, 5000],
    ['2022', 5001, 6000],
    ['2023', 2045, 4000],
  ],
};
```

***

#### filters

> **filters**: [`FilterRelations`](../../sdk-data/interfaces/interface.FilterRelations.md) \| [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[] \| `undefined`

Filters to limit (or slice) a chart’s data using one of the following options.

(1) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) or [FilterRelations](../../sdk-data/interfaces/interface.FilterRelations.md) returned from filter factory functions, such as
[`greaterThan()`](../../sdk-data/factories/namespace.filterFactory/functions/function.greaterThan.md) and [`members()`](../../sdk-data/factories/namespace.filterFactory/functions/function.members.md).

Use this option for filters that do not require a UI to set them
or for filters where you will supply your own UI components or use pre-built UI components. This is the most common option.

To learn more about using filter factory functions to create filters, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-functions).

(2) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) controlled by filter UI components – for example [`MemberFilterTile`](../../sdk-ui/filter-tiles/function.MemberFilterTile.md).

Use this option for filters that you want your users to set using pre-built UI components.

To learn more about using filter UI components to create filters, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components).

***

#### highlights

> **highlights**: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[] \| `undefined`

Highlights based on filter criteria to apply to a chart using one of the following options.

NOTE that the filter dimensions used in highlights must match those defined in the
`dataOptions` of the chart. Otherwise, the filters will be applied as regular slice filters.

(1) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) returned from filter factory functions, such as
[`greaterThan()`](../../sdk-data/factories/namespace.filterFactory/functions/function.greaterThan.md) and [`members()`](../../sdk-data/factories/namespace.filterFactory/functions/function.members.md).

Use this option for highlights that do not require a UI to set them
or for highlights where you will supply your own UI components or use pre-built UI components. This is the most common option.

To learn more about using filter factory functions to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-functions-for-highlighting).

(2) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) controlled by filter UI components – for example [`MemberFilterTile`](../../sdk-ui/filter-tiles/function.MemberFilterTile.md).

Use this option for highlights that you want your users to set using pre-built UI components.

To learn more about using filter components to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components-for-highlighting).

ts.

To learn more about using filter components to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components-for-highlighting).

### Chart

#### dataOptions

> **dataOptions**: [`CategoricalChartDataOptions`](../interfaces/interface.CategoricalChartDataOptions.md)

Configurations for how to interpret and present the data passed to the chart

***

#### styleOptions

> **styleOptions**: [`TreemapStyleOptions`](../interfaces/interface.TreemapStyleOptions.md) \| `undefined`

Configurations for how to style and present a chart's data.

chart

***

#### styleOptions

> **styleOptions**: [`TreemapStyleOptions`](../interfaces/interface.TreemapStyleOptions.md) \| `undefined`

Configurations for how to style and present a chart's data.

### Callbacks

#### beforeRender

> **beforeRender**: [`BeforeRenderHandler`](../type-aliases/type-alias.BeforeRenderHandler.md) \| `undefined`

A callback that allows you to customize the underlying chart element before it is rendered.
Use the `highchartsOptions` object that is passed to the callback to change
[options values](https://api.highcharts.com/highcharts/) and then return the modified options
object. The returned options are then used when rendering the chart.

This callback is not supported for Indicator Chart, Areamap Chart, Scattermap Chart, and Table.

For an example of how the `onBeforeRender` callback can be used, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#callbacks).

***

#### dataPointClick

> **dataPointClick**: `EventEmitter`\< [`DataPointEvent`](../type-aliases/type-alias.DataPointEvent.md) \>

A callback that allows you to customize what happens when a data point is clicked.

To learn more about callbacks, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#callbacks).

***

#### dataPointContextMenu

> **dataPointContextMenu**: `EventEmitter`\< [`DataPointEvent`](../type-aliases/type-alias.DataPointEvent.md) \>

A callback that allows you to customize what happens when a context menu is displayed for a data point.

To learn more about callbacks, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#callbacks).

***

#### dataPointsSelect

> **dataPointsSelect**: `EventEmitter`\< [`DataPointsEvent`](../type-aliases/type-alias.DataPointsEvent.md) \>

A callback that allows you to customize what happens when data points are selected.

To learn more about callbacks, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#callbacks).

***

#### dataReady

> **dataReady**: (`data`) => [`Data`](../../sdk-data/interfaces/interface.Data.md) \| `undefined`

A callback that allows to modify data immediately after it has been retrieved.
It can be used to inject modification of queried data.

a`](../../sdk-data/interfaces/interface.Data.md) \| `undefined`

A callback that allows to modify data immediately after it has been retrieved.
It can be used to inject modification of queried data.

# Function boxWhiskerProcessResult

> **boxWhiskerProcessResult**(
  `boxWhiskerData`,
  `outliersData`,
  `dataOptions`?): [`QueryResultData`](../../sdk-data/interfaces/interface.QueryResultData.md)

Processes box whisker data and outliers data to combine them into a single data set.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `boxWhiskerData` | [`QueryResultData`](../../sdk-data/interfaces/interface.QueryResultData.md) | The data for the box whisker. |
| `outliersData` | [`QueryResultData`](../../sdk-data/interfaces/interface.QueryResultData.md) | The data for the outliers. |
| `dataOptions`? | [`BoxplotChartCustomDataOptions`](../type-aliases/type-alias.BoxplotChartCustomDataOptions.md) | Optional data options for customizing data processing. |

## Returns

[`QueryResultData`](../../sdk-data/interfaces/interface.QueryResultData.md)

The combined data with outliers included in the box whisker plot.


## Dashboards

omizing data processing. |

## Returns

[`QueryResultData`](../../sdk-data/interfaces/interface.QueryResultData.md)

The combined data with outliers included in the box whisker plot.


## Dashboards

# Dashboards

Angular components and utilities for working with dashboards

- [ChartWidgetComponent](class.ChartWidgetComponent.md)
- [CustomWidgetsService](class.CustomWidgetsService.md)
- [DashboardComponent](class.DashboardComponent.md)
- [dashboardHelpers](namespace.dashboardHelpers/index.md) - Utility functions to manipulate dashboard elements
- [extractDimensionsAndMeasures](function.extractDimensionsAndMeasures.md)
- [PivotTableWidgetComponent](class.PivotTableWidgetComponent.md)
- [WidgetComponent](class.WidgetComponent.md)

# Namespace dashboardHelpers

Utility functions to manipulate `DashboardProps`

## Index

### Functions

- [addFilter](functions/function.addFilter.md)
- [addFilters](functions/function.addFilters.md)
- [removeFilter](functions/function.removeFilter.md)
- [removeFilters](functions/function.removeFilters.md)
- [replaceFilter](functions/function.replaceFilter.md)
- [replaceFilters](functions/function.replaceFilters.md)

Utility functions to manipulate `DashboardProps`

# Functions

- [addFilter](function.addFilter.md)
- [addFilters](function.addFilters.md)
- [removeFilter](function.removeFilter.md)
- [removeFilters](function.removeFilters.md)
- [replaceFilter](function.replaceFilter.md)
- [replaceFilters](function.replaceFilters.md)

ion.addFilters.md)
- [removeFilter](function.removeFilter.md)
- [removeFilters](function.removeFilters.md)
- [replaceFilter](function.replaceFilter.md)
- [replaceFilters](function.replaceFilters.md)

# Class ChartWidgetComponent

The Chart Widget component extending [ChartComponent](../charts/class.ChartComponent.md) to support widget style options.

[replaceFilters](function.replaceFilters.md)

# Class ChartWidgetComponent

The Chart Widget component extending [ChartComponent](../charts/class.ChartComponent.md) to support widget style options.

## Example

```html
<csdk-chart-widget
  [chartType]="chartWidget.chartType"
  [dataSource]="chartWidget.dataSource"
  [dataOptions]="chartWidget.dataOptions"
  [highlights]="filters"
  [title]="chartWidget.title"
  [description]="chartWidget.description"
  [beforeRender]="onBeforeRender"
  (dataPointClick)="logArguments($event)"
  (dataPointContextMenu)="logArguments($event)"
  (dataPointsSelect)="logArguments($event)"
/>
```
```ts
import { Component } from '@angular/core';
import { ChartType } from '@sisense/sdk-ui-angular';
import { filterFactory } from '@sisense/sdk-data';
import * as DM from '../../assets/sample-healthcare-model';

@Component({
  selector: 'app-widgets',
  templateUrl: './widgets.component.html',
  styleUrls: ['./widgets.component.scss'],
})
export class WidgetsComponent {
  filters = [filterFactory.members(DM.Divisions.Divison_name, ['Cardiology', 'Neurology'])];
  chartWidget = {
    chartType: 'column' as ChartType,
    dataSource: DM.DataSource,
    dataOptions: {
      category: [DM.Divisions.Divison_name],
      value: [measureFactory.sum(DM.Admissions.Cost_of_admission)],
      breakBy: [],
    },
    title: 'Chart Title',
    description: 'Chart Description',
  };
 logArguments(...args: any[]) {
  console.log(args);
}

onBeforeRender(options: any) {
  console.log('beforeRender');
  console.log(options);
  return options;
}

}
```
<img src="../../../img/angular-chart-widget-example.png" width="500px" />

g(args);
}

onBeforeRender(options: any) {
  console.log('beforeRender');
  console.log(options);
  return options;
}

}
```
<img src="../../../img/angular-chart-widget-example.png" width="500px" />

## Implements

- `AfterViewInit`
- `OnChanges`
- `OnDestroy`

## Constructors

### constructor

> **new ChartWidgetComponent**(`sisenseContextService`, `themeService`): [`ChartWidgetComponent`](class.ChartWidgetComponent.md)

#### Parameters

| Parameter | Type |
| :------ | :------ |
| `sisenseContextService` | [`SisenseContextService`](../contexts/class.SisenseContextService.md) |
| `themeService` | [`ThemeService`](../contexts/class.ThemeService.md) |

#### Returns

[`ChartWidgetComponent`](class.ChartWidgetComponent.md)

## Properties

### Data

#### dataSource

> **dataSource**: [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md) \| `undefined`

Data source the query is run against - e.g. `Sample ECommerce`

If not specified, the query will use the `defaultDataSource` specified in the parent Sisense Context.

***

#### filters

> **filters**: [`FilterRelations`](../../sdk-data/interfaces/interface.FilterRelations.md) \| [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[] \| `undefined`

Filters that will slice query results

***

#### highlights

> **highlights**: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[] \| `undefined`

Highlight filters that will highlight results that pass filter criteria

y results

***

#### highlights

> **highlights**: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[] \| `undefined`

Highlight filters that will highlight results that pass filter criteria

### Chart

#### chartType

> **chartType**: [`ChartType`](../type-aliases/type-alias.ChartType.md)

Default chart type of each series

***

#### dataOptions

> **dataOptions**: [`ChartDataOptions`](../type-aliases/type-alias.ChartDataOptions.md)

Configurations for how to interpret and present the data passed to the chart

### Widget

#### description

> **description**: `string` \| `undefined`

Description of the widget

***

#### highlightSelectionDisabled

> **highlightSelectionDisabled**: `boolean` \| `undefined`

Boolean flag whether selecting data points triggers highlight filter of the selected data

Recommended to turn on when the Chart Widget component is enhanced with data drilldown by the Drilldown Widget component

If not specified, the default value is `false`

***

#### styleOptions

> **styleOptions**: [`ChartWidgetStyleOptions`](../type-aliases/type-alias.ChartWidgetStyleOptions.md) \| `undefined`

Style options for both the chart and widget including the widget header

***

#### title

> **title**: `string` \| `undefined`

Title of the widget

-alias.ChartWidgetStyleOptions.md) \| `undefined`

Style options for both the chart and widget including the widget header

***

#### title

> **title**: `string` \| `undefined`

Title of the widget

### Callbacks

#### beforeRender

> **beforeRender**: [`BeforeRenderHandler`](../type-aliases/type-alias.BeforeRenderHandler.md) \| [`IndicatorBeforeRenderHandler`](../type-aliases/type-alias.IndicatorBeforeRenderHandler.md) \| `undefined`

A callback that allows you to customize the underlying chart element before it is rendered. The returned options are then used when rendering the chart.

This callback is not supported for Areamap Chart, Scattermap Chart, Table, and PivotTable.

***

#### dataPointClick

> **dataPointClick**: `EventEmitter`\< [`ChartDataPointClickEvent`](../type-aliases/type-alias.ChartDataPointClickEvent.md) \>

Click handler callback for a data point

***

#### dataPointContextMenu

> **dataPointContextMenu**: `EventEmitter`\< [`ChartDataPointContextMenuEvent`](../type-aliases/type-alias.ChartDataPointContextMenuEvent.md) \>

Context menu handler callback for a data point

***

#### dataPointsSelect

> **dataPointsSelect**: `EventEmitter`\< [`ChartDataPointsEvent`](../type-aliases/type-alias.ChartDataPointsEvent.md) \>

Handler callback for selection of multiple data points

***

#### dataReady

> **dataReady**: (`data`) => [`Data`](../../sdk-data/interfaces/interface.Data.md) \| `undefined`

A callback that allows to modify data immediately after it has been retrieved.
It can be used to inject modification of queried data.

a`](../../sdk-data/interfaces/interface.Data.md) \| `undefined`

A callback that allows to modify data immediately after it has been retrieved.
It can be used to inject modification of queried data.

# Class CustomWidgetsService

Service for working with custom widgets.

## Constructors

### constructor

> **new CustomWidgetsService**(): [`CustomWidgetsService`](class.CustomWidgetsService.md)

#### Returns

[`CustomWidgetsService`](class.CustomWidgetsService.md)

## Methods

### hasCustomWidget

> **hasCustomWidget**(`customWidgetType`): `boolean`

Checks if a custom widget is registered.

#### Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `customWidgetType` | `string` | The type of the custom widget. |

#### Returns

`boolean`

True if the custom widget is registered, false otherwise.

***

cription |
| :------ | :------ | :------ |
| `customWidgetType` | `string` | The type of the custom widget. |

#### Returns

`boolean`

True if the custom widget is registered, false otherwise.

***

### registerCustomWidget

> **registerCustomWidget**<`Props`>(`customWidgetType`, `customWidget`): `void`

Registers a new custom widget.

#### Type parameters

| Parameter | Default |
| :------ | :------ |
| `Props` *extends* [`CustomWidgetComponentProps`](../interfaces/interface.CustomWidgetComponentProps.md)\< [`GenericDataOptions`](../type-aliases/type-alias.GenericDataOptions.md), [`CustomWidgetStyleOptions`](../../sdk-ui/type-aliases/type-alias.CustomWidgetStyleOptions.md), [`AbstractDataPointWithEntries`](../../sdk-ui/type-aliases/type-alias.AbstractDataPointWithEntries.md), `Props` \> | [`CustomWidgetComponentProps`](../interfaces/interface.CustomWidgetComponentProps.md)\< [`GenericDataOptions`](../type-aliases/type-alias.GenericDataOptions.md), [`CustomWidgetStyleOptions`](../../sdk-ui/type-aliases/type-alias.CustomWidgetStyleOptions.md), [`AbstractDataPointWithEntries`](../../sdk-ui/type-aliases/type-alias.AbstractDataPointWithEntries.md) \> |

#### Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `customWidgetType` | `string` | The unique identifier for the custom widget type. |
| `customWidget` | [`CustomWidgetComponent`](../type-aliases/type-alias.CustomWidgetComponent.md)\< `Props` \> | The custom widget component class to register. |

#### Returns

`void`

widget type. |
| `customWidget` | [`CustomWidgetComponent`](../type-aliases/type-alias.CustomWidgetComponent.md)\< `Props` \> | The custom widget component class to register. |

#### Returns

`void`

# Class DashboardComponent

An Angular component used for easily rendering a dashboard created in Sisense Fusion.

**Note:** Dashboard and Widget extensions based on JS scripts and add-ons in Fusion – for example, Blox and Jump To Dashboard – are not supported.

y rendering a dashboard created in Sisense Fusion.

**Note:** Dashboard and Widget extensions based on JS scripts and add-ons in Fusion – for example, Blox and Jump To Dashboard – are not supported.

## Example

```html
<csdk-dashboard
 *ngIf="dashboard"
 [title]="dashboard.title"
 [layoutOptions]="dashboard.layoutOptions"
 [widgets]="dashboard.widgets"
 [filters]="dashboard.filters"
 [defaultDataSource]="dashboard.defaultDataSource"
 [widgetsOptions]="dashboard.widgetsOptions"
/>
```

```ts
import { Component } from '@angular/core';
import {
  type DashboardProps,
  DashboardService,
  dashboardModelTranslator,
} from '@sisense/sdk-ui-angular';

@Component({
 selector: 'app-dashboard',
 templateUrl: './dashboard.component.html',
 styleUrls: ['./dashboard.component.scss'],
})
export class DashboardComponent {

 dashboard: DashboardProps | null = null;

 constructor(private dashboardService: DashboardService) {}

 async ngOnInit(): Promise<void> {
   const dashboardModel = await this.dashboardService.getDashboardModel('your-dashboard-oid', { includeWidgets: true, includeFilters: true });
   this.dashboard = dashboardModelTranslator.toDashboardProps(dashboardModel);
 }
```

To learn more about this and related dashboard components,
see [Embedded Dashboards](/guides/sdk/guides/dashboards/index.html).

## Implements

- `AfterViewInit`
- `OnChanges`
- `OnDestroy`

## Constructors

more about this and related dashboard components,
see [Embedded Dashboards](/guides/sdk/guides/dashboards/index.html).

## Implements

- `AfterViewInit`
- `OnChanges`
- `OnDestroy`

## Constructors

### constructor

> **new DashboardComponent**(`sisenseContextService`, `themeService`): [`DashboardComponent`](class.DashboardComponent.md)

Constructor for the `Dashboard` component.

#### Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `sisenseContextService` | [`SisenseContextService`](../contexts/class.SisenseContextService.md) | Sisense context service |
| `themeService` | [`ThemeService`](../contexts/class.ThemeService.md) | Theme service |

#### Returns

[`DashboardComponent`](class.DashboardComponent.md)

## Properties

### Constructor

#### sisenseContextService

> **sisenseContextService**: [`SisenseContextService`](../contexts/class.SisenseContextService.md)

Sisense context service

***

#### themeService

> **themeService**: [`ThemeService`](../contexts/class.ThemeService.md)

Theme service

eContextService`](../contexts/class.SisenseContextService.md)

Sisense context service

***

#### themeService

> **themeService**: [`ThemeService`](../contexts/class.ThemeService.md)

Theme service

### Other

#### config

> **config**: [`DashboardConfig`](../interfaces/interface.DashboardConfig.md) \| `undefined`

The configuration for the dashboard

***

#### defaultDataSource

> **defaultDataSource**: [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md) \| `undefined`

The default data source to use for the dashboard

***

#### filters

> **filters**: [`FilterRelations`](../../sdk-data/interfaces/interface.FilterRelations.md) \| [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[] \| `undefined`

The dashboard filters to be applied to each of the widgets based on the widget filter options

***

#### layoutOptions

> **layoutOptions**: [`DashboardLayoutOptions`](../interfaces/interface.DashboardLayoutOptions.md) \| `undefined`

Dashboard layout options

***

#### styleOptions

> **styleOptions**: [`DashboardStyleOptions`](../../sdk-ui/type-aliases/type-alias.DashboardStyleOptions.md) \| `undefined`

The style options for the dashboard

***

#### title

> **title**: `string` \| `undefined`

The title of the dashboard

***

#### widgets

> **widgets**: [`WidgetProps`](../type-aliases/type-alias.WidgetProps.md)[]

The widgets to render in the dashboard

***

#### widgetsOptions

> **widgetsOptions**: [`WidgetsOptions`](../type-aliases/type-alias.WidgetsOptions.md) \| `undefined`

The options for each of the widgets

dgets to render in the dashboard

***

#### widgetsOptions

> **widgetsOptions**: [`WidgetsOptions`](../type-aliases/type-alias.WidgetsOptions.md) \| `undefined`

The options for each of the widgets

# Class PivotTableWidgetComponent

The Pivot Table Widget component extends the [PivotTableComponent](../data-grids/class.PivotTableComponent.md) component to support widget features,
including a header, widget style options, and more.

e Pivot Table Widget component extends the [PivotTableComponent](../data-grids/class.PivotTableComponent.md) component to support widget features,
including a header, widget style options, and more.

## Example

```html
<csdk-pivot-table-widget
 [dataSource]="pivotProps.dataSource"
 [dataOptions]="pivotProps.dataOptions"
 [filters]="pivotProps.filters"
 [styleOptions]="pivotProps.styleOptions"
 [title]="pivotProps.title"
 [description]="pivotProps.description"
/>
```
```ts
import { Component } from '@angular/core';
import { type PivotTableWidgetProps } from '@sisense/sdk-ui-angular';
import { measureFactory, filterFactory } from '@sisense/sdk-data';
import * as DM from '../../assets/sample-ecommerce';

@Component({
 selector: 'app-analytics',
 templateUrl: './analytics.component.html',
 styleUrls: ['./analytics.component.scss'],
})
export class AnalyticsComponent {

 pivotProps: PivotTableWidgetProps = {
   dataSource: DM.DataSource,
   dataOptions: {
     rows: [
       { column: DM.Category.Category, includeSubTotals: true },
       { column: DM.Commerce.AgeRange, includeSubTotals: true },
       DM.Commerce.Condition,
     ],
     columns: [{ column: DM.Commerce.Gender, includeSubTotals: true }],
     values: [
       measureFactory.sum(DM.Commerce.Cost, 'Total Cost'),
       {
         column: measureFactory.sum(DM.Commerce.Revenue, 'Total Revenue'),
         totalsCalculation: 'sum',
         dataBars: true,
       },
     ],
     grandTotals: { rows: true, columns: true },
   },
   filters: [filterFactory.members(DM.Commerce.Gender, ['Female', 'Male'])],
   styleOptions: { width: 1400, height: 600, rowsPerPage: 25 },
   title: 'Pivot Table Widget',
   description: 'Pivot Table Widget Description',
 };
}
```
<img src="../../../img/angular-pivot-table-widget-example.png" width="800px" />

t: 600, rowsPerPage: 25 },
   title: 'Pivot Table Widget',
   description: 'Pivot Table Widget Description',
 };
}
```
<img src="../../../img/angular-pivot-table-widget-example.png" width="800px" />

## Implements

- `AfterViewInit`
- `OnChanges`
- `OnDestroy`

## Constructors

### constructor

> **new PivotTableWidgetComponent**(`sisenseContextService`, `themeService`): [`PivotTableWidgetComponent`](class.PivotTableWidgetComponent.md)

#### Parameters

| Parameter | Type |
| :------ | :------ |
| `sisenseContextService` | [`SisenseContextService`](../contexts/class.SisenseContextService.md) |
| `themeService` | [`ThemeService`](../contexts/class.ThemeService.md) |

#### Returns

[`PivotTableWidgetComponent`](class.PivotTableWidgetComponent.md)

## Properties

s.SisenseContextService.md) |
| `themeService` | [`ThemeService`](../contexts/class.ThemeService.md) |

#### Returns

[`PivotTableWidgetComponent`](class.PivotTableWidgetComponent.md)

## Properties

### Data

#### dataOptions

> **dataOptions**: [`PivotTableDataOptions`](../interfaces/interface.PivotTableDataOptions.md)

Configurations for how to interpret and present the data passed to the table

***

#### dataSource

> **dataSource**: [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md) \| `undefined`

Data source the query is run against - e.g. `Sample ECommerce`

If not specified, the query will use the `defaultDataSource` specified in the parent Sisense Context.

***

#### filters

> **filters**: [`FilterRelations`](../../sdk-data/interfaces/interface.FilterRelations.md) \| [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[] \| `undefined`

Filters that will slice query results

***

#### highlights

> **highlights**: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[] \| `undefined`

Filters that will highlight query results

### Widget

#### description

> **description**: `string` \| `undefined`

Title of the widget

***

#### drilldownOptions

> **drilldownOptions**: [`PivotTableDrilldownOptions`](../type-aliases/type-alias.PivotTableDrilldownOptions.md) \| `undefined`

Configuration for the pivot table drilldown

***

#### title

> **title**: `string` \| `undefined`

Title of the widget

ns`](../type-aliases/type-alias.PivotTableDrilldownOptions.md) \| `undefined`

Configuration for the pivot table drilldown

***

#### title

> **title**: `string` \| `undefined`

Title of the widget

### Callbacks

#### dataPointClick

> **dataPointClick**: `EventEmitter`\< [`PivotTableDataPointEvent`](../type-aliases/type-alias.PivotTableDataPointEvent.md) \>

Callback function that is called when the pivot table cell is clicked

***

#### dataPointContextMenu

> **dataPointContextMenu**: `EventEmitter`\< [`PivotTableDataPointEvent`](../type-aliases/type-alias.PivotTableDataPointEvent.md) \>

Callback function that is called when the pivot table cell is right-clicked

### Representation

#### styleOptions

> **styleOptions**: [`PivotTableWidgetStyleOptions`](../type-aliases/type-alias.PivotTableWidgetStyleOptions.md) \| `undefined`

Style options for both the table and widget including the widget header

# Class WidgetComponent

Facade component that renders a widget within a dashboard based on the widget type.

\| `undefined`

Style options for both the table and widget including the widget header

# Class WidgetComponent

Facade component that renders a widget within a dashboard based on the widget type.

## Example

```html
<!--Component HTML template in example.component.html-->
<csdk-widget
 [id]="widgetProps.id"
 [title]="widgetProps.title"
 [widgetType]="widgetProps.widgetType"
 [chartType]="widgetProps.chartType"
 [dataSource]="widgetProps.dataSource"
 [dataOptions]="widgetProps.dataOptions"
/>
```

```ts
// Component behavior in example.component.ts
import { Component } from '@angular/core';
import { type WidgetProps } from '@sisense/sdk-ui-angular';

@Component({
 selector: 'example',
 templateUrl: './example.component.html',
 styleUrls: ['./example.component.scss'],
})
export class ExampleComponent {
 widgetProps: WidgetProps = {
   id: 'widget-id',
   widgetType: 'chart',
   chartType: 'column',
   title: 'Widget Title',
   dataSource: DM.DataSource,
   dataOptions: {
     category: [DM.Divisions.Divison_name],
     value: [measureFactory.sum(DM.Admissions.Cost_of_admission)],
     breakBy: [],
   },
 };
}
```
<img src="../../../img/angular-chart-widget-example.png" width="500px" />

## Implements

- `AfterViewInit`
- `OnChanges`
- `OnDestroy`

## Constructors

dmission)],
     breakBy: [],
   },
 };
}
```
<img src="../../../img/angular-chart-widget-example.png" width="500px" />

## Implements

- `AfterViewInit`
- `OnChanges`
- `OnDestroy`

## Constructors

### constructor

> **new WidgetComponent**(`sisenseContextService`, `themeService`): [`WidgetComponent`](class.WidgetComponent.md)

#### Parameters

| Parameter | Type |
| :------ | :------ |
| `sisenseContextService` | [`SisenseContextService`](../contexts/class.SisenseContextService.md) |
| `themeService` | [`ThemeService`](../contexts/class.ThemeService.md) |

#### Returns

[`WidgetComponent`](class.WidgetComponent.md)

## Properties

### Data

#### dataSource

> **dataSource**: [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md) \| `undefined`

Data source the query is run against - e.g. `Sample ECommerce`

If not specified, the query will use the `defaultDataSource` specified in the parent Sisense Context.

***

#### filters

> **filters**: [`FilterRelations`](../../sdk-data/interfaces/interface.FilterRelations.md) \| [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[] \| `undefined`

Filters that will slice query results

***

#### highlights

> **highlights**: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[] \| `undefined`

Highlight filters that will highlight results that pass filter criteria

y results

***

#### highlights

> **highlights**: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[] \| `undefined`

Highlight filters that will highlight results that pass filter criteria

### Chart

#### chartType

> **chartType**: [`ChartType`](../type-aliases/type-alias.ChartType.md) \| `undefined`

Default chart type of each series

***

#### dataOptions

> **dataOptions**: [`ChartDataOptions`](../type-aliases/type-alias.ChartDataOptions.md) \| [`GenericDataOptions`](../type-aliases/type-alias.GenericDataOptions.md) \| [`PivotTableDataOptions`](../interfaces/interface.PivotTableDataOptions.md) \| `undefined`

Configurations for how to interpret and present the data passed to the chart

ias.GenericDataOptions.md) \| [`PivotTableDataOptions`](../interfaces/interface.PivotTableDataOptions.md) \| `undefined`

Configurations for how to interpret and present the data passed to the chart

### Widget

#### customWidgetType

> **customWidgetType**: `string` \| `undefined`

Custom widget type. This is typically the name/ID of the custom widget.

***

#### description

> **description**: `string` \| `undefined`

Description of the widget

***

#### drilldownOptions

> **drilldownOptions**: [`DrilldownOptions`](../type-aliases/type-alias.DrilldownOptions.md) \| [`PivotTableDrilldownOptions`](../type-aliases/type-alias.PivotTableDrilldownOptions.md) \| `undefined`

List of categories to allow drilldowns on

***

#### id

> **id**: `string`

Unique identifier of the widget

***

#### styleOptions

> **styleOptions**: [`ChartWidgetStyleOptions`](../type-aliases/type-alias.ChartWidgetStyleOptions.md) \| [`CustomWidgetStyleOptions`](../../sdk-ui/type-aliases/type-alias.CustomWidgetStyleOptions.md) \| [`PivotTableWidgetStyleOptions`](../type-aliases/type-alias.PivotTableWidgetStyleOptions.md) \| [`TextWidgetStyleOptions`](../../sdk-ui/type-aliases/type-alias.TextWidgetStyleOptions.md) \| `undefined`

Style options for both the chart and widget including the widget header

***

#### title

> **title**: `string` \| `undefined`

Title of the widget

***

#### widgetType

> **widgetType**: `"chart"` \| `"custom"` \| `"pivot"` \| `"text"`

Widget type

g the widget header

***

#### title

> **title**: `string` \| `undefined`

Title of the widget

***

#### widgetType

> **widgetType**: `"chart"` \| `"custom"` \| `"pivot"` \| `"text"`

Widget type

### Callbacks

#### beforeRender

> **beforeRender**: [`BeforeRenderHandler`](../type-aliases/type-alias.BeforeRenderHandler.md) \| [`IndicatorBeforeRenderHandler`](../type-aliases/type-alias.IndicatorBeforeRenderHandler.md) \| `undefined`

A callback that allows you to customize the underlying chart element before it is rendered. The returned options are then used when rendering the chart.

This callback is not supported for Areamap Chart, Scattermap Chart, Table, and PivotTable.

***

#### dataPointClick

> **dataPointClick**: `EventEmitter`\< [`WidgetDataPointClickEvent`](../type-aliases/type-alias.WidgetDataPointClickEvent.md) \>

Click handler callback for a data point

***

#### dataPointContextMenu

> **dataPointContextMenu**: `EventEmitter`\< [`WidgetDataPointContextMenuEvent`](../type-aliases/type-alias.WidgetDataPointContextMenuEvent.md) \>

Context menu handler callback for a data point

***

#### dataPointsSelect

> **dataPointsSelect**: `EventEmitter`\< [`ChartDataPointsEvent`](../type-aliases/type-alias.ChartDataPointsEvent.md) \>

Handler callback for selection of multiple data points

***

#### dataReady

> **dataReady**: (`data`) => [`Data`](../../sdk-data/interfaces/interface.Data.md) \| `undefined`

A callback that allows to modify data immediately after it has been retrieved.
It can be used to inject modification of queried data.

a`](../../sdk-data/interfaces/interface.Data.md) \| `undefined`

A callback that allows to modify data immediately after it has been retrieved.
It can be used to inject modification of queried data.

# Function addFilter

> **addFilter**(`dashboard`, `newFilter`): [`DashboardProps`](../../../interfaces/interface.DashboardProps.md)

Creates a new dashboard instance with an additional filter added to its existing filters.

This function does not modify the original dashboard; instead, it returns a new dashboard with the added filter.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `dashboard` | [`DashboardProps`](../../../interfaces/interface.DashboardProps.md) | The original dashboard (`DashboardProps`) to which the filter will be added. |
| `newFilter` | [`Filter`](../../../../sdk-data/interfaces/interface.Filter.md) | The filter to add to the dashboard. |

## Returns

[`DashboardProps`](../../../interfaces/interface.DashboardProps.md)

A new dashboard instance with the new filter added.

## Example

Add a new filter to a dashboard.
```ts
const existingDashboard: DashboardProps = {...};
const newFilter: Filter = {...};
const updatedDashboard = dashboardHelpers.addFilter(existingDashboard, newFilter);
```

filter to a dashboard.
```ts
const existingDashboard: DashboardProps = {...};
const newFilter: Filter = {...};
const updatedDashboard = dashboardHelpers.addFilter(existingDashboard, newFilter);
```

# Function addFilters

> **addFilters**(`dashboard`, `newFilters`): [`DashboardProps`](../../../interfaces/interface.DashboardProps.md)

Creates a new dashboard instance with additional filters added to its existing filters.

This function does not modify the original dashboard; instead, it returns a new dashboard with the added filters.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `dashboard` | [`DashboardProps`](../../../interfaces/interface.DashboardProps.md) | The original dashboard (`DashboardProps`) to which the filters will be added. |
| `newFilters` | [`Filter`](../../../../sdk-data/interfaces/interface.Filter.md)[] | An array of filters to add to the dashboard. |

## Returns

[`DashboardProps`](../../../interfaces/interface.DashboardProps.md)

A new dashboard instance with the new filters added.

## Example

Add multiple new filters to a dashboard.
```ts
const existingDashboard: DashboardProps = {...};
const newFilters: Filter[] = [{...}, {...}, ...];
const updatedDashboard = dashboardHelpers.addFilters(existingDashboard, newFilters);
```

# Function extractDimensionsAndMeasures

> **extractDimensionsAndMeasures**(`dataOptions`): `object`

Utility function for converting data options to parameters for executing a query.

Filters);
```

# Function extractDimensionsAndMeasures

> **extractDimensionsAndMeasures**(`dataOptions`): `object`

Utility function for converting data options to parameters for executing a query.

## Parameters

| Parameter | Type |
| :------ | :------ |
| `dataOptions` | [`GenericDataOptions`](../type-aliases/type-alias.GenericDataOptions.md) |

## Returns

### `dimensions`

**dimensions**: [`Attribute`](../../sdk-data/interfaces/interface.Attribute.md)[]

### `measures`

**measures**: [`Measure`](../../sdk-data/interfaces/interface.Measure.md)[]

# Function removeFilter

> **removeFilter**(`dashboard`, `filterToRemove`): [`DashboardProps`](../../../interfaces/interface.DashboardProps.md)

Creates a new dashboard instance with a specific filter removed.

This function removes the filter with the same GUID as the provided filter from the dashboard's filters.
This function does not modify the original dashboard; instead, it returns a new dashboard with the updated filters.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `dashboard` | [`DashboardProps`](../../../interfaces/interface.DashboardProps.md) | The original dashboard (`DashboardProps`) from which to remove the filter. |
| `filterToRemove` | [`Filter`](../../../../sdk-data/interfaces/interface.Filter.md) | The filter to be removed. |

## Returns

[`DashboardProps`](../../../interfaces/interface.DashboardProps.md)

A new dashboard instance with the specified filter removed.

faces/interface.Filter.md) | The filter to be removed. |

## Returns

[`DashboardProps`](../../../interfaces/interface.DashboardProps.md)

A new dashboard instance with the specified filter removed.

## Example

Remove a filter from a dashboard.
```ts
const existingDashboard: DashboardProps = {...};
const filterToRemove: Filter = {...};
const updatedDashboard = dashboardHelpers.removeFilter(existingDashboard, filterToRemove);
```

# Function removeFilters

> **removeFilters**(`dashboard`, `filtersToRemove`): [`DashboardProps`](../../../interfaces/interface.DashboardProps.md)

Creates a new dashboard instance with multiple filters removed.

This function removes all filters with the same GUID as the provided filters from the dashboard's filters.
This function does not modify the original dashboard; instead, it returns a new dashboard with the updated filters.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `dashboard` | [`DashboardProps`](../../../interfaces/interface.DashboardProps.md) | The original dashboard (`DashboardProps`) from which the specified filters are removed. |
| `filtersToRemove` | [`Filter`](../../../../sdk-data/interfaces/interface.Filter.md)[] | An array of filters to remove. |

## Returns

[`DashboardProps`](../../../interfaces/interface.DashboardProps.md)

A new dashboard instance with the specified filters removed.

terface.Filter.md)[] | An array of filters to remove. |

## Returns

[`DashboardProps`](../../../interfaces/interface.DashboardProps.md)

A new dashboard instance with the specified filters removed.

## Example

Remove multiple filters from a dashboard.
```ts
const existingDashboard: DashboardProps = {...};
const filtersToRemove: Filter[] = [{...}, {...}, ...];
const updatedDashboard = dashboardHelpers.removeFilters(existingDashboard, filtersToRemove);
```

# Function replaceFilter

> **replaceFilter**(
  `dashboard`,
  `filterToReplace`,
  `newFilter`): [`DashboardProps`](../../../interfaces/interface.DashboardProps.md)

Creates a new dashboard instance with a specific filter replaced.

This function searches for a filter with the same GUID as the provided `filterToReplace` and replaces it with `newFilter`.
This function does not modify the original dashboard; instead, it returns a new dashboard with the updated filters.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `dashboard` | [`DashboardProps`](../../../interfaces/interface.DashboardProps.md) | The original dashboard (`DashboardProps`) containing the filter to be replaced. |
| `filterToReplace` | [`Filter`](../../../../sdk-data/interfaces/interface.Filter.md) | The existing filter to be replaced. |
| `newFilter` | [`Filter`](../../../../sdk-data/interfaces/interface.Filter.md) | The new filter to replace the existing one. |

nterfaces/interface.Filter.md) | The existing filter to be replaced. |
| `newFilter` | [`Filter`](../../../../sdk-data/interfaces/interface.Filter.md) | The new filter to replace the existing one. |

## Returns

[`DashboardProps`](../../../interfaces/interface.DashboardProps.md)

A new dashboard instance with the specified filter replaced.

## Example

Replace a filter in a dashboard.
```ts
const existingDashboard: DashboardProps = {...};
const filterToReplace: Filter = {...};
const newFilter: Filter = {...};
const updatedDashboard = dashboardHelpers.replaceFilter(existingDashboard, filterToReplace, newFilter);
```

# Function replaceFilters

> **replaceFilters**(`dashboard`, `newFilters`): [`DashboardProps`](../../../interfaces/interface.DashboardProps.md)

Creates a new dashboard instance with its filters replaced by a new set of filters.

This function does not modify the original dashboard; instead, it returns a new dashboard with the updated filters.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `dashboard` | [`DashboardProps`](../../../interfaces/interface.DashboardProps.md) | The original dashboard (`DashboardProps`) whose filters are to be replaced. |
| `newFilters` | [`FilterRelations`](../../../../sdk-data/interfaces/interface.FilterRelations.md) \| [`Filter`](../../../../sdk-data/interfaces/interface.Filter.md)[] | An array of new filters or filter relations to set on the dashboard. |

/../../sdk-data/interfaces/interface.FilterRelations.md) \| [`Filter`](../../../../sdk-data/interfaces/interface.Filter.md)[] | An array of new filters or filter relations to set on the dashboard. |

## Returns

[`DashboardProps`](../../../interfaces/interface.DashboardProps.md)

A new dashboard instance with the updated filters.

## Example

Replace all filters on a dashboard with a new set of filters.
```ts
const existingDashboard: DashboardProps = {...}
const newFilters: Filter[] = [{...}, {...}, ...];
const updatedDashboard = dashboardHelpers.replaceFilters(existingDashboard, newFilters);
```


## Fusion Assets

ingDashboard: DashboardProps = {...}
const newFilters: Filter[] = [{...}, {...}, ...];
const updatedDashboard = dashboardHelpers.replaceFilters(existingDashboard, newFilters);
```


## Fusion Assets

# Fusion Assets

Angular components, services, and utilities for working with Fusion dashboards, widgets, queries, and formulas

- [DashboardByIdComponent](class.DashboardByIdComponent.md) <Badge type="fusionEmbed" text="Fusion Embed" />
- [DashboardModel](interface.DashboardModel.md) <Badge type="fusionEmbed" text="Fusion Embed" />
- [dashboardModelTranslator](namespace.dashboardModelTranslator/index.md) <Badge type="fusionEmbed" text="Fusion Embed" /> - Utility functions to translate a Fusion dashboard model from and to other dashboard data structures
- [DashboardService](class.DashboardService.md) <Badge type="fusionEmbed" text="Fusion Embed" />
- [FormulaService](class.FormulaService.md) <Badge type="fusionEmbed" text="Fusion Embed" />
- [HierarchyService](class.HierarchyService.md) <Badge type="fusionEmbed" text="Fusion Embed" />
- [WidgetByIdComponent](class.WidgetByIdComponent.md) <Badge type="fusionEmbed" text="Fusion Embed" />
- [WidgetModel](interface.WidgetModel.md) <Badge type="fusionEmbed" text="Fusion Embed" />
- [widgetModelTranslator](namespace.widgetModelTranslator/index.md) <Badge type="fusionEmbed" text="Fusion Embed" /> - Utility functions to translate a Fusion widget model from and to other widget data structures
- [WidgetService](class.WidgetService.md) <Badge type="fusionEmbed" text="Fusion Embed" />

n Embed" /> - Utility functions to translate a Fusion widget model from and to other widget data structures
- [WidgetService](class.WidgetService.md) <Badge type="fusionEmbed" text="Fusion Embed" />

# Namespace dashboardModelTranslator <Badge type="fusionEmbed" text="Fusion Embed" />

Utility functions to translate a Fusion dashboard model from and to other dashboard data structures

## Index

### Functions

- [toDashboardProps](functions/function.toDashboardProps.md)

Utility functions to translate a Fusion dashboard model from and to other dashboard data structures

# Functions

- [toDashboardProps](function.toDashboardProps.md)

# Namespace widgetModelTranslator <Badge type="fusionEmbed" text="Fusion Embed" />

Utility functions to translate a Fusion widget model from and to other widget data structures

## Index

Props.md)

# Namespace widgetModelTranslator <Badge type="fusionEmbed" text="Fusion Embed" />

Utility functions to translate a Fusion widget model from and to other widget data structures

## Index

### Functions

- [toChartProps](functions/function.toChartProps.md)
- [toChartWidgetProps](functions/function.toChartWidgetProps.md)
- [toExecutePivotQueryParams](functions/function.toExecutePivotQueryParams.md)
- [toExecuteQueryParams](functions/function.toExecuteQueryParams.md)
- [toPivotTableProps](functions/function.toPivotTableProps.md)
- [toPivotTableWidgetProps](functions/function.toPivotTableWidgetProps.md)
- [toTableProps](functions/function.toTableProps.md)
- [toTextWidgetProps](functions/function.toTextWidgetProps.md)
- [toWidgetProps](functions/function.toWidgetProps.md)

Utility functions to translate a Fusion widget model from and to other widget data structures

# Functions

- [toChartProps](function.toChartProps.md)
- [toChartWidgetProps](function.toChartWidgetProps.md)
- [toExecutePivotQueryParams](function.toExecutePivotQueryParams.md)
- [toExecuteQueryParams](function.toExecuteQueryParams.md)
- [toPivotTableProps](function.toPivotTableProps.md)
- [toPivotTableWidgetProps](function.toPivotTableWidgetProps.md)
- [toTableProps](function.toTableProps.md)
- [toTextWidgetProps](function.toTextWidgetProps.md)
- [toWidgetProps](function.toWidgetProps.md)

votTableWidgetProps](function.toPivotTableWidgetProps.md)
- [toTableProps](function.toTableProps.md)
- [toTextWidgetProps](function.toTextWidgetProps.md)
- [toWidgetProps](function.toWidgetProps.md)

# Class DashboardByIdComponent <Badge type="fusionEmbed" text="Fusion Embed" />

An Angular component used for easily rendering a dashboard by its ID created in a Sisense Fusion instance.

**Note:** Dashboard and Widget extensions based on JS scripts and add-ons in Fusion – for example, Blox and Jump To Dashboard – are not supported.

## Example

```ts
import { Component } from '@angular/core';
@Component({
  selector: 'code-example',
  template: `
    <div style="width: 100vw;">
      `<csdk-dashboard-by-id *ngIf="dashboardOid" [dashboardOid]="dashboardOid" />`
    </div>
  `,
 })
export class CodeExampleComponent {
  dashboardOid = 'your-dashboard-oid';
}
```

To learn more about this and related dashboard components,
see [Embedded Dashboards](/guides/sdk/guides/dashboards/index.html).

## Implements

- `AfterViewInit`
- `OnChanges`
- `OnDestroy`

## Constructors

more about this and related dashboard components,
see [Embedded Dashboards](/guides/sdk/guides/dashboards/index.html).

## Implements

- `AfterViewInit`
- `OnChanges`
- `OnDestroy`

## Constructors

### constructor

> **new DashboardByIdComponent**(`sisenseContextService`, `themeService`): [`DashboardByIdComponent`](class.DashboardByIdComponent.md)

Constructor for the `DashboardById` component.

#### Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `sisenseContextService` | [`SisenseContextService`](../contexts/class.SisenseContextService.md) | Sisense context service |
| `themeService` | [`ThemeService`](../contexts/class.ThemeService.md) | Theme service |

#### Returns

[`DashboardByIdComponent`](class.DashboardByIdComponent.md)

## Properties

### Constructor

#### sisenseContextService

> **sisenseContextService**: [`SisenseContextService`](../contexts/class.SisenseContextService.md)

Sisense context service

***

#### themeService

> **themeService**: [`ThemeService`](../contexts/class.ThemeService.md)

Theme service

### Other

#### config

> **config**: [`DashboardByIdConfig`](../interfaces/interface.DashboardByIdConfig.md) \| `undefined`

The configuration for the dashboard

***

#### dashboardOid

> **dashboardOid**: `string`

The OID of the dashboard to render.

onfig`](../interfaces/interface.DashboardByIdConfig.md) \| `undefined`

The configuration for the dashboard

***

#### dashboardOid

> **dashboardOid**: `string`

The OID of the dashboard to render.

# Class DashboardService <Badge type="fusionEmbed" text="Fusion Embed" />

Service for working with Sisense Fusion dashboards.

**Note:** Dashboard and Widget extensions based on JS scripts and add-ons in Fusion – for example, Blox and Jump To Dashboard – are not supported.

## Constructors

### constructor

> **new DashboardService**(`sisenseContextService`): [`DashboardService`](class.DashboardService.md)

#### Parameters

| Parameter | Type |
| :------ | :------ |
| `sisenseContextService` | [`SisenseContextService`](../contexts/class.SisenseContextService.md) |

#### Returns

[`DashboardService`](class.DashboardService.md)

## Methods

|
| :------ | :------ |
| `sisenseContextService` | [`SisenseContextService`](../contexts/class.SisenseContextService.md) |

#### Returns

[`DashboardService`](class.DashboardService.md)

## Methods

### createComposedDashboard

> **createComposedDashboard**<`D`>(`initialDashboard`, `options` = `{}`): `object`

Сomposes dashboard or separate dashboard elements into a coordinated dashboard
with cross filtering, and change detection.

#### Type parameters

| Parameter |
| :------ |
| `D` *extends* [`ComposableDashboardProps`](../interfaces/interface.ComposableDashboardProps.md) \| [`DashboardProps`](../interfaces/interface.DashboardProps.md) |

#### Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `initialDashboard` | `D` | Initial dashboard |
| `options` | [`UseComposedDashboardOptions`](../../sdk-ui/type-aliases/type-alias.UseComposedDashboardOptions.md) | Configuration options |

#### Returns

Reactive composed dashboard object and API methods for interacting with it.
The returned object includes a `destroy()` method that should be called when
the dashboard is no longer needed to prevent memory leaks (e.g., in `ngOnDestroy`).

##### `dashboard$`

**dashboard$**: `BehaviorSubject`\< `D` \>

##### `destroy`

**destroy**: () => `void`

###### Returns

`void`

##### `setFilters`

**setFilters**: (`filters`) => `Promise`\< `void` \>

###### Parameters

| Parameter | Type |
| :------ | :------ |
| `filters` | [`FilterRelations`](../../sdk-data/interfaces/interface.FilterRelations.md) \| [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[] |

###### Returns

`Promise`\< `void` \>

##### `setWidgetsLayout`

**setWidgetsLayout**: (`newLayout`) => `Promise`\< `void` \>

###### Parameters

| Parameter | Type |
| :------ | :------ |
| `newLayout` | [`WidgetsPanelColumnLayout`](../interfaces/interface.WidgetsPanelColumnLayout.md) |

###### Returns

`Promise`\< `void` \>

#### Example

An example of using the `createComposedDashboard` to construct a composed dashboard and render it:
```html
 <!--Component HTML template in example.component.html-->
 <div *ngIf="dashboard$ | async as dashboard">
   <csdk-filter-tile
     *ngFor="let filter of getDashboardFilters(dashboard); trackBy: trackByIndex"
     [filter]="filter"
   />
   <csdk-widget
     *ngFor="let widget of dashboard.widgets; trackBy: trackByIndex"
     [id]="widget.id"
     [widgetType]="widget.widgetType"
     [chartType]="widget.chartType"
     [customWidgetType]="widget.customWidgetType"
     [dataSource]="widget.dataSource"
     [dataOptions]="widget.dataOptions"
     [filters]="widget.filters"
     [highlights]="widget.highlights"
     [styleOptions]="widget.styleOptions"
     [drilldownOptions]="widget.drilldownOptions"
     [title]="widget.title"
     [description]="widget.description"
     [beforeMenuOpen]="widget.beforeMenuOpen"
     (dataPointClick)="widget.dataPointClick?.($event)"
     (dataPointContextMenu)="widget.dataPointContextMenu?.($event)"
     (dataPointsSelect)="widget.dataPointsSelect?.($event)"
   />
 </div>
```

```ts
 // Component behavior in example.component.ts
 import { Component, OnDestroy } from '@angular/core';
 import { BehaviorSubject } from 'rxjs';
 import { DashboardService, type DashboardProps } from '@sisense/sdk-ui-angular';

 @Component({
   selector: 'example',
   templateUrl: './example.component.html',
   styleUrls: ['./example.component.scss'],
 })
 export class ExampleComponent implements OnDestroy {
   dashboard$: BehaviorSubject<DashboardProps> | undefined;
   private composedDashboard: ReturnType<DashboardService['createComposedDashboard']> | undefined;

   constructor(private dashboardService: DashboardService) {}

   ngOnInit() {
     const initialDashboard: DashboardProps = { ... };
     this.composedDashboard = this.dashboardService.createComposedDashboard(initialDashboard);
     this.dashboard$ = this.composedDashboard.dashboard$;
   }

   ngOnDestroy() {
     this.composedDashboard?.destroy();
   }

   trackByIndex = (index: number) => index;

   getDashboardFilters = ({ filters }: DashboardProps) => Array.isArray(filters) ? filters : [];
 }
```

***

this.composedDashboard?.destroy();
   }

   trackByIndex = (index: number) => index;

   getDashboardFilters = ({ filters }: DashboardProps) => Array.isArray(filters) ? filters : [];
 }
```

***

### getDashboardModel

> **getDashboardModel**(`dashboardOid`, `options`?): `Promise`\< [`DashboardModel`](interface.DashboardModel.md) \>

Retrieves an existing dashboard model from the Sisense instance.

#### Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `dashboardOid` | `string` | Identifier of the dashboard |
| `options`? | [`GetDashboardModelOptions`](../interfaces/interface.GetDashboardModelOptions.md) | Advanced configuration options |

#### Returns

`Promise`\< [`DashboardModel`](interface.DashboardModel.md) \>

Dashboard model

***

### getDashboardModels

> **getDashboardModels**(`options`?): `Promise`\< [`DashboardModel`](interface.DashboardModel.md)[] \>

Retrieves existing dashboard models from the Sisense instance.

#### Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `options`? | [`GetDashboardModelsOptions`](../interfaces/interface.GetDashboardModelsOptions.md) | Advanced configuration options |

#### Returns

`Promise`\< [`DashboardModel`](interface.DashboardModel.md)[] \>

Dashboard models array

# Class FormulaService <Badge type="fusionEmbed" text="Fusion Embed" />

Service for working with shared formulas.

## Constructors

Model`](interface.DashboardModel.md)[] \>

Dashboard models array

# Class FormulaService <Badge type="fusionEmbed" text="Fusion Embed" />

Service for working with shared formulas.

## Constructors

### constructor

> **new FormulaService**(`sisenseContextService`): [`FormulaService`](class.FormulaService.md)

#### Parameters

| Parameter | Type |
| :------ | :------ |
| `sisenseContextService` | [`SisenseContextService`](../contexts/class.SisenseContextService.md) |

#### Returns

[`FormulaService`](class.FormulaService.md)

## Methods

### getSharedFormula

> **getSharedFormula**(`params`): `Promise`\< [`CalculatedMeasure`](../../sdk-data/interfaces/interface.CalculatedMeasure.md) \| `null` \>

Fetch a [shared formula](https://docs.sisense.com/main/SisenseLinux/shared-formulas.htm) from a Fusion instance.

The formula can be identified either by `oid` or by `name` and `dataSource` pair.

When the retrieval is successful but the shared formula is not found, the result is `null`. When the retrieval is not successful, the promise is rejected with an error.

## Example

Retrieve a shared formula by oid:

```ts
try {
  const formula = await formulaService.getSharedFormula({
    oid: 'd61c337b-fabc-4e9e-b4cc-a30116857153',
  });

  if (formula) {
    console.log('Formula found:', formula);
  } else {
    console.log('Formula not found');
  }
} catch (error) {
  console.error('Error:', error);
}
```

b4cc-a30116857153',
  });

  if (formula) {
    console.log('Formula found:', formula);
  } else {
    console.log('Formula not found');
  }
} catch (error) {
  console.error('Error:', error);
}
```

## Example

Retrieve a shared formula by name and data source:

```ts
try {
  const formula = await formulaService.getSharedFormula({
    name: 'My Shared Formula',
    dataSource: DM.DataSource,
  });

  if (formula) {
    console.log('Formula found:', formula);
  } else {
    console.log('Formula not found');
  }
} catch (error) {
  console.error('Error:', error);
}
```

#### Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `params` | [`GetSharedFormulaParams`](../interfaces/interface.GetSharedFormulaParams.md) | Parameters for retrieving the shared formula. Must include either `oid` or both `name` and `dataSource`. |

#### Returns

`Promise`\< [`CalculatedMeasure`](../../sdk-data/interfaces/interface.CalculatedMeasure.md) \| `null` \>

Promise that resolves to the shared formula, or `null` if not found

# Class HierarchyService <Badge type="fusionEmbed" text="Fusion Embed" />

Service for working with Sisense Fusion hierarchies.

## Constructors

solves to the shared formula, or `null` if not found

# Class HierarchyService <Badge type="fusionEmbed" text="Fusion Embed" />

Service for working with Sisense Fusion hierarchies.

## Constructors

### constructor

> **new HierarchyService**(`sisenseContextService`): [`HierarchyService`](class.HierarchyService.md)

#### Parameters

| Parameter | Type |
| :------ | :------ |
| `sisenseContextService` | [`SisenseContextService`](../contexts/class.SisenseContextService.md) |

#### Returns

[`HierarchyService`](class.HierarchyService.md)

## Methods

### getHierarchyModels

> **getHierarchyModels**(`params`): `Promise`\< [`HierarchyModel`](../interfaces/interface.HierarchyModel.md)[] \>

Retrieves existing hierarchy models from the Sisense instance.

#### Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `params` | [`GetHierarchyModelsParams`](../interfaces/interface.GetHierarchyModelsParams.md) | Parameters to identify the target hierarchy models |

#### Returns

`Promise`\< [`HierarchyModel`](../interfaces/interface.HierarchyModel.md)[] \>

Hierarchy models array

HierarchyModelsParams.md) | Parameters to identify the target hierarchy models |

#### Returns

`Promise`\< [`HierarchyModel`](../interfaces/interface.HierarchyModel.md)[] \>

Hierarchy models array

# Class WidgetByIdComponent <Badge type="fusionEmbed" text="Fusion Embed" />

The `WidgetById` component, which is a thin wrapper on [ChartWidgetComponent](../dashboards/class.ChartWidgetComponent.md),
is used to render a widget created in a Sisense Fusion instance.

To learn more about using Sisense Fusion Widgets in Compose SDK, see
[Sisense Fusion Widgets](https://developer.sisense.com/guides/sdk/guides/charts/guide-fusion-widgets.html).

## Example

```html
<csdk-widget-by-id
   [widgetOid]="widgetOid"
   [dashboardOid]="dashboardOid"
   [includeDashboardFilters]="true"
/>
```
```ts
import { Component } from '@angular/core';

@Component({
 selector: 'app-widgets',
 templateUrl: './widgets.component.html',
 styleUrls: ['./widgets.component.scss'],
})
export class WidgetsComponent {
 widgetOid: string = '60f3e3e3e4b0e3e3e4b0e3e3';
 dashboardOid: string = '60f3e3e3e4b0e3e3e4b0e3e3';
}
```

## Implements

- `AfterViewInit`
- `OnChanges`
- `OnDestroy`

## Constructors

sComponent {
 widgetOid: string = '60f3e3e3e4b0e3e3e4b0e3e3';
 dashboardOid: string = '60f3e3e3e4b0e3e3e4b0e3e3';
}
```

## Implements

- `AfterViewInit`
- `OnChanges`
- `OnDestroy`

## Constructors

### constructor

> **new WidgetByIdComponent**(`sisenseContextService`, `themeService`): [`WidgetByIdComponent`](class.WidgetByIdComponent.md)

#### Parameters

| Parameter | Type |
| :------ | :------ |
| `sisenseContextService` | [`SisenseContextService`](../contexts/class.SisenseContextService.md) |
| `themeService` | [`ThemeService`](../contexts/class.ThemeService.md) |

#### Returns

[`WidgetByIdComponent`](class.WidgetByIdComponent.md)

## Properties

ontexts/class.SisenseContextService.md) |
| `themeService` | [`ThemeService`](../contexts/class.ThemeService.md) |

#### Returns

[`WidgetByIdComponent`](class.WidgetByIdComponent.md)

## Properties

### Data

#### filters

> **filters**: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[] \| `undefined`

Filters that will slice query results

Provided filters will be merged with the existing filters from the widget configuration.

***

#### filtersMergeStrategy

> **filtersMergeStrategy**: `"codeFirst"` \| `"codeOnly"` \| `"widgetFirst"` \| `undefined`

Strategy for merging the existing widget filters (including highlights) with the filters provided via the `filters` and `highlights` props:

- `widgetFirst` - prioritizes the widget filters over the provided filters in case of filter conflicts by certain attributes.
- `codeFirst` - prioritizes the provided filters over the widget filters in case of filter conflicts by certain attributes.
- `codeOnly` - applies only the provided filters and completely ignores the widget filters.

If not specified, the default strategy is `codeFirst`.

***

#### highlights

> **highlights**: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[] \| `undefined`

Highlight filters that will highlight results that pass filter criteria

***

#### includeDashboardFilters

> **includeDashboardFilters**: `boolean` \| `undefined`

Boolean flag whether to include dashboard filters in the widget's `filters` and `highlights`

If not specified, the default value is `false`.

> **includeDashboardFilters**: `boolean` \| `undefined`

Boolean flag whether to include dashboard filters in the widget's `filters` and `highlights`

If not specified, the default value is `false`.

### Widget

#### dashboardOid

> **dashboardOid**: `string`

Identifier of the dashboard that contains the widget

***

#### description

> **description**: `string` \| `undefined`

Description of the widget

If not specified, it takes the existing value from the widget configuration.

***

#### highlightSelectionDisabled

> **highlightSelectionDisabled**: `boolean` \| `undefined`

Boolean flag whether selecting data points triggers highlight filter of the selected data

Recommended to turn on when the Chart Widget component is enhanced with data drilldown by the Drilldown Widget component

If not specified, the default value is `false`

***

#### styleOptions

> **styleOptions**: [`WidgetByIdStyleOptions`](../interfaces/interface.WidgetByIdStyleOptions.md) \| `undefined`

Style options for the widget including the widget container and the chart or table inside.

***

#### title

> **title**: `string` \| `undefined`

Title of the widget

If not specified, it takes the existing value from the widget configuration.

***

#### widgetOid

> **widgetOid**: `string`

Identifier of the widget

: `string` \| `undefined`

Title of the widget

If not specified, it takes the existing value from the widget configuration.

***

#### widgetOid

> **widgetOid**: `string`

Identifier of the widget

### Callbacks

#### dataReady

> **dataReady**: (`data`) => [`Data`](../../sdk-data/interfaces/interface.Data.md) \| `undefined`

A callback that allows to modify data immediately after it has been retrieved.
It can be used to inject modification of queried data.

# Class WidgetService <Badge type="fusionEmbed" text="Fusion Embed" />

Service for working with Sisense Fusion widgets.

## Dashboards

ieved.
It can be used to inject modification of queried data.

# Class WidgetService <Badge type="fusionEmbed" text="Fusion Embed" />

Service for working with Sisense Fusion widgets.

## Dashboards

### createJtdWidget

> **createJtdWidget**(`widgetProps`, `jtdConfig`): `object`

Adds Jump To Dashboard (JTD) functionality to widget props.

Jump To Dashboard (JTD) allows users to navigate from one dashboard to another when interacting with widgets,
such as clicking on chart data points or using context menus. This method is particularly useful when rendering
Widget components directly (not through a Dashboard component), but you still want JTD navigation functionality.

For widgets that are part of a dashboard, consider using `applyJtdConfig` or `applyJtdConfigs` instead,
as they apply JTD configuration at the dashboard level rather than individual widget level.

Note: dashboard-only 'includeDashboardFilters' is not supported and would just be ignored, since we do not have a dashboard in the current context.

This method enhances the provided widget props with JTD navigation capabilities, including:
- Click and right-click event handlers for navigation
- Hyperlink styling for actionable pivot cells (when applicable)
- JTD icon display in widget headers

#### Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `widgetProps` | [`WidgetProps`](../type-aliases/type-alias.WidgetProps.md) \| `null` | Base widget props to enhance with JTD functionality |
| `jtdConfig` | [`JumpToDashboardConfig`](../interfaces/interface.JumpToDashboardConfig.md) \| [`JumpToDashboardConfigForPivot`](../interfaces/interface.JumpToDashboardConfigForPivot.md) | JTD configuration defining navigation targets and behavior |

#### Returns

Object containing:
        - `widget$`: The observable that emits enhanced widget props with JTD handlers.
        - `destroy`: Function to clean up resources. Call this when the component is destroyed.

##### `destroy`

**destroy**: () => `void`

###### Returns

`void`

##### `widget$`

**widget$**: `BehaviorSubject`\< [`WidgetProps`](../type-aliases/type-alias.WidgetProps.md) \| `null` \>

#### Example

```TypeScript
import { Component, OnDestroy } from '@angular/core';
import {
  WidgetService,
  widgetModelTranslator,
  type WidgetProps,
} from '@sisense/sdk-ui-angular';
import { BehaviorSubject } from 'rxjs';

@Component({
  selector: 'code-example',
  template: `
    `<csdk-widget
      *ngIf="widgetProps$ && (widgetProps$ | async) as widgetProps"
      [id]="widgetProps.id"
      [widgetType]="widgetProps.widgetType"
      [chartType]="widgetProps.chartType"
      [title]="widgetProps.title"
      [dataSource]="widgetProps.dataSource"
      [dataOptions]="widgetProps.dataOptions"
      [filters]="widgetProps.filters"
      [highlights]="widgetProps.highlights"
      [styleOptions]="widgetProps.styleOptions"
      [beforeMenuOpen]="widgetProps.beforeMenuOpen"
      (dataPointClick)="widgetProps.dataPointClick?.($event)"
      (dataPointContextMenu)="widgetProps.dataPointContextMenu?.($event)"
      (dataPointsSelect)="widgetProps.dataPointsSelect?.($event)"
    />`
  `,
})
export class CodeExample implements OnDestroy {
  constructor(private widgetService: WidgetService) {}

  widgetProps$: BehaviorSubject<WidgetProps | null> | null = null;
  private jtdDestroy: (() => void) | null = null;

  async ngOnInit(): Promise<void> {
    const widget = await this.widgetService.getWidgetModel({
      dashboardOid: '65a82171719e7f004018691c',
      widgetOid: '65a82171719e7f004018691f',
    });

    const baseProps = widget
      ? widgetModelTranslator.toWidgetProps(widget)
      : null;

    if (baseProps) {
      const jtdConfig = {
        targets: [{ id: 'target-dashboard-id', caption: 'Details' }],
        interaction: { triggerMethod: 'rightclick' },
      };
      const jtdResult = this.widgetService.createJtdWidget(
        baseProps,
        jtdConfig,
      );
      this.widgetProps$ = jtdResult.widget$;
      this.jtdDestroy = jtdResult.destroy;
    }
  }

  ngOnDestroy(): void {
    this.jtdDestroy?.();
  }
}
```

baseProps,
        jtdConfig,
      );
      this.widgetProps$ = jtdResult.widget$;
      this.jtdDestroy = jtdResult.destroy;
    }
  }

  ngOnDestroy(): void {
    this.jtdDestroy?.();
  }
}
```

## Constructors

### constructor

> **new WidgetService**(`sisenseContextService`, `themeService`): [`WidgetService`](class.WidgetService.md)

#### Parameters

| Parameter | Type |
| :------ | :------ |
| `sisenseContextService` | [`SisenseContextService`](../contexts/class.SisenseContextService.md) |
| `themeService` | [`ThemeService`](../contexts/class.ThemeService.md) |

#### Returns

[`WidgetService`](class.WidgetService.md)

## Methods

### getWidgetModel

> **getWidgetModel**(`params`): `Promise`\< [`WidgetModel`](interface.WidgetModel.md) \>

Retrieves an existing widget model from the Sisense instance.

#### Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `params` | [`GetWidgetModelParams`](../interfaces/interface.GetWidgetModelParams.md) | Parameters to identify the target widget |

#### Returns

`Promise`\< [`WidgetModel`](interface.WidgetModel.md) \>

Widget model

# Function toChartProps

> **toChartProps**(`widgetModel`): [`ChartProps`](../../../interfaces/interface.ChartProps.md)

Translates a [WidgetModel](../../interface.WidgetModel.md) to the props for rendering a chart.

## Parameters

| Parameter | Type |
| :------ | :------ |
| `widgetModel` | [`WidgetModel`](../../interface.WidgetModel.md) |

el](../../interface.WidgetModel.md) to the props for rendering a chart.

## Parameters

| Parameter | Type |
| :------ | :------ |
| `widgetModel` | [`WidgetModel`](../../interface.WidgetModel.md) |

## Returns

[`ChartProps`](../../../interfaces/interface.ChartProps.md)

## Example

```html
<csdk-chart
 *ngIf="chartProps"
 [chartType]="chartProps.chartType"
 [dataSet]="chartProps.dataSet"
 [dataOptions]="chartProps.dataOptions"
 [filters]="chartProps.filters"
 [highlights]="chartProps.highlights"
 [styleOptions]="chartProps.styleOptions"
/>
```

```ts
import { Component } from '@angular/core';
import {
 type ChartProps
 WidgetService,
 widgetModelTranslator,
} from '@sisense/sdk-ui-angular';

@Component({
 selector: 'app-example',
 templateUrl: './example.component.html',
 styleUrls: ['./example.component.scss'],
})
export class ExampleComponent {
 chartProps: ChartProps | null = null;

 constructor(private widgetService: WidgetService) {}

 async ngOnInit(): Promise<void> {
   const widgetModel = await widgetService.getWidgetModel({
     dashboardOid: 'your-dashboard-oid',
     widgetOid: 'your-widget-oid'
   });
   this.chartProps = widgetModelTranslator.toChartProps(widgetModel);
 }
}
```

Note: this method is not supported for pivot widgets.
Use [toPivotTableProps](function.toPivotTableProps.md) instead for getting props for the [PivotTableComponent](../../../data-grids/class.PivotTableComponent.md).

is not supported for pivot widgets.
Use [toPivotTableProps](function.toPivotTableProps.md) instead for getting props for the [PivotTableComponent](../../../data-grids/class.PivotTableComponent.md).

# Function toChartWidgetProps

> **toChartWidgetProps**(`widgetModel`): [`ChartWidgetProps`](../../../interfaces/interface.ChartWidgetProps.md)

Translates a [WidgetModel](../../interface.WidgetModel.md) to the props for rendering a chart widget.

## Parameters

| Parameter | Type |
| :------ | :------ |
| `widgetModel` | [`WidgetModel`](../../interface.WidgetModel.md) |

## Returns

[`ChartWidgetProps`](../../../interfaces/interface.ChartWidgetProps.md)

s

| Parameter | Type |
| :------ | :------ |
| `widgetModel` | [`WidgetModel`](../../interface.WidgetModel.md) |

## Returns

[`ChartWidgetProps`](../../../interfaces/interface.ChartWidgetProps.md)

## Example

```html
<csdk-chart-widget
 *ngIf="chartWidgetProps"
 [chartType]="chartWidgetProps.chartType"
 [dataSource]="chartWidgetProps.dataSource"
 [dataOptions]="chartWidgetProps.dataOptions"
 [filters]="chartWidgetProps.filters"
 [highlights]="chartWidgetProps.highlights"
 [styleOptions]="chartWidgetProps.styleOptions"
/>
```

```ts
import { Component } from '@angular/core';
import {
 type ChartWidgetProps
 WidgetService,
 widgetModelTranslator,
} from '@sisense/sdk-ui-angular';

@Component({
 selector: 'app-example',
 templateUrl: './example.component.html',
 styleUrls: ['./example.component.scss'],
})
export class ExampleComponent {
 chartWidgetProps: ChartWidgetProps | null = null;

 constructor(private widgetService: WidgetService) {}

 async ngOnInit(): Promise<void> {
   const widgetModel = await widgetService.getWidgetModel({
     dashboardOid: 'your-dashboard-oid',
     widgetOid: 'your-widget-oid'
   });
   this.chartWidgetProps = widgetModelTranslator.toChartWidgetProps(widgetModel);
 }
}
```

Note: this method is not supported for pivot widgets.

board-oid',
     widgetOid: 'your-widget-oid'
   });
   this.chartWidgetProps = widgetModelTranslator.toChartWidgetProps(widgetModel);
 }
}
```

Note: this method is not supported for pivot widgets.

# Function toDashboardProps

> **toDashboardProps**(`dashboardModel`): [`DashboardProps`](../../../interfaces/interface.DashboardProps.md)

Translates [DashboardModel](../../interface.DashboardModel.md) to [DashboardProps](../../../interfaces/interface.DashboardProps.md).

## Parameters

| Parameter | Type |
| :------ | :------ |
| `dashboardModel` | [`DashboardModel`](../../interface.DashboardModel.md) |

## Returns

[`DashboardProps`](../../../interfaces/interface.DashboardProps.md)

Parameter | Type |
| :------ | :------ |
| `dashboardModel` | [`DashboardModel`](../../interface.DashboardModel.md) |

## Returns

[`DashboardProps`](../../../interfaces/interface.DashboardProps.md)

## Example

```html
<csdk-dashboard
 *ngIf="dashboard"
 [title]="dashboard.title"
 [layoutOptions]="dashboard.layoutOptions"
 [widgets]="dashboard.widgets"
 [filters]="dashboard.filters"
 [defaultDataSource]="dashboard.defaultDataSource"
 [widgetsOptions]="dashboard.widgetsOptions"
/>
```

```ts
import { Component } from '@angular/core';
import {
 type DashboardProps,
 DashboardService,
 dashboardModelTranslator,
} from '@sisense/sdk-ui-angular';

@Component({
 selector: 'app-dashboard',
 templateUrl: './dashboard.component.html',
 styleUrls: ['./dashboard.component.scss'],
})
export class DashboardComponent {
 dashboard: DashboardProps | null = null;

 constructor(private dashboardService: DashboardService) {}

 async ngOnInit(): Promise<void> {
   const dashboardModel = await this.dashboardService.getDashboardModel('your-dashboard-oid', {
     includeWidgets: true,
     includeFilters: true,
   });
   this.dashboard = dashboardModelTranslator.toDashboardProps(dashboardModel);
 }
}
```

# Function toExecutePivotQueryParams

> **toExecutePivotQueryParams**(`widgetModel`): [`ExecutePivotQueryParams`](../../../interfaces/interface.ExecutePivotQueryParams.md)

Translates a [WidgetModel](../../interface.WidgetModel.md) to the parameters for executing a query for the pivot widget.

PivotQueryParams`](../../../interfaces/interface.ExecutePivotQueryParams.md)

Translates a [WidgetModel](../../interface.WidgetModel.md) to the parameters for executing a query for the pivot widget.

## Parameters

| Parameter | Type |
| :------ | :------ |
| `widgetModel` | [`WidgetModel`](../../interface.WidgetModel.md) |

## Returns

[`ExecutePivotQueryParams`](../../../interfaces/interface.ExecutePivotQueryParams.md)

## Example

```ts
const widgetModel = await widgetService.getWidgetModel({
 dashboardOid: 'your-dashboard-oid',
 widgetOid: 'your-widget-oid'
});
const executePivotQueryParams = widgetModelTranslator.toExecutePivotQueryParams(widgetModel);
const queryResult = await queryService.executePivotQuery(executeQueryParams);
```

Note: this method is supported only for getting pivot query.
Use [toExecuteQueryParams](function.toExecuteQueryParams.md) instead for getting query parameters for non-pivot widgets.

# Function toExecuteQueryParams

> **toExecuteQueryParams**(`widgetModel`): [`ExecuteQueryParams`](../../../interfaces/interface.ExecuteQueryParams.md)

Translates a [WidgetModel](../../interface.WidgetModel.md) to the parameters for executing a query for the widget.

## Parameters

| Parameter | Type |
| :------ | :------ |
| `widgetModel` | [`WidgetModel`](../../interface.WidgetModel.md) |

## Returns

[`ExecuteQueryParams`](../../../interfaces/interface.ExecuteQueryParams.md)

Parameter | Type |
| :------ | :------ |
| `widgetModel` | [`WidgetModel`](../../interface.WidgetModel.md) |

## Returns

[`ExecuteQueryParams`](../../../interfaces/interface.ExecuteQueryParams.md)

## Example

```ts
const widgetModel = await widgetService.getWidgetModel({
 dashboardOid: 'your-dashboard-oid',
 widgetOid: 'your-widget-oid'
});
const executeQueryParams = widgetModelTranslator.toExecuteQueryParams(widgetModel);
const queryResult = await queryService.executeQuery(executeQueryParams);
```

Note: this method is not supported for getting pivot query.
Use [toExecutePivotQueryParams](function.toExecutePivotQueryParams.md) instead for getting query parameters for the pivot widget.

# Function toPivotTableProps

> **toPivotTableProps**(`widgetModel`): [`PivotTableProps`](../../../interfaces/interface.PivotTableProps.md)

Translates a [WidgetModel](../../interface.WidgetModel.md) to the props for rendering a pivot table.

## Parameters

| Parameter | Type |
| :------ | :------ |
| `widgetModel` | [`WidgetModel`](../../interface.WidgetModel.md) |

## Returns

[`PivotTableProps`](../../../interfaces/interface.PivotTableProps.md)

ers

| Parameter | Type |
| :------ | :------ |
| `widgetModel` | [`WidgetModel`](../../interface.WidgetModel.md) |

## Returns

[`PivotTableProps`](../../../interfaces/interface.PivotTableProps.md)

## Example

```html
<csdk-pivot-table
 *ngIf="pivotTableProps"
 [dataSet]="pivotTableProps.dataSet"
 [dataOptions]="pivotTableProps.dataOptions"
 [filters]="pivotTableProps.filters"
 [styleOptions]="pivotTableProps.styleOptions"
/>
```

```ts
import { Component } from '@angular/core';
import {
 type PivotTableProps
 WidgetService,
 widgetModelTranslator,
} from '@sisense/sdk-ui-angular';

@Component({
 selector: 'app-example',
 templateUrl: './example.component.html',
 styleUrls: ['./example.component.scss'],
})
export class ExampleComponent {
 pivotTableProps: PivotTableProps | null = null;

 constructor(private widgetService: WidgetService) {}

 async ngOnInit(): Promise<void> {
   const widgetModel = await widgetService.getWidgetModel({
     dashboardOid: 'your-dashboard-oid',
     widgetOid: 'your-widget-oid'
   });
   this.pivotTableProps = widgetModelTranslator.toPivotTableProps(widgetModel);
 }
}
```

Note: this method is not supported for chart or table widgets.
Use [toChartProps](function.toChartProps.md) instead for getting props for the [ChartComponent](../../../charts/class.ChartComponent.md).
Use [toTableProps](function.toTableProps.md) instead for getting props for the [TableComponent](../../../data-grids/class.TableComponent.md).

hartComponent](../../../charts/class.ChartComponent.md).
Use [toTableProps](function.toTableProps.md) instead for getting props for the [TableComponent](../../../data-grids/class.TableComponent.md).

# Function toPivotTableWidgetProps

> **toPivotTableWidgetProps**(`widgetModel`): [`PivotTableWidgetProps`](../../../interfaces/interface.PivotTableWidgetProps.md)

Translates a [WidgetModel](../../interface.WidgetModel.md) to the props for rendering a pivot table widget.

## Parameters

| Parameter | Type |
| :------ | :------ |
| `widgetModel` | [`WidgetModel`](../../interface.WidgetModel.md) |

## Returns

[`PivotTableWidgetProps`](../../../interfaces/interface.PivotTableWidgetProps.md)

eter | Type |
| :------ | :------ |
| `widgetModel` | [`WidgetModel`](../../interface.WidgetModel.md) |

## Returns

[`PivotTableWidgetProps`](../../../interfaces/interface.PivotTableWidgetProps.md)

## Example

```html
<csdk-pivot-table-widget
 *ngIf="pivotWidgetProps"
 [dataSet]="pivotWidgetProps.dataSet"
 [dataOptions]="pivotWidgetProps.dataOptions"
 [filters]="pivotWidgetProps.filters"
 [styleOptions]="pivotWidgetProps.styleOptions"
/>
```

```ts
import { Component } from '@angular/core';
import {
 type PivotTableWidgetProps
 WidgetService,
 widgetModelTranslator,
} from '@sisense/sdk-ui-angular';

@Component({
 selector: 'app-example',
 templateUrl: './example.component.html',
 styleUrls: ['./example.component.scss'],
})
export class ExampleComponent {
 pivotWidgetProps: PivotTableWidgetProps | null = null;

 constructor(private widgetService: WidgetService) {}

 async ngOnInit(): Promise<void> {
   const widgetModel = await widgetService.getWidgetModel({
     dashboardOid: 'your-dashboard-oid',
     widgetOid: 'your-widget-oid'
   });
   this.pivotWidgetProps = widgetModelTranslator.toPivotTableWidgetProps(widgetModel);
 }
}
```

Note: this method is not supported for chart or table widgets.
Use [toChartWidgetProps](function.toChartWidgetProps.md) instead for getting props for the [ChartWidgetComponent](../../../dashboards/class.ChartWidgetComponent.md).

rted for chart or table widgets.
Use [toChartWidgetProps](function.toChartWidgetProps.md) instead for getting props for the [ChartWidgetComponent](../../../dashboards/class.ChartWidgetComponent.md).

# Function toTableProps

> **toTableProps**(`widgetModel`): [`TableProps`](../../../interfaces/interface.TableProps.md)

Translates a [WidgetModel](../../interface.WidgetModel.md) to the props for rendering a table.

## Parameters

| Parameter | Type |
| :------ | :------ |
| `widgetModel` | [`WidgetModel`](../../interface.WidgetModel.md) |

## Returns

[`TableProps`](../../../interfaces/interface.TableProps.md)

## Parameters

| Parameter | Type |
| :------ | :------ |
| `widgetModel` | [`WidgetModel`](../../interface.WidgetModel.md) |

## Returns

[`TableProps`](../../../interfaces/interface.TableProps.md)

## Example

```html
<csdk-table
 *ngIf="tableProps"
 [dataSet]="tableProps.dataSet"
 [dataOptions]="tableProps.dataOptions"
 [filters]="tableProps.filters"
 [styleOptions]="tableProps.styleOptions"
/>
```

```ts
import { Component } from '@angular/core';
import {
 type TableProps
 WidgetService,
 widgetModelTranslator,
} from '@sisense/sdk-ui-angular';

@Component({
 selector: 'app-example',
 templateUrl: './example.component.html',
 styleUrls: ['./example.component.scss'],
})
export class ExampleComponent {
 tableProps: TableProps | null = null;

 constructor(private widgetService: WidgetService) {}

 async ngOnInit(): Promise<void> {
   const widgetModel = await widgetService.getWidgetModel({
     dashboardOid: 'your-dashboard-oid',
     widgetOid: 'your-widget-oid'
   });
   this.tableProps = widgetModelTranslator.toTableProps(widgetModel);
 }
}
```

Note: this method is not supported for chart and pivot widgets.
Use [toChartProps](function.toChartProps.md) instead for getting props for the [ChartComponent](../../../charts/class.ChartComponent.md).
Use [toPivotTableProps](function.toPivotTableProps.md) instead for getting props for the [PivotTableComponent](../../../data-grids/class.PivotTableComponent.md).

/../charts/class.ChartComponent.md).
Use [toPivotTableProps](function.toPivotTableProps.md) instead for getting props for the [PivotTableComponent](../../../data-grids/class.PivotTableComponent.md).

# Function toTextWidgetProps

> **toTextWidgetProps**(`widgetModel`): [`TextWidgetProps`](../../../interfaces/interface.TextWidgetProps.md)

Translates a [WidgetModel](../../interface.WidgetModel.md) to the props for rendering a text widget.

## Parameters

| Parameter | Type |
| :------ | :------ |
| `widgetModel` | [`WidgetModel`](../../interface.WidgetModel.md) |

## Returns

[`TextWidgetProps`](../../../interfaces/interface.TextWidgetProps.md)

## Example

```ts
const widgetModel = await widgetService.getWidgetModel({
 dashboardOid: 'your-dashboard-oid',
 widgetOid: 'your-widget-oid'
});
const textWidgetProps = widgetModelTranslator.toTextWidgetProps(widgetModel);
```

Note: this method is not supported for chart or pivot widgets.
Use [toChartWidgetProps](function.toChartWidgetProps.md) instead for getting props for the [ChartWidgetComponent](../../../dashboards/class.ChartWidgetComponent.md).
Use [toPivotTableWidgetProps](function.toPivotTableWidgetProps.md) instead for getting props for the pivot table widget.

# Function toWidgetProps

> **toWidgetProps**(`widgetModel`): [`WidgetProps`](../../../type-aliases/type-alias.WidgetProps.md)

Translates [WidgetModel](../../interface.WidgetModel.md) to [WidgetProps](../../../type-aliases/type-alias.WidgetProps.md).

Model`): [`WidgetProps`](../../../type-aliases/type-alias.WidgetProps.md)

Translates [WidgetModel](../../interface.WidgetModel.md) to [WidgetProps](../../../type-aliases/type-alias.WidgetProps.md).

## Parameters

| Parameter | Type |
| :------ | :------ |
| `widgetModel` | [`WidgetModel`](../../interface.WidgetModel.md) |

## Returns

[`WidgetProps`](../../../type-aliases/type-alias.WidgetProps.md)

rameters

| Parameter | Type |
| :------ | :------ |
| `widgetModel` | [`WidgetModel`](../../interface.WidgetModel.md) |

## Returns

[`WidgetProps`](../../../type-aliases/type-alias.WidgetProps.md)

## Example

```html
<csdk-widget
  *ngIf="widgetProps"
  [id]="widgetProps.id"
  [widgetType]="widgetProps.widgetType"
  [chartType]="widgetProps.chartType"
  [dataSource]="widgetProps.dataSource"
  [dataOptions]="widgetProps.dataOptions"
  [filters]="widgetProps.filters"
  [highlights]="widgetProps.highlights"
  [styleOptions]="widgetProps.styleOptions"
  [title]="widgetProps.title"
  [description]="widgetProps.description"
/>
```

```ts
import { Component } from '@angular/core';
import {
  type WidgetProps,
  WidgetService,
  widgetModelTranslator,
} from '@sisense/sdk-ui-angular';

@Component({
  selector: 'app-example',
  templateUrl: './example.component.html',
  styleUrls: ['./example.component.scss'],
})
export class ExampleComponent {
  widgetProps: WidgetProps | null = null;

  constructor(private widgetService: WidgetService) {}

  async ngOnInit(): Promise<void> {
    const widgetModel = await widgetService.getWidgetModel({
      dashboardOid: 'your-dashboard-oid',
      widgetOid: 'your-widget-oid'
    });
    this.widgetProps = widgetModelTranslator.toWidgetProps(widgetModel);
  }
}
```

# Interface DashboardModel <Badge type="fusionEmbed" text="Fusion Embed" />

Model of Sisense Fusion dashboard defined in the abstractions of Compose SDK.

## Properties

ops(widgetModel);
  }
}
```

# Interface DashboardModel <Badge type="fusionEmbed" text="Fusion Embed" />

Model of Sisense Fusion dashboard defined in the abstractions of Compose SDK.

## Properties

### dataSource

> **dataSource**: [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md)

Dashboard data source details.

***

### oid

> **oid**: `string`

Unique identifier of the dashboard.

***

### title

> **title**: `string`

Dashboard title.

***

### widgets

> **widgets**: [`WidgetModel`](interface.WidgetModel.md)[]

Dashboard widget models.

# Interface WidgetModel <Badge type="fusionEmbed" text="Fusion Embed" />

Model of Sisense widget defined in the abstractions of Compose SDK.

## Properties

### chartType

> **chartType**?: [`ChartType`](../type-aliases/type-alias.ChartType.md)

Widget chart type.

***

### customOptions

> **customOptions**?: `Record`\< `string`, `any` \>

Custom widget options. Only present for custom widgets.

Contains widget-specific configuration that doesn't fit into standard style or data options.

***

### customWidgetType

> **customWidgetType**: `string`

Custom widget type. Only present for custom widgets.

If this is a custom widget, this is typically the name/ID of the custom widget.

***

### dataOptions

> **dataOptions**: [`WidgetDataOptions`](../type-aliases/type-alias.WidgetDataOptions.md)

Widget data options.

***

idget, this is typically the name/ID of the custom widget.

***

### dataOptions

> **dataOptions**: [`WidgetDataOptions`](../type-aliases/type-alias.WidgetDataOptions.md)

Widget data options.

***

### dataSource

> **dataSource**: [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md)

Full name of the widget data source.

***

### description

> **description**: `string`

Widget description.

***

### drilldownOptions

> **drilldownOptions**: [`DrilldownOptions`](../type-aliases/type-alias.DrilldownOptions.md) \| [`PivotTableDrilldownOptions`](../type-aliases/type-alias.PivotTableDrilldownOptions.md)

Widget drilldown options.

***

### filters

> **filters**: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Widget filters.

***

### highlights

> **highlights**: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Widget highlights.

***

### oid

> **`readonly`** **oid**: `string`

Unique identifier of the widget.

***

### styleOptions

> **styleOptions**: [`WidgetStyleOptions`](../type-aliases/type-alias.WidgetStyleOptions.md)

Widget style options.

***

### title

> **title**: `string`

Widget title.

***

### widgetType

> **widgetType**: [`WidgetType`](../type-aliases/type-alias.WidgetType.md)

Widget type.


## Filter Tiles

style options.

***

### title

> **title**: `string`

Widget title.

***

### widgetType

> **widgetType**: [`WidgetType`](../type-aliases/type-alias.WidgetType.md)

Widget type.


## Filter Tiles

# Filter Tiles

Angular filter tile components

- [CriteriaFilterTileComponent](class.CriteriaFilterTileComponent.md)
- [DateRangeFilterTileComponent](class.DateRangeFilterTileComponent.md)
- [FiltersPanelComponent](class.FiltersPanelComponent.md)
- [FilterTileComponent](class.FilterTileComponent.md) - Facade component rendering a filter tile based on filter type
- [MemberFilterTileComponent](class.MemberFilterTileComponent.md)
- [RelativeDateFilterTileComponent](class.RelativeDateFilterTileComponent.md)

# Class CriteriaFilterTileComponent

Criteria Filter Tile Component

rTileComponent](class.MemberFilterTileComponent.md)
- [RelativeDateFilterTileComponent](class.RelativeDateFilterTileComponent.md)

# Class CriteriaFilterTileComponent

Criteria Filter Tile Component

## Example

```html
    <csdk-criteria-filter-tile
      [title]="criteriaFilterTileProps.title"
      [filter]="criteriaFilterTileProps.filter"
      (filterChange)="criteriaFilterTileProps.setFilter($event)"
    />
```
```ts
import { Component } from '@angular/core';
import { Filter, filterFactory } from '@sisense/sdk-data';
import * as DM from '../../assets/sample-healthcare-model';

@Component({
  selector: 'app-filters',
  templateUrl: './filters.component.html',
  styleUrls: ['./filters.component.scss'],
})
export class FiltersComponent {
  DM = DM;
  title: 'Room Number',
  filter: filterFactory.lessThan(DM.Rooms.Room_number, 200) ,
  setFilter({ filter }: { filter: Filter | null }) {
    console.log(filter);
    if (filter) {
      this.filter = filter ;
    }
  },
}
```
<img src="../../../img/angular-criteria-filter-tile-example.png" width="225px" />

## Implements

- `AfterViewInit`
- `OnChanges`
- `OnDestroy`

## Constructors

is.filter = filter ;
    }
  },
}
```
<img src="../../../img/angular-criteria-filter-tile-example.png" width="225px" />

## Implements

- `AfterViewInit`
- `OnChanges`
- `OnDestroy`

## Constructors

### constructor

> **new CriteriaFilterTileComponent**(`sisenseContextService`, `themeService`): [`CriteriaFilterTileComponent`](class.CriteriaFilterTileComponent.md)

Constructor for the `CriteriaFilterTileComponent`.

#### Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `sisenseContextService` | [`SisenseContextService`](../contexts/class.SisenseContextService.md) | Sisense context service |
| `themeService` | [`ThemeService`](../contexts/class.ThemeService.md) | Theme service |

#### Returns

[`CriteriaFilterTileComponent`](class.CriteriaFilterTileComponent.md)

## Properties

### Constructor

#### sisenseContextService

> **sisenseContextService**: [`SisenseContextService`](../contexts/class.SisenseContextService.md)

Sisense context service

***

#### themeService

> **themeService**: [`ThemeService`](../contexts/class.ThemeService.md)

Theme service

eContextService`](../contexts/class.SisenseContextService.md)

Sisense context service

***

#### themeService

> **themeService**: [`ThemeService`](../contexts/class.ThemeService.md)

Theme service

### Other

#### arrangement

> **arrangement**: [`FilterVariant`](../type-aliases/type-alias.FilterVariant.md) \| `undefined`

Arrangement of the filter inputs. Use vertical for standard filter tiles and horizontal for toolbars

***

#### filter

> **filter**: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)

Text or numeric filter object to initialize filter type and default values

***

#### filterChange

> **filterChange**: `EventEmitter`\< `ArgumentsAsObject`\< (`filter`) => `void`, [`"filter"`] \> \>

Callback returning updated filter object

***

#### measures

> **measures**: [`Measure`](../../sdk-data/interfaces/interface.Measure.md)[] \| `undefined`

List of available measures to rank by. Required only for ranking filters.

***

#### title

> **title**: `string`

Title for the filter tile, which is rendered into the header

# Class DateRangeFilterTileComponent

Date Range Filter Tile Component

nly for ranking filters.

***

#### title

> **title**: `string`

Title for the filter tile, which is rendered into the header

# Class DateRangeFilterTileComponent

Date Range Filter Tile Component

## Example

```html
<csdk-date-range-filter-tile
      [title]="dateRangeFilterTileProps.title"
      [attribute]="dateRangeFilterTileProps.attribute"
      [filter]="dateRangeFilterTileProps.filter"
      (filterChange)="dateRangeFilterTileProps.setFilter($event)"
    />
```
```ts
import { Component } from '@angular/core';
import { Filter, filterFactory } from '@sisense/sdk-data';
import * as DM from '../../assets/sample-healthcare-model';

@Component({
  selector: 'app-filters',
  templateUrl: './filters.component.html',
  styleUrls: ['./filters.component.scss'],
})
export class FiltersComponent {
  DM = DM;

  dateRangeFilterTileProps = {
    title: 'Range Filter',
    attribute: DM.ER.Date.Years,
    filter: filterFactory.dateRange(DM.ER.Date.Years),
    setFilter({ filter }: { filter: Filter | null }) {
      console.log(filter);
      if (filter) {
        this.filter = filter;
      }
    },
  };
}
```
<img src="../../../img/angular-date-range-filter-tile-example.png" width="450px" />

## Implements

- `AfterViewInit`
- `OnChanges`
- `OnDestroy`

## Constructors

= filter;
      }
    },
  };
}
```
<img src="../../../img/angular-date-range-filter-tile-example.png" width="450px" />

## Implements

- `AfterViewInit`
- `OnChanges`
- `OnDestroy`

## Constructors

### constructor

> **new DateRangeFilterTileComponent**(`sisenseContextService`, `themeService`): [`DateRangeFilterTileComponent`](class.DateRangeFilterTileComponent.md)

Constructor for the `DateRangeFilterTileComponent`.

#### Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `sisenseContextService` | [`SisenseContextService`](../contexts/class.SisenseContextService.md) | Sisense context service |
| `themeService` | [`ThemeService`](../contexts/class.ThemeService.md) | Theme service |

#### Returns

[`DateRangeFilterTileComponent`](class.DateRangeFilterTileComponent.md)

## Properties

### Constructor

#### sisenseContextService

> **sisenseContextService**: [`SisenseContextService`](../contexts/class.SisenseContextService.md)

Sisense context service

***

#### themeService

> **themeService**: [`ThemeService`](../contexts/class.ThemeService.md)

Theme service

eContextService`](../contexts/class.SisenseContextService.md)

Sisense context service

***

#### themeService

> **themeService**: [`ThemeService`](../contexts/class.ThemeService.md)

Theme service

### Other

#### attribute

> **attribute**: [`LevelAttribute`](../../sdk-data/interfaces/interface.LevelAttribute.md)

Date level attribute the filter is based on

***

#### dataSource

> **dataSource**: [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md) \| `undefined`

Data source the query is run against - e.g. `Sample ECommerce`

If not specified, the query will use the `defaultDataSource` specified in the parent Sisense Context.

***

#### earliestDate

> **earliestDate**: `string` \| `undefined`

Earliest allowed date for selection.

If not specified, the earliest date of the target date-level attribute will be used.

***

#### filter

> **filter**: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)

Date range filter.

***

#### filterChange

> **filterChange**: `EventEmitter`\< `ArgumentsAsObject`\< (`filter`) => `void`, [`"filter"`] \> \>

Callback function that is called when the date range filter object should be updated.

***

#### lastDate

> **lastDate**: `string` \| `undefined`

Latest allowed date for selection.

If not specified, the latest date of the target date-level attribute will be used.

***

#### title

> **title**: `string`

Filter tile title

ing` \| `undefined`

Latest allowed date for selection.

If not specified, the latest date of the target date-level attribute will be used.

***

#### title

> **title**: `string`

Filter tile title

# Class FilterTileComponent

UI component that renders a filter tile based on filter type

## Example

Here’s how to render a filter model as a filter tile.

```html
<!--Component HTML template in example.component.html-->
<csdk-filter-tile
 [filter]="filterTileProps.filter"
 (filterChange)="filterTileProps.filterChange($event)"
/>
```

```ts
// Component behavior in example.component.ts
import { Component } from '@angular/core';
import { type FilterTileProps } from '@sisense/sdk-ui-angular';
import { filterFactory } from '@sisense/sdk-data';
import * as DM from '../../assets/sample-healthcare-model';

@Component({
 selector: 'example',
 templateUrl: './example.component.html',
 styleUrls: ['./example.component.scss'],
})
export class ExampleComponent {
 filterTileProps: FilterTileProps = {
   filter: filterFactory.members(DM.ER.Date.Years, ['2013-01-01T00:00:00']),
   filterChange({ filter }) {
     if (filter) {
       this.filter = filter;
     }
   },
 };
}
```
<img src="../../../img/angular-member-filter-tile-example.png" width="225px" />

## Implements

- `AfterViewInit`
- `OnChanges`
- `OnDestroy`

## Constructors

filter = filter;
     }
   },
 };
}
```
<img src="../../../img/angular-member-filter-tile-example.png" width="225px" />

## Implements

- `AfterViewInit`
- `OnChanges`
- `OnDestroy`

## Constructors

### constructor

> **new FilterTileComponent**(`sisenseContextService`, `themeService`): [`FilterTileComponent`](class.FilterTileComponent.md)

Constructor for the `FilterTileComponent`.

#### Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `sisenseContextService` | [`SisenseContextService`](../contexts/class.SisenseContextService.md) | Sisense context service |
| `themeService` | [`ThemeService`](../contexts/class.ThemeService.md) | Theme service |

#### Returns

[`FilterTileComponent`](class.FilterTileComponent.md)

## Properties

### Constructor

#### sisenseContextService

> **sisenseContextService**: [`SisenseContextService`](../contexts/class.SisenseContextService.md)

Sisense context service

***

#### themeService

> **themeService**: [`ThemeService`](../contexts/class.ThemeService.md)

Theme service

eContextService`](../contexts/class.SisenseContextService.md)

Sisense context service

***

#### themeService

> **themeService**: [`ThemeService`](../contexts/class.ThemeService.md)

Theme service

### Other

#### defaultDataSource

> **defaultDataSource**: [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md) \| `undefined`

Default data source used for filter tiles

***

#### filter

> **filter**: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)

Filter to display

***

#### filterChange

> **filterChange**: `EventEmitter`\< [`FilterChangeEvent`](../type-aliases/type-alias.FilterChangeEvent.md) \>

Filter change event handler.

***

#### filterDelete

> **filterDelete**: `EventEmitter`\< `void` \>

Filter delete event handler.

***

#### filterEdit

> **filterEdit**: `EventEmitter`\< [`FilterEditEvent`](../type-aliases/type-alias.FilterEditEvent.md) \>

Filter edit event handler.

# Class FiltersPanelComponent

Filters panel component that renders a list of filter tiles

itter`\< [`FilterEditEvent`](../type-aliases/type-alias.FilterEditEvent.md) \>

Filter edit event handler.

# Class FiltersPanelComponent

Filters panel component that renders a list of filter tiles

## Example

Here's how to render a filters panel with a set of filters.

```html
<!--Component HTML template in example.component.html-->
<csdk-filters-panel
 [filters]="filtersPanelProps.filters"
 [defaultDataSource]="filtersPanelProps.defaultDataSource"
 (filtersChange)="filtersPanelProps.filtersChange($event)"
/>
```

```ts
// Component behavior in example.component.ts
import { Component } from '@angular/core';
import { type FiltersPanelProps } from '@sisense/sdk-ui-angular';
import { filterFactory } from '@sisense/sdk-data';
import * as DM from '../../assets/sample-healthcare-model';

@Component({
 selector: 'example',
 templateUrl: './example.component.html',
 styleUrls: ['./example.component.scss'],
})
export class ExampleComponent {
 filtersPanelProps: FiltersPanelProps = {
   filters: [
     filterFactory.members(DM.ER.Date.Years, ['2013-01-01T00:00:00']),
     filterFactory.members(DM.ER.Departments.Department, ['Cardiology']),
   ],
   defaultDataSource: DM.DataSource,
   filtersChange({ filters }) {
     this.filtersPanelProps.filters = filters;
   },
 };
}
```

## Implements

- `AfterViewInit`
- `OnChanges`
- `OnDestroy`

## Constructors

taSource: DM.DataSource,
   filtersChange({ filters }) {
     this.filtersPanelProps.filters = filters;
   },
 };
}
```

## Implements

- `AfterViewInit`
- `OnChanges`
- `OnDestroy`

## Constructors

### constructor

> **new FiltersPanelComponent**(`sisenseContextService`, `themeService`): [`FiltersPanelComponent`](class.FiltersPanelComponent.md)

Constructor for the `FiltersPanelComponent`.

#### Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `sisenseContextService` | [`SisenseContextService`](../contexts/class.SisenseContextService.md) | Sisense context service |
| `themeService` | [`ThemeService`](../contexts/class.ThemeService.md) | Theme service |

#### Returns

[`FiltersPanelComponent`](class.FiltersPanelComponent.md)

## Properties

### Constructor

#### sisenseContextService

> **sisenseContextService**: [`SisenseContextService`](../contexts/class.SisenseContextService.md)

Sisense context service

***

#### themeService

> **themeService**: [`ThemeService`](../contexts/class.ThemeService.md)

Theme service

eContextService`](../contexts/class.SisenseContextService.md)

Sisense context service

***

#### themeService

> **themeService**: [`ThemeService`](../contexts/class.ThemeService.md)

Theme service

### Other

#### config

> **config**: [`FiltersPanelConfig`](../interfaces/interface.FiltersPanelConfig.md) \| `undefined`

The configuration for the filters panel

***

#### defaultDataSource

> **defaultDataSource**: [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md) \| `undefined`

Default data source used for filter tiles

***

#### filters

> **filters**: [`FilterRelations`](../../sdk-data/interfaces/interface.FilterRelations.md) \| [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Array of filters to display

***

#### filtersChange

> **filtersChange**: `EventEmitter`\< [`FiltersPanelChangeEvent`](../type-aliases/type-alias.FiltersPanelChangeEvent.md) \>

Callback to handle changes in filters

# Class MemberFilterTileComponent

Member Filter Tile Component

itter`\< [`FiltersPanelChangeEvent`](../type-aliases/type-alias.FiltersPanelChangeEvent.md) \>

Callback to handle changes in filters

# Class MemberFilterTileComponent

Member Filter Tile Component

## Example

```html
    <csdk-member-filter-tile
      title="Years Filter"
      [attribute]="DM.ER.Date.Years"
      [filter]="memberFilterTileProps.yearFilter"
      (filterChange)="memberFilterTileProps.setYearFilter($event)"
    />
```
```ts
import { Component } from '@angular/core';
import { Filter, filterFactory } from '@sisense/sdk-data';
import * as DM from '../../assets/sample-healthcare-model';

@Component({
  selector: 'app-filters',
  templateUrl: './filters.component.html',
  styleUrls: ['./filters.component.scss'],
})
export class FiltersComponent {
  DM = DM;
  memberFilterTileProps = {
    yearFilter: filterFactory.members(DM.ER.Date.Years, ['2013-01-01T00:00:00']),
    setYearFilter({ filter }: { filter: Filter | null }) {
      if (filter) {
        this.yearFilter = filter;
      }
    },
  };
}
```
<img src="../../../img/angular-member-filter-tile-example.png" width="225px" />

## Implements

- `AfterViewInit`
- `OnChanges`
- `OnDestroy`

## Constructors

ter = filter;
      }
    },
  };
}
```
<img src="../../../img/angular-member-filter-tile-example.png" width="225px" />

## Implements

- `AfterViewInit`
- `OnChanges`
- `OnDestroy`

## Constructors

### constructor

> **new MemberFilterTileComponent**(`sisenseContextService`, `themeService`): [`MemberFilterTileComponent`](class.MemberFilterTileComponent.md)

Constructor for the `MemberFilterTileComponent`.

#### Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `sisenseContextService` | [`SisenseContextService`](../contexts/class.SisenseContextService.md) | Sisense context service |
| `themeService` | [`ThemeService`](../contexts/class.ThemeService.md) | Theme service |

#### Returns

[`MemberFilterTileComponent`](class.MemberFilterTileComponent.md)

## Properties

### Constructor

#### sisenseContextService

> **sisenseContextService**: [`SisenseContextService`](../contexts/class.SisenseContextService.md)

Sisense context service

***

#### themeService

> **themeService**: [`ThemeService`](../contexts/class.ThemeService.md)

Theme service

eContextService`](../contexts/class.SisenseContextService.md)

Sisense context service

***

#### themeService

> **themeService**: [`ThemeService`](../contexts/class.ThemeService.md)

Theme service

### Other

#### attribute

> **attribute**: [`Attribute`](../../sdk-data/interfaces/interface.Attribute.md)

Attribute to filter on. A query will run to fetch all this attribute's members

***

#### dataSource

> **dataSource**: [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md) \| `undefined`

Data source the query is run against - e.g. `Sample ECommerce`

If not specified, the query will use the `defaultDataSource` specified in the parent Sisense Context.

***

#### filter

> **filter**: [`Filter`](../../sdk-data/interfaces/interface.Filter.md) \| `null`

Source filter object. Caller is responsible for keeping track of filter state

***

#### filterChange

> **filterChange**: `EventEmitter`\< `ArgumentsAsObject`\< (`filter`) => `void`, [`"filter"`] \> \>

Callback indicating when the source members filter should be updated

***

#### title

> **title**: `string`

Title for the filter tile, which is rendered into the header

# Class RelativeDateFilterTileComponent

Relative Date Filter Tile Component

should be updated

***

#### title

> **title**: `string`

Title for the filter tile, which is rendered into the header

# Class RelativeDateFilterTileComponent

Relative Date Filter Tile Component

## Example

```html
<csdk-relative-date-filter-tile
      [title]="relativeDateFilterTileProps.title"
      [arrangement]="relativeDateFilterTileProps.arrangement"
      [filter]="relativeDateFilterTileProps.filter"
      (filterChange)="relativeDateFilterTileProps.setFilter($event)"
    />
```
```ts
import { Component } from '@angular/core';
import { Filter, filterFactory } from '@sisense/sdk-data';
import * as DM from '../../assets/sample-healthcare-model';

@Component({
  selector: 'app-filters',
  templateUrl: './filters.component.html',
  styleUrls: ['./filters.component.scss'],
})
export class FiltersComponent {
  DM = DM;

  relativeDateFilterTileProps = {
    title: 'Relative Date Filter',
    arrangement: 'vertical',
    filter: filterFactory.dateRelativeTo(DM.ER.Date.Days, 0, 150),
    setFilter({ filter }: { filter: Filter | null }) {
      console.log(filter);
      if (filter) {
        this.filter = filter;
      }
    },
  };
}
```
<img src="../../../img/angular-relative-date-filter-tile-example.png" width="225px" />

## Implements

- `AfterViewInit`
- `OnChanges`
- `OnDestroy`

## Constructors

ilter;
      }
    },
  };
}
```
<img src="../../../img/angular-relative-date-filter-tile-example.png" width="225px" />

## Implements

- `AfterViewInit`
- `OnChanges`
- `OnDestroy`

## Constructors

### constructor

> **new RelativeDateFilterTileComponent**(`sisenseContextService`, `themeService`): [`RelativeDateFilterTileComponent`](class.RelativeDateFilterTileComponent.md)

Constructor for the `RelativeDateFilterTileComponent`.

#### Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `sisenseContextService` | [`SisenseContextService`](../contexts/class.SisenseContextService.md) | Sisense context service |
| `themeService` | [`ThemeService`](../contexts/class.ThemeService.md) | Theme service |

#### Returns

[`RelativeDateFilterTileComponent`](class.RelativeDateFilterTileComponent.md)

## Properties

### Constructor

#### sisenseContextService

> **sisenseContextService**: [`SisenseContextService`](../contexts/class.SisenseContextService.md)

Sisense context service

***

#### themeService

> **themeService**: [`ThemeService`](../contexts/class.ThemeService.md)

Theme service

eContextService`](../contexts/class.SisenseContextService.md)

Sisense context service

***

#### themeService

> **themeService**: [`ThemeService`](../contexts/class.ThemeService.md)

Theme service

### Other

#### arrangement

> **arrangement**: [`FilterVariant`](../type-aliases/type-alias.FilterVariant.md) \| `undefined`

Arrangement of the filter inputs. Use vertical for standard filter tiles and horizontal for toolbars

***

#### filter

> **filter**: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)

Relative date filter.

***

#### filterChange

> **filterChange**: `EventEmitter`\< `ArgumentsAsObject`\< (`filter`) => `void`, [`"filter"`] \> \>

Callback function that is called when the relative date filter object should be updated.

***

#### limit

> **limit**: \{
  `maxDate`: `string`;
  `minDate`: `string`;
 } \| `undefined`

Limit of the date range that can be selected.

***

#### title

> **title**: `string`

Filter tile title


## Drilldown

# Drilldown

Angular components for creating drilldown experiences

- [ContextMenuComponent](class.ContextMenuComponent.md)
- [DrilldownBreadcrumbsComponent](class.DrilldownBreadcrumbsComponent.md)
- [DrilldownWidgetComponent](class.DrilldownWidgetComponent.md)

# Class ContextMenuComponent

Context Menu Component

## Implements

- `AfterViewInit`
- `OnChanges`
- `OnDestroy`

## Constructors

)
- [DrilldownWidgetComponent](class.DrilldownWidgetComponent.md)

# Class ContextMenuComponent

Context Menu Component

## Implements

- `AfterViewInit`
- `OnChanges`
- `OnDestroy`

## Constructors

### constructor

> **new ContextMenuComponent**(`sisenseContextService`, `themeService`): [`ContextMenuComponent`](class.ContextMenuComponent.md)

Constructor for the `ContextMenuComponent`.

#### Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `sisenseContextService` | [`SisenseContextService`](../contexts/class.SisenseContextService.md) | Sisense context service |
| `themeService` | [`ThemeService`](../contexts/class.ThemeService.md) | Theme service |

#### Returns

[`ContextMenuComponent`](class.ContextMenuComponent.md)

## Properties

### Constructor

#### sisenseContextService

> **sisenseContextService**: [`SisenseContextService`](../contexts/class.SisenseContextService.md)

Sisense context service

***

#### themeService

> **themeService**: [`ThemeService`](../contexts/class.ThemeService.md)

Theme service

eContextService`](../contexts/class.SisenseContextService.md)

Sisense context service

***

#### themeService

> **themeService**: [`ThemeService`](../contexts/class.ThemeService.md)

Theme service

### Other

#### contextMenuClose

> **contextMenuClose**: `EventEmitter`\< `ArgumentsAsObject`\< () => `void`, [] \> \>

Callback function that is evaluated when the context menu is closed

***

#### itemSections

> **itemSections**: [`MenuItemSection`](../type-aliases/type-alias.MenuItemSection.md)[] \| `undefined`

Menu item sections

***

#### position

> **position**: [`MenuPosition`](../type-aliases/type-alias.MenuPosition.md) \| `null` \| `undefined`

Context menu position

# Class DrilldownBreadcrumbsComponent

Drilldown Breadcrumbs Component

## Implements

- `AfterViewInit`
- `OnChanges`
- `OnDestroy`

## Constructors

### constructor

> **new DrilldownBreadcrumbsComponent**(`sisenseContextService`, `themeService`): [`DrilldownBreadcrumbsComponent`](class.DrilldownBreadcrumbsComponent.md)

Constructor for the `DrilldownBreadcrumbsComponent`.

#### Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `sisenseContextService` | [`SisenseContextService`](../contexts/class.SisenseContextService.md) | Sisense context service |
| `themeService` | [`ThemeService`](../contexts/class.ThemeService.md) | Theme service |

#### Returns

[`DrilldownBreadcrumbsComponent`](class.DrilldownBreadcrumbsComponent.md)

## Properties

ice |
| `themeService` | [`ThemeService`](../contexts/class.ThemeService.md) | Theme service |

#### Returns

[`DrilldownBreadcrumbsComponent`](class.DrilldownBreadcrumbsComponent.md)

## Properties

### Widget

#### currentDimension

> **currentDimension**: [`Attribute`](../../sdk-data/interfaces/interface.Attribute.md)

Currently selected drilldown dimension

***

#### drilldownSelectionsClear

> **drilldownSelectionsClear**: `EventEmitter`\< `ArgumentsAsObject`\< () => `void`, [] \> \>

Callback function that is evaluated when the close (X) button is clicked

***

#### drilldownSelectionsSlice

> **drilldownSelectionsSlice**: `EventEmitter`\< `number` \>

Callback function that is evaluated when a breadcrumb is clicked

***

#### filtersDisplayValues

> **filtersDisplayValues**: `string`[][]

List of drilldown filters formatted to be displayed as breadcrumbs

### Constructor

#### sisenseContextService

> **sisenseContextService**: [`SisenseContextService`](../contexts/class.SisenseContextService.md)

Sisense context service

***

#### themeService

> **themeService**: [`ThemeService`](../contexts/class.ThemeService.md)

Theme service

eContextService`](../contexts/class.SisenseContextService.md)

Sisense context service

***

#### themeService

> **themeService**: [`ThemeService`](../contexts/class.ThemeService.md)

Theme service

# Class DrilldownWidgetComponent

An Angular component designed to add drilldown functionality to any type of chart.

It acts as a wrapper around a given chart component, enhancing it with drilldown capabilities

The widget offers several features including:
- A context menu for initiating drilldown actions (can be provided as a custom component)
- Breadcrumbs that not only allow for drilldown selection slicing but also
provide an option to clear the selection (can be provided as a custom component)
- Filters specifically created for drilldown operation
- An option to navigate to the next drilldown dimension

When an `initialDimension` is specified, the `drilldownDimension` will automatically inherit its value,
even before any points on the chart are selected.
This allows for complete control over the chart's dimensions to be handed over to the DrilldownWidget

mension` will automatically inherit its value,
even before any points on the chart are selected.
This allows for complete control over the chart's dimensions to be handed over to the DrilldownWidget

## Example

An example of using the `csdk-drilldown-widget` component to plot a `csdk-column-chart`
over the Sample Healthcare data source hosted in a Sisense instance:
```ts
// Component behavior in .component.ts
chart = {
  dataOptions: {
    category: [DM.Divisions.Divison_name],
    value: [measureFactory.sum(DM.Admissions.Cost_of_admission)],
    breakBy: [],
  },
  dataPointContextMenu: ({ point, nativeEvent }: { point: any; nativeEvent: MouseEvent }) => {
    this.drilldownResult?.onDataPointsSelected?.([point], nativeEvent);
    this.drilldownResult?.onContextMenu({
      left: nativeEvent.clientX,
      top: nativeEvent.clientY,
    });
  }
}

drilldownResult?: CustomDrilldownResult;

drilldown = {
  drilldownPaths: [DM.Patients.Gender, DM.Admissions.Surgical_Procedure],
  initialDimension: DM.Divisions.Divison_name,
  drilldownChange: (drilldownResult: CustomDrilldownResult) => {
    this.drilldownResult = drilldownResult;
    this.chart.dataOptions = {
      ...this.chart.dataOptions,
      category: [drilldownResult.drilldownDimension]
    }
  }
};
```
```html
<!--Component HTML template in .component.html-->
<csdk-drilldown-widget
  [drilldownPaths]="drilldown.drilldownPaths"
  [initialDimension]="drilldown.initialDimension"
  (drilldownResultChange)="drilldown.drilldownChange($event)"
>
  <csdk-column-chart
    [dataSet]="DM.DataSource"
    [dataOptions]="chart.dataOptions"
    [filters]="drilldownResult?.drilldownFilters || []"
    (dataPointContextMenu)="chart.dataPointContextMenu($event)"
  />
</csdk-drilldown-widget>
```
<img src="../../../img/angular-drilldown-widget-example.png" width="800px" />

rilldownFilters || []"
    (dataPointContextMenu)="chart.dataPointContextMenu($event)"
  />
</csdk-drilldown-widget>
```
<img src="../../../img/angular-drilldown-widget-example.png" width="800px" />

## Implements

- `AfterViewInit`
- `OnChanges`
- `OnDestroy`

## Constructors

### constructor

> **new DrilldownWidgetComponent**(`sisenseContextService`, `themeService`): [`DrilldownWidgetComponent`](class.DrilldownWidgetComponent.md)

Constructor for the `DrilldownWidgetComponent`.

#### Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `sisenseContextService` | [`SisenseContextService`](../contexts/class.SisenseContextService.md) | Sisense context service |
| `themeService` | [`ThemeService`](../contexts/class.ThemeService.md) | Theme service |

#### Returns

[`DrilldownWidgetComponent`](class.DrilldownWidgetComponent.md)

## Properties

ntext service |
| `themeService` | [`ThemeService`](../contexts/class.ThemeService.md) | Theme service |

#### Returns

[`DrilldownWidgetComponent`](class.DrilldownWidgetComponent.md)

## Properties

### Widget

#### config

> **config**?: `Omit`\< [`DrilldownWidgetConfig`](../../sdk-ui/type-aliases/type-alias.DrilldownWidgetConfig.md) \| `undefined`, "breadcrumbsComponent \| contextMenuComponent" \> & \{
  `breadcrumbsComponent`: (`drilldownBreadcrumbsProps`) => `HTMLDivElement`;
  `contextMenuComponent`: (`contextMenuProps`) => `HTMLDivElement`;
 }

An object that allows users to pass advanced configuration options as a prop for the `DrilldownWidget` component

> ##### `config.breadcrumbsComponent`
>
> **breadcrumbsComponent**?: (`drilldownBreadcrumbsProps`) => `HTMLDivElement`
>
> ###### Parameters
>
>
> | Parameter | Type |
> | :------ | :------ |
> | `drilldownBreadcrumbsProps` | [`DrilldownBreadcrumbsProps`](../../sdk-ui/interfaces/interface.DrilldownBreadcrumbsProps.md) |
>
>
> ###### Returns
>
> `HTMLDivElement`
>
>
>
> ##### `config.contextMenuComponent`
>
> **contextMenuComponent**?: (`contextMenuProps`) => `HTMLDivElement`
>
> ###### Parameters
>
>
> | Parameter | Type |
> | :------ | :------ |
> | `contextMenuProps` | [`ContextMenuProps`](../../sdk-ui/interfaces/interface.ContextMenuProps.md) |
>
>
> ###### Returns
>
> `HTMLDivElement`
>
>
>
>

***

#### drilldownPaths

> **drilldownPaths**: ([`Attribute`](../../sdk-data/interfaces/interface.Attribute.md) \| [`Hierarchy`](../interfaces/interface.Hierarchy.md))[] \| `undefined`

Dimensions and hierarchies available for drilldown on.

***

#### initialDimension

> **initialDimension**: [`Attribute`](../../sdk-data/interfaces/interface.Attribute.md)

Initial dimension to apply first set of filters to

s available for drilldown on.

***

#### initialDimension

> **initialDimension**: [`Attribute`](../../sdk-data/interfaces/interface.Attribute.md)

Initial dimension to apply first set of filters to

### Callbacks

#### drilldownResultChange

> **drilldownResultChange**: `EventEmitter`\< [`CustomDrilldownResult`](../type-aliases/type-alias.CustomDrilldownResult.md) \>

Drilldown result change handler callback

### Constructor

#### sisenseContextService

> **sisenseContextService**: [`SisenseContextService`](../contexts/class.SisenseContextService.md)

Sisense context service

***

#### themeService

> **themeService**: [`ThemeService`](../contexts/class.ThemeService.md)

Theme service


## Queries

# Queries

Angular query service

- [QueryService](class.QueryService.md)

# Class QueryService

Service for executing data queries.

## Constructors

### constructor

> **new QueryService**(`sisenseContextService`): [`QueryService`](class.QueryService.md)

#### Parameters

| Parameter | Type |
| :------ | :------ |
| `sisenseContextService` | [`SisenseContextService`](../contexts/class.SisenseContextService.md) |

#### Returns

[`QueryService`](class.QueryService.md)

## Methods

| Type |
| :------ | :------ |
| `sisenseContextService` | [`SisenseContextService`](../contexts/class.SisenseContextService.md) |

#### Returns

[`QueryService`](class.QueryService.md)

## Methods

### executeCsvQuery

> **executeCsvQuery**(`params`): `Promise`\< \{
  `data`: `Blob` \| `string`;
 } \>

Executes a CSV data query.
Similar to [QueryService.executeQuery](class.QueryService.md#executequery), but returns the data in CSV format as text or as a stream.

#### Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `params` | [`ExecuteCsvQueryParams`](../interfaces/interface.ExecuteCsvQueryParams.md) | CSV query parameters |

#### Returns

`Promise`\< \{
  `data`: `Blob` \| `string`;
 } \>

CSV query result

***

arams` | [`ExecuteCsvQueryParams`](../interfaces/interface.ExecuteCsvQueryParams.md) | CSV query parameters |

#### Returns

`Promise`\< \{
  `data`: `Blob` \| `string`;
 } \>

CSV query result

***

### executeCustomWidgetQuery

> **executeCustomWidgetQuery**(`params`): `Promise`\< \{
  `data`: [`QueryResultData`](../../sdk-data/interfaces/interface.QueryResultData.md);
 } \>

Executes a data query from custom widget component props.

This method takes custom widget props (dataSource, dataOptions, filters, etc.)
and executes the appropriate data query

#### Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `params` | [`ExecuteCustomWidgetQueryParams`](../interfaces/interface.ExecuteCustomWidgetQueryParams.md) | Custom widget component props containing data source, data options, filters, etc. |

#### Returns

`Promise`\< \{
  `data`: [`QueryResultData`](../../sdk-data/interfaces/interface.QueryResultData.md);
 } \>

Promise resolving to query result with formatted data

***

filters, etc. |

#### Returns

`Promise`\< \{
  `data`: [`QueryResultData`](../../sdk-data/interfaces/interface.QueryResultData.md);
 } \>

Promise resolving to query result with formatted data

***

### executePivotQuery

> **executePivotQuery**(`params`): `Promise`\< \{
  `data`: [`PivotQueryResultData`](../../sdk-data/interfaces/interface.PivotQueryResultData.md);
 } \>

Executes a data query for a pivot table.

#### Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `params` | [`ExecutePivotQueryParams`](../interfaces/interface.ExecutePivotQueryParams.md) | Pivot query parameters |

#### Returns

`Promise`\< \{
  `data`: [`PivotQueryResultData`](../../sdk-data/interfaces/interface.PivotQueryResultData.md);
 } \>

Pivot query result

***

eryParams.md) | Pivot query parameters |

#### Returns

`Promise`\< \{
  `data`: [`PivotQueryResultData`](../../sdk-data/interfaces/interface.PivotQueryResultData.md);
 } \>

Pivot query result

***

### executeQuery

> **executeQuery**(`params`): `Promise`\< \{
  `data`: [`QueryResultData`](../../sdk-data/interfaces/interface.QueryResultData.md);
 } \>

Executes a data query. If you want to display the query results, you can use
them to populate Compose SDK UI elements or third party UI elements.

To learn how to populate third party UI elements with query results, see the
[External Charts Guide](/guides/sdk/guides/charts/guide-external-charts.html#query)

#### Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `params` | [`ExecuteQueryParams`](../interfaces/interface.ExecuteQueryParams.md) | Query parameters |

#### Returns

`Promise`\< \{
  `data`: [`QueryResultData`](../../sdk-data/interfaces/interface.QueryResultData.md);
 } \>

Query result

***

es/interface.ExecuteQueryParams.md) | Query parameters |

#### Returns

`Promise`\< \{
  `data`: [`QueryResultData`](../../sdk-data/interfaces/interface.QueryResultData.md);
 } \>

Query result

***

### executeQueryByWidgetId

> **executeQueryByWidgetId**(`params`): `Promise`\< \{
  `data`: [`QueryResultData`](../../sdk-data/interfaces/interface.QueryResultData.md);
 } & [`QueryByWidgetIdQueryParams`](../../sdk-ui/type-aliases/type-alias.QueryByWidgetIdQueryParams.md) \>

Executes a data query extracted from an existing widget in the Sisense instance.

#### Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `params` | [`ExecuteQueryByWidgetIdParams`](../interfaces/interface.ExecuteQueryByWidgetIdParams.md) | Parameters to identify the target widget |

#### Returns

`Promise`\< \{
  `data`: [`QueryResultData`](../../sdk-data/interfaces/interface.QueryResultData.md);
 } & [`QueryByWidgetIdQueryParams`](../../sdk-ui/type-aliases/type-alias.QueryByWidgetIdQueryParams.md) \>

Query result


## Data Grids

# Data Grids

Angular components for data grids

- [PivotTableComponent](class.PivotTableComponent.md)
- [TableComponent](class.TableComponent.md)

# Class PivotTableComponent

Pivot Table with and pagination.

s

Angular components for data grids

- [PivotTableComponent](class.PivotTableComponent.md)
- [TableComponent](class.TableComponent.md)

# Class PivotTableComponent

Pivot Table with and pagination.

## Example

```html
 <csdk-pivot-table
   [dataSet]="pivotTable.dataSet"
   [dataOptions]="pivotTable.dataOptions"
   [filters]="pivotTable.filters"
   [styleOptions]="pivotTable.styleOptions"
 />
```
```ts
import { Component } from '@angular/core';
import { measureFactory, filterFactory } from '@sisense/sdk-data';
import * as DM from '../../assets/sample-ecommerce';
import type { PivotTableDataOptions } from '@sisense/sdk-ui-angular';

@Component({
 selector: 'app-analytics',
 templateUrl: './analytics.component.html',
 styleUrls: ['./analytics.component.scss'],
})
export class AnalyticsComponent {

 pivotTableDataOptions: PivotTableDataOptions = {
   rows: [
     { column: DM.Category.Category, includeSubTotals: true },
     { column: DM.Commerce.AgeRange, includeSubTotals: true },
     DM.Commerce.Condition,
   ],
   columns: [{ column: DM.Commerce.Gender, includeSubTotals: true }],
   values: [
     measureFactory.sum(DM.Commerce.Cost, 'Total Cost'),
     {
       column: measureFactory.sum(DM.Commerce.Revenue, 'Total Revenue'),
       totalsCalculation: 'sum',
       dataBars: true,
     },
   ],
   grandTotals: { rows: true, columns: true },
 };

 pivotTable = {
   dataSet: DM.DataSource,
   dataOptions: this.pivotTableDataOptions,
   filters: [filterFactory.members(DM.Commerce.Gender, ['Female', 'Male'])],
   styleOptions: { width: 1400, height: 600, rowsPerPage: 50 },
 };

}
```
<img src="../../../img/angular-pivot-table-example.png" width="800px" />

.members(DM.Commerce.Gender, ['Female', 'Male'])],
   styleOptions: { width: 1400, height: 600, rowsPerPage: 50 },
 };

}
```
<img src="../../../img/angular-pivot-table-example.png" width="800px" />

## Remarks

Configuration options can also be applied within the scope of a `<SisenseContextProvider>` to control the default behavior of PivotTable, by changing available settings within `appConfig.chartConfig.tabular.*`

Follow the link to [AppConfig](../type-aliases/type-alias.AppConfig.md) for more details on the available settings.

## Implements

- `AfterViewInit`
- `OnChanges`
- `OnDestroy`

## Constructors

### constructor

> **new PivotTableComponent**(`sisenseContextService`, `themeService`): [`PivotTableComponent`](class.PivotTableComponent.md)

#### Parameters

| Parameter | Type |
| :------ | :------ |
| `sisenseContextService` | [`SisenseContextService`](../contexts/class.SisenseContextService.md) |
| `themeService` | [`ThemeService`](../contexts/class.ThemeService.md) |

#### Returns

[`PivotTableComponent`](class.PivotTableComponent.md)

## Properties

ontexts/class.SisenseContextService.md) |
| `themeService` | [`ThemeService`](../contexts/class.ThemeService.md) |

#### Returns

[`PivotTableComponent`](class.PivotTableComponent.md)

## Properties

### Data

#### dataOptions

> **dataOptions**: [`PivotTableDataOptions`](../interfaces/interface.PivotTableDataOptions.md)

Configurations for how to interpret and present the data passed to the component

***

#### dataSet

> **dataSet**: [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md) \| `undefined`

Data source name (as a `string`) - e.g. `Sample ECommerce`.

If not specified, the component will use the `defaultDataSource` specified in the parent Sisense Context.

***

#### filters

> **filters**: [`FilterRelations`](../../sdk-data/interfaces/interface.FilterRelations.md) \| [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[] \| `undefined`

Filters that will slice query results

***

#### highlights

> **highlights**: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[] \| `undefined`

Filters that will highlight query results

Filters that will slice query results

***

#### highlights

> **highlights**: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[] \| `undefined`

Filters that will highlight query results

### Callbacks

#### dataPointClick

> **dataPointClick**: `EventEmitter`\< [`PivotTableDataPointEvent`](../type-aliases/type-alias.PivotTableDataPointEvent.md) \>

Callback function that is called when the pivot table cell is clicked

***

#### dataPointContextMenu

> **dataPointContextMenu**: `EventEmitter`\< [`PivotTableDataPointEvent`](../type-aliases/type-alias.PivotTableDataPointEvent.md) \>

Callback function that is called when the pivot table cell is right-clicked

### Representation

#### styleOptions

> **styleOptions**: [`PivotTableStyleOptions`](../interfaces/interface.PivotTableStyleOptions.md) \| `undefined`

Configurations for how to style and present a pivot table's data.

# Class TableComponent

Table with aggregation and pagination.

](../interfaces/interface.PivotTableStyleOptions.md) \| `undefined`

Configurations for how to style and present a pivot table's data.

# Class TableComponent

Table with aggregation and pagination.

## Example

```html
 <csdk-table [dataSet]="table.dataSet" [dataOptions]="table.dataOptions" [filters]="filters" />
```
```ts
import { Component } from '@angular/core';
import { measureFactory, filterFactory } from '@sisense/sdk-data';
import * as DM from '../../assets/sample-healthcare-model';

@Component({
 selector: 'app-analytics',
 templateUrl: './analytics.component.html',
 styleUrls: ['./analytics.component.scss'],
})
export class AnalyticsComponent {
 DM = DM;
 filters = [filterFactory.members(DM.Divisions.Divison_name, ['Cardiology', 'Neurology'])];
 table = {
   dataSet: DM.DataSource,
   dataOptions: {
     columns: [DM.Admissions.Patient_ID, measureFactory.sum(DM.Admissions.Cost_of_admission)],
   },
 };

}
```
<img src="../../../img/angular-table-chart-example.png" width="800px" />

## Implements

- `AfterViewInit`
- `OnChanges`
- `OnDestroy`

## Constructors

missions.Cost_of_admission)],
   },
 };

}
```
<img src="../../../img/angular-table-chart-example.png" width="800px" />

## Implements

- `AfterViewInit`
- `OnChanges`
- `OnDestroy`

## Constructors

### constructor

> **new TableComponent**(`sisenseContextService`, `themeService`): [`TableComponent`](class.TableComponent.md)

#### Parameters

| Parameter | Type |
| :------ | :------ |
| `sisenseContextService` | [`SisenseContextService`](../contexts/class.SisenseContextService.md) |
| `themeService` | [`ThemeService`](../contexts/class.ThemeService.md) |

#### Returns

[`TableComponent`](class.TableComponent.md)

## Properties

ice`](../contexts/class.SisenseContextService.md) |
| `themeService` | [`ThemeService`](../contexts/class.ThemeService.md) |

#### Returns

[`TableComponent`](class.TableComponent.md)

## Properties

### Data

#### dataOptions

> **dataOptions**: [`TableDataOptions`](../interfaces/interface.TableDataOptions.md)

Configurations for how to interpret and present the data passed to the component

***

#### dataSet

> **dataSet**: [`Data`](../../sdk-data/interfaces/interface.Data.md) \| [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md) \| `undefined`

Data set for a chart using one of the following options. If neither option is specified, the chart
will use the `defaultDataSource` specified in the parent `SisenseContextProvider`
component.

(1) Sisense data source name as a string. For example, `'Sample ECommerce'`. Typically, you
retrieve the data source name from a data model you create using the `get-data-model`
[command](https://developer.sisense.com/guides/sdk/guides/cli.html) of the Compose SDK CLI. The chart
connects to the data source, executes a query, and loads the data as specified in
`dataOptions`, `filters`, and `highlights`.

To learn more about using data from a Sisense data source, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#sisense-data).

OR

(2) Explicit [`Data`](../../sdk-data/interfaces/interface.Data.md), which is made up of an array of
[`Column`](../../sdk-data/interfaces/interface.Column.md) objects and a two-dimensional array of row data. This approach
allows the chart component to be used with any data you provide.

To learn more about using data from an external data source, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#explicit-data).

Example data in the proper format:

```ts
const sampleData = {
  columns: [
    { name: 'Years', type: 'date' },
    { name: 'Quantity', type: 'number' },
    { name: 'Units', type: 'number' },
  ],
  rows: [
    ['2019', 5500, 1500],
    ['2020', 4471, 7000],
    ['2021', 1812, 5000],
    ['2022', 5001, 6000],
    ['2023', 2045, 4000],
  ],
};
```

***

#### filters

> **filters**: [`FilterRelations`](../../sdk-data/interfaces/interface.FilterRelations.md) \| [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[] \| `undefined`

Filters that will slice query results

rs**: [`FilterRelations`](../../sdk-data/interfaces/interface.FilterRelations.md) \| [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[] \| `undefined`

Filters that will slice query results

### Callbacks

#### dataReady

> **dataReady**: (`data`) => [`Data`](../../sdk-data/interfaces/interface.Data.md) \| `undefined`

A callback that allows to modify data immediately after it has been retrieved.
It can be used to inject modification of queried data.

### Representation

#### styleOptions

> **styleOptions**: [`TableStyleOptions`](../interfaces/interface.TableStyleOptions.md) \| `undefined`

Configurations for how to style and present a table's data.


## Generative Ai

# Generative AI

Angular modules, components, and services for working with Generative AI features provided by Sisense Fusion
::: tip Note
For more information on requirements for enabling Generative AI features, please refer to the [Generative AI documentation](https://docs.sisense.com/main/SisenseLinux/genai.htm)
:::

- [AI\_CONTEXT\_CONFIG\_TOKEN](variable.AI_CONTEXT_CONFIG_TOKEN.md)
- [AiService](class.AiService.md)
- [ChatbotComponent](class.ChatbotComponent.md)
- [GetNlgInsightsComponent](class.GetNlgInsightsComponent.md)
- [SdkAiModule](class.SdkAiModule.md)

# Class AiService

Service for working with Sisense Fusion Generative AI.

## Constructors

nt.md)
- [GetNlgInsightsComponent](class.GetNlgInsightsComponent.md)
- [SdkAiModule](class.SdkAiModule.md)

# Class AiService

Service for working with Sisense Fusion Generative AI.

## Constructors

### constructor

> **new AiService**(`sisenseContextService`, `aiContextConfig`?): [`AiService`](class.AiService.md)

#### Parameters

| Parameter | Type |
| :------ | :------ |
| `sisenseContextService` | [`SisenseContextService`](../contexts/class.SisenseContextService.md) |
| `aiContextConfig`? | [`AiContextConfig`](../interfaces/interface.AiContextConfig.md) |

#### Returns

[`AiService`](class.AiService.md)

## Methods

### getNlgInsights

> **getNlgInsights**(`params`): `Promise`\< `string` \| `undefined` \>

Fetches an analysis of the provided query using natural language generation (NLG).
Specifying NLG parameters is similar to providing parameters to the [QueryService.executeQuery](../queries/class.QueryService.md#executequery) service method, using dimensions, measures, and filters.

#### Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `params` | [`GetNlgInsightsParams`](../interfaces/interface.GetNlgInsightsParams.md) | Parameters for getting NLG insights |

#### Returns

`Promise`\< `string` \| `undefined` \>

NLG insights text summary

***

`GetNlgInsightsParams`](../interfaces/interface.GetNlgInsightsParams.md) | Parameters for getting NLG insights |

#### Returns

`Promise`\< `string` \| `undefined` \>

NLG insights text summary

***

### getNlqResult <Badge type="beta" text="Beta" />

> **getNlqResult**(`params`): `Promise`\< [`WidgetProps`](../type-aliases/type-alias.WidgetProps.md) \| `undefined` \>

Executes a natural language query (NLQ) against a data model or perspective

#### Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `params` | [`GetNlqResultParams`](../interfaces/interface.GetNlqResultParams.md) | NLQ query parameters |

#### Returns

`Promise`\< [`WidgetProps`](../type-aliases/type-alias.WidgetProps.md) \| `undefined` \>

The result as WidgetProps

***

### getQueryRecommendations <Badge type="beta" text="Beta" />

> **getQueryRecommendations**(`params`): `Promise`\< [`QueryRecommendation`](../interfaces/interface.QueryRecommendation.md)[] \>

Fetches recommended questions for a data model or perspective.

#### Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `params` | [`GetQueryRecommendationsParams`](../interfaces/interface.GetQueryRecommendationsParams.md) | Parameters for recommendations |

#### Returns

`Promise`\< [`QueryRecommendation`](../interfaces/interface.QueryRecommendation.md)[] \>

An array of objects, each containing recommended question text and its corresponding `widgetProps`

Returns

`Promise`\< [`QueryRecommendation`](../interfaces/interface.QueryRecommendation.md)[] \>

An array of objects, each containing recommended question text and its corresponding `widgetProps`

# Class ChatbotComponent

An Angular component that renders a chatbot with data topic selection.

## Example

An example of using the `ChatbotComponent`:

```html
<!--Component HTML template in example.component.html-->
<csdk-chatbot
 [width]="chatbot.width"
 [height]="chatbot.height"
 [config]="chatbot.config"
/>
```

```ts
// Component behavior in example.component.ts
import { Component } from '@angular/core';

@Component({
 selector: 'example',
 templateUrl: './example.component.html',
 styleUrls: ['./example.component.scss'],
})
export class ExampleComponent {
 chatbot = {
   width: '500px',
   height: '700px',
   config: {
     numOfRecommendations: 5,
   },
 };
}
```

<img src="../../../img/angular-chatbot-example.png" width="500px" />

## Implements

- `AfterViewInit`
- `OnChanges`
- `OnDestroy`

## Constructors

: {
     numOfRecommendations: 5,
   },
 };
}
```

<img src="../../../img/angular-chatbot-example.png" width="500px" />

## Implements

- `AfterViewInit`
- `OnChanges`
- `OnDestroy`

## Constructors

### constructor

> **new ChatbotComponent**(
  `sisenseContextService`,
  `themeService`,
  `aiService`): [`ChatbotComponent`](class.ChatbotComponent.md)

Constructor for the `ChatbotComponent`.

#### Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `sisenseContextService` | [`SisenseContextService`](../contexts/class.SisenseContextService.md) | Sisense context service |
| `themeService` | [`ThemeService`](../contexts/class.ThemeService.md) | Theme service |
| `aiService` | [`AiService`](class.AiService.md) | AI service |

#### Returns

[`ChatbotComponent`](class.ChatbotComponent.md)

## Properties

### Constructor

#### aiService

> **aiService**: [`AiService`](class.AiService.md)

AI service

***

#### sisenseContextService

> **sisenseContextService**: [`SisenseContextService`](../contexts/class.SisenseContextService.md)

Sisense context service

***

#### themeService

> **themeService**: [`ThemeService`](../contexts/class.ThemeService.md)

Theme service

eContextService`](../contexts/class.SisenseContextService.md)

Sisense context service

***

#### themeService

> **themeService**: [`ThemeService`](../contexts/class.ThemeService.md)

Theme service

### Other

#### config

> **config**: `Partial`\< [`ChatConfig`](../interfaces/interface.ChatConfig.md) \> \| `undefined`

Various configuration options for the chatbot

***

#### height

> **height**: `Height`\< `number` \| `string` \> \| `undefined`

Total height of the chatbot

If not specified, a default height of `900px` will be used.

***

#### width

> **width**: `Width`\< `number` \| `string` \> \| `undefined`

Total width of the chatbot

If not specified, a default width of `500px` will be used.

# Class GetNlgInsightsComponent

An Angular component that fetches and displays a collapsible analysis of the provided query using natural language generation (NLG).
Specifying NLG parameters is similar to providing parameters to the [QueryService.executeQuery](../queries/class.QueryService.md#executequery) service method, using dimensions, measures, and filters.

pecifying NLG parameters is similar to providing parameters to the [QueryService.executeQuery](../queries/class.QueryService.md#executequery) service method, using dimensions, measures, and filters.

## Example

An example of using the `GetNlgInsightsComponent`:

```html
<!--Component HTML template in example.component.html-->
<csdk-get-nlg-insights
 [dataSource]="nlgParams.dataSource"
 [dimensions]="nlgParams.dimensions"
 [measures]="nlgParams.measures"
/>
```

```ts
// Component behavior in example.component.ts
import { Component } from '@angular/core';
import { measureFactory } from '@sisense/sdk-data';
import * as DM from '../../assets/sample-healthcare-model';

@Component({
 selector: 'example',
 templateUrl: './example.component.html',
 styleUrls: ['./example.component.scss'],
})
export class ExampleComponent {
 nlgParams = {
   dataSource: DM.DataSource.title,
   dimensions: [DM.Divisions.Divison_name],
   measures: [measureFactory.sum(DM.Admissions.Cost_of_admission)],
 };
}
```

<img src="../../../img/angular-get-nlg-insights-example.png" width="700px" />

## Implements

- `AfterViewInit`
- `OnChanges`
- `OnDestroy`

## Constructors

dmissions.Cost_of_admission)],
 };
}
```

<img src="../../../img/angular-get-nlg-insights-example.png" width="700px" />

## Implements

- `AfterViewInit`
- `OnChanges`
- `OnDestroy`

## Constructors

### constructor

> **new GetNlgInsightsComponent**(
  `sisenseContextService`,
  `themeService`,
  `aiService`): [`GetNlgInsightsComponent`](class.GetNlgInsightsComponent.md)

Constructor for the `GetNlgInsightsProps`.

#### Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `sisenseContextService` | [`SisenseContextService`](../contexts/class.SisenseContextService.md) | Sisense context service |
| `themeService` | [`ThemeService`](../contexts/class.ThemeService.md) | Theme service |
| `aiService` | [`AiService`](class.AiService.md) | AI service |

#### Returns

[`GetNlgInsightsComponent`](class.GetNlgInsightsComponent.md)

## Properties

### Constructor

#### aiService

> **aiService**: [`AiService`](class.AiService.md)

AI service

***

#### sisenseContextService

> **sisenseContextService**: [`SisenseContextService`](../contexts/class.SisenseContextService.md)

Sisense context service

***

#### themeService

> **themeService**: [`ThemeService`](../contexts/class.ThemeService.md)

Theme service

eContextService`](../contexts/class.SisenseContextService.md)

Sisense context service

***

#### themeService

> **themeService**: [`ThemeService`](../contexts/class.ThemeService.md)

Theme service

### Other

#### dataSource

> **dataSource**: [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md)

The data source that the query targets - e.g. `Sample ECommerce`

***

#### dimensions

> **dimensions**: [`Attribute`](../../sdk-data/interfaces/interface.Attribute.md)[] \| `undefined`

Dimensions of the query

***

#### filters

> **filters**: [`FilterRelations`](../../sdk-data/interfaces/interface.FilterRelations.md) \| [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[] \| `undefined`

Filters of the query

***

#### measures

> **measures**: [`Measure`](../../sdk-data/interfaces/interface.Measure.md)[] \| `undefined`

Measures of the query

***

#### verbosity

> **verbosity**: `"High"` \| `"Low"` \| `undefined`

The verbosity of the NLG summarization

# Class SdkAiModule

SDK AI Module, which is a container for generative AI components and services.

sity

> **verbosity**: `"High"` \| `"Low"` \| `undefined`

The verbosity of the NLG summarization

# Class SdkAiModule

SDK AI Module, which is a container for generative AI components and services.

## Example

Example of importing [SdkAiModule](class.SdkAiModule.md) and injecting [AiContextConfig](../interfaces/interface.AiContextConfig.md) into your application,
along with importing dependency [SdkUiModule](../contexts/class.SdkUiModule.md) and injecting [SisenseContextConfig](../interfaces/interface.SisenseContextConfig.md) to connect to a Sisense instance:

```ts
import { SdkUiModule, SisenseContextConfig } from '@sisense/sdk-ui-angular';
import { SdkAiModule, AI_CONTEXT_CONFIG_TOKEN, AiContextConfig } from '@sisense/sdk-ui-angular/ai';

const AI_CONTEXT_CONFIG: AiContextConfig = {
  volatile: true,
};
const SISENSE_CONTEXT_CONFIG: SisenseContextConfig = {
  url: "<instance url>", // replace with the URL of your Sisense instance
  token: "<api token>", // replace with the API token of your user account
  defaultDataSource: DM.DataSource,
};

@NgModule({
  imports: [
    BrowserModule,
    SdkUiModule,
    SdkAiModule,
  ],
  declarations: [AppComponent],
  providers: [
    { provide: AI_CONTEXT_CONFIG_TOKEN, useValue: AI_CONTEXT_CONFIG },
    { provide: SISENSE_CONTEXT_CONFIG_TOKEN, useValue: SISENSE_CONTEXT_CONFIG },
  ],
  bootstrap: [AppComponent],
})
```

## Constructors

de: AI_CONTEXT_CONFIG_TOKEN, useValue: AI_CONTEXT_CONFIG },
    { provide: SISENSE_CONTEXT_CONFIG_TOKEN, useValue: SISENSE_CONTEXT_CONFIG },
  ],
  bootstrap: [AppComponent],
})
```

## Constructors

### constructor

> **new SdkAiModule**(): [`SdkAiModule`](class.SdkAiModule.md)

#### Returns

[`SdkAiModule`](class.SdkAiModule.md)

# Variable AI\_CONTEXT\_CONFIG\_TOKEN

> **`const`** **AI\_CONTEXT\_CONFIG\_TOKEN**: `InjectionToken`\< [`AiContextConfig`](../interfaces/interface.AiContextConfig.md) \>

Token used to inject [AiContextConfig](../interfaces/interface.AiContextConfig.md) into your application.

EN**: `InjectionToken`\< [`AiContextConfig`](../interfaces/interface.AiContextConfig.md) \>

Token used to inject [AiContextConfig](../interfaces/interface.AiContextConfig.md) into your application.

## Example

Example of importing [SdkAiModule](class.SdkAiModule.md) and injecting [AiContextConfig](../interfaces/interface.AiContextConfig.md) into your application,
along with importing dependency [SdkUiModule](../contexts/class.SdkUiModule.md) and injecting [SisenseContextConfig](../interfaces/interface.SisenseContextConfig.md) to connect to a Sisense instance:

```ts
import { SdkUiModule, SisenseContextConfig } from '@sisense/sdk-ui-angular';
import { SdkAiModule, AI_CONTEXT_CONFIG_TOKEN, AiContextConfig } from '@sisense/sdk-ui-angular/ai';

const AI_CONTEXT_CONFIG: AiContextConfig = {
  volatile: true,
};
const SISENSE_CONTEXT_CONFIG: SisenseContextConfig = {
  url: "<instance url>", // replace with the URL of your Sisense instance
  token: "<api token>", // replace with the API token of your user account
  defaultDataSource: DM.DataSource,
};

@NgModule({
  imports: [
    BrowserModule,
    SdkUiModule,
    SdkAiModule,
  ],
  declarations: [AppComponent],
  providers: [
    { provide: AI_CONTEXT_CONFIG_TOKEN, useValue: AI_CONTEXT_CONFIG },
    { provide: SISENSE_CONTEXT_CONFIG_TOKEN, useValue: SISENSE_CONTEXT_CONFIG },
  ],
  bootstrap: [AppComponent],
})
```


## Interfaces

ide: AI_CONTEXT_CONFIG_TOKEN, useValue: AI_CONTEXT_CONFIG },
    { provide: SISENSE_CONTEXT_CONFIG_TOKEN, useValue: SISENSE_CONTEXT_CONFIG },
  ],
  bootstrap: [AppComponent],
})
```


## Interfaces

# Interfaces

TypeScript interfaces for components and services listed above

- [AiContextConfig](interface.AiContextConfig.md)
- [AreaChartProps](interface.AreaChartProps.md)
- [AreamapChartDataOptions](interface.AreamapChartDataOptions.md)
- [AreamapChartProps](interface.AreamapChartProps.md)
- [AreamapStyleOptions](interface.AreamapStyleOptions.md)
- [AreaRangeChartProps](interface.AreaRangeChartProps.md)
- [AreaRangeStyleOptions](interface.AreaRangeStyleOptions.md)
- [AreaStyleOptions](interface.AreaStyleOptions.md)
- [BarChartProps](interface.BarChartProps.md)
- [BoxplotChartProps](interface.BoxplotChartProps.md)
- [BoxplotStyleOptions](interface.BoxplotStyleOptions.md)
- [CalendarHeatmapChartDataOptions](interface.CalendarHeatmapChartDataOptions.md)
- [CalendarHeatmapChartProps](interface.CalendarHeatmapChartProps.md)
- [CalendarHeatmapStyleOptions](interface.CalendarHeatmapStyleOptions.md)
- [CartesianChartDataOptions](interface.CartesianChartDataOptions.md)
- [CategoricalChartDataOptions](interface.CategoricalChartDataOptions.md)
- [ChartProps](interface.ChartProps.md)
- [ChartWidgetProps](interface.ChartWidgetProps.md)
- [ChatbotProps](interface.ChatbotProps.md)
- [ChatConfig](interface.ChatConfig.md)
- [ColumnChartProps](interface.ColumnChartProps.md)
- [ComposableDashboardProps](interface.ComposableDashboardProps.md)
- [CriteriaFilterTileProps](interface.CriteriaFilterTileProps.md)
- [CustomWidgetComponentProps](interface.CustomWidgetComponentProps.md)
- [DashboardByIdConfig](interface.DashboardByIdConfig.md)
- [DashboardByIdProps](interface.DashboardByIdProps.md)
- [DashboardConfig](interface.DashboardConfig.md)
- [DashboardFiltersPanelConfig](interface.DashboardFiltersPanelConfig.md)
- [DashboardLayoutOptions](interface.DashboardLayoutOptions.md)
- [DashboardProps](interface.DashboardProps.md)
- [DataLimits](interface.DataLimits.md)
- [DateRangeFilterTileProps](interface.DateRangeFilterTileProps.md)
- [DrilldownBreadcrumbsProps](interface.DrilldownBreadcrumbsProps.md)
- [ExecuteCsvQueryParams](interface.ExecuteCsvQueryParams.md)
- [ExecuteCustomWidgetQueryParams](interface.ExecuteCustomWidgetQueryParams.md)
- [ExecutePivotQueryParams](interface.ExecutePivotQueryParams.md)
- [ExecuteQueryByWidgetIdParams](interface.ExecuteQueryByWidgetIdParams.md)
- [ExecuteQueryParams](interface.ExecuteQueryParams.md)
- [FiltersPanelConfig](interface.FiltersPanelConfig.md)
- [FiltersPanelProps](interface.FiltersPanelProps.md)
- [FilterTileProps](interface.FilterTileProps.md)
- [FunnelChartProps](interface.FunnelChartProps.md)
- [FunnelStyleOptions](interface.FunnelStyleOptions.md)
- [GaugeIndicatorStyleOptions](interface.GaugeIndicatorStyleOptions.md)
- [GetDashboardModelOptions](interface.GetDashboardModelOptions.md)
- [GetDashboardModelsOptions](interface.GetDashboardModelsOptions.md)
- [GetFilterMembersData](interface.GetFilterMembersData.md)
- [GetFilterMembersParams](interface.GetFilterMembersParams.md)
- [GetHierarchyModelsParams](interface.GetHierarchyModelsParams.md)
- [GetNlgInsightsParams](interface.GetNlgInsightsParams.md)
- [GetNlgInsightsProps](interface.GetNlgInsightsProps.md)
- [GetNlqResultParams](interface.GetNlqResultParams.md)
- [GetQueryRecommendationsParams](interface.GetQueryRecommendationsParams.md)
- [GetSharedFormulaParams](interface.GetSharedFormulaParams.md)
- [GetWidgetModelParams](interface.GetWidgetModelParams.md)
- [Hierarchy](interface.Hierarchy.md)
- [HierarchyModel](interface.HierarchyModel.md)
- [IndicatorChartDataOptions](interface.IndicatorChartDataOptions.md)
- [IndicatorChartProps](interface.IndicatorChartProps.md)
- [JumpToDashboardConfig](interface.JumpToDashboardConfig.md)
- [JumpToDashboardConfigForPivot](interface.JumpToDashboardConfigForPivot.md)
- [LineChartProps](interface.LineChartProps.md)
- [LineStyleOptions](interface.LineStyleOptions.md)
- [Member](interface.Member.md)
- [MemberFilterTileProps](interface.MemberFilterTileProps.md)
- [NumericBarIndicatorStyleOptions](interface.NumericBarIndicatorStyleOptions.md)
- [NumericSimpleIndicatorStyleOptions](interface.NumericSimpleIndicatorStyleOptions.md)
- [PieChartProps](interface.PieChartProps.md)
- [PieStyleOptions](interface.PieStyleOptions.md)
- [PivotTableDataOptions](interface.PivotTableDataOptions.md)
- [PivotTableProps](interface.PivotTableProps.md)
- [PivotTableStyleOptions](interface.PivotTableStyleOptions.md)
- [PivotTableWidgetProps](interface.PivotTableWidgetProps.md)
- [PolarChartProps](interface.PolarChartProps.md)
- [PolarStyleOptions](interface.PolarStyleOptions.md)
- [QueryRecommendation](interface.QueryRecommendation.md)
- [RangeChartDataOptions](interface.RangeChartDataOptions.md)
- [RelativeDateFilterTileProps](interface.RelativeDateFilterTileProps.md)
- [ScatterChartDataOptions](interface.ScatterChartDataOptions.md)
- [ScatterChartProps](interface.ScatterChartProps.md)
- [ScattermapChartDataOptions](interface.ScattermapChartDataOptions.md)
- [ScattermapChartProps](interface.ScattermapChartProps.md)
- [ScattermapStyleOptions](interface.ScattermapStyleOptions.md)
- [ScatterStyleOptions](interface.ScatterStyleOptions.md)
- [SisenseContextConfig](interface.SisenseContextConfig.md)
- [StackableStyleOptions](interface.StackableStyleOptions.md)
- [StreamgraphChartProps](interface.StreamgraphChartProps.md)
- [StreamgraphStyleOptions](interface.StreamgraphStyleOptions.md)
- [StyledColumn](interface.StyledColumn.md)
- [StyledMeasureColumn](interface.StyledMeasureColumn.md)
- [SunburstChartProps](interface.SunburstChartProps.md)
- [SunburstStyleOptions](interface.SunburstStyleOptions.md)
- [TableDataOptions](interface.TableDataOptions.md)
- [TableProps](interface.TableProps.md)
- [TableStyleOptions](interface.TableStyleOptions.md)
- [TextWidgetProps](interface.TextWidgetProps.md)
- [ThemeSettings](interface.ThemeSettings.md)
- [TreemapChartProps](interface.TreemapChartProps.md)
- [TreemapStyleOptions](interface.TreemapStyleOptions.md)
- [WidgetByIdProps](interface.WidgetByIdProps.md)
- [WidgetByIdStyleOptions](interface.WidgetByIdStyleOptions.md)
- [WidgetsPanelColumnLayout](interface.WidgetsPanelColumnLayout.md)

StyleOptions.md)
- [WidgetByIdProps](interface.WidgetByIdProps.md)
- [WidgetByIdStyleOptions](interface.WidgetByIdStyleOptions.md)
- [WidgetsPanelColumnLayout](interface.WidgetsPanelColumnLayout.md)

# Interface AiContextConfig

## Properties

### volatile

> **volatile**?: `boolean`

Boolean flag to indicate whether the chat session should be volatile.

When `false` the chat session history will be stored per user per datamodel. The retention period is configurable in Sisense Fusion.

When the `Chatbot` component renders, if a previous chat history exists for the current user and datamodel, it will be restored. The user may continue the conversation or clear the history.

When `true` a new chat session (with no history) will be created each time the `Chatbot` comoponent initializes.

#### Default

```ts
false
```

# Interface AreaChartProps

Props of the [AreaChartComponent](../charts/class.AreaChartComponent.md) component.

## Properties

e the `Chatbot` comoponent initializes.

#### Default

```ts
false
```

# Interface AreaChartProps

Props of the [AreaChartComponent](../charts/class.AreaChartComponent.md) component.

## Properties

### Data

#### dataSet

> **dataSet**?: [`Data`](../../sdk-data/interfaces/interface.Data.md) \| [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md)

Data set for a chart using one of the following options. If neither option is specified, the chart
will use the `defaultDataSource` specified in the parent `SisenseContextProvider`
component.

(1) Sisense data source name as a string. For example, `'Sample ECommerce'`. Typically, you
retrieve the data source name from a data model you create using the `get-data-model`
[command](https://developer.sisense.com/guides/sdk/guides/cli.html) of the Compose SDK CLI. The chart
connects to the data source, executes a query, and loads the data as specified in
`dataOptions`, `filters`, and `highlights`.

To learn more about using data from a Sisense data source, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#sisense-data).

OR

(2) Explicit [`Data`](../../sdk-data/interfaces/interface.Data.md), which is made up of an array of
[`Column`](../../sdk-data/interfaces/interface.Column.md) objects and a two-dimensional array of row data. This approach
allows the chart component to be used with any data you provide.

To learn more about using data from an external data source, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#explicit-data).

Example data in the proper format:

```ts
const sampleData = {
  columns: [
    { name: 'Years', type: 'date' },
    { name: 'Quantity', type: 'number' },
    { name: 'Units', type: 'number' },
  ],
  rows: [
    ['2019', 5500, 1500],
    ['2020', 4471, 7000],
    ['2021', 1812, 5000],
    ['2022', 5001, 6000],
    ['2023', 2045, 4000],
  ],
};
```

***

#### filters

> **filters**?: [`FilterRelations`](../../sdk-data/interfaces/interface.FilterRelations.md) \| [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Filters to limit (or slice) a chart’s data using one of the following options.

(1) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) or [FilterRelations](../../sdk-data/interfaces/interface.FilterRelations.md) returned from filter factory functions, such as
[`greaterThan()`](../../sdk-data/factories/namespace.filterFactory/functions/function.greaterThan.md) and [`members()`](../../sdk-data/factories/namespace.filterFactory/functions/function.members.md).

Use this option for filters that do not require a UI to set them
or for filters where you will supply your own UI components or use pre-built UI components. This is the most common option.

To learn more about using filter factory functions to create filters, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-functions).

(2) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) controlled by filter UI components – for example [`MemberFilterTile`](../../sdk-ui/filter-tiles/function.MemberFilterTile.md).

Use this option for filters that you want your users to set using pre-built UI components.

To learn more about using filter UI components to create filters, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components).

***

#### highlights

> **highlights**?: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Highlights based on filter criteria to apply to a chart using one of the following options.

NOTE that the filter dimensions used in highlights must match those defined in the
`dataOptions` of the chart. Otherwise, the filters will be applied as regular slice filters.

(1) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) returned from filter factory functions, such as
[`greaterThan()`](../../sdk-data/factories/namespace.filterFactory/functions/function.greaterThan.md) and [`members()`](../../sdk-data/factories/namespace.filterFactory/functions/function.members.md).

Use this option for highlights that do not require a UI to set them
or for highlights where you will supply your own UI components or use pre-built UI components. This is the most common option.

To learn more about using filter factory functions to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-functions-for-highlighting).

(2) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) controlled by filter UI components – for example [`MemberFilterTile`](../../sdk-ui/filter-tiles/function.MemberFilterTile.md).

Use this option for highlights that you want your users to set using pre-built UI components.

To learn more about using filter components to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components-for-highlighting).

ts.

To learn more about using filter components to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components-for-highlighting).

### Chart

#### dataOptions

> **dataOptions**: [`CartesianChartDataOptions`](interface.CartesianChartDataOptions.md)

Configurations for how to interpret and present a chart's data.

To learn more about using data options,
see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#dataoptions).

***

#### styleOptions

> **styleOptions**?: [`AreaStyleOptions`](interface.AreaStyleOptions.md)

Configurations for how to style and present a chart's data.

e-compose-sdk-charts.html#dataoptions).

***

#### styleOptions

> **styleOptions**?: [`AreaStyleOptions`](interface.AreaStyleOptions.md)

Configurations for how to style and present a chart's data.

### Callbacks

#### beforeRender

> **beforeRender**?: [`BeforeRenderHandler`](../type-aliases/type-alias.BeforeRenderHandler.md)

A callback that allows you to customize the underlying chart element before it is rendered. The returned options are then used when rendering the chart.

This callback is not supported for Areamap Chart, Scattermap Chart, Table, and PivotTable.

***

#### dataPointClick

> **dataPointClick**?: [`DataPointEventHandler`](../type-aliases/type-alias.DataPointEventHandler.md)

Click handler callback for a data point

***

#### dataPointContextMenu

> **dataPointContextMenu**?: [`DataPointEventHandler`](../type-aliases/type-alias.DataPointEventHandler.md)

Context menu handler callback for a data point

***

#### dataPointsSelect

> **dataPointsSelect**?: [`DataPointsEventHandler`](../type-aliases/type-alias.DataPointsEventHandler.md)

Handler callback for selection of multiple data points

***

#### dataReady

> **dataReady**?: (`data`) => [`Data`](../../sdk-data/interfaces/interface.Data.md)

A callback that allows to modify data immediately after it has been retrieved.
It can be used to inject modification of queried data.

##### Parameters

| Parameter | Type |
| :------ | :------ |
| `data` | [`Data`](../../sdk-data/interfaces/interface.Data.md) |

##### Returns

[`Data`](../../sdk-data/interfaces/interface.Data.md)

##### Parameters

| Parameter | Type |
| :------ | :------ |
| `data` | [`Data`](../../sdk-data/interfaces/interface.Data.md) |

##### Returns

[`Data`](../../sdk-data/interfaces/interface.Data.md)

# Interface AreaRangeChartProps

Props of the [AreaRangeChartComponent](../charts/class.AreaRangeChartComponent.md).

## Properties

## Returns

[`Data`](../../sdk-data/interfaces/interface.Data.md)

# Interface AreaRangeChartProps

Props of the [AreaRangeChartComponent](../charts/class.AreaRangeChartComponent.md).

## Properties

### Data

#### dataSet

> **dataSet**?: [`Data`](../../sdk-data/interfaces/interface.Data.md) \| [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md)

Data set for a chart using one of the following options. If neither option is specified, the chart
will use the `defaultDataSource` specified in the parent `SisenseContextProvider`
component.

(1) Sisense data source name as a string. For example, `'Sample ECommerce'`. Typically, you
retrieve the data source name from a data model you create using the `get-data-model`
[command](https://developer.sisense.com/guides/sdk/guides/cli.html) of the Compose SDK CLI. The chart
connects to the data source, executes a query, and loads the data as specified in
`dataOptions`, `filters`, and `highlights`.

To learn more about using data from a Sisense data source, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#sisense-data).

OR

(2) Explicit [`Data`](../../sdk-data/interfaces/interface.Data.md), which is made up of an array of
[`Column`](../../sdk-data/interfaces/interface.Column.md) objects and a two-dimensional array of row data. This approach
allows the chart component to be used with any data you provide.

To learn more about using data from an external data source, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#explicit-data).

Example data in the proper format:

```ts
const sampleData = {
  columns: [
    { name: 'Years', type: 'date' },
    { name: 'Quantity', type: 'number' },
    { name: 'Units', type: 'number' },
  ],
  rows: [
    ['2019', 5500, 1500],
    ['2020', 4471, 7000],
    ['2021', 1812, 5000],
    ['2022', 5001, 6000],
    ['2023', 2045, 4000],
  ],
};
```

***

#### filters

> **filters**?: [`FilterRelations`](../../sdk-data/interfaces/interface.FilterRelations.md) \| [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Filters to limit (or slice) a chart’s data using one of the following options.

(1) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) or [FilterRelations](../../sdk-data/interfaces/interface.FilterRelations.md) returned from filter factory functions, such as
[`greaterThan()`](../../sdk-data/factories/namespace.filterFactory/functions/function.greaterThan.md) and [`members()`](../../sdk-data/factories/namespace.filterFactory/functions/function.members.md).

Use this option for filters that do not require a UI to set them
or for filters where you will supply your own UI components or use pre-built UI components. This is the most common option.

To learn more about using filter factory functions to create filters, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-functions).

(2) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) controlled by filter UI components – for example [`MemberFilterTile`](../../sdk-ui/filter-tiles/function.MemberFilterTile.md).

Use this option for filters that you want your users to set using pre-built UI components.

To learn more about using filter UI components to create filters, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components).

***

#### highlights

> **highlights**?: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Highlights based on filter criteria to apply to a chart using one of the following options.

NOTE that the filter dimensions used in highlights must match those defined in the
`dataOptions` of the chart. Otherwise, the filters will be applied as regular slice filters.

(1) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) returned from filter factory functions, such as
[`greaterThan()`](../../sdk-data/factories/namespace.filterFactory/functions/function.greaterThan.md) and [`members()`](../../sdk-data/factories/namespace.filterFactory/functions/function.members.md).

Use this option for highlights that do not require a UI to set them
or for highlights where you will supply your own UI components or use pre-built UI components. This is the most common option.

To learn more about using filter factory functions to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-functions-for-highlighting).

(2) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) controlled by filter UI components – for example [`MemberFilterTile`](../../sdk-ui/filter-tiles/function.MemberFilterTile.md).

Use this option for highlights that you want your users to set using pre-built UI components.

To learn more about using filter components to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components-for-highlighting).

ts.

To learn more about using filter components to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components-for-highlighting).

### Chart

#### dataOptions

> **dataOptions**: [`RangeChartDataOptions`](interface.RangeChartDataOptions.md)

Configurations for how to interpret and present the data passed to the chart

***

#### styleOptions

> **styleOptions**?: [`AreaRangeStyleOptions`](interface.AreaRangeStyleOptions.md)

Configurations for how to style and present a chart's data.

the data passed to the chart

***

#### styleOptions

> **styleOptions**?: [`AreaRangeStyleOptions`](interface.AreaRangeStyleOptions.md)

Configurations for how to style and present a chart's data.

### Callbacks

#### beforeRender

> **beforeRender**?: [`BeforeRenderHandler`](../type-aliases/type-alias.BeforeRenderHandler.md)

A callback that allows you to customize the underlying chart element before it is rendered. The returned options are then used when rendering the chart.

This callback is not supported for Areamap Chart, Scattermap Chart, Table, and PivotTable.

***

#### dataPointClick

> **dataPointClick**?: [`DataPointEventHandler`](../type-aliases/type-alias.DataPointEventHandler.md)

Click handler callback for a data point

***

#### dataPointContextMenu

> **dataPointContextMenu**?: [`DataPointEventHandler`](../type-aliases/type-alias.DataPointEventHandler.md)

Context menu handler callback for a data point

***

#### dataPointsSelect

> **dataPointsSelect**?: [`DataPointsEventHandler`](../type-aliases/type-alias.DataPointsEventHandler.md)

Handler callback for selection of multiple data points

***

#### dataReady

> **dataReady**?: (`data`) => [`Data`](../../sdk-data/interfaces/interface.Data.md)

A callback that allows to modify data immediately after it has been retrieved.
It can be used to inject modification of queried data.

##### Parameters

| Parameter | Type |
| :------ | :------ |
| `data` | [`Data`](../../sdk-data/interfaces/interface.Data.md) |

##### Returns

[`Data`](../../sdk-data/interfaces/interface.Data.md)

##### Parameters

| Parameter | Type |
| :------ | :------ |
| `data` | [`Data`](../../sdk-data/interfaces/interface.Data.md) |

##### Returns

[`Data`](../../sdk-data/interfaces/interface.Data.md)

# Interface AreaRangeStyleOptions

Configuration options that define functional style of the various elements of AreaRangeChart

## Properties

### dataLimits

> **dataLimits**?: [`DataLimits`](interface.DataLimits.md)

Data limit for series or categories that will be plotted

***

### height

> **height**?: `number`

Total height of the component, which is considered in the following order of priority:

1. Value passed to this property (in pixels).
2. Height of the container wrapping this component
3. Default value of 400px (for component without header) or 425px (for component with header).

***

### legend

> **legend**?: [`LegendOptions`](../../sdk-ui/type-aliases/type-alias.LegendOptions.md)

Configuration for legend - a key that provides information about the data series or colors used in chart

***

### line

> **line**?: [`LineOptions`](../type-aliases/type-alias.LineOptions.md)

Configuration that defines line style

***

### lineWidth

> **lineWidth**?: [`LineWidth`](../type-aliases/type-alias.LineWidth.md)

Configuration that defines line width

::: warning Deprecated
Use line.width instead
:::

***

### markers

> **markers**?: [`Markers`](../type-aliases/type-alias.Markers.md)

Configuration for markers - symbols or data points that highlight specific values

***

e line.width instead
:::

***

### markers

> **markers**?: [`Markers`](../type-aliases/type-alias.Markers.md)

Configuration for markers - symbols or data points that highlight specific values

***

### navigator

> **navigator**?: [`Navigator`](../type-aliases/type-alias.Navigator.md)

Configuration for navigator - zoom/pan tool for large datasets in a chart

***

### seriesLabels

> **seriesLabels**?: [`SeriesLabels`](../type-aliases/type-alias.SeriesLabels.md)

Configuration for series labels - titles/names identifying data series in a chart

***

### subtype

> **subtype**?: [`AreaRangeSubtype`](../../sdk-ui/type-aliases/type-alias.AreaRangeSubtype.md)

Subtype of AreaRangeChart

***

### width

> **width**?: `number`

Total width of the component, which is considered in the following order of priority:

1. Value passed to this property (in pixels)
2. Width of the container wrapping this component
3. Default value of 400px

***

### xAxis

> **xAxis**?: [`AxisLabel`](../type-aliases/type-alias.AxisLabel.md)

Configuration for X axis

***

### y2Axis

> **y2Axis**?: [`AxisLabel`](../type-aliases/type-alias.AxisLabel.md)

Configuration for second Y axis

***

### yAxis

> **yAxis**?: [`AxisLabel`](../type-aliases/type-alias.AxisLabel.md)

Configuration for Y axis

# Interface AreaStyleOptions

Configuration options that define functional style of the various elements of AreaChart

## Properties

/type-aliases/type-alias.AxisLabel.md)

Configuration for Y axis

# Interface AreaStyleOptions

Configuration options that define functional style of the various elements of AreaChart

## Properties

### dataLimits

> **dataLimits**?: [`DataLimits`](interface.DataLimits.md)

Data limit for series or categories that will be plotted

***

### height

> **height**?: `number`

Total height of the component, which is considered in the following order of priority:

1. Value passed to this property (in pixels).
2. Height of the container wrapping this component
3. Default value of 400px (for component without header) or 425px (for component with header).

***

### legend

> **legend**?: [`LegendOptions`](../../sdk-ui/type-aliases/type-alias.LegendOptions.md)

Configuration for legend - a key that provides information about the data series or colors used in chart

***

### line

> **line**?: [`LineOptions`](../type-aliases/type-alias.LineOptions.md)

Configuration that defines line style

***

### lineWidth

> **lineWidth**?: [`LineWidth`](../type-aliases/type-alias.LineWidth.md)

Configuration that defines line width

::: warning Deprecated
Use line.width instead
:::

***

### markers

> **markers**?: [`Markers`](../type-aliases/type-alias.Markers.md)

Configuration for markers - symbols or data points that highlight specific values

***

e line.width instead
:::

***

### markers

> **markers**?: [`Markers`](../type-aliases/type-alias.Markers.md)

Configuration for markers - symbols or data points that highlight specific values

***

### navigator

> **navigator**?: [`Navigator`](../type-aliases/type-alias.Navigator.md)

Configuration for navigator - zoom/pan tool for large datasets in a chart

***

### seriesLabels

> **seriesLabels**?: [`SeriesLabels`](../type-aliases/type-alias.SeriesLabels.md)

Configuration for series labels - titles/names identifying data series in a chart

***

### subtype

> **subtype**?: [`AreaSubtype`](../type-aliases/type-alias.AreaSubtype.md)

Subtype of AreaChart

***

### totalLabels

> **totalLabels**?: [`TotalLabels`](../../sdk-ui/type-aliases/type-alias.TotalLabels.md)

Configuration for total labels
Only supported for stacked chart subtypes

***

### width

> **width**?: `number`

Total width of the component, which is considered in the following order of priority:

1. Value passed to this property (in pixels)
2. Width of the container wrapping this component
3. Default value of 400px

***

### xAxis

> **xAxis**?: [`AxisLabel`](../type-aliases/type-alias.AxisLabel.md)

Configuration for X axis

***

### y2Axis

> **y2Axis**?: [`AxisLabel`](../type-aliases/type-alias.AxisLabel.md)

Configuration for second Y axis

***

### yAxis

> **yAxis**?: [`AxisLabel`](../type-aliases/type-alias.AxisLabel.md)

Configuration for Y axis

`AxisLabel`](../type-aliases/type-alias.AxisLabel.md)

Configuration for second Y axis

***

### yAxis

> **yAxis**?: [`AxisLabel`](../type-aliases/type-alias.AxisLabel.md)

Configuration for Y axis

# Interface AreamapChartDataOptions

Configuration for how to query aggregate data and assign data
to geographic features of an Areamap chart.

## Properties

### color

> **color**?: [[`CalculatedMeasureColumn`](../../sdk-data/interfaces/interface.CalculatedMeasureColumn.md) \| [`MeasureColumn`](../../sdk-data/interfaces/interface.MeasureColumn.md) \| [`StyledMeasureColumn`](interface.StyledMeasureColumn.md)]

Measure column (or measure) encoded by the color of the countries (or states) on the map.

***

### geo

> **geo**: [[`Column`](../../sdk-data/interfaces/interface.Column.md) \| [`StyledColumn`](interface.StyledColumn.md)]

Column or attribute representing the countries (or states) on the map.

# Interface AreamapChartProps

Props of the [AreamapChartComponent](../charts/class.AreamapChartComponent.md).

## Properties

Column or attribute representing the countries (or states) on the map.

# Interface AreamapChartProps

Props of the [AreamapChartComponent](../charts/class.AreamapChartComponent.md).

## Properties

### Data

#### dataSet

> **dataSet**?: [`Data`](../../sdk-data/interfaces/interface.Data.md) \| [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md)

Data set for a chart using one of the following options. If neither option is specified, the chart
will use the `defaultDataSource` specified in the parent `SisenseContextProvider`
component.

(1) Sisense data source name as a string. For example, `'Sample ECommerce'`. Typically, you
retrieve the data source name from a data model you create using the `get-data-model`
[command](https://developer.sisense.com/guides/sdk/guides/cli.html) of the Compose SDK CLI. The chart
connects to the data source, executes a query, and loads the data as specified in
`dataOptions`, `filters`, and `highlights`.

To learn more about using data from a Sisense data source, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#sisense-data).

OR

(2) Explicit [`Data`](../../sdk-data/interfaces/interface.Data.md), which is made up of an array of
[`Column`](../../sdk-data/interfaces/interface.Column.md) objects and a two-dimensional array of row data. This approach
allows the chart component to be used with any data you provide.

To learn more about using data from an external data source, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#explicit-data).

Example data in the proper format:

```ts
const sampleData = {
  columns: [
    { name: 'Years', type: 'date' },
    { name: 'Quantity', type: 'number' },
    { name: 'Units', type: 'number' },
  ],
  rows: [
    ['2019', 5500, 1500],
    ['2020', 4471, 7000],
    ['2021', 1812, 5000],
    ['2022', 5001, 6000],
    ['2023', 2045, 4000],
  ],
};
```

***

#### filters

> **filters**?: [`FilterRelations`](../../sdk-data/interfaces/interface.FilterRelations.md) \| [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Filters to limit (or slice) a chart’s data using one of the following options.

(1) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) or [FilterRelations](../../sdk-data/interfaces/interface.FilterRelations.md) returned from filter factory functions, such as
[`greaterThan()`](../../sdk-data/factories/namespace.filterFactory/functions/function.greaterThan.md) and [`members()`](../../sdk-data/factories/namespace.filterFactory/functions/function.members.md).

Use this option for filters that do not require a UI to set them
or for filters where you will supply your own UI components or use pre-built UI components. This is the most common option.

To learn more about using filter factory functions to create filters, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-functions).

(2) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) controlled by filter UI components – for example [`MemberFilterTile`](../../sdk-ui/filter-tiles/function.MemberFilterTile.md).

Use this option for filters that you want your users to set using pre-built UI components.

To learn more about using filter UI components to create filters, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components).

***

#### highlights

> **highlights**?: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Highlights based on filter criteria to apply to a chart using one of the following options.

NOTE that the filter dimensions used in highlights must match those defined in the
`dataOptions` of the chart. Otherwise, the filters will be applied as regular slice filters.

(1) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) returned from filter factory functions, such as
[`greaterThan()`](../../sdk-data/factories/namespace.filterFactory/functions/function.greaterThan.md) and [`members()`](../../sdk-data/factories/namespace.filterFactory/functions/function.members.md).

Use this option for highlights that do not require a UI to set them
or for highlights where you will supply your own UI components or use pre-built UI components. This is the most common option.

To learn more about using filter factory functions to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-functions-for-highlighting).

(2) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) controlled by filter UI components – for example [`MemberFilterTile`](../../sdk-ui/filter-tiles/function.MemberFilterTile.md).

Use this option for highlights that you want your users to set using pre-built UI components.

To learn more about using filter components to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components-for-highlighting).

ts.

To learn more about using filter components to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components-for-highlighting).

### Chart

#### dataOptions

> **dataOptions**: [`AreamapChartDataOptions`](interface.AreamapChartDataOptions.md)

Configurations for how to interpret and present the data passed to the chart

***

#### styleOptions

> **styleOptions**?: [`AreamapStyleOptions`](interface.AreamapStyleOptions.md)

Configurations for how to style and present a chart's data.

### Callbacks

#### dataPointClick

> **dataPointClick**?: [`AreamapDataPointEventHandler`](../type-aliases/type-alias.AreamapDataPointEventHandler.md)

Click handler callback for a data point

***

#### dataReady

> **dataReady**?: (`data`) => [`Data`](../../sdk-data/interfaces/interface.Data.md)

A callback that allows to modify data immediately after it has been retrieved.
It can be used to inject modification of queried data.

##### Parameters

| Parameter | Type |
| :------ | :------ |
| `data` | [`Data`](../../sdk-data/interfaces/interface.Data.md) |

##### Returns

[`Data`](../../sdk-data/interfaces/interface.Data.md)

# Interface AreamapStyleOptions

Configuration options that define functional style of the various elements of the AreamapChart component

## Properties

../../sdk-data/interfaces/interface.Data.md)

# Interface AreamapStyleOptions

Configuration options that define functional style of the various elements of the AreamapChart component

## Properties

### height

> **height**?: `number`

Total height of the component, which is considered in the following order of priority:

1. Value passed to this property (in pixels).
2. Height of the container wrapping this component
3. Default value of 400px (for component without header) or 425px (for component with header).

***

### mapType

> **mapType**?: [`AreamapType`](../../sdk-ui/type-aliases/type-alias.AreamapType.md)

Type of map to display on the AreamapChart component

***

### width

> **width**?: `number`

Total width of the component, which is considered in the following order of priority:

1. Value passed to this property (in pixels)
2. Width of the container wrapping this component
3. Default value of 400px

# Interface BarChartProps

Props of the [BarChartComponent](../charts/class.BarChartComponent.md).

## Properties

pixels)
2. Width of the container wrapping this component
3. Default value of 400px

# Interface BarChartProps

Props of the [BarChartComponent](../charts/class.BarChartComponent.md).

## Properties

### Data

#### dataSet

> **dataSet**?: [`Data`](../../sdk-data/interfaces/interface.Data.md) \| [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md)

Data set for a chart using one of the following options. If neither option is specified, the chart
will use the `defaultDataSource` specified in the parent `SisenseContextProvider`
component.

(1) Sisense data source name as a string. For example, `'Sample ECommerce'`. Typically, you
retrieve the data source name from a data model you create using the `get-data-model`
[command](https://developer.sisense.com/guides/sdk/guides/cli.html) of the Compose SDK CLI. The chart
connects to the data source, executes a query, and loads the data as specified in
`dataOptions`, `filters`, and `highlights`.

To learn more about using data from a Sisense data source, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#sisense-data).

OR

(2) Explicit [`Data`](../../sdk-data/interfaces/interface.Data.md), which is made up of an array of
[`Column`](../../sdk-data/interfaces/interface.Column.md) objects and a two-dimensional array of row data. This approach
allows the chart component to be used with any data you provide.

To learn more about using data from an external data source, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#explicit-data).

Example data in the proper format:

```ts
const sampleData = {
  columns: [
    { name: 'Years', type: 'date' },
    { name: 'Quantity', type: 'number' },
    { name: 'Units', type: 'number' },
  ],
  rows: [
    ['2019', 5500, 1500],
    ['2020', 4471, 7000],
    ['2021', 1812, 5000],
    ['2022', 5001, 6000],
    ['2023', 2045, 4000],
  ],
};
```

***

#### filters

> **filters**?: [`FilterRelations`](../../sdk-data/interfaces/interface.FilterRelations.md) \| [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Filters to limit (or slice) a chart’s data using one of the following options.

(1) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) or [FilterRelations](../../sdk-data/interfaces/interface.FilterRelations.md) returned from filter factory functions, such as
[`greaterThan()`](../../sdk-data/factories/namespace.filterFactory/functions/function.greaterThan.md) and [`members()`](../../sdk-data/factories/namespace.filterFactory/functions/function.members.md).

Use this option for filters that do not require a UI to set them
or for filters where you will supply your own UI components or use pre-built UI components. This is the most common option.

To learn more about using filter factory functions to create filters, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-functions).

(2) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) controlled by filter UI components – for example [`MemberFilterTile`](../../sdk-ui/filter-tiles/function.MemberFilterTile.md).

Use this option for filters that you want your users to set using pre-built UI components.

To learn more about using filter UI components to create filters, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components).

***

#### highlights

> **highlights**?: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Highlights based on filter criteria to apply to a chart using one of the following options.

NOTE that the filter dimensions used in highlights must match those defined in the
`dataOptions` of the chart. Otherwise, the filters will be applied as regular slice filters.

(1) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) returned from filter factory functions, such as
[`greaterThan()`](../../sdk-data/factories/namespace.filterFactory/functions/function.greaterThan.md) and [`members()`](../../sdk-data/factories/namespace.filterFactory/functions/function.members.md).

Use this option for highlights that do not require a UI to set them
or for highlights where you will supply your own UI components or use pre-built UI components. This is the most common option.

To learn more about using filter factory functions to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-functions-for-highlighting).

(2) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) controlled by filter UI components – for example [`MemberFilterTile`](../../sdk-ui/filter-tiles/function.MemberFilterTile.md).

Use this option for highlights that you want your users to set using pre-built UI components.

To learn more about using filter components to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components-for-highlighting).

ts.

To learn more about using filter components to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components-for-highlighting).

### Chart

#### dataOptions

> **dataOptions**: [`CartesianChartDataOptions`](interface.CartesianChartDataOptions.md)

Configurations for how to interpret and present a chart's data.

To learn more about using data options,
see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#dataoptions).

***

#### styleOptions

> **styleOptions**?: [`StackableStyleOptions`](interface.StackableStyleOptions.md)

Configurations for how to style and present a chart's data.

sdk-charts.html#dataoptions).

***

#### styleOptions

> **styleOptions**?: [`StackableStyleOptions`](interface.StackableStyleOptions.md)

Configurations for how to style and present a chart's data.

### Callbacks

#### beforeRender

> **beforeRender**?: [`BeforeRenderHandler`](../type-aliases/type-alias.BeforeRenderHandler.md)

A callback that allows you to customize the underlying chart element before it is rendered. The returned options are then used when rendering the chart.

This callback is not supported for Areamap Chart, Scattermap Chart, Table, and PivotTable.

***

#### dataPointClick

> **dataPointClick**?: [`DataPointEventHandler`](../type-aliases/type-alias.DataPointEventHandler.md)

Click handler callback for a data point

***

#### dataPointContextMenu

> **dataPointContextMenu**?: [`DataPointEventHandler`](../type-aliases/type-alias.DataPointEventHandler.md)

Context menu handler callback for a data point

***

#### dataPointsSelect

> **dataPointsSelect**?: [`DataPointsEventHandler`](../type-aliases/type-alias.DataPointsEventHandler.md)

Handler callback for selection of multiple data points

***

#### dataReady

> **dataReady**?: (`data`) => [`Data`](../../sdk-data/interfaces/interface.Data.md)

A callback that allows to modify data immediately after it has been retrieved.
It can be used to inject modification of queried data.

##### Parameters

| Parameter | Type |
| :------ | :------ |
| `data` | [`Data`](../../sdk-data/interfaces/interface.Data.md) |

##### Returns

[`Data`](../../sdk-data/interfaces/interface.Data.md)

##### Parameters

| Parameter | Type |
| :------ | :------ |
| `data` | [`Data`](../../sdk-data/interfaces/interface.Data.md) |

##### Returns

[`Data`](../../sdk-data/interfaces/interface.Data.md)

# Interface BoxplotChartProps

Props of the [BoxplotChartComponent](../charts/class.BoxplotChartComponent.md).

## Properties

|

##### Returns

[`Data`](../../sdk-data/interfaces/interface.Data.md)

# Interface BoxplotChartProps

Props of the [BoxplotChartComponent](../charts/class.BoxplotChartComponent.md).

## Properties

### Data

#### dataSet

> **dataSet**?: [`Data`](../../sdk-data/interfaces/interface.Data.md) \| [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md)

Data set for a chart using one of the following options. If neither option is specified, the chart
will use the `defaultDataSource` specified in the parent `SisenseContextProvider`
component.

(1) Sisense data source name as a string. For example, `'Sample ECommerce'`. Typically, you
retrieve the data source name from a data model you create using the `get-data-model`
[command](https://developer.sisense.com/guides/sdk/guides/cli.html) of the Compose SDK CLI. The chart
connects to the data source, executes a query, and loads the data as specified in
`dataOptions`, `filters`, and `highlights`.

To learn more about using data from a Sisense data source, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#sisense-data).

OR

(2) Explicit [`Data`](../../sdk-data/interfaces/interface.Data.md), which is made up of an array of
[`Column`](../../sdk-data/interfaces/interface.Column.md) objects and a two-dimensional array of row data. This approach
allows the chart component to be used with any data you provide.

To learn more about using data from an external data source, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#explicit-data).

Example data in the proper format:

```ts
const sampleData = {
  columns: [
    { name: 'Years', type: 'date' },
    { name: 'Quantity', type: 'number' },
    { name: 'Units', type: 'number' },
  ],
  rows: [
    ['2019', 5500, 1500],
    ['2020', 4471, 7000],
    ['2021', 1812, 5000],
    ['2022', 5001, 6000],
    ['2023', 2045, 4000],
  ],
};
```

***

#### filters

> **filters**?: [`FilterRelations`](../../sdk-data/interfaces/interface.FilterRelations.md) \| [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Filters to limit (or slice) a chart’s data using one of the following options.

(1) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) or [FilterRelations](../../sdk-data/interfaces/interface.FilterRelations.md) returned from filter factory functions, such as
[`greaterThan()`](../../sdk-data/factories/namespace.filterFactory/functions/function.greaterThan.md) and [`members()`](../../sdk-data/factories/namespace.filterFactory/functions/function.members.md).

Use this option for filters that do not require a UI to set them
or for filters where you will supply your own UI components or use pre-built UI components. This is the most common option.

To learn more about using filter factory functions to create filters, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-functions).

(2) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) controlled by filter UI components – for example [`MemberFilterTile`](../../sdk-ui/filter-tiles/function.MemberFilterTile.md).

Use this option for filters that you want your users to set using pre-built UI components.

To learn more about using filter UI components to create filters, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components).

***

#### highlights

> **highlights**?: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Highlights based on filter criteria to apply to a chart using one of the following options.

NOTE that the filter dimensions used in highlights must match those defined in the
`dataOptions` of the chart. Otherwise, the filters will be applied as regular slice filters.

(1) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) returned from filter factory functions, such as
[`greaterThan()`](../../sdk-data/factories/namespace.filterFactory/functions/function.greaterThan.md) and [`members()`](../../sdk-data/factories/namespace.filterFactory/functions/function.members.md).

Use this option for highlights that do not require a UI to set them
or for highlights where you will supply your own UI components or use pre-built UI components. This is the most common option.

To learn more about using filter factory functions to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-functions-for-highlighting).

(2) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) controlled by filter UI components – for example [`MemberFilterTile`](../../sdk-ui/filter-tiles/function.MemberFilterTile.md).

Use this option for highlights that you want your users to set using pre-built UI components.

To learn more about using filter components to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components-for-highlighting).

ts.

To learn more about using filter components to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components-for-highlighting).

### Chart

#### dataOptions

> **dataOptions**: [`BoxplotChartCustomDataOptions`](../type-aliases/type-alias.BoxplotChartCustomDataOptions.md) \| [`BoxplotChartDataOptions`](../type-aliases/type-alias.BoxplotChartDataOptions.md)

Configurations for how to interpret and present the data passed to the chart

***

#### styleOptions

> **styleOptions**?: [`BoxplotStyleOptions`](interface.BoxplotStyleOptions.md)

Configurations for how to style and present a chart's data.

sent the data passed to the chart

***

#### styleOptions

> **styleOptions**?: [`BoxplotStyleOptions`](interface.BoxplotStyleOptions.md)

Configurations for how to style and present a chart's data.

### Callbacks

#### beforeRender

> **beforeRender**?: [`BeforeRenderHandler`](../type-aliases/type-alias.BeforeRenderHandler.md)

A callback that allows you to customize the underlying chart element before it is rendered. The returned options are then used when rendering the chart.

This callback is not supported for Areamap Chart, Scattermap Chart, Table, and PivotTable.

***

#### dataPointClick

> **dataPointClick**?: [`BoxplotDataPointEventHandler`](../type-aliases/type-alias.BoxplotDataPointEventHandler.md)

Click handler callback for a data point

***

#### dataPointContextMenu

> **dataPointContextMenu**?: [`BoxplotDataPointEventHandler`](../type-aliases/type-alias.BoxplotDataPointEventHandler.md)

Context menu handler callback for a data point

***

#### dataPointsSelect

> **dataPointsSelect**?: [`DataPointsEventHandler`](../type-aliases/type-alias.DataPointsEventHandler.md)

Handler callback for selection of multiple data points

***

#### dataReady

> **dataReady**?: (`data`) => [`Data`](../../sdk-data/interfaces/interface.Data.md)

A callback that allows to modify data immediately after it has been retrieved.
It can be used to inject modification of queried data.

##### Parameters

| Parameter | Type |
| :------ | :------ |
| `data` | [`Data`](../../sdk-data/interfaces/interface.Data.md) |

##### Returns

[`Data`](../../sdk-data/interfaces/interface.Data.md)

##### Parameters

| Parameter | Type |
| :------ | :------ |
| `data` | [`Data`](../../sdk-data/interfaces/interface.Data.md) |

##### Returns

[`Data`](../../sdk-data/interfaces/interface.Data.md)

# Interface BoxplotStyleOptions

Configuration options that define functional style of the various elements of the BoxplotChart component

## Properties

### dataLimits

> **dataLimits**?: [`DataLimits`](interface.DataLimits.md)

Data limit for series or categories that will be plotted

***

### height

> **height**?: `number`

Total height of the component, which is considered in the following order of priority:

1. Value passed to this property (in pixels).
2. Height of the container wrapping this component
3. Default value of 400px (for component without header) or 425px (for component with header).

***

### legend

> **legend**?: [`LegendOptions`](../../sdk-ui/type-aliases/type-alias.LegendOptions.md)

Configuration for legend - a key that provides information about the data series or colors used in chart

***

### markers

> **markers**?: [`Markers`](../type-aliases/type-alias.Markers.md)

Configuration for markers - symbols or data points that highlight specific values

***

### navigator

> **navigator**?: [`Navigator`](../type-aliases/type-alias.Navigator.md)

Configuration for navigator - zoom/pan tool for large datasets in a chart

***

ighlight specific values

***

### navigator

> **navigator**?: [`Navigator`](../type-aliases/type-alias.Navigator.md)

Configuration for navigator - zoom/pan tool for large datasets in a chart

***

### seriesLabels

> **seriesLabels**?: [`SeriesLabels`](../type-aliases/type-alias.SeriesLabels.md)

Configuration for series labels - titles/names identifying data series in a chart

***

### subtype

> **subtype**?: [`BoxplotSubtype`](../type-aliases/type-alias.BoxplotSubtype.md)

Subtype of the BoxplotChart component

***

### width

> **width**?: `number`

Total width of the component, which is considered in the following order of priority:

1. Value passed to this property (in pixels)
2. Width of the container wrapping this component
3. Default value of 400px

***

### xAxis

> **xAxis**?: [`AxisLabel`](../type-aliases/type-alias.AxisLabel.md)

Configuration for X axis

***

### y2Axis

> **y2Axis**?: [`AxisLabel`](../type-aliases/type-alias.AxisLabel.md)

Configuration for second Y axis

***

### yAxis

> **yAxis**?: [`AxisLabel`](../type-aliases/type-alias.AxisLabel.md)

Configuration for Y axis

# Interface CalendarHeatmapChartDataOptions

Configuration for how to query aggregate data and assign data
to a calendar-heatmap chart.

## Properties

### date

> **date**: [`Column`](../../sdk-data/interfaces/interface.Column.md) \| [`StyledColumn`](interface.StyledColumn.md)

Date column representing dates on the calendar heatmap.

***

operties

### date

> **date**: [`Column`](../../sdk-data/interfaces/interface.Column.md) \| [`StyledColumn`](interface.StyledColumn.md)

Date column representing dates on the calendar heatmap.

***

### value

> **value**: [`CalculatedMeasureColumn`](../../sdk-data/interfaces/interface.CalculatedMeasureColumn.md) \| [`MeasureColumn`](../../sdk-data/interfaces/interface.MeasureColumn.md) \| [`StyledMeasureColumn`](interface.StyledMeasureColumn.md)

Measure column (or measure) assigned to the calendar cells.

# Interface CalendarHeatmapChartProps

Props of the [CalendarHeatmapChartComponent](../charts/class.CalendarHeatmapChartComponent.md) component.

## Properties

sure) assigned to the calendar cells.

# Interface CalendarHeatmapChartProps

Props of the [CalendarHeatmapChartComponent](../charts/class.CalendarHeatmapChartComponent.md) component.

## Properties

### Data

#### dataSet

> **dataSet**?: [`Data`](../../sdk-data/interfaces/interface.Data.md) \| [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md)

Data set for a chart using one of the following options. If neither option is specified, the chart
will use the `defaultDataSource` specified in the parent `SisenseContextProvider`
component.

(1) Sisense data source name as a string. For example, `'Sample ECommerce'`. Typically, you
retrieve the data source name from a data model you create using the `get-data-model`
[command](https://developer.sisense.com/guides/sdk/guides/cli.html) of the Compose SDK CLI. The chart
connects to the data source, executes a query, and loads the data as specified in
`dataOptions`, `filters`, and `highlights`.

To learn more about using data from a Sisense data source, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#sisense-data).

OR

(2) Explicit [`Data`](../../sdk-data/interfaces/interface.Data.md), which is made up of an array of
[`Column`](../../sdk-data/interfaces/interface.Column.md) objects and a two-dimensional array of row data. This approach
allows the chart component to be used with any data you provide.

To learn more about using data from an external data source, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#explicit-data).

Example data in the proper format:

```ts
const sampleData = {
  columns: [
    { name: 'Years', type: 'date' },
    { name: 'Quantity', type: 'number' },
    { name: 'Units', type: 'number' },
  ],
  rows: [
    ['2019', 5500, 1500],
    ['2020', 4471, 7000],
    ['2021', 1812, 5000],
    ['2022', 5001, 6000],
    ['2023', 2045, 4000],
  ],
};
```

***

#### filters

> **filters**?: [`FilterRelations`](../../sdk-data/interfaces/interface.FilterRelations.md) \| [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Filters to limit (or slice) a chart’s data using one of the following options.

(1) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) or [FilterRelations](../../sdk-data/interfaces/interface.FilterRelations.md) returned from filter factory functions, such as
[`greaterThan()`](../../sdk-data/factories/namespace.filterFactory/functions/function.greaterThan.md) and [`members()`](../../sdk-data/factories/namespace.filterFactory/functions/function.members.md).

Use this option for filters that do not require a UI to set them
or for filters where you will supply your own UI components or use pre-built UI components. This is the most common option.

To learn more about using filter factory functions to create filters, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-functions).

(2) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) controlled by filter UI components – for example [`MemberFilterTile`](../../sdk-ui/filter-tiles/function.MemberFilterTile.md).

Use this option for filters that you want your users to set using pre-built UI components.

To learn more about using filter UI components to create filters, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components).

***

#### highlights

> **highlights**?: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Highlights based on filter criteria to apply to a chart using one of the following options.

NOTE that the filter dimensions used in highlights must match those defined in the
`dataOptions` of the chart. Otherwise, the filters will be applied as regular slice filters.

(1) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) returned from filter factory functions, such as
[`greaterThan()`](../../sdk-data/factories/namespace.filterFactory/functions/function.greaterThan.md) and [`members()`](../../sdk-data/factories/namespace.filterFactory/functions/function.members.md).

Use this option for highlights that do not require a UI to set them
or for highlights where you will supply your own UI components or use pre-built UI components. This is the most common option.

To learn more about using filter factory functions to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-functions-for-highlighting).

(2) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) controlled by filter UI components – for example [`MemberFilterTile`](../../sdk-ui/filter-tiles/function.MemberFilterTile.md).

Use this option for highlights that you want your users to set using pre-built UI components.

To learn more about using filter components to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components-for-highlighting).

ts.

To learn more about using filter components to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components-for-highlighting).

### Chart

#### dataOptions

> **dataOptions**: [`CalendarHeatmapChartDataOptions`](interface.CalendarHeatmapChartDataOptions.md)

Configurations for how to interpret and present the data passed to the chart

***

#### styleOptions

> **styleOptions**?: [`CalendarHeatmapStyleOptions`](interface.CalendarHeatmapStyleOptions.md)

Configurations for how to style and present a chart's data.

ssed to the chart

***

#### styleOptions

> **styleOptions**?: [`CalendarHeatmapStyleOptions`](interface.CalendarHeatmapStyleOptions.md)

Configurations for how to style and present a chart's data.

### Callbacks

#### beforeRender

> **beforeRender**?: [`BeforeRenderHandler`](../type-aliases/type-alias.BeforeRenderHandler.md)

A callback that allows you to customize the underlying chart element before it is rendered. The returned options are then used when rendering the chart.

This callback is not supported for Areamap Chart, Scattermap Chart, Table, and PivotTable.

***

#### dataPointClick

> **dataPointClick**?: [`CalendarHeatmapDataPointEventHandler`](../type-aliases/type-alias.CalendarHeatmapDataPointEventHandler.md)

Click handler callback for a data point

***

#### dataPointContextMenu

> **dataPointContextMenu**?: [`CalendarHeatmapDataPointEventHandler`](../type-aliases/type-alias.CalendarHeatmapDataPointEventHandler.md)

Context menu handler callback for a data point

***

#### dataPointsSelect

> **dataPointsSelect**?: [`CalendarHeatmapDataPointsEventHandler`](../type-aliases/type-alias.CalendarHeatmapDataPointsEventHandler.md)

Handler callback for selection of multiple data points

***

#### dataReady

> **dataReady**?: (`data`) => [`Data`](../../sdk-data/interfaces/interface.Data.md)

A callback that allows to modify data immediately after it has been retrieved.
It can be used to inject modification of queried data.

##### Parameters

| Parameter | Type |
| :------ | :------ |
| `data` | [`Data`](../../sdk-data/interfaces/interface.Data.md) |

##### Returns

[`Data`](../../sdk-data/interfaces/interface.Data.md)

##### Parameters

| Parameter | Type |
| :------ | :------ |
| `data` | [`Data`](../../sdk-data/interfaces/interface.Data.md) |

##### Returns

[`Data`](../../sdk-data/interfaces/interface.Data.md)

# Interface CalendarHeatmapStyleOptions

Configuration options that define functional style of the various elements of calendar-heatmap chart

## Properties

### cellLabels

> **cellLabels**?: [`CalendarHeatmapCellLabels`](../../sdk-ui/type-aliases/type-alias.CalendarHeatmapCellLabels.md)

Configuration for day numbers (1-31) in calendar cells

***

### dayLabels

> **dayLabels**?: `object`

Configuration for weekday names in the header

#### Type declaration

> ##### `dayLabels.enabled`
>
> **enabled**?: `boolean`
>
> Boolean flag that defines if calendar weekday names should be shown
>
> ###### Default
>
> ```ts
> true
> ```
>
> ##### `dayLabels.style`
>
> **style**?: [`TextStyle`](../../sdk-ui/type-aliases/type-alias.TextStyle.md)
>
> Style configuration for calendar weekday names
>
> ::: warning Deprecated
> Please use `textStyle` instead
> :::
>
> ##### `dayLabels.textStyle`
>
> **textStyle**?: [`TextStyle`](../../sdk-ui/type-aliases/type-alias.TextStyle.md)
>
> Style configuration for calendar weekday names
>
>

***

tStyle` instead
> :::
>
> ##### `dayLabels.textStyle`
>
> **textStyle**?: [`TextStyle`](../../sdk-ui/type-aliases/type-alias.TextStyle.md)
>
> Style configuration for calendar weekday names
>
>

***

### height

> **height**?: `number`

Total height of the component, which is considered in the following order of priority:

1. Value passed to this property (in pixels).
2. Height of the container wrapping this component
3. Default value of 400px (for component without header) or 425px (for component with header).

***

### monthLabels

> **monthLabels**?: `object`

Configuration for month names in multi-month view types

#### Type declaration

> ##### `monthLabels.enabled`
>
> **enabled**?: `boolean`
>
> Boolean flag that defines if month names should be shown
>
> ###### Default
>
> ```ts
> true
> ```
>
> ##### `monthLabels.style`
>
> **style**?: [`TextStyle`](../../sdk-ui/type-aliases/type-alias.TextStyle.md)
>
> Style configuration for month names
>
> ::: warning Deprecated
> Please use `textStyle` instead
> :::
>
> ##### `monthLabels.textStyle`
>
> **textStyle**?: [`TextStyle`](../../sdk-ui/type-aliases/type-alias.TextStyle.md)
>
> Style configuration for month names
>
>

***

use `textStyle` instead
> :::
>
> ##### `monthLabels.textStyle`
>
> **textStyle**?: [`TextStyle`](../../sdk-ui/type-aliases/type-alias.TextStyle.md)
>
> Style configuration for month names
>
>

***

### pagination

> **pagination**?: `object`

Configuration for pagination controls in multi-month view types

#### Type declaration

> ##### `pagination.enabled`
>
> **enabled**?: `boolean`
>
> Boolean flag that defines if pagination controls should be shown
>
> ###### Default
>
> ```ts
> true
> ```
>
> ##### `pagination.startMonth`
>
> **startMonth**?: `Date`
>
> Start month to display when the chart is first rendered
>
> ##### `pagination.textStyle`
>
> **textStyle**?: [`TextStyle`](../../sdk-ui/type-aliases/type-alias.TextStyle.md)
>
> Style configuration for pagination controls text
>
>

***

### startOfWeek

> **startOfWeek**?: [`CalendarDayOfWeek`](../type-aliases/type-alias.CalendarDayOfWeek.md)

Determines which day of the week to start the calendar with

#### Default

```ts
'sunday'
```

***

### subtype

> **subtype**?: [`CalendarHeatmapSubtype`](../type-aliases/type-alias.CalendarHeatmapSubtype.md)

Calendar heatmap chart subtype

#### Default

```ts
'calendar-heatmap/split'
```

***

### viewType

> **viewType**?: [`CalendarHeatmapViewType`](../type-aliases/type-alias.CalendarHeatmapViewType.md)

View type determines how many months to display: 'month' (1), 'quarter' (3), 'half-year' (6), 'year' (12)

***

*?: [`CalendarHeatmapViewType`](../type-aliases/type-alias.CalendarHeatmapViewType.md)

View type determines how many months to display: 'month' (1), 'quarter' (3), 'half-year' (6), 'year' (12)

***

### weekends

> **weekends**?: `object`

Configuration for weekend days

#### Type declaration

> ##### `weekends.cellColor`
>
> **cellColor**?: `string`
>
> Calendar cell color for weekend days
>
> ###### Default
>
> ```ts
> '#e6e6e6'
> ```
>
> ##### `weekends.days`
>
> **days**?: [`CalendarDayOfWeek`](../type-aliases/type-alias.CalendarDayOfWeek.md)[]
>
> Weekend days - defaults to ['saturday', 'sunday']
>
> ##### `weekends.enabled`
>
> **enabled**?: `boolean`
>
> Boolean flag that enables/disables weekend highlighting
>
> ###### Default
>
> ```ts
> false
> ```
>
> ##### `weekends.hideValues`
>
> **hideValues**?: `boolean`
>
> Whether to hide values in tooltip for weekend days
>
> ###### Default
>
> ```ts
> false
> ```
>
>

***

### width

> **width**?: `number`

Total width of the component, which is considered in the following order of priority:

1. Value passed to this property (in pixels)
2. Width of the container wrapping this component
3. Default value of 400px

# Interface CartesianChartDataOptions

Configuration for how to query aggregate data and assign data
to axes of a [Cartesian chart](../type-aliases/type-alias.CartesianChartType.md).

These charts can include multiple values on both the X and Y-axis,
as well as a break-down by categories displayed on the Y-axis.

Cartesian chart](../type-aliases/type-alias.CartesianChartType.md).

These charts can include multiple values on both the X and Y-axis,
as well as a break-down by categories displayed on the Y-axis.

## Properties

### breakBy

> **breakBy**: ([`Column`](../../sdk-data/interfaces/interface.Column.md) \| [`StyledColumn`](interface.StyledColumn.md))[]

Columns (or attributes) by which to break (group) the data represented in the chart.

Each group is represented by a different visual encoding - for example, color of bars in a bar chart,
and is automatically added to the chart's legend.

***

### category

> **category**: ([`Column`](../../sdk-data/interfaces/interface.Column.md) \| [`StyledColumn`](interface.StyledColumn.md))[]

Columns (or attributes) whose values are placed on the X-axis.

Typically, the X-axis represents descriptive data.

***

### seriesToColorMap

> **seriesToColorMap**?: [`ValueToColorMap`](../type-aliases/type-alias.ValueToColorMap.md)

Optional mapping of each of the series to colors.

***

### value

> **value**: ([`CalculatedMeasureColumn`](../../sdk-data/interfaces/interface.CalculatedMeasureColumn.md) \| [`MeasureColumn`](../../sdk-data/interfaces/interface.MeasureColumn.md) \| [`StyledMeasureColumn`](interface.StyledMeasureColumn.md))[]

Measure columns (or measures) whose values are scaled to the Y-axis of the chart.

Each measure is represented as a series in the chart.

[`StyledMeasureColumn`](interface.StyledMeasureColumn.md))[]

Measure columns (or measures) whose values are scaled to the Y-axis of the chart.

Each measure is represented as a series in the chart.

# Interface CategoricalChartDataOptions

Configuration for how to query aggregate data and assign data
to a [Categorical chart](../type-aliases/type-alias.CategoricalChartType.md).

## Properties

### category

> **category**: ([`Column`](../../sdk-data/interfaces/interface.Column.md) \| [`StyledColumn`](interface.StyledColumn.md))[]

Columns (or attributes) whose values represent categories in the chart.

For funnel charts, only the first 50 categories will be used.

***

### seriesToColorMap

> **seriesToColorMap**?: [`MultiColumnValueToColorMap`](../type-aliases/type-alias.MultiColumnValueToColorMap.md) \| [`ValueToColorMap`](../type-aliases/type-alias.ValueToColorMap.md)

Optional mapping of each of the series to colors.
([MultiColumnValueToColorMap](../type-aliases/type-alias.MultiColumnValueToColorMap.md) used only for the Sunburst Chart component)

***

lorMap.md)

Optional mapping of each of the series to colors.
([MultiColumnValueToColorMap](../type-aliases/type-alias.MultiColumnValueToColorMap.md) used only for the Sunburst Chart component)

***

### value

> **value**: ([`CalculatedMeasureColumn`](../../sdk-data/interfaces/interface.CalculatedMeasureColumn.md) \| [`MeasureColumn`](../../sdk-data/interfaces/interface.MeasureColumn.md) \| [`StyledMeasureColumn`](interface.StyledMeasureColumn.md))[]

Measure columns (or measures) whose values are scaled to visual elements of the chart.
For example, the size of the pie slices of a pie chart.

Values are typically used to represent numeric data.

# Interface ChartProps

Props shared across the [ChartComponent](../charts/class.ChartComponent.md).

## Properties

pie slices of a pie chart.

Values are typically used to represent numeric data.

# Interface ChartProps

Props shared across the [ChartComponent](../charts/class.ChartComponent.md).

## Properties

### Data

#### dataSet

> **dataSet**?: [`Data`](../../sdk-data/interfaces/interface.Data.md) \| [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md)

Data set for a chart using one of the following options. If neither option is specified, the chart
will use the `defaultDataSource` specified in the parent `SisenseContextProvider`
component.

(1) Sisense data source name as a string. For example, `'Sample ECommerce'`. Typically, you
retrieve the data source name from a data model you create using the `get-data-model`
[command](https://developer.sisense.com/guides/sdk/guides/cli.html) of the Compose SDK CLI. The chart
connects to the data source, executes a query, and loads the data as specified in
`dataOptions`, `filters`, and `highlights`.

To learn more about using data from a Sisense data source, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#sisense-data).

OR

(2) Explicit [`Data`](../../sdk-data/interfaces/interface.Data.md), which is made up of an array of
[`Column`](../../sdk-data/interfaces/interface.Column.md) objects and a two-dimensional array of row data. This approach
allows the chart component to be used with any data you provide.

To learn more about using data from an external data source, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#explicit-data).

Example data in the proper format:

```ts
const sampleData = {
  columns: [
    { name: 'Years', type: 'date' },
    { name: 'Quantity', type: 'number' },
    { name: 'Units', type: 'number' },
  ],
  rows: [
    ['2019', 5500, 1500],
    ['2020', 4471, 7000],
    ['2021', 1812, 5000],
    ['2022', 5001, 6000],
    ['2023', 2045, 4000],
  ],
};
```

***

#### filters

> **filters**?: [`FilterRelations`](../../sdk-data/interfaces/interface.FilterRelations.md) \| [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Filters to limit (or slice) a chart’s data using one of the following options.

(1) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) or [FilterRelations](../../sdk-data/interfaces/interface.FilterRelations.md) returned from filter factory functions, such as
[`greaterThan()`](../../sdk-data/factories/namespace.filterFactory/functions/function.greaterThan.md) and [`members()`](../../sdk-data/factories/namespace.filterFactory/functions/function.members.md).

Use this option for filters that do not require a UI to set them
or for filters where you will supply your own UI components or use pre-built UI components. This is the most common option.

To learn more about using filter factory functions to create filters, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-functions).

(2) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) controlled by filter UI components – for example [`MemberFilterTile`](../../sdk-ui/filter-tiles/function.MemberFilterTile.md).

Use this option for filters that you want your users to set using pre-built UI components.

To learn more about using filter UI components to create filters, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components).

***

#### highlights

> **highlights**?: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Highlights based on filter criteria to apply to a chart using one of the following options.

NOTE that the filter dimensions used in highlights must match those defined in the
`dataOptions` of the chart. Otherwise, the filters will be applied as regular slice filters.

(1) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) returned from filter factory functions, such as
[`greaterThan()`](../../sdk-data/factories/namespace.filterFactory/functions/function.greaterThan.md) and [`members()`](../../sdk-data/factories/namespace.filterFactory/functions/function.members.md).

Use this option for highlights that do not require a UI to set them
or for highlights where you will supply your own UI components or use pre-built UI components. This is the most common option.

To learn more about using filter factory functions to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-functions-for-highlighting).

(2) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) controlled by filter UI components – for example [`MemberFilterTile`](../../sdk-ui/filter-tiles/function.MemberFilterTile.md).

Use this option for highlights that you want your users to set using pre-built UI components.

To learn more about using filter components to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components-for-highlighting).

ts.

To learn more about using filter components to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components-for-highlighting).

### Chart

#### chartType

> **chartType**: [`ChartType`](../type-aliases/type-alias.ChartType.md)

Default chart type of each series.

***

#### dataOptions

> **dataOptions**: [`ChartDataOptions`](../type-aliases/type-alias.ChartDataOptions.md)

Configurations for how to interpret and present a chart's data.

To learn more about using data options,
see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#dataoptions).

***

#### styleOptions

> **styleOptions**?: [`ChartStyleOptions`](../type-aliases/type-alias.ChartStyleOptions.md)

Configurations for how to style and present a chart's data.

To learn more about using style options,
see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#styleoptions).

tions for how to style and present a chart's data.

To learn more about using style options,
see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#styleoptions).

### Callbacks

#### beforeRender

> **beforeRender**?: [`BeforeRenderHandler`](../type-aliases/type-alias.BeforeRenderHandler.md) \| [`IndicatorBeforeRenderHandler`](../type-aliases/type-alias.IndicatorBeforeRenderHandler.md)

A callback that allows you to customize the underlying chart element before it is rendered. The returned options are then used when rendering the chart.

This callback is not supported for Areamap Chart, Scattermap Chart, Table, and PivotTable.

***

#### dataPointClick

> **dataPointClick**?: [`ChartDataPointClickEventHandler`](../type-aliases/type-alias.ChartDataPointClickEventHandler.md)

Click handler callback for a data point

***

#### dataPointContextMenu

> **dataPointContextMenu**?: [`ChartDataPointContextMenuEventHandler`](../type-aliases/type-alias.ChartDataPointContextMenuEventHandler.md)

Context menu handler callback for a data point

***

#### dataPointsSelect

> **dataPointsSelect**?: [`ChartDataPointsEventHandler`](../type-aliases/type-alias.ChartDataPointsEventHandler.md)

Handler callback for selection of multiple data points

***

#### dataReady

> **dataReady**?: (`data`) => [`Data`](../../sdk-data/interfaces/interface.Data.md)

A callback that allows to modify data immediately after it has been retrieved.
It can be used to inject modification of queried data.

##### Parameters

| Parameter | Type |
| :------ | :------ |
| `data` | [`Data`](../../sdk-data/interfaces/interface.Data.md) |

##### Returns

[`Data`](../../sdk-data/interfaces/interface.Data.md)

##### Parameters

| Parameter | Type |
| :------ | :------ |
| `data` | [`Data`](../../sdk-data/interfaces/interface.Data.md) |

##### Returns

[`Data`](../../sdk-data/interfaces/interface.Data.md)

# Interface ChartWidgetProps

Props of the [ChartWidgetComponent](../dashboards/class.ChartWidgetComponent.md).

## Properties

### Data

#### dataSource

> **dataSource**?: [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md)

Data source the query is run against - e.g. `Sample ECommerce`

If not specified, the query will use the `defaultDataSource` specified in the parent Sisense Context.

***

#### filters

> **filters**?: [`FilterRelations`](../../sdk-data/interfaces/interface.FilterRelations.md) \| [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Filters that will slice query results

***

#### highlights

> **highlights**?: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Highlight filters that will highlight results that pass filter criteria

### Chart

#### chartType

> **chartType**: [`ChartType`](../type-aliases/type-alias.ChartType.md)

Default chart type of each series

***

#### dataOptions

> **dataOptions**: [`ChartDataOptions`](../type-aliases/type-alias.ChartDataOptions.md)

Configurations for how to interpret and present the data passed to the chart

h series

***

#### dataOptions

> **dataOptions**: [`ChartDataOptions`](../type-aliases/type-alias.ChartDataOptions.md)

Configurations for how to interpret and present the data passed to the chart

### Widget

#### description

> **description**?: `string`

Description of the widget

***

#### drilldownOptions

> **drilldownOptions**?: [`DrilldownOptions`](../type-aliases/type-alias.DrilldownOptions.md)

List of categories to allow drilldowns on

***

#### highlightSelectionDisabled

> **highlightSelectionDisabled**?: `boolean`

Boolean flag whether selecting data points triggers highlight filter of the selected data

Recommended to turn on when the Chart Widget component is enhanced with data drilldown by the Drilldown Widget component

If not specified, the default value is `false`

***

#### styleOptions

> **styleOptions**?: [`ChartWidgetStyleOptions`](../type-aliases/type-alias.ChartWidgetStyleOptions.md)

Style options for both the chart and widget including the widget header

***

#### title

> **title**?: `string`

Title of the widget

ptions`](../type-aliases/type-alias.ChartWidgetStyleOptions.md)

Style options for both the chart and widget including the widget header

***

#### title

> **title**?: `string`

Title of the widget

### Callbacks

#### beforeRender

> **beforeRender**?: [`BeforeRenderHandler`](../type-aliases/type-alias.BeforeRenderHandler.md) \| [`IndicatorBeforeRenderHandler`](../type-aliases/type-alias.IndicatorBeforeRenderHandler.md)

A callback that allows you to customize the underlying chart element before it is rendered. The returned options are then used when rendering the chart.

This callback is not supported for Areamap Chart, Scattermap Chart, Table, and PivotTable.

***

#### dataPointClick

> **dataPointClick**?: [`ChartDataPointClickEventHandler`](../type-aliases/type-alias.ChartDataPointClickEventHandler.md)

Click handler callback for a data point

***

#### dataPointContextMenu

> **dataPointContextMenu**?: [`ChartDataPointContextMenuEventHandler`](../type-aliases/type-alias.ChartDataPointContextMenuEventHandler.md)

Context menu handler callback for a data point

***

#### dataPointsSelect

> **dataPointsSelect**?: [`ChartDataPointsEventHandler`](../type-aliases/type-alias.ChartDataPointsEventHandler.md)

Handler callback for selection of multiple data points

***

#### dataReady

> **dataReady**?: (`data`) => [`Data`](../../sdk-data/interfaces/interface.Data.md)

A callback that allows to modify data immediately after it has been retrieved.
It can be used to inject modification of queried data.

##### Parameters

| Parameter | Type |
| :------ | :------ |
| `data` | [`Data`](../../sdk-data/interfaces/interface.Data.md) |

##### Returns

[`Data`](../../sdk-data/interfaces/interface.Data.md)

##### Parameters

| Parameter | Type |
| :------ | :------ |
| `data` | [`Data`](../../sdk-data/interfaces/interface.Data.md) |

##### Returns

[`Data`](../../sdk-data/interfaces/interface.Data.md)

# Interface ChatConfig

## Properties

### customPrompt

> **customPrompt**?: `string`

Pass a custom prompt to AI when generating query recommendations

e.g. "Focus on age range"

***

### dataTopicsList

> **dataTopicsList**?: `string`[]

List of titles representing allowed contexts (data models or perspectives) for a chat session.

Each context will be validated and checked for availability.
If only one context is specified, the data topic selector screen will not be shown.

***

### enableFollowupQuestions

> **enableFollowupQuestions**: `boolean`

Boolean flag to show or hide suggested questions following a chat response. Currently
follow-up questions are still under development and are not validated. Therefore, follow-up
questions are disabled by default.

***

w or hide suggested questions following a chat response. Currently
follow-up questions are still under development and are not validated. Therefore, follow-up
questions are disabled by default.

***

### hideHistory

> **hideHistory**?: `boolean`

Boolean flag to hide chat history on every load.

Note: When the flag is `true`, chat history will be preserved and stored for the session but will not be displayed. Changing this setting back to `false` will make the entire history visible again, even if it was previously hidden. Use the "Clear History" button to completely erase the history.

#### Default

```ts
false
```

::: warning Deprecated
This flag is deprecated and will be removed in a future version. Use [@sisense/sdk-ui!AiContextProviderProps.volatile](../../sdk-ui/interfaces/interface.AiContextProviderProps.md#volatile) instead.
:::

***

### inputPromptText

> **inputPromptText**?: `string`

The input prompt text to show in the chat input box

***

### numOfRecentPrompts

> **numOfRecentPrompts**: `number`

Number of recent prompts that should be shown in a chat session

If not specified, the default value is `5`

***

### numOfRecommendations

> **numOfRecommendations**: `number`

Number of recommended queries that should initially be shown in a chat session

If not specified, the default value is `4`.

Set to `0` to disable initial recommendations.

***

ndations**: `number`

Number of recommended queries that should initially be shown in a chat session

If not specified, the default value is `4`.

Set to `0` to disable initial recommendations.

***

### suggestionsWelcomeText

> **suggestionsWelcomeText**?: `false` \| `string`

The message text to show above the initial suggested questions in a chat session.

A value of `false` will hide the text.

If not specified, a default message will be displayed.

***

### welcomeText

> **welcomeText**?: `false` \| `string`

The welcome text to show at the top of a chat session.

A value of `false` will hide the welcome text.

If not specified, a default message will be displayed.

# Interface ChatbotProps

Props of the [ChatbotComponent](../generative-ai/class.ChatbotComponent.md).

## Properties

### config

> **config**?: `Partial`\< [`ChatConfig`](interface.ChatConfig.md) \>

Various configuration options for the chatbot

***

### height

> **height**?: `Height`\< `number` \| `string` \>

Total height of the chatbot

If not specified, a default height of `900px` will be used.

***

### width

> **width**?: `Width`\< `number` \| `string` \>

Total width of the chatbot

If not specified, a default width of `500px` will be used.

# Interface ColumnChartProps

Props of the [ColumnChartComponent](../charts/class.ColumnChartComponent.md).

## Properties

of the chatbot

If not specified, a default width of `500px` will be used.

# Interface ColumnChartProps

Props of the [ColumnChartComponent](../charts/class.ColumnChartComponent.md).

## Properties

### Data

#### dataSet

> **dataSet**?: [`Data`](../../sdk-data/interfaces/interface.Data.md) \| [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md)

Data set for a chart using one of the following options. If neither option is specified, the chart
will use the `defaultDataSource` specified in the parent `SisenseContextProvider`
component.

(1) Sisense data source name as a string. For example, `'Sample ECommerce'`. Typically, you
retrieve the data source name from a data model you create using the `get-data-model`
[command](https://developer.sisense.com/guides/sdk/guides/cli.html) of the Compose SDK CLI. The chart
connects to the data source, executes a query, and loads the data as specified in
`dataOptions`, `filters`, and `highlights`.

To learn more about using data from a Sisense data source, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#sisense-data).

OR

(2) Explicit [`Data`](../../sdk-data/interfaces/interface.Data.md), which is made up of an array of
[`Column`](../../sdk-data/interfaces/interface.Column.md) objects and a two-dimensional array of row data. This approach
allows the chart component to be used with any data you provide.

To learn more about using data from an external data source, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#explicit-data).

Example data in the proper format:

```ts
const sampleData = {
  columns: [
    { name: 'Years', type: 'date' },
    { name: 'Quantity', type: 'number' },
    { name: 'Units', type: 'number' },
  ],
  rows: [
    ['2019', 5500, 1500],
    ['2020', 4471, 7000],
    ['2021', 1812, 5000],
    ['2022', 5001, 6000],
    ['2023', 2045, 4000],
  ],
};
```

***

#### filters

> **filters**?: [`FilterRelations`](../../sdk-data/interfaces/interface.FilterRelations.md) \| [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Filters to limit (or slice) a chart’s data using one of the following options.

(1) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) or [FilterRelations](../../sdk-data/interfaces/interface.FilterRelations.md) returned from filter factory functions, such as
[`greaterThan()`](../../sdk-data/factories/namespace.filterFactory/functions/function.greaterThan.md) and [`members()`](../../sdk-data/factories/namespace.filterFactory/functions/function.members.md).

Use this option for filters that do not require a UI to set them
or for filters where you will supply your own UI components or use pre-built UI components. This is the most common option.

To learn more about using filter factory functions to create filters, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-functions).

(2) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) controlled by filter UI components – for example [`MemberFilterTile`](../../sdk-ui/filter-tiles/function.MemberFilterTile.md).

Use this option for filters that you want your users to set using pre-built UI components.

To learn more about using filter UI components to create filters, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components).

***

#### highlights

> **highlights**?: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Highlights based on filter criteria to apply to a chart using one of the following options.

NOTE that the filter dimensions used in highlights must match those defined in the
`dataOptions` of the chart. Otherwise, the filters will be applied as regular slice filters.

(1) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) returned from filter factory functions, such as
[`greaterThan()`](../../sdk-data/factories/namespace.filterFactory/functions/function.greaterThan.md) and [`members()`](../../sdk-data/factories/namespace.filterFactory/functions/function.members.md).

Use this option for highlights that do not require a UI to set them
or for highlights where you will supply your own UI components or use pre-built UI components. This is the most common option.

To learn more about using filter factory functions to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-functions-for-highlighting).

(2) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) controlled by filter UI components – for example [`MemberFilterTile`](../../sdk-ui/filter-tiles/function.MemberFilterTile.md).

Use this option for highlights that you want your users to set using pre-built UI components.

To learn more about using filter components to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components-for-highlighting).

ts.

To learn more about using filter components to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components-for-highlighting).

### Chart

#### dataOptions

> **dataOptions**: [`CartesianChartDataOptions`](interface.CartesianChartDataOptions.md)

Configurations for how to interpret and present a chart's data.

To learn more about using data options,
see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#dataoptions).

***

#### styleOptions

> **styleOptions**?: [`StackableStyleOptions`](interface.StackableStyleOptions.md)

Configurations for how to style and present a chart's data.

sdk-charts.html#dataoptions).

***

#### styleOptions

> **styleOptions**?: [`StackableStyleOptions`](interface.StackableStyleOptions.md)

Configurations for how to style and present a chart's data.

### Callbacks

#### beforeRender

> **beforeRender**?: [`BeforeRenderHandler`](../type-aliases/type-alias.BeforeRenderHandler.md)

A callback that allows you to customize the underlying chart element before it is rendered. The returned options are then used when rendering the chart.

This callback is not supported for Areamap Chart, Scattermap Chart, Table, and PivotTable.

***

#### dataPointClick

> **dataPointClick**?: [`DataPointEventHandler`](../type-aliases/type-alias.DataPointEventHandler.md)

Click handler callback for a data point

***

#### dataPointContextMenu

> **dataPointContextMenu**?: [`DataPointEventHandler`](../type-aliases/type-alias.DataPointEventHandler.md)

Context menu handler callback for a data point

***

#### dataPointsSelect

> **dataPointsSelect**?: [`DataPointsEventHandler`](../type-aliases/type-alias.DataPointsEventHandler.md)

Handler callback for selection of multiple data points

***

#### dataReady

> **dataReady**?: (`data`) => [`Data`](../../sdk-data/interfaces/interface.Data.md)

A callback that allows to modify data immediately after it has been retrieved.
It can be used to inject modification of queried data.

##### Parameters

| Parameter | Type |
| :------ | :------ |
| `data` | [`Data`](../../sdk-data/interfaces/interface.Data.md) |

##### Returns

[`Data`](../../sdk-data/interfaces/interface.Data.md)

##### Parameters

| Parameter | Type |
| :------ | :------ |
| `data` | [`Data`](../../sdk-data/interfaces/interface.Data.md) |

##### Returns

[`Data`](../../sdk-data/interfaces/interface.Data.md)

# Interface ComposableDashboardProps

## Properties

### config

> **config**?: [`DashboardConfig`](interface.DashboardConfig.md)

The configuration for the dashboard

***

### filters

> **filters**?: [`FilterRelations`](../../sdk-data/interfaces/interface.FilterRelations.md) \| [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

The dashboard filters to be applied to each of the widgets based on the widget filter options

***

### layoutOptions

> **layoutOptions**?: [`DashboardLayoutOptions`](interface.DashboardLayoutOptions.md)

Dashboard layout options

***

### widgets

> **widgets**: [`WidgetProps`](../type-aliases/type-alias.WidgetProps.md)[]

***

### widgetsOptions

> **widgetsOptions**?: [`WidgetsOptions`](../type-aliases/type-alias.WidgetsOptions.md)

The options for each of the widgets

# Interface CriteriaFilterTileProps

Props of the [CriteriaFilterTileComponent](../filter-tiles/class.CriteriaFilterTileComponent.md).

## Properties

### arrangement

> **arrangement**?: [`FilterVariant`](../type-aliases/type-alias.FilterVariant.md)

Arrangement of the filter inputs. Use vertical for standard filter tiles and horizontal for toolbars

***

ngement

> **arrangement**?: [`FilterVariant`](../type-aliases/type-alias.FilterVariant.md)

Arrangement of the filter inputs. Use vertical for standard filter tiles and horizontal for toolbars

***

### filter

> **filter**: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)

Text or numeric filter object to initialize filter type and default values

***

### filterChange

> **filterChange**?: (`filter`) => `void`

#### Parameters

| Parameter | Type |
| :------ | :------ |
| `filter` | [`Filter`](../../sdk-data/interfaces/interface.Filter.md) |

#### Returns

`void`

***

### measures

> **measures**?: [`Measure`](../../sdk-data/interfaces/interface.Measure.md)[]

List of available measures to rank by. Required only for ranking filters.

***

### onDelete

> **onDelete**?: () => `void`

Filter delete callback

#### Returns

`void`

***

### onEdit

> **onEdit**?: () => `void`

Filter edit callback

#### Returns

`void`

***

### title

> **title**: `string`

Title for the filter tile, which is rendered into the header

# Interface CustomWidgetComponentProps`<DataOptions, StyleOptions, DataPoint>`

Props passed to a user-defined custom widget component.

Title for the filter tile, which is rendered into the header

# Interface CustomWidgetComponentProps`<DataOptions, StyleOptions, DataPoint>`

Props passed to a user-defined custom widget component.

## Example

```ts
import { Component, Input } from '@angular/core';
import {
  CustomWidgetComponentProps,
  CustomWidgetsService,
  GenericDataOptions,
  AbstractDataPointWithEntries,
  DataPointEntry,
  StyledColumn,
  StyledMeasureColumn,
} from '@sisense/sdk-ui-angular';
import type { DataSource, Filter, FilterRelations } from '@sisense/sdk-data';

interface MyDataOptions extends GenericDataOptions {
  category: StyledColumn[];
  value: StyledMeasureColumn[];
}

interface MyDataPoint extends AbstractDataPointWithEntries {
  entries: {
    category: DataPointEntry[];
    value: DataPointEntry[];
  };
}

type MyWidgetProps = CustomWidgetComponentProps<MyDataOptions, object, MyDataPoint>;

@Component({
  selector: 'app-my-widget',
  template: `<div>My Custom Widget</div>`,
})
export class MyWidgetComponent implements MyWidgetProps {
  @Input() dataOptions!: MyDataOptions;
  @Input() dataSource?: DataSource;
  @Input() styleOptions?: object;
  @Input() filters?: Filter[] | FilterRelations;
  @Input() highlights?: Filter[];
  @Input() description?: string;
  @Input() onDataPointClick?: (point: MyDataPoint, nativeEvent: MouseEvent) => void;
  @Input() onDataPointContextMenu?: (point: MyDataPoint, nativeEvent: MouseEvent) => void;
  @Input() onDataPointsSelected?: (points: MyDataPoint[], nativeEvent: MouseEvent) => void;
}

// In AppModule or a component, register the custom widget:
constructor(private customWidgets: CustomWidgetsService) {
  this.customWidgets.registerCustomWidget('my-widget', MyWidgetComponent);
}
```

/ In AppModule or a component, register the custom widget:
constructor(private customWidgets: CustomWidgetsService) {
  this.customWidgets.registerCustomWidget('my-widget', MyWidgetComponent);
}
```

## Type parameters

| Parameter | Default | Description |
| :------ | :------ | :------ |
| `DataOptions` | [`GenericDataOptions`](../type-aliases/type-alias.GenericDataOptions.md) | The shape of data options for this custom widget |
| `StyleOptions` | [`CustomWidgetStyleOptions`](../../sdk-ui/type-aliases/type-alias.CustomWidgetStyleOptions.md) | The shape of style options for this custom widget |
| `DataPoint` *extends* [`AbstractDataPointWithEntries`](../../sdk-ui/type-aliases/type-alias.AbstractDataPointWithEntries.md) | [`AbstractDataPointWithEntries`](../../sdk-ui/type-aliases/type-alias.AbstractDataPointWithEntries.md) | The shape of data points for event handlers |

## Properties

stractDataPointWithEntries.md) | [`AbstractDataPointWithEntries`](../../sdk-ui/type-aliases/type-alias.AbstractDataPointWithEntries.md) | The shape of data points for event handlers |

## Properties

### Callbacks

#### onDataPointClick

> **onDataPointClick**?: [`CustomWidgetDataPointEventHandler`](../../sdk-ui/type-aliases/type-alias.CustomWidgetDataPointEventHandler.md)\< `DataPoint` \>

Click handler callback for a data point

***

#### onDataPointContextMenu

> **onDataPointContextMenu**?: [`CustomWidgetDataPointContextMenuHandler`](../../sdk-ui/type-aliases/type-alias.CustomWidgetDataPointContextMenuHandler.md)\< `DataPoint` \>

Context menu handler callback for a data point

***

#### onDataPointsSelected

> **onDataPointsSelected**?: [`CustomWidgetDataPointsEventHandler`](../../sdk-ui/type-aliases/type-alias.CustomWidgetDataPointsEventHandler.md)\< `DataPoint` \>

Handler callback for selection of multiple data points

lected**?: [`CustomWidgetDataPointsEventHandler`](../../sdk-ui/type-aliases/type-alias.CustomWidgetDataPointsEventHandler.md)\< `DataPoint` \>

Handler callback for selection of multiple data points

### Other

#### dataOptions

> **dataOptions**: `DataOptions`

Data options defining what data to display

***

#### dataSource

> **dataSource**?: [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md)

Data source for the custom widget

***

#### description

> **description**?: `string`

Description of the widget

***

#### filters

> **filters**?: [`FilterRelations`](../../sdk-data/interfaces/interface.FilterRelations.md) \| [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Filters to apply to the data

***

#### highlights

> **highlights**?: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Highlight filters for interactive highlighting

***

#### styleOptions

> **styleOptions**?: `StyleOptions`

Style options for customizing appearance

# Interface DashboardByIdConfig

Dashboard configuration

## Properties

### filtersPanel

> **filtersPanel**?: [`DashboardFiltersPanelConfig`](interface.DashboardFiltersPanelConfig.md)

Configuration for the filters panel

***

ig

Dashboard configuration

## Properties

### filtersPanel

> **filtersPanel**?: [`DashboardFiltersPanelConfig`](interface.DashboardFiltersPanelConfig.md)

Configuration for the filters panel

***

### persist

> **persist**?: `boolean`

Boolean flag indicating whether changes to the embedded dashboard should be saved to the dashboard in Fusion.

If not specified, the default value is `false`.

Limitations:
- WAT authentication does not support persistence.
- Currently only changes to dashboard filters are persisted.

***

### tabbers

> **tabbers**?: [`TabbersConfig`](../../sdk-ui/type-aliases/type-alias.TabbersConfig.md)

Configuration for tabber widgets in the dashboard

***

### toolbar

> **toolbar**?: `object`

Configuration for the toolbar

#### Type declaration

> ##### `toolbar.visible`
>
> **visible**: `boolean`
>
> Determines whether the toolbar is visible.
>
> If not specified, the default value is `true`.
>
>

***

### widgetsPanel

> **widgetsPanel**?: [`WidgetsPanelConfig`](../../sdk-ui/interfaces/interface.WidgetsPanelConfig.md)

Configuration for the widgets panel

# Interface DashboardByIdProps

Props of the [DashboardByIdComponent](../fusion-assets/class.DashboardByIdComponent.md).

## Properties

### config

> **config**?: [`DashboardByIdConfig`](interface.DashboardByIdConfig.md)

The configuration for the dashboard

***

### dashboardOid

> **dashboardOid**: `string`

The OID of the dashboard to render.

**config**?: [`DashboardByIdConfig`](interface.DashboardByIdConfig.md)

The configuration for the dashboard

***

### dashboardOid

> **dashboardOid**: `string`

The OID of the dashboard to render.

# Interface DashboardConfig

Dashboard configuration

## Properties

### filtersPanel

> **filtersPanel**?: [`DashboardFiltersPanelConfig`](interface.DashboardFiltersPanelConfig.md)

Configuration for the filters panel

***

### tabbers

> **tabbers**?: [`TabbersConfig`](../../sdk-ui/type-aliases/type-alias.TabbersConfig.md)

Configuration for tabber widgets in the dashboard

***

### toolbar

> **toolbar**?: `object`

Configuration for the toolbar

#### Type declaration

> ##### `toolbar.visible`
>
> **visible**: `boolean`
>
> Determines whether the toolbar is visible.
>
> If not specified, the default value is `true`.
>
>

***

### widgetsPanel

> **widgetsPanel**?: [`WidgetsPanelConfig`](../../sdk-ui/interfaces/interface.WidgetsPanelConfig.md)

Configuration for the widgets panel

# Interface DashboardFiltersPanelConfig

Dashboard filters panel configuration

## Properties

lConfig`](../../sdk-ui/interfaces/interface.WidgetsPanelConfig.md)

Configuration for the widgets panel

# Interface DashboardFiltersPanelConfig

Dashboard filters panel configuration

## Properties

### actions

> **actions**?: `object`

Configures the available actions within the filters panel.

#### Type declaration

> ##### `actions.addFilter`
>
> **addFilter**?: `object`
>
> Configuration for adding a new filter.
>
> > ###### `addFilter.enabled`
> >
> > **enabled**?: `boolean`
> >
> > Determines whether the possibility to create a new filter is enabled.
> >
> > If not specified, the default value is `false`.
> >
> >
>
> ##### `actions.deleteFilter`
>
> **deleteFilter**?: `object`
>
> Configuration for deleting a filter.
>
> > ###### `deleteFilter.enabled`
> >
> > **enabled**?: `boolean`
> >
> > Determines whether the possibility to delete a filter is enabled.
> >
> > If not specified, the default value is `false`.
> >
> >
>
> ##### `actions.editFilter`
>
> **editFilter**?: `object`
>
> Configuration for editing an existing filter.
>
> > ###### `editFilter.enabled`
> >
> > **enabled**?: `boolean`
> >
> > Determines whether the possibility to edit an existing filter is enabled.
> >
> > If not specified, the default value is `false`.
> >
> >
>
>

***

### collapsedInitially

> **collapsedInitially**?: `boolean`

Boolean flag that controls the initial "collapsed" state of the filters panel.

If not specified, the default value is `false`.

***

**

### collapsedInitially

> **collapsedInitially**?: `boolean`

Boolean flag that controls the initial "collapsed" state of the filters panel.

If not specified, the default value is `false`.

***

### persistCollapsedStateToLocalStorage

> **persistCollapsedStateToLocalStorage**?: `boolean`

Setting this to `true` will use the isCollapsed state from local storage, if available, and store any changes to local storage.
This state is shared across all dashboards.
This state has a higher priority than `collapsedInitially` when enabled.

***

### showFilterIconInToolbar

> **showFilterIconInToolbar**?: `boolean`

If enabled, the expand/collapse arrow on the divider between the filters panel and the dashboard content will be replaced with a filter toggle icon on the dashboard toolbar.

If the dashboard toolbar is configured to be not visible, this setting will be ignored.

If not specified, the default value is `false`.

***

### visible

> **visible**?: `boolean`

Determines whether the filters panel is visible.

If not specified, the default value is `true`.

# Interface DashboardLayoutOptions

Dashboard layout options

## Properties

### widgetsPanel

> **widgetsPanel**?: [`WidgetsPanelColumnLayout`](interface.WidgetsPanelColumnLayout.md)

The layout of the dashboard widgets panel
If not provided, the widgets will be laid out in one column vertically by default

# Interface DashboardProps

Props of the [DashboardComponent](../dashboards/class.DashboardComponent.md).

ets panel
If not provided, the widgets will be laid out in one column vertically by default

# Interface DashboardProps

Props of the [DashboardComponent](../dashboards/class.DashboardComponent.md).

## Properties

### config

> **config**?: [`DashboardConfig`](interface.DashboardConfig.md)

The configuration for the dashboard

***

### defaultDataSource

> **defaultDataSource**?: [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md)

The default data source to use for the dashboard

***

### filters

> **filters**?: [`FilterRelations`](../../sdk-data/interfaces/interface.FilterRelations.md) \| [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

The dashboard filters to be applied to each of the widgets based on the widget filter options

***

### layoutOptions

> **layoutOptions**?: [`DashboardLayoutOptions`](interface.DashboardLayoutOptions.md)

Dashboard layout options

***

### onChange

> **onChange**?: (`event`) => `void`

Callback to receive changes

This callback is invoked when the dashboard state changes, such as filter updates,
layout changes, or widget deletions. See [DashboardChangeEvent](../../sdk-ui/type-aliases/type-alias.DashboardChangeEvent.md) for all possible event types.

#### Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `event` | [`DashboardChangeEvent`](../../sdk-ui/type-aliases/type-alias.DashboardChangeEvent.md) | The event that occurred |

#### Returns

`void`

***

escription |
| :------ | :------ | :------ |
| `event` | [`DashboardChangeEvent`](../../sdk-ui/type-aliases/type-alias.DashboardChangeEvent.md) | The event that occurred |

#### Returns

`void`

***

### styleOptions

> **styleOptions**?: [`DashboardStyleOptions`](../../sdk-ui/type-aliases/type-alias.DashboardStyleOptions.md)

The style options for the dashboard

***

### title

> **title**?: `string`

The title of the dashboard

***

### widgets

> **widgets**: [`WidgetProps`](../type-aliases/type-alias.WidgetProps.md)[]

The widgets to render in the dashboard

***

### widgetsOptions

> **widgetsOptions**?: [`WidgetsOptions`](../type-aliases/type-alias.WidgetsOptions.md)

The options for each of the widgets

# Interface DataLimits

Configuration that limits the series or categories that are charted.

## Properties

### categoriesCapacity

> **categoriesCapacity**?: `number`

Maximum number of categories to chart

***

### seriesCapacity

> **seriesCapacity**?: `number`

Maximum number of series to chart

# Interface DateRangeFilterTileProps

Props of the [DateRangeFilterTileComponent](../filter-tiles/class.DateRangeFilterTileComponent.md).

## Properties

### attribute

> **attribute**: [`LevelAttribute`](../../sdk-data/interfaces/interface.LevelAttribute.md)

Date level attribute the filter is based on

***

geFilterTileComponent.md).

## Properties

### attribute

> **attribute**: [`LevelAttribute`](../../sdk-data/interfaces/interface.LevelAttribute.md)

Date level attribute the filter is based on

***

### dataSource

> **dataSource**?: [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md)

Data source the query is run against - e.g. `Sample ECommerce`

If not specified, the query will use the `defaultDataSource` specified in the parent Sisense Context.

***

### earliestDate

> **earliestDate**?: `string`

Earliest allowed date for selection.

If not specified, the earliest date of the target date-level attribute will be used.

***

### filter

> **filter**: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)

Date range filter.

***

### filterChange

> **filterChange**?: (`filter`) => `void`

#### Parameters

| Parameter | Type |
| :------ | :------ |
| `filter` | [`Filter`](../../sdk-data/interfaces/interface.Filter.md) |

#### Returns

`void`

***

### lastDate

> **lastDate**?: `string`

Latest allowed date for selection.

If not specified, the latest date of the target date-level attribute will be used.

***

### onDelete

> **onDelete**?: () => `void`

Filter delete callback

#### Returns

`void`

***

### onEdit

> **onEdit**?: () => `void`

Filter edit callback

#### Returns

`void`

***

### parentFilters

> **parentFilters**?: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

List of filters this filter is dependent on.

***

lter edit callback

#### Returns

`void`

***

### parentFilters

> **parentFilters**?: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

List of filters this filter is dependent on.

***

### title

> **title**: `string`

Filter tile title

# Interface DrilldownBreadcrumbsProps

Props of the [DrilldownBreadcrumbsComponent](../drilldown/class.DrilldownBreadcrumbsComponent.md).

## Properties

### Widget

#### currentDimension

> **currentDimension**: [`Attribute`](../../sdk-data/interfaces/interface.Attribute.md)

Currently selected drilldown dimension

***

#### filtersDisplayValues

> **filtersDisplayValues**: `string`[][]

List of drilldown filters formatted to be displayed as breadcrumbs

***

#### sliceDrilldownSelections

> **sliceDrilldownSelections**: (`i`) => `void`

Callback function that is evaluated when a breadcrumb is clicked

##### Parameters

| Parameter | Type |
| :------ | :------ |
| `i` | `number` |

##### Returns

`void`

### Other

#### drilldownSelectionsClear

> **drilldownSelectionsClear**?: () => `void`

##### Returns

`void`

***

#### drilldownSelectionsSlice

> **drilldownSelectionsSlice**?: (`event`) => `void`

##### Parameters

| Parameter | Type |
| :------ | :------ |
| `event` | `object` |
| `event.i` | `number` |

##### Returns

`void`

# Interface ExecuteCsvQueryParams

Parameters for CSV data query execution.

## Properties

eter | Type |
| :------ | :------ |
| `event` | `object` |
| `event.i` | `number` |

##### Returns

`void`

# Interface ExecuteCsvQueryParams

Parameters for CSV data query execution.

## Properties

### beforeQuery

> **beforeQuery**?: (`jaql`) => `any`

Sync or async callback that allows to modify the JAQL payload before it is sent to the server.

#### Parameters

| Parameter | Type |
| :------ | :------ |
| `jaql` | `any` |

#### Returns

`any`

***

### config

> **config**?: [`ExecuteCSVQueryConfig`](../../sdk-ui/type-aliases/type-alias.ExecuteCSVQueryConfig.md)

***

### count

> **count**?: `number`

Number of rows to return in the query result

If not specified, the default value is `20000`

***

### dataSource

> **dataSource**?: [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md)

Data source the query is run against - e.g. `Sample ECommerce`

If not specified, the query will use the `defaultDataSource` specified in the parent Sisense Context.

***

### dimensions

> **dimensions**?: [`Attribute`](../../sdk-data/interfaces/interface.Attribute.md)[]

Dimensions of the query

***

### filters

> **filters**?: [`FilterRelations`](../../sdk-data/interfaces/interface.FilterRelations.md) \| [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Filters that will slice query results

***

> **filters**?: [`FilterRelations`](../../sdk-data/interfaces/interface.FilterRelations.md) \| [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Filters that will slice query results

***

### highlights

> **highlights**?: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Highlight filters that will highlight results that pass filter criteria

***

### measures

> **measures**?: [`Measure`](../../sdk-data/interfaces/interface.Measure.md)[]

Measures of the query

***

### offset

> **offset**?: `number`

Offset of the first row to return

If not specified, the default value is `0`

***

### ungroup

> **ungroup**?: `boolean`

Boolean flag whether to include `ungroup: true` in non-aggregated JAQL queries.

This improves computation and performance of querying tables when no aggregation is needed

If not specified, the default value is `false`

# Interface ExecuteCustomWidgetQueryParams

Parameters for custom widget query execution.

## Properties

### beforeQuery

> **beforeQuery**?: (`jaql`) => `any`

Sync or async callback that allows to modify the JAQL payload before it is sent to the server.

#### Parameters

| Parameter | Type |
| :------ | :------ |
| `jaql` | `any` |

#### Returns

`any`

***

### count

> **count**?: `number`

Number of rows to return in the query result

If not specified, the default value is `20000`

***

:------ | :------ |
| `jaql` | `any` |

#### Returns

`any`

***

### count

> **count**?: `number`

Number of rows to return in the query result

If not specified, the default value is `20000`

***

### dataOptions

> **dataOptions**: [`GenericDataOptions`](../type-aliases/type-alias.GenericDataOptions.md)

Data options defining dimensions and measures

***

### dataSource

> **dataSource**?: [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md)

Data source for the query

***

### filters

> **filters**?: [`FilterRelations`](../../sdk-data/interfaces/interface.FilterRelations.md) \| [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Filters to apply to the query

***

### highlights

> **highlights**?: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Highlight filters

***

### offset

> **offset**?: `number`

Offset of the first row to return

If not specified, the default value is `0`

***

### ungroup

> **ungroup**?: `boolean`

Boolean flag whether to include `ungroup: true` in non-aggregated JAQL queries.

This improves computation and performance of querying tables when no aggregation is needed

If not specified, the default value is `false`

# Interface ExecutePivotQueryParams

Parameters for pivot data query execution.

## Properties

mance of querying tables when no aggregation is needed

If not specified, the default value is `false`

# Interface ExecutePivotQueryParams

Parameters for pivot data query execution.

## Properties

### Data Options

#### columns

> **columns**?: ([`Attribute`](../../sdk-data/interfaces/interface.Attribute.md) \| [`PivotAttribute`](../../sdk-data/interfaces/interface.PivotAttribute.md))[]

Dimensions for the columns of the pivot table

***

#### dataSource

> **dataSource**?: [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md)

Data source the query is run against - e.g. `Sample ECommerce`

If not specified, the query will use the `defaultDataSource` specified in the parent Sisense Context.

***

#### grandTotals

> **grandTotals**?: [`PivotGrandTotals`](../../sdk-data/type-aliases/type-alias.PivotGrandTotals.md)

Options for grand totals

***

#### rows

> **rows**?: ([`Attribute`](../../sdk-data/interfaces/interface.Attribute.md) \| [`PivotAttribute`](../../sdk-data/interfaces/interface.PivotAttribute.md))[]

Dimensions for the rows of the pivot table

***

#### values

> **values**?: ([`Measure`](../../sdk-data/interfaces/interface.Measure.md) \| [`PivotMeasure`](../../sdk-data/interfaces/interface.PivotMeasure.md))[]

Measures for the values of the pivot table

s

> **values**?: ([`Measure`](../../sdk-data/interfaces/interface.Measure.md) \| [`PivotMeasure`](../../sdk-data/interfaces/interface.PivotMeasure.md))[]

Measures for the values of the pivot table

### Filtering

#### filters

> **filters**?: [`FilterRelations`](../../sdk-data/interfaces/interface.FilterRelations.md) \| [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Filters that will slice query results

***

#### highlights

> **highlights**?: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Filters that will highlight query results

### Other

#### beforeQuery

> **beforeQuery**?: (`jaql`) => `any`

Sync or async callback that allows to modify the JAQL payload before it is sent to the server.

##### Parameters

| Parameter | Type |
| :------ | :------ |
| `jaql` | `any` |

##### Returns

`any`

# Interface ExecuteQueryByWidgetIdParams

Parameters for data query by widget id execution.

## Properties

### beforeQuery

> **beforeQuery**?: (`jaql`) => `any`

Sync or async callback that allows to modify the JAQL payload before it is sent to the server.

#### Parameters

| Parameter | Type |
| :------ | :------ |
| `jaql` | `any` |

#### Returns

`any`

***

### count

> **count**?: `number`

Number of rows to return in the query result

If not specified, the default value is `20000`

***

### dashboardOid

> **dashboardOid**: `string`

Identifier of the dashboard that contains the widget

***

of rows to return in the query result

If not specified, the default value is `20000`

***

### dashboardOid

> **dashboardOid**: `string`

Identifier of the dashboard that contains the widget

***

### filters

> **filters**?: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Filters that will slice query results.

The provided filters will be merged with the existing widget filters based on `filtersMergeStrategy`

***

### filtersMergeStrategy

> **filtersMergeStrategy**?: `"codeFirst"` \| `"codeOnly"` \| `"widgetFirst"`

Strategy for merging the existing widget filters (including highlights) with the filters provided via the `filters` and `highlights` props:

- `widgetFirst` - prioritizes the widget filters over the provided filters in case of filter conflicts by certain attributes.
- `codeFirst` - prioritizes the provided filters over the widget filters in case of filter conflicts by certain attributes.
- `codeOnly` - applies only the provided filters and completely ignores the widget filters.

If not specified, the default strategy is `codeFirst`.

***

### highlights

> **highlights**?: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Highlight filters that will highlight results that pass filter criteria

***

### includeDashboardFilters

> **includeDashboardFilters**?: `boolean`

Boolean flag whether to include dashboard filters in the widget's `filters` and `highlights`

If not specified, the default value is `false`.

***

Filters

> **includeDashboardFilters**?: `boolean`

Boolean flag whether to include dashboard filters in the widget's `filters` and `highlights`

If not specified, the default value is `false`.

***

### offset

> **offset**?: `number`

Offset of the first row to return

If not specified, the default value is `0`

***

### widgetOid

> **widgetOid**: `string`

Identifier of the widget

# Interface ExecuteQueryParams

Parameters for data query execution.

## Properties

### beforeQuery

> **beforeQuery**?: (`jaql`) => `any`

Sync or async callback that allows to modify the JAQL payload before it is sent to the server.

#### Parameters

| Parameter | Type |
| :------ | :------ |
| `jaql` | `any` |

#### Returns

`any`

***

### count

> **count**?: `number`

Number of rows to return in the query result

If not specified, the default value is `20000`

***

### dataSource

> **dataSource**?: [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md)

Data source the query is run against - e.g. `Sample ECommerce`

If not specified, the query will use the `defaultDataSource` specified in the parent Sisense Context.

***

### dimensions

> **dimensions**?: [`Attribute`](../../sdk-data/interfaces/interface.Attribute.md)[]

Dimensions of the query

***

### filters

> **filters**?: [`FilterRelations`](../../sdk-data/interfaces/interface.FilterRelations.md) \| [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Filters that will slice query results

***

> **filters**?: [`FilterRelations`](../../sdk-data/interfaces/interface.FilterRelations.md) \| [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Filters that will slice query results

***

### highlights

> **highlights**?: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Highlight filters that will highlight results that pass filter criteria

***

### measures

> **measures**?: [`Measure`](../../sdk-data/interfaces/interface.Measure.md)[]

Measures of the query

***

### offset

> **offset**?: `number`

Offset of the first row to return

If not specified, the default value is `0`

***

### ungroup

> **ungroup**?: `boolean`

Boolean flag whether to include `ungroup: true` in non-aggregated JAQL queries.

This improves computation and performance of querying tables when no aggregation is needed

If not specified, the default value is `false`

# Interface FilterTileProps

Props of the [FilterTileComponent](../filter-tiles/class.FilterTileComponent.md).

## Properties

### defaultDataSource

> **defaultDataSource**?: [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md)

Default data source used for filter tiles

***

### filter

> **filter**: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)

Filter to display

***

### filterChange

> **filterChange**?: [`FilterChangeEventHandler`](../type-aliases/type-alias.FilterChangeEventHandler.md)

Filter change event handler.

***

ace.Filter.md)

Filter to display

***

### filterChange

> **filterChange**?: [`FilterChangeEventHandler`](../type-aliases/type-alias.FilterChangeEventHandler.md)

Filter change event handler.

***

### filterDelete

> **filterDelete**?: [`FilterDeleteEventHandler`](../type-aliases/type-alias.FilterDeleteEventHandler.md)

Filter delete event handler.

***

### filterEdit

> **filterEdit**?: [`FilterEditEventHandler`](../type-aliases/type-alias.FilterEditEventHandler.md)

Filter edit event handler.

# Interface FiltersPanelConfig

Configuration for the filters panel

## Properties

t**?: [`FilterEditEventHandler`](../type-aliases/type-alias.FilterEditEventHandler.md)

Filter edit event handler.

# Interface FiltersPanelConfig

Configuration for the filters panel

## Properties

### actions

> **actions**?: `object`

Configures the available actions within the filters panel.

#### Type declaration

> ##### `actions.addFilter`
>
> **addFilter**?: `object`
>
> Configuration for adding a new filter.
>
> > ###### `addFilter.enabled`
> >
> > **enabled**?: `boolean`
> >
> > Determines whether the possibility to create a new filter is enabled.
> >
> > If not specified, the default value is `false`.
> >
> >
>
> ##### `actions.deleteFilter`
>
> **deleteFilter**?: `object`
>
> Configuration for deleting a filter.
>
> > ###### `deleteFilter.enabled`
> >
> > **enabled**?: `boolean`
> >
> > Determines whether the possibility to delete a filter is enabled.
> >
> > If not specified, the default value is `false`.
> >
> >
>
> ##### `actions.editFilter`
>
> **editFilter**?: `object`
>
> Configuration for editing an existing filter.
>
> > ###### `editFilter.enabled`
> >
> > **enabled**?: `boolean`
> >
> > Determines whether the possibility to edit an existing filter is enabled.
> >
> > If not specified, the default value is `false`.
> >
> >
>
>

# Interface FiltersPanelProps

Props of the [FiltersPanelComponent](../filter-tiles/class.FiltersPanelComponent.md).

## Properties

>
> > If not specified, the default value is `false`.
> >
> >
>
>

# Interface FiltersPanelProps

Props of the [FiltersPanelComponent](../filter-tiles/class.FiltersPanelComponent.md).

## Properties

### config

> **config**?: [`FiltersPanelConfig`](interface.FiltersPanelConfig.md)

The configuration for the filters panel

***

### defaultDataSource

> **defaultDataSource**?: [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md)

Default data source used for filter tiles

***

### filters

> **filters**: [`FilterRelations`](../../sdk-data/interfaces/interface.FilterRelations.md) \| [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Array of filters to display

***

### filtersChange

> **filtersChange**?: (`event`) => `void`

Callback to handle changes in filters

#### Parameters

| Parameter | Type |
| :------ | :------ |
| `event` | [`FiltersPanelChangeEvent`](../type-aliases/type-alias.FiltersPanelChangeEvent.md) |

#### Returns

`void`

# Interface FunnelChartProps

Props of the [FunnelChartComponent](../charts/class.FunnelChartComponent.md).

## Properties

ype-aliases/type-alias.FiltersPanelChangeEvent.md) |

#### Returns

`void`

# Interface FunnelChartProps

Props of the [FunnelChartComponent](../charts/class.FunnelChartComponent.md).

## Properties

### Data

#### dataSet

> **dataSet**?: [`Data`](../../sdk-data/interfaces/interface.Data.md) \| [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md)

Data set for a chart using one of the following options. If neither option is specified, the chart
will use the `defaultDataSource` specified in the parent `SisenseContextProvider`
component.

(1) Sisense data source name as a string. For example, `'Sample ECommerce'`. Typically, you
retrieve the data source name from a data model you create using the `get-data-model`
[command](https://developer.sisense.com/guides/sdk/guides/cli.html) of the Compose SDK CLI. The chart
connects to the data source, executes a query, and loads the data as specified in
`dataOptions`, `filters`, and `highlights`.

To learn more about using data from a Sisense data source, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#sisense-data).

OR

(2) Explicit [`Data`](../../sdk-data/interfaces/interface.Data.md), which is made up of an array of
[`Column`](../../sdk-data/interfaces/interface.Column.md) objects and a two-dimensional array of row data. This approach
allows the chart component to be used with any data you provide.

To learn more about using data from an external data source, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#explicit-data).

Example data in the proper format:

```ts
const sampleData = {
  columns: [
    { name: 'Years', type: 'date' },
    { name: 'Quantity', type: 'number' },
    { name: 'Units', type: 'number' },
  ],
  rows: [
    ['2019', 5500, 1500],
    ['2020', 4471, 7000],
    ['2021', 1812, 5000],
    ['2022', 5001, 6000],
    ['2023', 2045, 4000],
  ],
};
```

***

#### filters

> **filters**?: [`FilterRelations`](../../sdk-data/interfaces/interface.FilterRelations.md) \| [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Filters to limit (or slice) a chart’s data using one of the following options.

(1) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) or [FilterRelations](../../sdk-data/interfaces/interface.FilterRelations.md) returned from filter factory functions, such as
[`greaterThan()`](../../sdk-data/factories/namespace.filterFactory/functions/function.greaterThan.md) and [`members()`](../../sdk-data/factories/namespace.filterFactory/functions/function.members.md).

Use this option for filters that do not require a UI to set them
or for filters where you will supply your own UI components or use pre-built UI components. This is the most common option.

To learn more about using filter factory functions to create filters, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-functions).

(2) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) controlled by filter UI components – for example [`MemberFilterTile`](../../sdk-ui/filter-tiles/function.MemberFilterTile.md).

Use this option for filters that you want your users to set using pre-built UI components.

To learn more about using filter UI components to create filters, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components).

***

#### highlights

> **highlights**?: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Highlights based on filter criteria to apply to a chart using one of the following options.

NOTE that the filter dimensions used in highlights must match those defined in the
`dataOptions` of the chart. Otherwise, the filters will be applied as regular slice filters.

(1) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) returned from filter factory functions, such as
[`greaterThan()`](../../sdk-data/factories/namespace.filterFactory/functions/function.greaterThan.md) and [`members()`](../../sdk-data/factories/namespace.filterFactory/functions/function.members.md).

Use this option for highlights that do not require a UI to set them
or for highlights where you will supply your own UI components or use pre-built UI components. This is the most common option.

To learn more about using filter factory functions to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-functions-for-highlighting).

(2) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) controlled by filter UI components – for example [`MemberFilterTile`](../../sdk-ui/filter-tiles/function.MemberFilterTile.md).

Use this option for highlights that you want your users to set using pre-built UI components.

To learn more about using filter components to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components-for-highlighting).

ts.

To learn more about using filter components to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components-for-highlighting).

### Chart

#### dataOptions

> **dataOptions**: [`CategoricalChartDataOptions`](interface.CategoricalChartDataOptions.md)

Configurations for how to interpret and present the data passed to the chart

***

#### styleOptions

> **styleOptions**?: [`FunnelStyleOptions`](interface.FunnelStyleOptions.md)

Configurations for how to style and present a chart's data.

resent the data passed to the chart

***

#### styleOptions

> **styleOptions**?: [`FunnelStyleOptions`](interface.FunnelStyleOptions.md)

Configurations for how to style and present a chart's data.

### Callbacks

#### beforeRender

> **beforeRender**?: [`BeforeRenderHandler`](../type-aliases/type-alias.BeforeRenderHandler.md)

A callback that allows you to customize the underlying chart element before it is rendered. The returned options are then used when rendering the chart.

This callback is not supported for Areamap Chart, Scattermap Chart, Table, and PivotTable.

***

#### dataPointClick

> **dataPointClick**?: [`DataPointEventHandler`](../type-aliases/type-alias.DataPointEventHandler.md)

Click handler callback for a data point

***

#### dataPointContextMenu

> **dataPointContextMenu**?: [`DataPointEventHandler`](../type-aliases/type-alias.DataPointEventHandler.md)

Context menu handler callback for a data point

***

#### dataPointsSelect

> **dataPointsSelect**?: [`DataPointsEventHandler`](../type-aliases/type-alias.DataPointsEventHandler.md)

Handler callback for selection of multiple data points

***

#### dataReady

> **dataReady**?: (`data`) => [`Data`](../../sdk-data/interfaces/interface.Data.md)

A callback that allows to modify data immediately after it has been retrieved.
It can be used to inject modification of queried data.

##### Parameters

| Parameter | Type |
| :------ | :------ |
| `data` | [`Data`](../../sdk-data/interfaces/interface.Data.md) |

##### Returns

[`Data`](../../sdk-data/interfaces/interface.Data.md)

##### Parameters

| Parameter | Type |
| :------ | :------ |
| `data` | [`Data`](../../sdk-data/interfaces/interface.Data.md) |

##### Returns

[`Data`](../../sdk-data/interfaces/interface.Data.md)

# Interface FunnelStyleOptions

Configuration options that define functional style of the various elements of FunnelChart

## Properties

### dataLimits

> **dataLimits**?: [`DataLimits`](interface.DataLimits.md)

Data limit for series or categories that will be plotted

***

### funnelDirection

> **funnelDirection**?: `"inverted"` \| `"regular"`

Direction of FunnelChart narrowing

***

### funnelSize

> **funnelSize**?: `"narrow"` \| `"regular"` \| `"wide"`

Visual size of the lowest slice (degree of funnel narrowing from highest to lowest slices)

***

### funnelType

> **funnelType**?: `"pinched"` \| `"regular"`

Visual type of the lowest slice of FunnelChart

***

### height

> **height**?: `number`

Total height of the component, which is considered in the following order of priority:

1. Value passed to this property (in pixels).
2. Height of the container wrapping this component
3. Default value of 400px (for component without header) or 425px (for component with header).

***

### labels

> **labels**?: [`Labels`](../type-aliases/type-alias.Labels.md)

Configuration that defines behavior of data labels on FunnelChart

::: warning Deprecated
Use seriesLabels instead
:::

***

# labels

> **labels**?: [`Labels`](../type-aliases/type-alias.Labels.md)

Configuration that defines behavior of data labels on FunnelChart

::: warning Deprecated
Use seriesLabels instead
:::

***

### legend

> **legend**?: [`LegendOptions`](../../sdk-ui/type-aliases/type-alias.LegendOptions.md)

Configuration for legend - a key that provides information about the data series or colors used in chart

***

### seriesLabels

> **seriesLabels**?: [`FunnelSeriesLabels`](../../sdk-ui/interfaces/interface.FunnelSeriesLabels.md)

Configuration for series labels

***

### subtype

> **subtype**?: `undefined`

Subtype of FunnelChart

***

### width

> **width**?: `number`

Total width of the component, which is considered in the following order of priority:

1. Value passed to this property (in pixels)
2. Width of the container wrapping this component
3. Default value of 400px

# Interface GaugeIndicatorStyleOptions

Configuration options that define functional style of the various elements of Gauge IndicatorChart

## Properties

### forceTickerView

> **forceTickerView**?: `boolean`

Boolean flag to force render indicator in ticker mode regardless of display size

***

### indicatorComponents

> **indicatorComponents**?: [`IndicatorComponents`](../type-aliases/type-alias.IndicatorComponents.md)

***

### skin

> **skin**: `1` \| `2`

***

### subtype

> **subtype**: `"indicator/gauge"`

***

**indicatorComponents**?: [`IndicatorComponents`](../type-aliases/type-alias.IndicatorComponents.md)

***

### skin

> **skin**: `1` \| `2`

***

### subtype

> **subtype**: `"indicator/gauge"`

***

### tickerBarHeight

> **tickerBarHeight**?: `number`

Bar height for gauge indicator in ticker mode

# Interface GetDashboardModelOptions

## Properties

### includeFilters

> **includeFilters**?: `boolean`

Boolean flag whether to include filters in the dashboard model

If not specified, the default value is `false`

***

### includeWidgets

> **includeWidgets**?: `boolean`

Boolean flag whether to include widgets in the dashboard model

If not specified, the default value is `false`

# Interface GetDashboardModelsOptions

## Properties

### includeWidgets

> **includeWidgets**?: `boolean`

Boolean flag whether to include widgets in the dashboard model

If not specified, the default value is `false`

***

### searchByTitle

> **searchByTitle**?: `string`

Dashboard title to search by

Dashboard titles are not necessarily unique, so the result may contain multiple dashboards.

# Interface GetFilterMembersData

Result data of retrieving filter members.

## Properties

### allMembers

> **allMembers**: [`Member`](interface.Member.md)[]

Array of all available members

***

### enableMultiSelection

> **enableMultiSelection**: `boolean`

Flag indicating if multiple selection is enabled

***

bers**: [`Member`](interface.Member.md)[]

Array of all available members

***

### enableMultiSelection

> **enableMultiSelection**: `boolean`

Flag indicating if multiple selection is enabled

***

### excludeMembers

> **excludeMembers**: `boolean`

Flag indicating whether members are excluded

***

### hasBackgroundFilter

> **hasBackgroundFilter**: `boolean`

Flag indicating if there is a background filter applied

***

### selectedMembers

> **selectedMembers**: [`SelectedMember`](../../sdk-ui/interfaces/interface.SelectedMember.md)[]

Array of members that are currently selected

# Interface GetFilterMembersParams

Parameters for retrieving filter members.

## Properties

### defaultDataSource

> **defaultDataSource**?: [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md)

Default data source to use if filter does not have one

***

### filter

> **filter**: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)

Provided members filter

***

### parentFilters

> **parentFilters**?: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

List of filters this filter is dependent on

# Interface GetHierarchyModelsParams

Parameters for retrieving an existing hierarchy models from the Sisense instance.

## Properties

face.Filter.md)[]

List of filters this filter is dependent on

# Interface GetHierarchyModelsParams

Parameters for retrieving an existing hierarchy models from the Sisense instance.

## Properties

### alwaysIncluded

> **alwaysIncluded**?: `boolean`

A flag indicating whether to filter the retrieved hierarchies based on the `alwaysIncluded` field.

When set to true, only hierarchies with `alwaysIncluded: true` will be returned.
When set to false, only hierarchies with `alwaysIncluded: false` will be returned.
If not specified, all hierarchies will be returned.

***

### dataSource

> **dataSource**?: [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md)

The data source from which to retrieve the hierarchies - e.g. `Sample ECommerce`.

If not specified, the query will use the `defaultDataSource` specified in the parent Sisense Context.

***

### dimension

> **dimension**: [`Attribute`](../../sdk-data/interfaces/interface.Attribute.md)

The dimension for which to retrieve the hierarchies.

***

### ids

> **ids**?: `string`[]

A list of hierarchy IDs to retrieve specific hierarchies.

# Interface GetNlgInsightsParams

## Properties

### dataSource

> **dataSource**: [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md)

The data source that the query targets - e.g. `Sample ECommerce`

***

### dimensions

> **dimensions**?: [`Attribute`](../../sdk-data/interfaces/interface.Attribute.md)[]

Dimensions of the query

***

data source that the query targets - e.g. `Sample ECommerce`

***

### dimensions

> **dimensions**?: [`Attribute`](../../sdk-data/interfaces/interface.Attribute.md)[]

Dimensions of the query

***

### filters

> **filters**?: [`FilterRelations`](../../sdk-data/interfaces/interface.FilterRelations.md) \| [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Filters of the query

***

### measures

> **measures**?: [`Measure`](../../sdk-data/interfaces/interface.Measure.md)[]

Measures of the query

***

### verbosity

> **verbosity**?: `"High"` \| `"Low"`

The verbosity of the NLG summarization

# Interface GetNlgInsightsProps

Props of the [GetNlgInsightsComponent](../generative-ai/class.GetNlgInsightsComponent.md).

## Properties

### dataSource

> **dataSource**: [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md)

The data source that the query targets - e.g. `Sample ECommerce`

***

### dimensions

> **dimensions**?: [`Attribute`](../../sdk-data/interfaces/interface.Attribute.md)[]

Dimensions of the query

***

### filters

> **filters**?: [`FilterRelations`](../../sdk-data/interfaces/interface.FilterRelations.md) \| [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Filters of the query

***

### measures

> **measures**?: [`Measure`](../../sdk-data/interfaces/interface.Measure.md)[]

Measures of the query

***

### verbosity

> **verbosity**?: `"High"` \| `"Low"`

The verbosity of the NLG summarization

**measures**?: [`Measure`](../../sdk-data/interfaces/interface.Measure.md)[]

Measures of the query

***

### verbosity

> **verbosity**?: `"High"` \| `"Low"`

The verbosity of the NLG summarization

# Interface GetNlqResultParams

## Properties

### chartTypes

> **chartTypes**?: (`"bar"` \| `"column"` \| `"indicator"` \| `"line"` \| `"pie"` \| `"table"`)[]

Possible chart types to be used in NLQ results

***

### dataSource

> **dataSource**: [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md)

Data source for queries to run against

***

### query

> **query**: `string`

Text containing the natural language query

# Interface GetQueryRecommendationsParams

## Properties

### contextTitle

> **contextTitle**: `string`

Data model title or perspective title

***

### count

> **count**?: `number`

Number of recommendations that should be returned

If not specified, the default value is `4`

***

### customPrompt

> **customPrompt**?: `string`

Pass a custom prompt to AI when generating query recommendations

e.g. "Focus on age range"

# Interface GetSharedFormulaParams

Parameters for retrieving a shared formula.

## Properties

### dataSource

> **dataSource**?: [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md)

Data source - e.g. `Sample ECommerce`

***

### name

> **name**?: `string`

Formula name

***

### oid

> **oid**?: `string`

Formula identifier

/../sdk-data/type-aliases/type-alias.DataSource.md)

Data source - e.g. `Sample ECommerce`

***

### name

> **name**?: `string`

Formula name

***

### oid

> **oid**?: `string`

Formula identifier

# Interface GetWidgetModelParams

Parameters for retrieving an existing widget model from the Sisense instance

## Properties

### dashboardOid

> **dashboardOid**: `string`

Identifier of the dashboard that contains the widget

***

### widgetOid

> **widgetOid**: `string`

Identifier of the widget to be retrieved

# Interface Hierarchy

Hierarchy with a title and associated levels.

## Properties

### levels

> **levels**: [`Attribute`](../../sdk-data/interfaces/interface.Attribute.md)[]

Hierarchy levels.

***

### title

> **title**: `string`

Hierarchy title.

# Interface HierarchyModel

Model of Sisense hierarchy defined in the abstractions of Compose SDK.

## Properties

### id

> **id**: `string`

Unique identifier of the hierarchy.

***

### levels

> **levels**: [`Attribute`](../../sdk-data/interfaces/interface.Attribute.md)[]

Hierarchy levels.

***

### title

> **title**: `string`

Hierarchy title.

# Interface IndicatorChartDataOptions

Configuration for how to query aggregate data and assign data
to a [Indicator chart](../type-aliases/type-alias.IndicatorChartType.md).

## Properties

title.

# Interface IndicatorChartDataOptions

Configuration for how to query aggregate data and assign data
to a [Indicator chart](../type-aliases/type-alias.IndicatorChartType.md).

## Properties

### max

> **max**?: ([`CalculatedMeasureColumn`](../../sdk-data/interfaces/interface.CalculatedMeasureColumn.md) \| [`MeasureColumn`](../../sdk-data/interfaces/interface.MeasureColumn.md) \| [`StyledMeasureColumn`](interface.StyledMeasureColumn.md))[]

Measure columns (or measures) whose values are used for max value of indicator.

***

### min

> **min**?: ([`CalculatedMeasureColumn`](../../sdk-data/interfaces/interface.CalculatedMeasureColumn.md) \| [`MeasureColumn`](../../sdk-data/interfaces/interface.MeasureColumn.md) \| [`StyledMeasureColumn`](interface.StyledMeasureColumn.md))[]

Measure columns (or measures) whose values are used for min value of indicator.

***

### secondary

> **secondary**?: ([`CalculatedMeasureColumn`](../../sdk-data/interfaces/interface.CalculatedMeasureColumn.md) \| [`MeasureColumn`](../../sdk-data/interfaces/interface.MeasureColumn.md) \| [`StyledMeasureColumn`](interface.StyledMeasureColumn.md))[]

Measure columns (or measures) whose values are used for secondary value of indicator.

***

ata/interfaces/interface.MeasureColumn.md) \| [`StyledMeasureColumn`](interface.StyledMeasureColumn.md))[]

Measure columns (or measures) whose values are used for secondary value of indicator.

***

### value

> **value**?: ([`CalculatedMeasureColumn`](../../sdk-data/interfaces/interface.CalculatedMeasureColumn.md) \| [`MeasureColumn`](../../sdk-data/interfaces/interface.MeasureColumn.md) \| [`StyledMeasureColumn`](interface.StyledMeasureColumn.md))[]

Measure columns (or measures) whose values are used for main value of indicator.

# Interface IndicatorChartProps

Props of the [IndicatorChartComponent](../charts/class.IndicatorChartComponent.md).

## Properties

(or measures) whose values are used for main value of indicator.

# Interface IndicatorChartProps

Props of the [IndicatorChartComponent](../charts/class.IndicatorChartComponent.md).

## Properties

### Data

#### dataSet

> **dataSet**?: [`Data`](../../sdk-data/interfaces/interface.Data.md) \| [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md)

Data set for a chart using one of the following options. If neither option is specified, the chart
will use the `defaultDataSource` specified in the parent `SisenseContextProvider`
component.

(1) Sisense data source name as a string. For example, `'Sample ECommerce'`. Typically, you
retrieve the data source name from a data model you create using the `get-data-model`
[command](https://developer.sisense.com/guides/sdk/guides/cli.html) of the Compose SDK CLI. The chart
connects to the data source, executes a query, and loads the data as specified in
`dataOptions`, `filters`, and `highlights`.

To learn more about using data from a Sisense data source, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#sisense-data).

OR

(2) Explicit [`Data`](../../sdk-data/interfaces/interface.Data.md), which is made up of an array of
[`Column`](../../sdk-data/interfaces/interface.Column.md) objects and a two-dimensional array of row data. This approach
allows the chart component to be used with any data you provide.

To learn more about using data from an external data source, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#explicit-data).

Example data in the proper format:

```ts
const sampleData = {
  columns: [
    { name: 'Years', type: 'date' },
    { name: 'Quantity', type: 'number' },
    { name: 'Units', type: 'number' },
  ],
  rows: [
    ['2019', 5500, 1500],
    ['2020', 4471, 7000],
    ['2021', 1812, 5000],
    ['2022', 5001, 6000],
    ['2023', 2045, 4000],
  ],
};
```

***

#### filters

> **filters**?: [`FilterRelations`](../../sdk-data/interfaces/interface.FilterRelations.md) \| [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Filters to limit (or slice) a chart’s data using one of the following options.

(1) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) or [FilterRelations](../../sdk-data/interfaces/interface.FilterRelations.md) returned from filter factory functions, such as
[`greaterThan()`](../../sdk-data/factories/namespace.filterFactory/functions/function.greaterThan.md) and [`members()`](../../sdk-data/factories/namespace.filterFactory/functions/function.members.md).

Use this option for filters that do not require a UI to set them
or for filters where you will supply your own UI components or use pre-built UI components. This is the most common option.

To learn more about using filter factory functions to create filters, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-functions).

(2) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) controlled by filter UI components – for example [`MemberFilterTile`](../../sdk-ui/filter-tiles/function.MemberFilterTile.md).

Use this option for filters that you want your users to set using pre-built UI components.

To learn more about using filter UI components to create filters, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components).

***

#### highlights

> **highlights**?: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Highlights based on filter criteria to apply to a chart using one of the following options.

NOTE that the filter dimensions used in highlights must match those defined in the
`dataOptions` of the chart. Otherwise, the filters will be applied as regular slice filters.

(1) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) returned from filter factory functions, such as
[`greaterThan()`](../../sdk-data/factories/namespace.filterFactory/functions/function.greaterThan.md) and [`members()`](../../sdk-data/factories/namespace.filterFactory/functions/function.members.md).

Use this option for highlights that do not require a UI to set them
or for highlights where you will supply your own UI components or use pre-built UI components. This is the most common option.

To learn more about using filter factory functions to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-functions-for-highlighting).

(2) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) controlled by filter UI components – for example [`MemberFilterTile`](../../sdk-ui/filter-tiles/function.MemberFilterTile.md).

Use this option for highlights that you want your users to set using pre-built UI components.

To learn more about using filter components to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components-for-highlighting).

ts.

To learn more about using filter components to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components-for-highlighting).

### Chart

#### dataOptions

> **dataOptions**: [`IndicatorChartDataOptions`](interface.IndicatorChartDataOptions.md)

Configurations for how to interpret and present the data passed to the chart

***

#### styleOptions

> **styleOptions**?: [`IndicatorStyleOptions`](../type-aliases/type-alias.IndicatorStyleOptions.md)

Configurations for how to style and present a chart's data.

### Callbacks

#### beforeRender

> **beforeRender**?: [`IndicatorBeforeRenderHandler`](../type-aliases/type-alias.IndicatorBeforeRenderHandler.md)

A callback that allows you to customize the underlying indicator chart element before it is rendered.
The returned options are then used when rendering the chart.

***

#### dataReady

> **dataReady**?: (`data`) => [`Data`](../../sdk-data/interfaces/interface.Data.md)

A callback that allows to modify data immediately after it has been retrieved.
It can be used to inject modification of queried data.

##### Parameters

| Parameter | Type |
| :------ | :------ |
| `data` | [`Data`](../../sdk-data/interfaces/interface.Data.md) |

##### Returns

[`Data`](../../sdk-data/interfaces/interface.Data.md)

##### Parameters

| Parameter | Type |
| :------ | :------ |
| `data` | [`Data`](../../sdk-data/interfaces/interface.Data.md) |

##### Returns

[`Data`](../../sdk-data/interfaces/interface.Data.md)

# Interface JumpToDashboardConfig

Configuration for Jump To Dashboard functionality.
Allows users to navigate from a widget to another dashboard with contextual filtering.

## Properties

### enabled

> **enabled**?: `boolean`

Whether Jump To Dashboard functionality is enabled

#### Default

```ts
true
```

***

a widget to another dashboard with contextual filtering.

## Properties

### enabled

> **enabled**?: `boolean`

Whether Jump To Dashboard functionality is enabled

#### Default

```ts
true
```

***

### filtering

> **filtering**?: `object`

Configuration for filter handling between source and target dashboards

#### Type declaration

> ##### `filtering.extraFilters`
>
> **extraFilters**?: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]
>
> Additional filters to apply to the target dashboard
>
> ###### Example
>
> ```ts
> const extraFilters = [dashboardProps.filters[0], dashboardProps.widgets[0].filters[0]]
> ```
>
> ###### Default
>
> ```ts
> []
> ```
>
> ##### `filtering.includeDashboardFilters`
>
> **includeDashboardFilters**?: `string`[]
>
> Dashboard-level filter dimensions to pass through
>
> undefined - include all
> [] - include nothing
> [string] - include specific dimensions
>
> example: ["[ER.Date (Calendar)]", "[Doctors.Specialty]"]
>
> ###### Default
>
> ```ts
> undefined
> ```
>
> ##### `filtering.includeWidgetFilters`
>
> **includeWidgetFilters**?: `string`[]
>
> Widget-level filter dimensions to pass through
>
> undefined - include all
> [] - include nothing
> [string] - include specific dimensions
>
> example: ["[ER.Date (Calendar)]", "[Doctors.Specialty]"]
>
> ###### Default
>
> ```ts
> undefined
> ```
>
> ##### `filtering.mergeWithTargetFilters`
>
> **mergeWithTargetFilters**?: `boolean`
>
> Whether to merge filters with existing target dashboard filters or replace them
>
> ###### Default
>
> ```ts
> false
> ```
>
>

***

eWithTargetFilters`
>
> **mergeWithTargetFilters**?: `boolean`
>
> Whether to merge filters with existing target dashboard filters or replace them
>
> ###### Default
>
> ```ts
> false
> ```
>
>

***

### interaction

> **interaction**?: `object`

Configuration for user interaction behavior

#### Type declaration

> ##### `interaction.captionPrefix`
>
> **captionPrefix**?: `string`
>
> Caption prefix for jumping action (i.e in context menu)
>
> ###### Default
>
> ```ts
> 'Jump to'
> ```
>
> ##### `interaction.showIcon`
>
> **showIcon**?: `boolean`
>
> Whether to show the Jump To Dashboard icon in the toolbar of the source widget
>
> ###### Default
>
> ```ts
> true
> ```
>
> ##### `interaction.triggerMethod`
>
> **triggerMethod**?: [`TriggerMethod`](../../sdk-ui/type-aliases/type-alias.TriggerMethod.md)
>
> How users trigger the jump action
> Note that not all widgets support both trigger methods
>
> ###### Default
>
> ```ts
> 'rightclick'
> ```
>
>

***

ui/type-aliases/type-alias.TriggerMethod.md)
>
> How users trigger the jump action
> Note that not all widgets support both trigger methods
>
> ###### Default
>
> ```ts
> 'rightclick'
> ```
>
>

***

### modal

> **modal**?: `object`

Configuration for the modal window that will display the target dashboard

#### Type declaration

> ##### `modal.height`
>
> **height**?: `number`
>
> Height of the modal window
>
> ###### Default
>
> ```ts
> 85 (when measurementUnit is '%') or 800 (when measurementUnit is 'px')
> ```
>
> ##### `modal.measurementUnit`
>
> **measurementUnit**?: `"%"` \| `"px"`
>
> Unit of measurement for width/height
>
> ###### Default
>
> ```ts
> 'px'
> ```
>
> ##### `modal.width`
>
> **width**?: `number`
>
> Width of the modal window
>
> ###### Default
>
> ```ts
> 85 (when measurementUnit is '%') or 1200 (when measurementUnit is 'px')
> ```
>
>

***

### targetDashboardConfig

> **targetDashboardConfig**?: [`DashboardConfig`](interface.DashboardConfig.md)

Configuration for the target dashboard display.
This configuration will be merged with target dashboard config, having higher priority

#### Default

```ts
{}
```

***

### targets

> **targets**: [`JtdTarget`](../../sdk-ui/type-aliases/type-alias.JtdTarget.md)[]

List of target dashboards that can be navigated to

g higher priority

#### Default

```ts
{}
```

***

### targets

> **targets**: [`JtdTarget`](../../sdk-ui/type-aliases/type-alias.JtdTarget.md)[]

List of target dashboards that can be navigated to

# Interface JumpToDashboardConfigForPivot

Configuration for Jump To Dashboard functionality for pivot widgets.
Used for pivot widgets, allowing to configure jumping to different dashboard from different dimensions

## See

[JumpToDashboardConfig](interface.JumpToDashboardConfig.md)

## Properties

### enabled

> **enabled**?: `boolean`

Whether Jump To Dashboard functionality is enabled

#### Default

```ts
true
```

***

mpToDashboardConfig](interface.JumpToDashboardConfig.md)

## Properties

### enabled

> **enabled**?: `boolean`

Whether Jump To Dashboard functionality is enabled

#### Default

```ts
true
```

***

### filtering

> **filtering**?: `object`

Configuration for filter handling between source and target dashboards

#### Type declaration

> ##### `filtering.extraFilters`
>
> **extraFilters**?: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]
>
> Additional filters to apply to the target dashboard
>
> ###### Example
>
> ```ts
> const extraFilters = [dashboardProps.filters[0], dashboardProps.widgets[0].filters[0]]
> ```
>
> ###### Default
>
> ```ts
> []
> ```
>
> ##### `filtering.includeDashboardFilters`
>
> **includeDashboardFilters**?: `string`[]
>
> Dashboard-level filter dimensions to pass through
>
> undefined - include all
> [] - include nothing
> [string] - include specific dimensions
>
> example: ["[ER.Date (Calendar)]", "[Doctors.Specialty]"]
>
> ###### Default
>
> ```ts
> undefined
> ```
>
> ##### `filtering.includeWidgetFilters`
>
> **includeWidgetFilters**?: `string`[]
>
> Widget-level filter dimensions to pass through
>
> undefined - include all
> [] - include nothing
> [string] - include specific dimensions
>
> example: ["[ER.Date (Calendar)]", "[Doctors.Specialty]"]
>
> ###### Default
>
> ```ts
> undefined
> ```
>
> ##### `filtering.mergeWithTargetFilters`
>
> **mergeWithTargetFilters**?: `boolean`
>
> Whether to merge filters with existing target dashboard filters or replace them
>
> ###### Default
>
> ```ts
> false
> ```
>
>

***

eWithTargetFilters`
>
> **mergeWithTargetFilters**?: `boolean`
>
> Whether to merge filters with existing target dashboard filters or replace them
>
> ###### Default
>
> ```ts
> false
> ```
>
>

***

### interaction

> **interaction**?: `object`

Configuration for user interaction behavior

#### Type declaration

> ##### `interaction.captionPrefix`
>
> **captionPrefix**?: `string`
>
> Caption prefix for jumping action (i.e in context menu)
>
> ###### Default
>
> ```ts
> 'Jump to'
> ```
>
> ##### `interaction.showIcon`
>
> **showIcon**?: `boolean`
>
> Whether to show the Jump To Dashboard icon in the toolbar of the source widget
>
> ###### Default
>
> ```ts
> true
> ```
>
> ##### `interaction.triggerMethod`
>
> **triggerMethod**?: [`TriggerMethod`](../../sdk-ui/type-aliases/type-alias.TriggerMethod.md)
>
> How users trigger the jump action
> Note that not all widgets support both trigger methods
>
> ###### Default
>
> ```ts
> 'rightclick'
> ```
>
>

***

ui/type-aliases/type-alias.TriggerMethod.md)
>
> How users trigger the jump action
> Note that not all widgets support both trigger methods
>
> ###### Default
>
> ```ts
> 'rightclick'
> ```
>
>

***

### modal

> **modal**?: `object`

Configuration for the modal window that will display the target dashboard

#### Type declaration

> ##### `modal.height`
>
> **height**?: `number`
>
> Height of the modal window
>
> ###### Default
>
> ```ts
> 85 (when measurementUnit is '%') or 800 (when measurementUnit is 'px')
> ```
>
> ##### `modal.measurementUnit`
>
> **measurementUnit**?: `"%"` \| `"px"`
>
> Unit of measurement for width/height
>
> ###### Default
>
> ```ts
> 'px'
> ```
>
> ##### `modal.width`
>
> **width**?: `number`
>
> Width of the modal window
>
> ###### Default
>
> ```ts
> 85 (when measurementUnit is '%') or 1200 (when measurementUnit is 'px')
> ```
>
>

***

### targetDashboardConfig

> **targetDashboardConfig**?: [`DashboardConfig`](interface.DashboardConfig.md)

Configuration for the target dashboard display.
This configuration will be merged with target dashboard config, having higher priority

#### Default

```ts
{}
```

***

interface.DashboardConfig.md)

Configuration for the target dashboard display.
This configuration will be merged with target dashboard config, having higher priority

#### Default

```ts
{}
```

***

### targets <Badge type="alpha" text="Alpha" />

> **targets**: `Map`\< [`Attribute`](../../sdk-data/interfaces/interface.Attribute.md) \| [`Measure`](../../sdk-data/interfaces/interface.Measure.md) \| \{
  `dimension`: [`Attribute`](../../sdk-data/interfaces/interface.Attribute.md);
  `location`: `"column"` \| `"row"` \| `"value"`;
 }, [`JtdTarget`](../../sdk-ui/type-aliases/type-alias.JtdTarget.md)[] \>

Map of target dashboards for different dimensions/measures

#### Example

```ts
const FormulaMeasure = dashboardProps.widgets[0].dataOptions.values[0];
const ageRangeAttribute = dashboardProps.widgets[0].dataOptions.rows[1];

const targets = new Map([
   [ageRangeAttribute, [target, target2]],
   [FormulaMeasure, [target3]],
]);
```

# Interface LineChartProps

Props of the [LineChartComponent](../charts/class.LineChartComponent.md).

## Properties

[ageRangeAttribute, [target, target2]],
   [FormulaMeasure, [target3]],
]);
```

# Interface LineChartProps

Props of the [LineChartComponent](../charts/class.LineChartComponent.md).

## Properties

### Data

#### dataSet

> **dataSet**?: [`Data`](../../sdk-data/interfaces/interface.Data.md) \| [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md)

Data set for a chart using one of the following options. If neither option is specified, the chart
will use the `defaultDataSource` specified in the parent `SisenseContextProvider`
component.

(1) Sisense data source name as a string. For example, `'Sample ECommerce'`. Typically, you
retrieve the data source name from a data model you create using the `get-data-model`
[command](https://developer.sisense.com/guides/sdk/guides/cli.html) of the Compose SDK CLI. The chart
connects to the data source, executes a query, and loads the data as specified in
`dataOptions`, `filters`, and `highlights`.

To learn more about using data from a Sisense data source, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#sisense-data).

OR

(2) Explicit [`Data`](../../sdk-data/interfaces/interface.Data.md), which is made up of an array of
[`Column`](../../sdk-data/interfaces/interface.Column.md) objects and a two-dimensional array of row data. This approach
allows the chart component to be used with any data you provide.

To learn more about using data from an external data source, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#explicit-data).

Example data in the proper format:

```ts
const sampleData = {
  columns: [
    { name: 'Years', type: 'date' },
    { name: 'Quantity', type: 'number' },
    { name: 'Units', type: 'number' },
  ],
  rows: [
    ['2019', 5500, 1500],
    ['2020', 4471, 7000],
    ['2021', 1812, 5000],
    ['2022', 5001, 6000],
    ['2023', 2045, 4000],
  ],
};
```

***

#### filters

> **filters**?: [`FilterRelations`](../../sdk-data/interfaces/interface.FilterRelations.md) \| [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Filters to limit (or slice) a chart’s data using one of the following options.

(1) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) or [FilterRelations](../../sdk-data/interfaces/interface.FilterRelations.md) returned from filter factory functions, such as
[`greaterThan()`](../../sdk-data/factories/namespace.filterFactory/functions/function.greaterThan.md) and [`members()`](../../sdk-data/factories/namespace.filterFactory/functions/function.members.md).

Use this option for filters that do not require a UI to set them
or for filters where you will supply your own UI components or use pre-built UI components. This is the most common option.

To learn more about using filter factory functions to create filters, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-functions).

(2) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) controlled by filter UI components – for example [`MemberFilterTile`](../../sdk-ui/filter-tiles/function.MemberFilterTile.md).

Use this option for filters that you want your users to set using pre-built UI components.

To learn more about using filter UI components to create filters, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components).

***

#### highlights

> **highlights**?: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Highlights based on filter criteria to apply to a chart using one of the following options.

NOTE that the filter dimensions used in highlights must match those defined in the
`dataOptions` of the chart. Otherwise, the filters will be applied as regular slice filters.

(1) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) returned from filter factory functions, such as
[`greaterThan()`](../../sdk-data/factories/namespace.filterFactory/functions/function.greaterThan.md) and [`members()`](../../sdk-data/factories/namespace.filterFactory/functions/function.members.md).

Use this option for highlights that do not require a UI to set them
or for highlights where you will supply your own UI components or use pre-built UI components. This is the most common option.

To learn more about using filter factory functions to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-functions-for-highlighting).

(2) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) controlled by filter UI components – for example [`MemberFilterTile`](../../sdk-ui/filter-tiles/function.MemberFilterTile.md).

Use this option for highlights that you want your users to set using pre-built UI components.

To learn more about using filter components to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components-for-highlighting).

ts.

To learn more about using filter components to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components-for-highlighting).

### Chart

#### dataOptions

> **dataOptions**: [`CartesianChartDataOptions`](interface.CartesianChartDataOptions.md)

Configurations for how to interpret and present a chart's data.

To learn more about using data options,
see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#dataoptions).

***

#### styleOptions

> **styleOptions**?: [`LineStyleOptions`](interface.LineStyleOptions.md)

Configurations for how to style and present a chart's data.

e-compose-sdk-charts.html#dataoptions).

***

#### styleOptions

> **styleOptions**?: [`LineStyleOptions`](interface.LineStyleOptions.md)

Configurations for how to style and present a chart's data.

### Callbacks

#### beforeRender

> **beforeRender**?: [`BeforeRenderHandler`](../type-aliases/type-alias.BeforeRenderHandler.md)

A callback that allows you to customize the underlying chart element before it is rendered. The returned options are then used when rendering the chart.

This callback is not supported for Areamap Chart, Scattermap Chart, Table, and PivotTable.

***

#### dataPointClick

> **dataPointClick**?: [`DataPointEventHandler`](../type-aliases/type-alias.DataPointEventHandler.md)

Click handler callback for a data point

***

#### dataPointContextMenu

> **dataPointContextMenu**?: [`DataPointEventHandler`](../type-aliases/type-alias.DataPointEventHandler.md)

Context menu handler callback for a data point

***

#### dataPointsSelect

> **dataPointsSelect**?: [`DataPointsEventHandler`](../type-aliases/type-alias.DataPointsEventHandler.md)

Handler callback for selection of multiple data points

***

#### dataReady

> **dataReady**?: (`data`) => [`Data`](../../sdk-data/interfaces/interface.Data.md)

A callback that allows to modify data immediately after it has been retrieved.
It can be used to inject modification of queried data.

##### Parameters

| Parameter | Type |
| :------ | :------ |
| `data` | [`Data`](../../sdk-data/interfaces/interface.Data.md) |

##### Returns

[`Data`](../../sdk-data/interfaces/interface.Data.md)

##### Parameters

| Parameter | Type |
| :------ | :------ |
| `data` | [`Data`](../../sdk-data/interfaces/interface.Data.md) |

##### Returns

[`Data`](../../sdk-data/interfaces/interface.Data.md)

# Interface LineStyleOptions

Configuration options that define functional style of the various elements of LineChart

## Properties

### dataLimits

> **dataLimits**?: [`DataLimits`](interface.DataLimits.md)

Data limit for series or categories that will be plotted

***

### height

> **height**?: `number`

Total height of the component, which is considered in the following order of priority:

1. Value passed to this property (in pixels).
2. Height of the container wrapping this component
3. Default value of 400px (for component without header) or 425px (for component with header).

***

### legend

> **legend**?: [`LegendOptions`](../../sdk-ui/type-aliases/type-alias.LegendOptions.md)

Configuration for legend - a key that provides information about the data series or colors used in chart

***

### line

> **line**?: [`LineOptions`](../type-aliases/type-alias.LineOptions.md)

Configuration that defines line style

***

### lineWidth

> **lineWidth**?: [`LineWidth`](../type-aliases/type-alias.LineWidth.md)

Configuration that defines line width

::: warning Deprecated
Use line.width instead
:::

***

### markers

> **markers**?: [`Markers`](../type-aliases/type-alias.Markers.md)

Configuration for markers - symbols or data points that highlight specific values

***

e line.width instead
:::

***

### markers

> **markers**?: [`Markers`](../type-aliases/type-alias.Markers.md)

Configuration for markers - symbols or data points that highlight specific values

***

### navigator

> **navigator**?: [`Navigator`](../type-aliases/type-alias.Navigator.md)

Configuration for navigator - zoom/pan tool for large datasets in a chart

***

### seriesLabels

> **seriesLabels**?: [`SeriesLabels`](../type-aliases/type-alias.SeriesLabels.md)

Configuration for series labels - titles/names identifying data series in a chart

***

### stepPosition

> **stepPosition**?: `"center"` \| `"left"` \| `"right"`

For step charts: defines where the step occurs (before, between, or after points)
Only used when subtype is 'line/step'

**Values**

- `left` - step occurs before the point (default)
- `center` - step occurs between points
- `right` - step occurs after the point

***

### subtype

> **subtype**?: [`LineSubtype`](../type-aliases/type-alias.LineSubtype.md)

Subtype of LineChart

***

### width

> **width**?: `number`

Total width of the component, which is considered in the following order of priority:

1. Value passed to this property (in pixels)
2. Width of the container wrapping this component
3. Default value of 400px

***

### xAxis

> **xAxis**?: [`AxisLabel`](../type-aliases/type-alias.AxisLabel.md)

Configuration for X axis

***

### y2Axis

> **y2Axis**?: [`AxisLabel`](../type-aliases/type-alias.AxisLabel.md)

Configuration for second Y axis

***

bel`](../type-aliases/type-alias.AxisLabel.md)

Configuration for X axis

***

### y2Axis

> **y2Axis**?: [`AxisLabel`](../type-aliases/type-alias.AxisLabel.md)

Configuration for second Y axis

***

### yAxis

> **yAxis**?: [`AxisLabel`](../type-aliases/type-alias.AxisLabel.md)

Configuration for Y axis

# Interface Member

## Properties

### key

> **key**: `string`

Key of the member

***

### title

> **title**: `string`

Title of the member

# Interface MemberFilterTileProps

Props of the [MemberFilterTileComponent](../filter-tiles/class.MemberFilterTileComponent.md).

## Properties

### attribute

> **attribute**: [`Attribute`](../../sdk-data/interfaces/interface.Attribute.md)

Attribute to filter on. A query will run to fetch all this attribute's members

***

### dataSource

> **dataSource**?: [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md)

Data source the query is run against - e.g. `Sample ECommerce`

If not specified, the query will use the `defaultDataSource` specified in the parent Sisense Context.

***

### filter

> **filter**: [`Filter`](../../sdk-data/interfaces/interface.Filter.md) \| `null`

Source filter object. Caller is responsible for keeping track of filter state

***

### filterChange

> **filterChange**?: (`filter`) => `void`

#### Parameters

| Parameter | Type |
| :------ | :------ |
| `filter` | [`Filter`](../../sdk-data/interfaces/interface.Filter.md) \| `null` |

#### Returns

`void`

***

ge**?: (`filter`) => `void`

#### Parameters

| Parameter | Type |
| :------ | :------ |
| `filter` | [`Filter`](../../sdk-data/interfaces/interface.Filter.md) \| `null` |

#### Returns

`void`

***

### onDelete

> **onDelete**?: () => `void`

Filter delete callback

#### Returns

`void`

***

### onEdit

> **onEdit**?: () => `void`

Filter edit callback

#### Returns

`void`

***

### parentFilters

> **parentFilters**?: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

List of filters this filter is dependent on

***

### title

> **title**: `string`

Title for the filter tile, which is rendered into the header

# Interface NumericBarIndicatorStyleOptions

Configuration options that define functional style of the various elements of Numeric Bar IndicatorChart

## Properties

### forceTickerView

> **forceTickerView**?: `boolean`

Boolean flag to force render indicator in ticker mode regardless of display size

***

### indicatorComponents

> **indicatorComponents**?: [`IndicatorComponents`](../type-aliases/type-alias.IndicatorComponents.md)

***

### numericSubtype

> **numericSubtype**: `"numericBar"`

***

### subtype

> **subtype**: `"indicator/numeric"`

# Interface NumericSimpleIndicatorStyleOptions

Configuration options that define functional style of the various elements of Numeric Simple IndicatorChart

## Properties

e**: `"indicator/numeric"`

# Interface NumericSimpleIndicatorStyleOptions

Configuration options that define functional style of the various elements of Numeric Simple IndicatorChart

## Properties

### forceTickerView

> **forceTickerView**?: `boolean`

Boolean flag to force render indicator in ticker mode regardless of display size

***

### indicatorComponents

> **indicatorComponents**?: [`IndicatorComponents`](../type-aliases/type-alias.IndicatorComponents.md)

***

### numericSubtype

> **numericSubtype**: `"numericSimple"`

***

### skin

> **skin**: `"horizontal"` \| `"vertical"`

***

### subtype

> **subtype**: `"indicator/numeric"`

# Interface PieChartProps

Props of the [PieChartComponent](../charts/class.PieChartComponent.md).

## Properties

orizontal"` \| `"vertical"`

***

### subtype

> **subtype**: `"indicator/numeric"`

# Interface PieChartProps

Props of the [PieChartComponent](../charts/class.PieChartComponent.md).

## Properties

### Data

#### dataSet

> **dataSet**?: [`Data`](../../sdk-data/interfaces/interface.Data.md) \| [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md)

Data set for a chart using one of the following options. If neither option is specified, the chart
will use the `defaultDataSource` specified in the parent `SisenseContextProvider`
component.

(1) Sisense data source name as a string. For example, `'Sample ECommerce'`. Typically, you
retrieve the data source name from a data model you create using the `get-data-model`
[command](https://developer.sisense.com/guides/sdk/guides/cli.html) of the Compose SDK CLI. The chart
connects to the data source, executes a query, and loads the data as specified in
`dataOptions`, `filters`, and `highlights`.

To learn more about using data from a Sisense data source, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#sisense-data).

OR

(2) Explicit [`Data`](../../sdk-data/interfaces/interface.Data.md), which is made up of an array of
[`Column`](../../sdk-data/interfaces/interface.Column.md) objects and a two-dimensional array of row data. This approach
allows the chart component to be used with any data you provide.

To learn more about using data from an external data source, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#explicit-data).

Example data in the proper format:

```ts
const sampleData = {
  columns: [
    { name: 'Years', type: 'date' },
    { name: 'Quantity', type: 'number' },
    { name: 'Units', type: 'number' },
  ],
  rows: [
    ['2019', 5500, 1500],
    ['2020', 4471, 7000],
    ['2021', 1812, 5000],
    ['2022', 5001, 6000],
    ['2023', 2045, 4000],
  ],
};
```

***

#### filters

> **filters**?: [`FilterRelations`](../../sdk-data/interfaces/interface.FilterRelations.md) \| [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Filters to limit (or slice) a chart’s data using one of the following options.

(1) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) or [FilterRelations](../../sdk-data/interfaces/interface.FilterRelations.md) returned from filter factory functions, such as
[`greaterThan()`](../../sdk-data/factories/namespace.filterFactory/functions/function.greaterThan.md) and [`members()`](../../sdk-data/factories/namespace.filterFactory/functions/function.members.md).

Use this option for filters that do not require a UI to set them
or for filters where you will supply your own UI components or use pre-built UI components. This is the most common option.

To learn more about using filter factory functions to create filters, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-functions).

(2) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) controlled by filter UI components – for example [`MemberFilterTile`](../../sdk-ui/filter-tiles/function.MemberFilterTile.md).

Use this option for filters that you want your users to set using pre-built UI components.

To learn more about using filter UI components to create filters, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components).

***

#### highlights

> **highlights**?: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Highlights based on filter criteria to apply to a chart using one of the following options.

NOTE that the filter dimensions used in highlights must match those defined in the
`dataOptions` of the chart. Otherwise, the filters will be applied as regular slice filters.

(1) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) returned from filter factory functions, such as
[`greaterThan()`](../../sdk-data/factories/namespace.filterFactory/functions/function.greaterThan.md) and [`members()`](../../sdk-data/factories/namespace.filterFactory/functions/function.members.md).

Use this option for highlights that do not require a UI to set them
or for highlights where you will supply your own UI components or use pre-built UI components. This is the most common option.

To learn more about using filter factory functions to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-functions-for-highlighting).

(2) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) controlled by filter UI components – for example [`MemberFilterTile`](../../sdk-ui/filter-tiles/function.MemberFilterTile.md).

Use this option for highlights that you want your users to set using pre-built UI components.

To learn more about using filter components to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components-for-highlighting).

ts.

To learn more about using filter components to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components-for-highlighting).

### Chart

#### dataOptions

> **dataOptions**: [`CategoricalChartDataOptions`](interface.CategoricalChartDataOptions.md)

Configurations for how to interpret and present the data passed to the chart

***

#### styleOptions

> **styleOptions**?: [`PieStyleOptions`](interface.PieStyleOptions.md)

Configurations for how to style and present a chart's data.

and present the data passed to the chart

***

#### styleOptions

> **styleOptions**?: [`PieStyleOptions`](interface.PieStyleOptions.md)

Configurations for how to style and present a chart's data.

### Callbacks

#### beforeRender

> **beforeRender**?: [`BeforeRenderHandler`](../type-aliases/type-alias.BeforeRenderHandler.md)

A callback that allows you to customize the underlying chart element before it is rendered. The returned options are then used when rendering the chart.

This callback is not supported for Areamap Chart, Scattermap Chart, Table, and PivotTable.

***

#### dataPointClick

> **dataPointClick**?: [`DataPointEventHandler`](../type-aliases/type-alias.DataPointEventHandler.md)

Click handler callback for a data point

***

#### dataPointContextMenu

> **dataPointContextMenu**?: [`DataPointEventHandler`](../type-aliases/type-alias.DataPointEventHandler.md)

Context menu handler callback for a data point

***

#### dataPointsSelect

> **dataPointsSelect**?: [`DataPointsEventHandler`](../type-aliases/type-alias.DataPointsEventHandler.md)

Handler callback for selection of multiple data points

***

#### dataReady

> **dataReady**?: (`data`) => [`Data`](../../sdk-data/interfaces/interface.Data.md)

A callback that allows to modify data immediately after it has been retrieved.
It can be used to inject modification of queried data.

##### Parameters

| Parameter | Type |
| :------ | :------ |
| `data` | [`Data`](../../sdk-data/interfaces/interface.Data.md) |

##### Returns

[`Data`](../../sdk-data/interfaces/interface.Data.md)

##### Parameters

| Parameter | Type |
| :------ | :------ |
| `data` | [`Data`](../../sdk-data/interfaces/interface.Data.md) |

##### Returns

[`Data`](../../sdk-data/interfaces/interface.Data.md)

# Interface PieStyleOptions

Configuration options that define functional style of the various elements of Pie chart

## Properties

### convolution

> **convolution**?: [`Convolution`](../type-aliases/type-alias.Convolution.md)

Configuration that defines the ability of the Pie chart to collapse (convolve) and
hide part of the data under the single category "Others".

***

### dataLimits

> **dataLimits**?: [`DataLimits`](interface.DataLimits.md)

Data limit for series or categories that will be plotted

***

### height

> **height**?: `number`

Total height of the component, which is considered in the following order of priority:

1. Value passed to this property (in pixels).
2. Height of the container wrapping this component
3. Default value of 400px (for component without header) or 425px (for component with header).

***

### labels

> **labels**?: [`Labels`](../type-aliases/type-alias.Labels.md)

Configuration that defines behavior of data labels on Pie chart

::: warning Deprecated
Use seriesLabels instead
:::

***

### legend

> **legend**?: [`LegendOptions`](../../sdk-ui/type-aliases/type-alias.LegendOptions.md)

Configuration for legend - a key that provides information about the data series or colors used in chart

***

> **legend**?: [`LegendOptions`](../../sdk-ui/type-aliases/type-alias.LegendOptions.md)

Configuration for legend - a key that provides information about the data series or colors used in chart

***

### semiCircle

> **semiCircle**?: `boolean`

Boolean flag that defines if the pie chart should be displayed as a semi-circle

***

### seriesLabels

> **seriesLabels**?: [`PieSeriesLabels`](../../sdk-ui/type-aliases/type-alias.PieSeriesLabels.md)

Configuration for series labels - titles/names identifying data series in a chart

***

### subtype

> **subtype**?: [`PieSubtype`](../type-aliases/type-alias.PieSubtype.md)

Subtype of Pie chart

***

### width

> **width**?: `number`

Total width of the component, which is considered in the following order of priority:

1. Value passed to this property (in pixels)
2. Width of the container wrapping this component
3. Default value of 400px

# Interface PivotTableDataOptions

Configuration for how to query data and assign data to PivotTable.

## Properties

els)
2. Width of the container wrapping this component
3. Default value of 400px

# Interface PivotTableDataOptions

Configuration for how to query data and assign data to PivotTable.

## Properties

### Data Options

#### columns

> **columns**?: ([`Column`](../../sdk-data/interfaces/interface.Column.md) \| [`StyledColumn`](interface.StyledColumn.md))[]

Dimensions for the columns of the pivot table

***

#### grandTotals

> **grandTotals**?: [`PivotGrandTotals`](../../sdk-data/type-aliases/type-alias.PivotGrandTotals.md)

Options for grand totals

***

#### rows

> **rows**?: ([`Column`](../../sdk-data/interfaces/interface.Column.md) \| [`StyledColumn`](interface.StyledColumn.md))[]

Dimensions for the rows of the pivot table

***

#### values

> **values**?: ([`CalculatedMeasureColumn`](../../sdk-data/interfaces/interface.CalculatedMeasureColumn.md) \| [`MeasureColumn`](../../sdk-data/interfaces/interface.MeasureColumn.md) \| [`StyledMeasureColumn`](interface.StyledMeasureColumn.md))[]

Measures for the values of the pivot table

# Interface PivotTableProps

Props of the [PivotTableComponent](../data-grids/class.PivotTableComponent.md).

## Properties

ce.StyledMeasureColumn.md))[]

Measures for the values of the pivot table

# Interface PivotTableProps

Props of the [PivotTableComponent](../data-grids/class.PivotTableComponent.md).

## Properties

### Data

#### dataSet

> **dataSet**?: [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md)

Data source name (as a `string`) - e.g. `Sample ECommerce`.

If not specified, the component will use the `defaultDataSource` specified in the parent Sisense Context.

***

#### filters

> **filters**?: [`FilterRelations`](../../sdk-data/interfaces/interface.FilterRelations.md) \| [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Filters that will slice query results

***

#### highlights

> **highlights**?: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Filters that will highlight query results

### Callbacks

#### dataPointClick

> **dataPointClick**?: [`PivotTableDataPointEventHandler`](../type-aliases/type-alias.PivotTableDataPointEventHandler.md)

Callback function that is called when the pivot table cell is clicked

***

#### dataPointContextMenu

> **dataPointContextMenu**?: [`PivotTableDataPointEventHandler`](../type-aliases/type-alias.PivotTableDataPointEventHandler.md)

Callback function that is called when the pivot table cell is right-clicked

taPointContextMenu**?: [`PivotTableDataPointEventHandler`](../type-aliases/type-alias.PivotTableDataPointEventHandler.md)

Callback function that is called when the pivot table cell is right-clicked

### Representation

#### dataOptions

> **dataOptions**: [`PivotTableDataOptions`](interface.PivotTableDataOptions.md)

Configurations for how to interpret and present the data passed to the component

***

#### styleOptions

> **styleOptions**?: [`PivotTableStyleOptions`](interface.PivotTableStyleOptions.md)

Configurations for how to style and present a pivot table's data.

# Interface PivotTableStyleOptions

Configuration options that define functional style of the various elements of the PivotTable component.

## Properties

### alternatingColumnsColor

> **alternatingColumnsColor**?: `boolean`

Boolean flag whether to apply background color to alternate columns

***

### alternatingRowsColor

> **alternatingRowsColor**?: `boolean`

Boolean flag whether to apply background color to alternate rows.

***

### alwaysShowResultsPerPage

> **alwaysShowResultsPerPage**?: `boolean`

Boolean flag whether to always show the results per page select

If `true`, the results per page select will be shown even if there is only one page of results.

#### Default

```ts
false
```

***

### headersColor

> **headersColor**?: `boolean`

Boolean flag whether to fill header cells with background color

***

even if there is only one page of results.

#### Default

```ts
false
```

***

### headersColor

> **headersColor**?: `boolean`

Boolean flag whether to fill header cells with background color

***

### height

> **height**?: `number`

Total height of the component, which is considered in the following order of priority:

1. Value passed to this property (in pixels).
2. Height of the container wrapping this component
3. Default value of 500px (for component without header) or 525px (for component with header).

***

### highlightColor

> **highlightColor**?: `string`

Color of highlighted cells. If not specified, default value is light yellow (`#ffff9c`).

***

header) or 525px (for component with header).

***

### highlightColor

> **highlightColor**?: `string`

Color of highlighted cells. If not specified, default value is light yellow (`#ffff9c`).

***

### isAutoContentWidth

> **isAutoContentWidth**?: `boolean`

Boolean flag whether the widths of each vertical column of table cells should be automatically calculated
to fit the width of the component, which defaults to '100%' if `width` is not specified.

If `true`, all vertical columns of table cells will be resized to fit within the component width without requiring horizontal scroll.
If a width is also specified in the `dataOptions` item, this will be used to calculate the width in proportion to the total width of the component.
Using `isAutoContentWidth: true` with a large number of columns displayed may result in very narrow columns, and is not recommended.

If `false`, each vertical column of table cells will be calculated to fit the contents, or if specified, the width provided in the corresponding `dataOptions` item.
Horizontal scroll will be shown automatically if required.

#### Default

```ts
false
```

***

### isAutoHeight

> **isAutoHeight**?: `boolean`

Boolean flag whether the height of the component should be automatically adjusted to fit the content

***

### membersColor

> **membersColor**?: `boolean`

Boolean flag whether to fill row members cells with background color

***

of the component should be automatically adjusted to fit the content

***

### membersColor

> **membersColor**?: `boolean`

Boolean flag whether to fill row members cells with background color

***

### rowHeight

> **rowHeight**?: `number`

Manual height of each row (default is 25px)

***

### rowsPerPage

> **rowsPerPage**?: `number`

Number of rows per page

Default value is 25

***

### totalsColor

> **totalsColor**?: `boolean`

Boolean flag whether to fill totals and subtotals cells with background color

***

### width

> **width**?: `number`

Total width of the component, which is considered in the following order of priority:

1. Value passed to this property (in pixels)
2. Width of the container wrapping this component
3. Default value of 400px

# Interface PivotTableWidgetProps

Props of the [PivotTableWidgetComponent](../dashboards/class.PivotTableWidgetComponent.md).

## Properties

ainer wrapping this component
3. Default value of 400px

# Interface PivotTableWidgetProps

Props of the [PivotTableWidgetComponent](../dashboards/class.PivotTableWidgetComponent.md).

## Properties

### Data

#### dataSource

> **dataSource**?: [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md)

Data source the query is run against - e.g. `Sample ECommerce`

If not specified, the query will use the `defaultDataSource` specified in the parent Sisense Context.

***

#### filters

> **filters**?: [`FilterRelations`](../../sdk-data/interfaces/interface.FilterRelations.md) \| [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Filters that will slice query results

***

#### highlights

> **highlights**?: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Filters that will highlight query results

### Chart

#### dataOptions

> **dataOptions**: [`PivotTableDataOptions`](interface.PivotTableDataOptions.md)

Configurations for how to interpret and present the data passed to the table

y results

### Chart

#### dataOptions

> **dataOptions**: [`PivotTableDataOptions`](interface.PivotTableDataOptions.md)

Configurations for how to interpret and present the data passed to the table

### Widget

#### description

> **description**?: `string`

Description of the widget

***

#### drilldownOptions

> **drilldownOptions**?: [`PivotTableDrilldownOptions`](../type-aliases/type-alias.PivotTableDrilldownOptions.md)

Configuration for the pivot table drilldown

***

#### styleOptions

> **styleOptions**?: [`PivotTableWidgetStyleOptions`](../type-aliases/type-alias.PivotTableWidgetStyleOptions.md)

Style options for both the table and widget including the widget header

***

#### title

> **title**?: `string`

Title of the widget

### Callbacks

#### dataPointClick

> **dataPointClick**?: [`PivotTableDataPointEventHandler`](../type-aliases/type-alias.PivotTableDataPointEventHandler.md)

Callback function that is called when the pivot table cell is clicked

***

#### dataPointContextMenu

> **dataPointContextMenu**?: [`PivotTableDataPointEventHandler`](../type-aliases/type-alias.PivotTableDataPointEventHandler.md)

Callback function that is called when the pivot table cell is right-clicked

# Interface PolarChartProps

Props of the [PolarChartComponent](../charts/class.PolarChartComponent.md).

## Properties

Callback function that is called when the pivot table cell is right-clicked

# Interface PolarChartProps

Props of the [PolarChartComponent](../charts/class.PolarChartComponent.md).

## Properties

### Data

#### dataSet

> **dataSet**?: [`Data`](../../sdk-data/interfaces/interface.Data.md) \| [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md)

Data set for a chart using one of the following options. If neither option is specified, the chart
will use the `defaultDataSource` specified in the parent `SisenseContextProvider`
component.

(1) Sisense data source name as a string. For example, `'Sample ECommerce'`. Typically, you
retrieve the data source name from a data model you create using the `get-data-model`
[command](https://developer.sisense.com/guides/sdk/guides/cli.html) of the Compose SDK CLI. The chart
connects to the data source, executes a query, and loads the data as specified in
`dataOptions`, `filters`, and `highlights`.

To learn more about using data from a Sisense data source, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#sisense-data).

OR

(2) Explicit [`Data`](../../sdk-data/interfaces/interface.Data.md), which is made up of an array of
[`Column`](../../sdk-data/interfaces/interface.Column.md) objects and a two-dimensional array of row data. This approach
allows the chart component to be used with any data you provide.

To learn more about using data from an external data source, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#explicit-data).

Example data in the proper format:

```ts
const sampleData = {
  columns: [
    { name: 'Years', type: 'date' },
    { name: 'Quantity', type: 'number' },
    { name: 'Units', type: 'number' },
  ],
  rows: [
    ['2019', 5500, 1500],
    ['2020', 4471, 7000],
    ['2021', 1812, 5000],
    ['2022', 5001, 6000],
    ['2023', 2045, 4000],
  ],
};
```

***

#### filters

> **filters**?: [`FilterRelations`](../../sdk-data/interfaces/interface.FilterRelations.md) \| [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Filters to limit (or slice) a chart’s data using one of the following options.

(1) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) or [FilterRelations](../../sdk-data/interfaces/interface.FilterRelations.md) returned from filter factory functions, such as
[`greaterThan()`](../../sdk-data/factories/namespace.filterFactory/functions/function.greaterThan.md) and [`members()`](../../sdk-data/factories/namespace.filterFactory/functions/function.members.md).

Use this option for filters that do not require a UI to set them
or for filters where you will supply your own UI components or use pre-built UI components. This is the most common option.

To learn more about using filter factory functions to create filters, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-functions).

(2) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) controlled by filter UI components – for example [`MemberFilterTile`](../../sdk-ui/filter-tiles/function.MemberFilterTile.md).

Use this option for filters that you want your users to set using pre-built UI components.

To learn more about using filter UI components to create filters, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components).

***

#### highlights

> **highlights**?: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Highlights based on filter criteria to apply to a chart using one of the following options.

NOTE that the filter dimensions used in highlights must match those defined in the
`dataOptions` of the chart. Otherwise, the filters will be applied as regular slice filters.

(1) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) returned from filter factory functions, such as
[`greaterThan()`](../../sdk-data/factories/namespace.filterFactory/functions/function.greaterThan.md) and [`members()`](../../sdk-data/factories/namespace.filterFactory/functions/function.members.md).

Use this option for highlights that do not require a UI to set them
or for highlights where you will supply your own UI components or use pre-built UI components. This is the most common option.

To learn more about using filter factory functions to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-functions-for-highlighting).

(2) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) controlled by filter UI components – for example [`MemberFilterTile`](../../sdk-ui/filter-tiles/function.MemberFilterTile.md).

Use this option for highlights that you want your users to set using pre-built UI components.

To learn more about using filter components to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components-for-highlighting).

ts.

To learn more about using filter components to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components-for-highlighting).

### Chart

#### dataOptions

> **dataOptions**: [`CartesianChartDataOptions`](interface.CartesianChartDataOptions.md)

Configurations for how to interpret and present a chart's data.

To learn more about using data options,
see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#dataoptions).

***

#### styleOptions

> **styleOptions**?: [`PolarStyleOptions`](interface.PolarStyleOptions.md)

Configurations for how to style and present a chart's data.

compose-sdk-charts.html#dataoptions).

***

#### styleOptions

> **styleOptions**?: [`PolarStyleOptions`](interface.PolarStyleOptions.md)

Configurations for how to style and present a chart's data.

### Callbacks

#### beforeRender

> **beforeRender**?: [`BeforeRenderHandler`](../type-aliases/type-alias.BeforeRenderHandler.md)

A callback that allows you to customize the underlying chart element before it is rendered. The returned options are then used when rendering the chart.

This callback is not supported for Areamap Chart, Scattermap Chart, Table, and PivotTable.

***

#### dataPointClick

> **dataPointClick**?: [`DataPointEventHandler`](../type-aliases/type-alias.DataPointEventHandler.md)

Click handler callback for a data point

***

#### dataPointContextMenu

> **dataPointContextMenu**?: [`DataPointEventHandler`](../type-aliases/type-alias.DataPointEventHandler.md)

Context menu handler callback for a data point

***

#### dataPointsSelect

> **dataPointsSelect**?: [`DataPointsEventHandler`](../type-aliases/type-alias.DataPointsEventHandler.md)

Handler callback for selection of multiple data points

***

#### dataReady

> **dataReady**?: (`data`) => [`Data`](../../sdk-data/interfaces/interface.Data.md)

A callback that allows to modify data immediately after it has been retrieved.
It can be used to inject modification of queried data.

##### Parameters

| Parameter | Type |
| :------ | :------ |
| `data` | [`Data`](../../sdk-data/interfaces/interface.Data.md) |

##### Returns

[`Data`](../../sdk-data/interfaces/interface.Data.md)

##### Parameters

| Parameter | Type |
| :------ | :------ |
| `data` | [`Data`](../../sdk-data/interfaces/interface.Data.md) |

##### Returns

[`Data`](../../sdk-data/interfaces/interface.Data.md)

# Interface PolarStyleOptions

Configuration options that define functional style of the various elements of PolarChart

## Properties

### dataLimits

> **dataLimits**?: [`DataLimits`](interface.DataLimits.md)

Data limit for series or categories that will be plotted

***

### height

> **height**?: `number`

Total height of the component, which is considered in the following order of priority:

1. Value passed to this property (in pixels).
2. Height of the container wrapping this component
3. Default value of 400px (for component without header) or 425px (for component with header).

***

### legend

> **legend**?: [`LegendOptions`](../../sdk-ui/type-aliases/type-alias.LegendOptions.md)

Configuration for legend - a key that provides information about the data series or colors used in chart

***

### markers

> **markers**?: [`Markers`](../type-aliases/type-alias.Markers.md)

Configuration for markers - symbols or data points that highlight specific values

***

### navigator

> **navigator**?: [`Navigator`](../type-aliases/type-alias.Navigator.md)

Configuration for navigator - zoom/pan tool for large datasets in a chart

***

ighlight specific values

***

### navigator

> **navigator**?: [`Navigator`](../type-aliases/type-alias.Navigator.md)

Configuration for navigator - zoom/pan tool for large datasets in a chart

***

### seriesLabels

> **seriesLabels**?: [`SeriesLabels`](../type-aliases/type-alias.SeriesLabels.md)

Configuration for series labels - titles/names identifying data series in a chart

***

### subtype

> **subtype**?: [`PolarSubtype`](../type-aliases/type-alias.PolarSubtype.md)

Subtype of PolarChart

***

### width

> **width**?: `number`

Total width of the component, which is considered in the following order of priority:

1. Value passed to this property (in pixels)
2. Width of the container wrapping this component
3. Default value of 400px

***

### xAxis

> **xAxis**?: [`AxisLabel`](../type-aliases/type-alias.AxisLabel.md)

Configuration for X axis

***

### y2Axis

> **y2Axis**?: [`AxisLabel`](../type-aliases/type-alias.AxisLabel.md)

Configuration for second Y axis

***

### yAxis

> **yAxis**?: [`AxisLabel`](../type-aliases/type-alias.AxisLabel.md)

Configuration for Y axis

# Interface QueryRecommendation

AI-generated recommended query you can run on your data model

## Properties

### detailedDescription

> **detailedDescription**: `string`

Detailed description of the response

***

### nlqPrompt

> **nlqPrompt**: `string`

NLQ prompt used in the request

***

### userMsg

> **userMsg**: `string`

The response message for the chat

***

Detailed description of the response

***

### nlqPrompt

> **nlqPrompt**: `string`

NLQ prompt used in the request

***

### userMsg

> **userMsg**: `string`

The response message for the chat

***

### widgetProps

> **widgetProps**?: [`WidgetProps`](../type-aliases/type-alias.WidgetProps.md)

Suggested widget props

# Interface RangeChartDataOptions

Configuration for how to query aggregate data and assign data
to axes of a Range chart.

## Properties

### breakBy

> **breakBy**: ([`Column`](../../sdk-data/interfaces/interface.Column.md) \| [`StyledColumn`](interface.StyledColumn.md))[]

Columns (or attributes) by which to break (group) the data represented in the chart.

Each group is represented by a different visual encoding - for example, color of bars in a bar chart,
and is automatically added to the chart's legend.

***

### category

> **category**: ([`Column`](../../sdk-data/interfaces/interface.Column.md) \| [`StyledColumn`](interface.StyledColumn.md))[]

Columns (or attributes) whose values are placed on the X-axis.

Typically, the X-axis represents descriptive data.

***

### seriesToColorMap

> **seriesToColorMap**?: [`ValueToColorMap`](../type-aliases/type-alias.ValueToColorMap.md)

Optional mapping of each of the series to colors.

***

ents descriptive data.

***

### seriesToColorMap

> **seriesToColorMap**?: [`ValueToColorMap`](../type-aliases/type-alias.ValueToColorMap.md)

Optional mapping of each of the series to colors.

***

### value

> **value**: ([`AreaRangeMeasureColumn`](../../sdk-ui/interfaces/interface.AreaRangeMeasureColumn.md) \| [`CalculatedMeasureColumn`](../../sdk-data/interfaces/interface.CalculatedMeasureColumn.md) \| [`StyledMeasureColumn`](interface.StyledMeasureColumn.md))[]

An array of measure columns used to represent the target numeric values for computing the metrics
in an area range chart.

Each measure column defines the range of values by specifying a lower and an upper bound,
providing the necessary data to visualize the area range on the chart.

# Interface RelativeDateFilterTileProps

Props of the [RelativeDateFilterTileComponent](../filter-tiles/class.RelativeDateFilterTileComponent.md).

## Properties

### arrangement

> **arrangement**?: [`FilterVariant`](../type-aliases/type-alias.FilterVariant.md)

Arrangement of the filter inputs. Use vertical for standard filter tiles and horizontal for toolbars

***

### filter

> **filter**: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)

Relative date filter.

***

### filterChange

> **filterChange**?: (`filter`) => `void`

#### Parameters

| Parameter | Type |
| :------ | :------ |
| `filter` | [`Filter`](../../sdk-data/interfaces/interface.Filter.md) |

#### Returns

`void`

***

filterChange**?: (`filter`) => `void`

#### Parameters

| Parameter | Type |
| :------ | :------ |
| `filter` | [`Filter`](../../sdk-data/interfaces/interface.Filter.md) |

#### Returns

`void`

***

### limit

> **limit**?: `object`

Limit of the date range that can be selected.

#### Type declaration

> ##### `limit.maxDate`
>
> **maxDate**: `string`
>
> ##### `limit.minDate`
>
> **minDate**: `string`
>
>

***

### onDelete

> **onDelete**?: () => `void`

Filter delete callback

#### Returns

`void`

***

### onEdit

> **onEdit**?: () => `void`

Filter edit callback

#### Returns

`void`

***

### title

> **title**: `string`

Filter tile title

# Interface ScatterChartDataOptions

Configuration for how to query aggregate data and assign data
to axes of a [Scatter chart](../type-aliases/type-alias.ScatterChartType.md).

These charts can include data points scattered on X-Y plane further broken down by categories
and encoded by bubble sizes.

## Properties

ter chart](../type-aliases/type-alias.ScatterChartType.md).

These charts can include data points scattered on X-Y plane further broken down by categories
and encoded by bubble sizes.

## Properties

### breakByColor

> **breakByColor**?: [`CalculatedMeasureColumn`](../../sdk-data/interfaces/interface.CalculatedMeasureColumn.md) \| [`Column`](../../sdk-data/interfaces/interface.Column.md) \| [`MeasureColumn`](../../sdk-data/interfaces/interface.MeasureColumn.md) \| [`StyledColumn`](interface.StyledColumn.md) \| [`StyledMeasureColumn`](interface.StyledMeasureColumn.md)

Select a column by which to break (group) the columns in the chart.
This must be a descriptive column. If you select descriptive data,
then the points in the chart are grouped into the members of the column.
Each member is represented by a different color.

OR

Select a column by which to color the columns in the chart.
This must be a numeric column. If you select numeric data,
then the point color is a gradient where the highest value is
the darkest color and the lowest value is the lightest color.

***

the chart.
This must be a numeric column. If you select numeric data,
then the point color is a gradient where the highest value is
the darkest color and the lowest value is the lightest color.

***

### breakByPoint

> **breakByPoint**?: [`Column`](../../sdk-data/interfaces/interface.Column.md) \| [`StyledColumn`](interface.StyledColumn.md)

A column to be scattered across the chart as circles;
one point (circle) appears on the chart for each member of this column.
These columns must be descriptive data (not numeric data).

You can only add a break-by point if either the X-axis or the Y-axis was defined to represent numeric data.

***

### seriesToColorMap

> **seriesToColorMap**?: [`ValueToColorMap`](../type-aliases/type-alias.ValueToColorMap.md)

Optional mapping of each of the series created by [breakByColor](interface.ScatterChartDataOptions.md#breakbycolor) to colors.

***

### size

> **size**?: [`CalculatedMeasureColumn`](../../sdk-data/interfaces/interface.CalculatedMeasureColumn.md) \| [`MeasureColumn`](../../sdk-data/interfaces/interface.MeasureColumn.md) \| [`StyledMeasureColumn`](interface.StyledMeasureColumn.md)

Column that determines the size of the circle. It must be numeric data.

***

umn`](../../sdk-data/interfaces/interface.MeasureColumn.md) \| [`StyledMeasureColumn`](interface.StyledMeasureColumn.md)

Column that determines the size of the circle. It must be numeric data.

***

### x

> **x**?: [`CalculatedMeasureColumn`](../../sdk-data/interfaces/interface.CalculatedMeasureColumn.md) \| [`Column`](../../sdk-data/interfaces/interface.Column.md) \| [`MeasureColumn`](../../sdk-data/interfaces/interface.MeasureColumn.md) \| [`StyledColumn`](interface.StyledColumn.md) \| [`StyledMeasureColumn`](interface.StyledMeasureColumn.md)

A column or measure column whose values are placed on the X-axis.

Typically, the X-axis of a Scatter Chart is used to represent numeric data.
Alternatively, Descriptive data is also supported. At most one column is allowed.

***

### y

> **y**?: [`CalculatedMeasureColumn`](../../sdk-data/interfaces/interface.CalculatedMeasureColumn.md) \| [`Column`](../../sdk-data/interfaces/interface.Column.md) \| [`MeasureColumn`](../../sdk-data/interfaces/interface.MeasureColumn.md) \| [`StyledColumn`](interface.StyledColumn.md) \| [`StyledMeasureColumn`](interface.StyledMeasureColumn.md)

A column or measure column whose values are placed on the Y-axis.

Typically, the Y-axis of a Scatter Chart is used to represent numeric data.
Alternatively, Descriptive data is also supported. At most one column is allowed.

# Interface ScatterChartProps

Props of the [ScatterChartComponent](../charts/class.ScatterChartComponent.md).

## Properties

ely, Descriptive data is also supported. At most one column is allowed.

# Interface ScatterChartProps

Props of the [ScatterChartComponent](../charts/class.ScatterChartComponent.md).

## Properties

### Data

#### dataSet

> **dataSet**?: [`Data`](../../sdk-data/interfaces/interface.Data.md) \| [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md)

Data set for a chart using one of the following options. If neither option is specified, the chart
will use the `defaultDataSource` specified in the parent `SisenseContextProvider`
component.

(1) Sisense data source name as a string. For example, `'Sample ECommerce'`. Typically, you
retrieve the data source name from a data model you create using the `get-data-model`
[command](https://developer.sisense.com/guides/sdk/guides/cli.html) of the Compose SDK CLI. The chart
connects to the data source, executes a query, and loads the data as specified in
`dataOptions`, `filters`, and `highlights`.

To learn more about using data from a Sisense data source, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#sisense-data).

OR

(2) Explicit [`Data`](../../sdk-data/interfaces/interface.Data.md), which is made up of an array of
[`Column`](../../sdk-data/interfaces/interface.Column.md) objects and a two-dimensional array of row data. This approach
allows the chart component to be used with any data you provide.

To learn more about using data from an external data source, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#explicit-data).

Example data in the proper format:

```ts
const sampleData = {
  columns: [
    { name: 'Years', type: 'date' },
    { name: 'Quantity', type: 'number' },
    { name: 'Units', type: 'number' },
  ],
  rows: [
    ['2019', 5500, 1500],
    ['2020', 4471, 7000],
    ['2021', 1812, 5000],
    ['2022', 5001, 6000],
    ['2023', 2045, 4000],
  ],
};
```

***

#### filters

> **filters**?: [`FilterRelations`](../../sdk-data/interfaces/interface.FilterRelations.md) \| [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Filters to limit (or slice) a chart’s data using one of the following options.

(1) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) or [FilterRelations](../../sdk-data/interfaces/interface.FilterRelations.md) returned from filter factory functions, such as
[`greaterThan()`](../../sdk-data/factories/namespace.filterFactory/functions/function.greaterThan.md) and [`members()`](../../sdk-data/factories/namespace.filterFactory/functions/function.members.md).

Use this option for filters that do not require a UI to set them
or for filters where you will supply your own UI components or use pre-built UI components. This is the most common option.

To learn more about using filter factory functions to create filters, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-functions).

(2) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) controlled by filter UI components – for example [`MemberFilterTile`](../../sdk-ui/filter-tiles/function.MemberFilterTile.md).

Use this option for filters that you want your users to set using pre-built UI components.

To learn more about using filter UI components to create filters, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components).

***

#### highlights

> **highlights**?: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Highlights based on filter criteria to apply to a chart using one of the following options.

NOTE that the filter dimensions used in highlights must match those defined in the
`dataOptions` of the chart. Otherwise, the filters will be applied as regular slice filters.

(1) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) returned from filter factory functions, such as
[`greaterThan()`](../../sdk-data/factories/namespace.filterFactory/functions/function.greaterThan.md) and [`members()`](../../sdk-data/factories/namespace.filterFactory/functions/function.members.md).

Use this option for highlights that do not require a UI to set them
or for highlights where you will supply your own UI components or use pre-built UI components. This is the most common option.

To learn more about using filter factory functions to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-functions-for-highlighting).

(2) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) controlled by filter UI components – for example [`MemberFilterTile`](../../sdk-ui/filter-tiles/function.MemberFilterTile.md).

Use this option for highlights that you want your users to set using pre-built UI components.

To learn more about using filter components to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components-for-highlighting).

ts.

To learn more about using filter components to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components-for-highlighting).

### Chart

#### dataOptions

> **dataOptions**: [`ScatterChartDataOptions`](interface.ScatterChartDataOptions.md)

Configurations for how to interpret and present the data passed to the chart

***

#### styleOptions

> **styleOptions**?: [`ScatterStyleOptions`](interface.ScatterStyleOptions.md)

Configurations for how to style and present a chart's data.

sent the data passed to the chart

***

#### styleOptions

> **styleOptions**?: [`ScatterStyleOptions`](interface.ScatterStyleOptions.md)

Configurations for how to style and present a chart's data.

### Callbacks

#### beforeRender

> **beforeRender**?: [`BeforeRenderHandler`](../type-aliases/type-alias.BeforeRenderHandler.md)

A callback that allows you to customize the underlying chart element before it is rendered. The returned options are then used when rendering the chart.

This callback is not supported for Areamap Chart, Scattermap Chart, Table, and PivotTable.

***

#### dataPointClick

> **dataPointClick**?: [`ScatterDataPointEventHandler`](../type-aliases/type-alias.ScatterDataPointEventHandler.md)

Click handler callback for a data point

***

#### dataPointContextMenu

> **dataPointContextMenu**?: [`ScatterDataPointEventHandler`](../type-aliases/type-alias.ScatterDataPointEventHandler.md)

Context menu handler callback for a data point

***

#### dataPointsSelect

> **dataPointsSelect**?: [`ScatterDataPointsEventHandler`](../type-aliases/type-alias.ScatterDataPointsEventHandler.md)

Handler callback for selection of multiple data points

***

#### dataReady

> **dataReady**?: (`data`) => [`Data`](../../sdk-data/interfaces/interface.Data.md)

A callback that allows to modify data immediately after it has been retrieved.
It can be used to inject modification of queried data.

##### Parameters

| Parameter | Type |
| :------ | :------ |
| `data` | [`Data`](../../sdk-data/interfaces/interface.Data.md) |

##### Returns

[`Data`](../../sdk-data/interfaces/interface.Data.md)

##### Parameters

| Parameter | Type |
| :------ | :------ |
| `data` | [`Data`](../../sdk-data/interfaces/interface.Data.md) |

##### Returns

[`Data`](../../sdk-data/interfaces/interface.Data.md)

# Interface ScatterStyleOptions

Configuration options that define functional style of the various elements of ScatterChart

## Properties

### dataLimits

> **dataLimits**?: [`DataLimits`](interface.DataLimits.md)

Data limit for series or categories that will be plotted

***

### height

> **height**?: `number`

Total height of the component, which is considered in the following order of priority:

1. Value passed to this property (in pixels).
2. Height of the container wrapping this component
3. Default value of 400px (for component without header) or 425px (for component with header).

***

### legend

> **legend**?: [`LegendOptions`](../../sdk-ui/type-aliases/type-alias.LegendOptions.md)

Configuration for legend - a key that provides information about the data series or colors used in chart

***

### markers

> **markers**?: [`Markers`](../type-aliases/type-alias.Markers.md)

Configuration for markers - symbols or data points that highlight specific values

***

### markerSize

> **markerSize**?: [`ScatterMarkerSize`](../type-aliases/type-alias.ScatterMarkerSize.md)

***

### navigator

> **navigator**?: [`Navigator`](../type-aliases/type-alias.Navigator.md)

Configuration for navigator - zoom/pan tool for large datasets in a chart

***

as.ScatterMarkerSize.md)

***

### navigator

> **navigator**?: [`Navigator`](../type-aliases/type-alias.Navigator.md)

Configuration for navigator - zoom/pan tool for large datasets in a chart

***

### seriesLabels

> **seriesLabels**?: [`ScatterSeriesLabels`](../../sdk-ui/type-aliases/type-alias.ScatterSeriesLabels.md)

***

### subtype

> **subtype**?: `undefined`

Subtype of ScatterChart

***

### width

> **width**?: `number`

Total width of the component, which is considered in the following order of priority:

1. Value passed to this property (in pixels)
2. Width of the container wrapping this component
3. Default value of 400px

***

### xAxis

> **xAxis**?: [`AxisLabel`](../type-aliases/type-alias.AxisLabel.md)

Configuration for X axis

***

### y2Axis

> **y2Axis**?: [`AxisLabel`](../type-aliases/type-alias.AxisLabel.md)

Configuration for second Y axis

***

### yAxis

> **yAxis**?: [`AxisLabel`](../type-aliases/type-alias.AxisLabel.md)

Configuration for Y axis

# Interface ScattermapChartDataOptions

Configuration for how to query aggregate data and assign data
to axes of a Scattermap chart.

## Properties

### colorBy

> **colorBy**?: [`CalculatedMeasureColumn`](../../sdk-data/interfaces/interface.CalculatedMeasureColumn.md) \| [`MeasureColumn`](../../sdk-data/interfaces/interface.MeasureColumn.md) \| [`StyledMeasureColumn`](interface.StyledMeasureColumn.md)

Measure column (or measure) representing the color of the points on the map.

***

(../../sdk-data/interfaces/interface.MeasureColumn.md) \| [`StyledMeasureColumn`](interface.StyledMeasureColumn.md)

Measure column (or measure) representing the color of the points on the map.

***

### details

> **details**?: [`CalculatedMeasureColumn`](../../sdk-data/interfaces/interface.CalculatedMeasureColumn.md) \| [`Column`](../../sdk-data/interfaces/interface.Column.md) \| [`MeasureColumn`](../../sdk-data/interfaces/interface.MeasureColumn.md) \| [`StyledColumn`](interface.StyledColumn.md) \| [`StyledMeasureColumn`](interface.StyledMeasureColumn.md)

Column or measure column representing the additional details for the points on the map.

***

### geo

> **geo**: ([`Column`](../../sdk-data/interfaces/interface.Column.md) \| [`StyledColumn`](interface.StyledColumn.md))[]

Columns (or attributes) whose values represent locations on the map.
Support field(s) that contain geographic data (Country, City, State/Province, etc)
To visualize latitude and longitude data, you have to add one field containing latitude data, and another field containing longitude data, in this order.

***

### size

> **size**?: [`CalculatedMeasureColumn`](../../sdk-data/interfaces/interface.CalculatedMeasureColumn.md) \| [`MeasureColumn`](../../sdk-data/interfaces/interface.MeasureColumn.md) \| [`StyledMeasureColumn`](interface.StyledMeasureColumn.md)

Measure column (or measure) representing the size of the points on the map.

lumn`](../../sdk-data/interfaces/interface.MeasureColumn.md) \| [`StyledMeasureColumn`](interface.StyledMeasureColumn.md)

Measure column (or measure) representing the size of the points on the map.

# Interface ScattermapChartProps

Props of the [ScattermapChartComponent](../charts/class.ScattermapChartComponent.md).

## Properties

n (or measure) representing the size of the points on the map.

# Interface ScattermapChartProps

Props of the [ScattermapChartComponent](../charts/class.ScattermapChartComponent.md).

## Properties

### Data

#### dataSet

> **dataSet**?: [`Data`](../../sdk-data/interfaces/interface.Data.md) \| [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md)

Data set for a chart using one of the following options. If neither option is specified, the chart
will use the `defaultDataSource` specified in the parent `SisenseContextProvider`
component.

(1) Sisense data source name as a string. For example, `'Sample ECommerce'`. Typically, you
retrieve the data source name from a data model you create using the `get-data-model`
[command](https://developer.sisense.com/guides/sdk/guides/cli.html) of the Compose SDK CLI. The chart
connects to the data source, executes a query, and loads the data as specified in
`dataOptions`, `filters`, and `highlights`.

To learn more about using data from a Sisense data source, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#sisense-data).

OR

(2) Explicit [`Data`](../../sdk-data/interfaces/interface.Data.md), which is made up of an array of
[`Column`](../../sdk-data/interfaces/interface.Column.md) objects and a two-dimensional array of row data. This approach
allows the chart component to be used with any data you provide.

To learn more about using data from an external data source, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#explicit-data).

Example data in the proper format:

```ts
const sampleData = {
  columns: [
    { name: 'Years', type: 'date' },
    { name: 'Quantity', type: 'number' },
    { name: 'Units', type: 'number' },
  ],
  rows: [
    ['2019', 5500, 1500],
    ['2020', 4471, 7000],
    ['2021', 1812, 5000],
    ['2022', 5001, 6000],
    ['2023', 2045, 4000],
  ],
};
```

***

#### filters

> **filters**?: [`FilterRelations`](../../sdk-data/interfaces/interface.FilterRelations.md) \| [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Filters to limit (or slice) a chart’s data using one of the following options.

(1) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) or [FilterRelations](../../sdk-data/interfaces/interface.FilterRelations.md) returned from filter factory functions, such as
[`greaterThan()`](../../sdk-data/factories/namespace.filterFactory/functions/function.greaterThan.md) and [`members()`](../../sdk-data/factories/namespace.filterFactory/functions/function.members.md).

Use this option for filters that do not require a UI to set them
or for filters where you will supply your own UI components or use pre-built UI components. This is the most common option.

To learn more about using filter factory functions to create filters, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-functions).

(2) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) controlled by filter UI components – for example [`MemberFilterTile`](../../sdk-ui/filter-tiles/function.MemberFilterTile.md).

Use this option for filters that you want your users to set using pre-built UI components.

To learn more about using filter UI components to create filters, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components).

***

#### highlights

> **highlights**?: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Highlights based on filter criteria to apply to a chart using one of the following options.

NOTE that the filter dimensions used in highlights must match those defined in the
`dataOptions` of the chart. Otherwise, the filters will be applied as regular slice filters.

(1) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) returned from filter factory functions, such as
[`greaterThan()`](../../sdk-data/factories/namespace.filterFactory/functions/function.greaterThan.md) and [`members()`](../../sdk-data/factories/namespace.filterFactory/functions/function.members.md).

Use this option for highlights that do not require a UI to set them
or for highlights where you will supply your own UI components or use pre-built UI components. This is the most common option.

To learn more about using filter factory functions to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-functions-for-highlighting).

(2) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) controlled by filter UI components – for example [`MemberFilterTile`](../../sdk-ui/filter-tiles/function.MemberFilterTile.md).

Use this option for highlights that you want your users to set using pre-built UI components.

To learn more about using filter components to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components-for-highlighting).

ts.

To learn more about using filter components to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components-for-highlighting).

### Chart

#### dataOptions

> **dataOptions**: [`ScattermapChartDataOptions`](interface.ScattermapChartDataOptions.md)

Configurations for how to interpret and present the data passed to the chart

***

#### styleOptions

> **styleOptions**?: [`ScattermapStyleOptions`](interface.ScattermapStyleOptions.md)

Configurations for how to style and present a chart's data.

### Callbacks

#### dataPointClick

> **dataPointClick**?: [`ScattermapDataPointEventHandler`](../type-aliases/type-alias.ScattermapDataPointEventHandler.md)

Click handler callback for a data point

***

#### dataReady

> **dataReady**?: (`data`) => [`Data`](../../sdk-data/interfaces/interface.Data.md)

A callback that allows to modify data immediately after it has been retrieved.
It can be used to inject modification of queried data.

##### Parameters

| Parameter | Type |
| :------ | :------ |
| `data` | [`Data`](../../sdk-data/interfaces/interface.Data.md) |

##### Returns

[`Data`](../../sdk-data/interfaces/interface.Data.md)

# Interface ScattermapStyleOptions

Configuration options that define functional style of the various elements of ScattermapChart

## Properties

`Data`](../../sdk-data/interfaces/interface.Data.md)

# Interface ScattermapStyleOptions

Configuration options that define functional style of the various elements of ScattermapChart

## Properties

### height

> **height**?: `number`

Total height of the component, which is considered in the following order of priority:

1. Value passed to this property (in pixels).
2. Height of the container wrapping this component
3. Default value of 400px (for component without header) or 425px (for component with header).

***

### markers

> **markers**?: [`ScattermapMarkers`](../type-aliases/type-alias.ScattermapMarkers.md)

***

### subtype

> **subtype**?: `undefined`

***

### width

> **width**?: `number`

Total width of the component, which is considered in the following order of priority:

1. Value passed to this property (in pixels)
2. Width of the container wrapping this component
3. Default value of 400px

# Interface SisenseContextConfig

Configurations and authentication for Sisense Context.

Use one of the following to authenticate:

- [ssoEnabled](interface.SisenseContextConfig.md#ssoenabled)
- [token](interface.SisenseContextConfig.md#token)
- [wat](interface.SisenseContextConfig.md#wat)

## Properties

lowing to authenticate:

- [ssoEnabled](interface.SisenseContextConfig.md#ssoenabled)
- [token](interface.SisenseContextConfig.md#token)
- [wat](interface.SisenseContextConfig.md#wat)

## Properties

### Sisense App

#### appConfig

> **appConfig**?: [`AppConfig`](../type-aliases/type-alias.AppConfig.md)

Application specific configurations such as locale and date formats.

***

#### defaultDataSource

> **defaultDataSource**?: [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md)

Default data source explicitly set to be used by child components that are not defined with a data source.

***

#### url

> **url**: `string`

URL of the Sisense environment the app connects to

d)

Default data source explicitly set to be used by child components that are not defined with a data source.

***

#### url

> **url**: `string`

URL of the Sisense environment the app connects to

### Sisense Authentication

#### enableSilentPreAuth

> **enableSilentPreAuth**?: `boolean`

Boolean flag to enable sending silent pre-authentication requests to the Sisense instance.
Used to check if user is already authenticated, check is performed in an ivisible iframe.
Used only with SSO authentication.
If not specified, the default value is `false`.

***

#### ssoEnabled

> **ssoEnabled**?: `boolean`

[Single Sign-On](https://docs.sisense.com/main/SisenseLinux/using-single-sign-on-to-access-sisense.htm) toggle.

Set to `true` to use SSO authentication. When `true`, this overrides any other authentication methods. Defaults to `false`.

***

#### token

> **token**?: `null` \| `string`

Token for [bearer authentication](https://developer.sisense.com/guides/restApi/using-rest-api.html).

To signify that the token is pending (e.g., being generated), set the value to `null`. This is supported for React and Vue only.

***

#### useFusionAuth

> **useFusionAuth**?: `boolean`

Flag to delegate authentication to Fusion.

Defaults to `false`.

***

#### wat

> **wat**?: `null` \| `string`

[Web Access Token](https://docs.sisense.com/main/SisenseLinux/using-web-access-token.htm).

To signify that the token is pending (e.g., being generated), set the value to `null`. This is supported for React and Vue only.

ps://docs.sisense.com/main/SisenseLinux/using-web-access-token.htm).

To signify that the token is pending (e.g., being generated), set the value to `null`. This is supported for React and Vue only.

# Interface StackableStyleOptions

Configuration options that define functional style of the various elements of stackable charts, like Column or Bar

## Properties

### dataLimits

> **dataLimits**?: [`DataLimits`](interface.DataLimits.md)

Data limit for series or categories that will be plotted

***

### height

> **height**?: `number`

Total height of the component, which is considered in the following order of priority:

1. Value passed to this property (in pixels).
2. Height of the container wrapping this component
3. Default value of 400px (for component without header) or 425px (for component with header).

***

### legend

> **legend**?: [`LegendOptions`](../../sdk-ui/type-aliases/type-alias.LegendOptions.md)

Configuration for legend - a key that provides information about the data series or colors used in chart

***

### markers

> **markers**?: [`Markers`](../type-aliases/type-alias.Markers.md)

Configuration for markers - symbols or data points that highlight specific values

***

### navigator

> **navigator**?: [`Navigator`](../type-aliases/type-alias.Navigator.md)

Configuration for navigator - zoom/pan tool for large datasets in a chart

***

ighlight specific values

***

### navigator

> **navigator**?: [`Navigator`](../type-aliases/type-alias.Navigator.md)

Configuration for navigator - zoom/pan tool for large datasets in a chart

***

### series

> **series**?: `object`

Configuration for series styling

#### Type declaration

> ##### `series.borderRadius`
>
> **borderRadius**?: `number` \| `string`
>
> The corner radius of the border surrounding each column or bar.
> A number signifies pixels.
> A percentage string, like for example 50%, signifies a relative size.
>
> ###### Default
>
> ```ts
> 0
> ```
>
> ##### `series.groupPadding`
>
> **groupPadding**?: `number`
>
> Padding between each value groups, in x axis units.
>
> ###### Default
>
> ```ts
> 0.1
> ```
>
> ##### `series.padding`
>
> **padding**?: `number`
>
> Padding between each column or bar, in x axis units.
>
> ###### Default
>
> ```ts
> 0.01
> ```
>
>

***

### seriesLabels

> **seriesLabels**?: [`SeriesLabels`](../type-aliases/type-alias.SeriesLabels.md)

Configuration for series labels - titles/names identifying data series in a chart

***

### subtype

> **subtype**?: [`StackableSubtype`](../type-aliases/type-alias.StackableSubtype.md)

Subtype of stackable chart

***

### totalLabels

> **totalLabels**?: [`TotalLabels`](../../sdk-ui/type-aliases/type-alias.TotalLabels.md)

Configuration for total labels
Only supported for stacked chart subtypes

***

e chart

***

### totalLabels

> **totalLabels**?: [`TotalLabels`](../../sdk-ui/type-aliases/type-alias.TotalLabels.md)

Configuration for total labels
Only supported for stacked chart subtypes

***

### width

> **width**?: `number`

Total width of the component, which is considered in the following order of priority:

1. Value passed to this property (in pixels)
2. Width of the container wrapping this component
3. Default value of 400px

***

### xAxis

> **xAxis**?: [`AxisLabel`](../type-aliases/type-alias.AxisLabel.md)

Configuration for X axis

***

### y2Axis

> **y2Axis**?: [`AxisLabel`](../type-aliases/type-alias.AxisLabel.md)

Configuration for second Y axis

***

### yAxis

> **yAxis**?: [`AxisLabel`](../type-aliases/type-alias.AxisLabel.md)

Configuration for Y axis

# Interface StreamgraphChartProps

Props of the [StreamgraphChartComponent](../charts/class.StreamgraphChartComponent.md) component.

## Properties

ype-alias.AxisLabel.md)

Configuration for Y axis

# Interface StreamgraphChartProps

Props of the [StreamgraphChartComponent](../charts/class.StreamgraphChartComponent.md) component.

## Properties

### Data

#### dataSet

> **dataSet**?: [`Data`](../../sdk-data/interfaces/interface.Data.md) \| [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md)

Data set for a chart using one of the following options. If neither option is specified, the chart
will use the `defaultDataSource` specified in the parent `SisenseContextProvider`
component.

(1) Sisense data source name as a string. For example, `'Sample ECommerce'`. Typically, you
retrieve the data source name from a data model you create using the `get-data-model`
[command](https://developer.sisense.com/guides/sdk/guides/cli.html) of the Compose SDK CLI. The chart
connects to the data source, executes a query, and loads the data as specified in
`dataOptions`, `filters`, and `highlights`.

To learn more about using data from a Sisense data source, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#sisense-data).

OR

(2) Explicit [`Data`](../../sdk-data/interfaces/interface.Data.md), which is made up of an array of
[`Column`](../../sdk-data/interfaces/interface.Column.md) objects and a two-dimensional array of row data. This approach
allows the chart component to be used with any data you provide.

To learn more about using data from an external data source, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#explicit-data).

Example data in the proper format:

```ts
const sampleData = {
  columns: [
    { name: 'Years', type: 'date' },
    { name: 'Quantity', type: 'number' },
    { name: 'Units', type: 'number' },
  ],
  rows: [
    ['2019', 5500, 1500],
    ['2020', 4471, 7000],
    ['2021', 1812, 5000],
    ['2022', 5001, 6000],
    ['2023', 2045, 4000],
  ],
};
```

***

#### filters

> **filters**?: [`FilterRelations`](../../sdk-data/interfaces/interface.FilterRelations.md) \| [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Filters to limit (or slice) a chart’s data using one of the following options.

(1) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) or [FilterRelations](../../sdk-data/interfaces/interface.FilterRelations.md) returned from filter factory functions, such as
[`greaterThan()`](../../sdk-data/factories/namespace.filterFactory/functions/function.greaterThan.md) and [`members()`](../../sdk-data/factories/namespace.filterFactory/functions/function.members.md).

Use this option for filters that do not require a UI to set them
or for filters where you will supply your own UI components or use pre-built UI components. This is the most common option.

To learn more about using filter factory functions to create filters, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-functions).

(2) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) controlled by filter UI components – for example [`MemberFilterTile`](../../sdk-ui/filter-tiles/function.MemberFilterTile.md).

Use this option for filters that you want your users to set using pre-built UI components.

To learn more about using filter UI components to create filters, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components).

***

#### highlights

> **highlights**?: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Highlights based on filter criteria to apply to a chart using one of the following options.

NOTE that the filter dimensions used in highlights must match those defined in the
`dataOptions` of the chart. Otherwise, the filters will be applied as regular slice filters.

(1) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) returned from filter factory functions, such as
[`greaterThan()`](../../sdk-data/factories/namespace.filterFactory/functions/function.greaterThan.md) and [`members()`](../../sdk-data/factories/namespace.filterFactory/functions/function.members.md).

Use this option for highlights that do not require a UI to set them
or for highlights where you will supply your own UI components or use pre-built UI components. This is the most common option.

To learn more about using filter factory functions to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-functions-for-highlighting).

(2) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) controlled by filter UI components – for example [`MemberFilterTile`](../../sdk-ui/filter-tiles/function.MemberFilterTile.md).

Use this option for highlights that you want your users to set using pre-built UI components.

To learn more about using filter components to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components-for-highlighting).

ts.

To learn more about using filter components to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components-for-highlighting).

### Chart

#### dataOptions

> **dataOptions**: [`CartesianChartDataOptions`](interface.CartesianChartDataOptions.md)

Configurations for how to interpret and present a chart's data.

Streamgraph requires at least one category (X-axis) and one or more value measures.
Multiple series can be created using the `breakBy` property or by providing multiple
value measures.

To learn more about using data options,
see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#dataoptions).

***

#### styleOptions

> **styleOptions**?: [`StreamgraphStyleOptions`](interface.StreamgraphStyleOptions.md)

Configurations for how to style and present a chart's data.

charts.html#dataoptions).

***

#### styleOptions

> **styleOptions**?: [`StreamgraphStyleOptions`](interface.StreamgraphStyleOptions.md)

Configurations for how to style and present a chart's data.

### Callbacks

#### beforeRender

> **beforeRender**?: [`BeforeRenderHandler`](../type-aliases/type-alias.BeforeRenderHandler.md)

A callback that allows you to customize the underlying chart element before it is rendered. The returned options are then used when rendering the chart.

This callback is not supported for Areamap Chart, Scattermap Chart, Table, and PivotTable.

***

#### dataPointClick

> **dataPointClick**?: [`DataPointEventHandler`](../type-aliases/type-alias.DataPointEventHandler.md)

Click handler callback for a data point

***

#### dataPointContextMenu

> **dataPointContextMenu**?: [`DataPointEventHandler`](../type-aliases/type-alias.DataPointEventHandler.md)

Context menu handler callback for a data point

***

#### dataPointsSelect

> **dataPointsSelect**?: [`DataPointsEventHandler`](../type-aliases/type-alias.DataPointsEventHandler.md)

Handler callback for selection of multiple data points

***

#### dataReady

> **dataReady**?: (`data`) => [`Data`](../../sdk-data/interfaces/interface.Data.md)

A callback that allows to modify data immediately after it has been retrieved.
It can be used to inject modification of queried data.

##### Parameters

| Parameter | Type |
| :------ | :------ |
| `data` | [`Data`](../../sdk-data/interfaces/interface.Data.md) |

##### Returns

[`Data`](../../sdk-data/interfaces/interface.Data.md)

##### Parameters

| Parameter | Type |
| :------ | :------ |
| `data` | [`Data`](../../sdk-data/interfaces/interface.Data.md) |

##### Returns

[`Data`](../../sdk-data/interfaces/interface.Data.md)

# Interface StreamgraphStyleOptions

Configuration options that define the visual style of a Streamgraph chart.

Streamgraphs are centered stacked area charts that emphasize flowing patterns
and overall trends. The Y-axis is typically hidden or minimal, and series labels
are often displayed directly on the areas for identification.

## Properties

### dataLimits

> **dataLimits**?: [`DataLimits`](interface.DataLimits.md)

Data limit for series or categories that will be plotted

***

### height

> **height**?: `number`

Total height of the component, which is considered in the following order of priority:

1. Value passed to this property (in pixels).
2. Height of the container wrapping this component
3. Default value of 400px (for component without header) or 425px (for component with header).

***

### legend

> **legend**?: [`LegendOptions`](../../sdk-ui/type-aliases/type-alias.LegendOptions.md)

Configuration for legend - a key that provides information about the data series or colors used in chart

***

### line

> **line**?: [`LineOptions`](../type-aliases/type-alias.LineOptions.md)

Configuration that defines line style for area boundaries.

***

about the data series or colors used in chart

***

### line

> **line**?: [`LineOptions`](../type-aliases/type-alias.LineOptions.md)

Configuration that defines line style for area boundaries.

***

### lineWidth

> **lineWidth**?: [`LineWidth`](../type-aliases/type-alias.LineWidth.md)

Configuration that defines line width for area boundaries.

::: warning Deprecated
Use line.width instead
:::

***

### markers

> **markers**?: [`Markers`](../type-aliases/type-alias.Markers.md)

Configuration for markers - symbols or data points that highlight specific values

***

### navigator

> **navigator**?: [`Navigator`](../type-aliases/type-alias.Navigator.md)

Configuration for navigator - zoom/pan tool for large datasets in a chart

***

### seriesLabels

> **seriesLabels**?: [`SeriesLabels`](../type-aliases/type-alias.SeriesLabels.md)

Configuration for series labels - titles/names identifying data series in a chart.

***

### width

> **width**?: `number`

Total width of the component, which is considered in the following order of priority:

1. Value passed to this property (in pixels)
2. Width of the container wrapping this component
3. Default value of 400px

***

### xAxis

> **xAxis**?: [`AxisLabel`](../type-aliases/type-alias.AxisLabel.md)

Configuration for X axis

***

### y2Axis

> **y2Axis**?: [`AxisLabel`](../type-aliases/type-alias.AxisLabel.md)

Configuration for second Y axis

***

bel`](../type-aliases/type-alias.AxisLabel.md)

Configuration for X axis

***

### y2Axis

> **y2Axis**?: [`AxisLabel`](../type-aliases/type-alias.AxisLabel.md)

Configuration for second Y axis

***

### yAxis

> **yAxis**?: [`AxisLabel`](../type-aliases/type-alias.AxisLabel.md)

Configuration for Y axis

# Interface StyledColumn

Wrapped [Column](../../sdk-data/interfaces/interface.Column.md) with styles controlling how the column is visualized in a chart.

## Example

An example of using `StyledColumn` to change the date format of the months displayed on the x-axis.

```ts
<Chart
  dataSet={DM.DataSource}
  chartType={'line'}
  dataOptions={{
    category: [
      {
        column: DM.Commerce.Date.Months,
        dateFormat: 'yy-MM',
      },
    ],
    value: [
      measureFactory.sum(DM.Commerce.Revenue),
      {
        column: measureFactory.sum(DM.Commerce.Quantity),
        showOnRightAxis: true,
        chartType: 'column',
      },
    ],
    breakBy: [],
  }}
/>
```

<img src="../../../img/chart-mixed-series-example-1.png" width="800px" />

Also, see [StyledMeasureColumn](interface.StyledMeasureColumn.md).

## Properties

### color

> **color**?: [`DataColorOptions`](../type-aliases/type-alias.DataColorOptions.md)

All possible color options for data.

***

### column

> **column**: [`Column`](../../sdk-data/interfaces/interface.Column.md)

Wrapped Column

***

](../type-aliases/type-alias.DataColorOptions.md)

All possible color options for data.

***

### column

> **column**: [`Column`](../../sdk-data/interfaces/interface.Column.md)

Wrapped Column

***

### continuous

> **continuous**?: `boolean`

Boolean flag to toggle continuous timeline on this date column.

***

### dateFormat

> **dateFormat**?: `string`

Date format.

See [ECMAScript Date Time String Format](https://tc39.es/ecma262/multipage/numbers-and-dates.html#sec-date-time-string-format)

Note that 'YYYY' and 'DD' have been disabled since they often get confused with 'yyyy' and 'dd'
and can produce unexpected results.

***

### geoLevel

> **geoLevel**?: [`ScattermapLocationLevel`](../type-aliases/type-alias.ScattermapLocationLevel.md)

Geographic location level for Scattermap chart.

***

### granularity

> **granularity**?: `string`

Date granularity that works with continuous timeline.

Values from [`DateLevels`](../../sdk-data/variables/variable.DateLevels.md).

***

### includeSubTotals

> **includeSubTotals**?: `boolean`

Boolean flag whether to include subtotals for this dimension in the pivot table.

***

### isColored

> **isColored**?: `boolean`

***

### isHtml

> **isHtml**?: `boolean`

Boolean flag whether to render category/column value as HTML in the Table component.

***

### name

> **name**?: `string`

Name of the column.

***

lean`

***

### isHtml

> **isHtml**?: `boolean`

Boolean flag whether to render category/column value as HTML in the Table component.

***

### name

> **name**?: `string`

Name of the column.

***

### numberFormatConfig

> **numberFormatConfig**?: [`NumberFormatConfig`](../type-aliases/type-alias.NumberFormatConfig.md)

Configuration for number formatting.

***

### sortType

> **sortType**?: [`PivotRowsSort`](../type-aliases/type-alias.PivotRowsSort.md) \| [`SortDirection`](../type-aliases/type-alias.SortDirection.md)

Sorting configuration that represents either [SortDirection](../type-aliases/type-alias.SortDirection.md) or [PivotRowsSort](../type-aliases/type-alias.PivotRowsSort.md) for the pivot table

# Interface StyledMeasureColumn

Wrapped [Measure Column](../../sdk-data/interfaces/interface.MeasureColumn.md) with styles
controlling how the measure is visualized in a chart.

for the pivot table

# Interface StyledMeasureColumn

Wrapped [Measure Column](../../sdk-data/interfaces/interface.MeasureColumn.md) with styles
controlling how the measure is visualized in a chart.

## Example

Example of using `StyledMeasureColumn` to mix a column series of `Total Revenue` to a line chart.

Note that the chart doesn't display a second Y-axis on the right but that can be customized by
style options.

```ts
<Chart
  dataSet={DM.DataSource}
  chartType={'line'}
  dataOptions={{
    category: [
      {
        column: DM.Commerce.Date.Months,
        dateFormat: 'yy-MM',
      },
    ],
    value: [
      measureFactory.sum(DM.Commerce.Revenue),
      {
        column: measureFactory.sum(DM.Commerce.Quantity),
        showOnRightAxis: true,
        chartType: 'column',
      },
    ],
    breakBy: [],
  }}
/>
```

<img src="../../../img/chart-mixed-series-example-1.png" width="800px" />

See also [StyledColumn](interface.StyledColumn.md).

## Properties

### chartType

> **chartType**?: [`SeriesChartType`](../type-aliases/type-alias.SeriesChartType.md)

Series chart type, which is used with [StyledMeasureColumn](interface.StyledMeasureColumn.md) to customize
series in a mixed chart.

***

### color

> **color**?: [`DataColorOptions`](../type-aliases/type-alias.DataColorOptions.md)

All possible color options for data.

***

MeasureColumn.md) to customize
series in a mixed chart.

***

### color

> **color**?: [`DataColorOptions`](../type-aliases/type-alias.DataColorOptions.md)

All possible color options for data.

***

### column

> **column**: [`CalculatedMeasureColumn`](../../sdk-data/interfaces/interface.CalculatedMeasureColumn.md) \| [`MeasureColumn`](../../sdk-data/interfaces/interface.MeasureColumn.md)

Wrapped MeasureColumn or CalculatedMeasureColumn

***

### connectNulls

> **connectNulls**?: `boolean`

Boolean flag whether to connect a graph line across null points or render a gap

***

### dataBars

> **dataBars**?: `boolean`

Boolean flag whether to display data bars for this measure in the pivot table.

***

### dataBarsColor

> **dataBarsColor**?: [`ConditionalDataColorOptions`](../type-aliases/type-alias.ConditionalDataColorOptions.md) \| [`UniformDataColorOptions`](../type-aliases/type-alias.UniformDataColorOptions.md) \| `string`

Color options for data bars for this measure in the pivot table

***

### name

> **name**?: `string`

Name of the measure.

***

### numberFormatConfig

> **numberFormatConfig**?: [`NumberFormatConfig`](../type-aliases/type-alias.NumberFormatConfig.md)

Configuration for number formatting.

***

### seriesStyleOptions

> **seriesStyleOptions**?: [`SeriesStyleOptions`](../../sdk-ui/type-aliases/type-alias.SeriesStyleOptions.md)

Specific style options to be applied to specific series in Chart.
Supported only for cartesian and polar charts.

***

eriesStyleOptions`](../../sdk-ui/type-aliases/type-alias.SeriesStyleOptions.md)

Specific style options to be applied to specific series in Chart.
Supported only for cartesian and polar charts.

***

### showOnRightAxis

> **showOnRightAxis**?: `boolean`

Boolean flag whether to show this value/measure
on the right axis (`true`) or on the left axis (`false`).

***

### sortType

> **sortType**?: [`SortDirection`](../type-aliases/type-alias.SortDirection.md)

Sorting direction, either in Ascending order, Descending order, or None

***

### totalsCalculation

> **totalsCalculation**?: [`TotalsCalculation`](../../sdk-data/type-aliases/type-alias.TotalsCalculation.md)

Calculation for the totals of this measure in the pivot table.

***

### treatNullDataAsZeros

> **treatNullDataAsZeros**?: `boolean`

Boolean flag whether null values are treated as zeros in the chart

# Interface SunburstChartProps

Props of the [SunburstChartComponent](../charts/class.SunburstChartComponent.md).

## Properties

Boolean flag whether null values are treated as zeros in the chart

# Interface SunburstChartProps

Props of the [SunburstChartComponent](../charts/class.SunburstChartComponent.md).

## Properties

### Data

#### dataSet

> **dataSet**?: [`Data`](../../sdk-data/interfaces/interface.Data.md) \| [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md)

Data set for a chart using one of the following options. If neither option is specified, the chart
will use the `defaultDataSource` specified in the parent `SisenseContextProvider`
component.

(1) Sisense data source name as a string. For example, `'Sample ECommerce'`. Typically, you
retrieve the data source name from a data model you create using the `get-data-model`
[command](https://developer.sisense.com/guides/sdk/guides/cli.html) of the Compose SDK CLI. The chart
connects to the data source, executes a query, and loads the data as specified in
`dataOptions`, `filters`, and `highlights`.

To learn more about using data from a Sisense data source, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#sisense-data).

OR

(2) Explicit [`Data`](../../sdk-data/interfaces/interface.Data.md), which is made up of an array of
[`Column`](../../sdk-data/interfaces/interface.Column.md) objects and a two-dimensional array of row data. This approach
allows the chart component to be used with any data you provide.

To learn more about using data from an external data source, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#explicit-data).

Example data in the proper format:

```ts
const sampleData = {
  columns: [
    { name: 'Years', type: 'date' },
    { name: 'Quantity', type: 'number' },
    { name: 'Units', type: 'number' },
  ],
  rows: [
    ['2019', 5500, 1500],
    ['2020', 4471, 7000],
    ['2021', 1812, 5000],
    ['2022', 5001, 6000],
    ['2023', 2045, 4000],
  ],
};
```

***

#### filters

> **filters**?: [`FilterRelations`](../../sdk-data/interfaces/interface.FilterRelations.md) \| [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Filters to limit (or slice) a chart’s data using one of the following options.

(1) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) or [FilterRelations](../../sdk-data/interfaces/interface.FilterRelations.md) returned from filter factory functions, such as
[`greaterThan()`](../../sdk-data/factories/namespace.filterFactory/functions/function.greaterThan.md) and [`members()`](../../sdk-data/factories/namespace.filterFactory/functions/function.members.md).

Use this option for filters that do not require a UI to set them
or for filters where you will supply your own UI components or use pre-built UI components. This is the most common option.

To learn more about using filter factory functions to create filters, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-functions).

(2) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) controlled by filter UI components – for example [`MemberFilterTile`](../../sdk-ui/filter-tiles/function.MemberFilterTile.md).

Use this option for filters that you want your users to set using pre-built UI components.

To learn more about using filter UI components to create filters, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components).

***

#### highlights

> **highlights**?: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Highlights based on filter criteria to apply to a chart using one of the following options.

NOTE that the filter dimensions used in highlights must match those defined in the
`dataOptions` of the chart. Otherwise, the filters will be applied as regular slice filters.

(1) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) returned from filter factory functions, such as
[`greaterThan()`](../../sdk-data/factories/namespace.filterFactory/functions/function.greaterThan.md) and [`members()`](../../sdk-data/factories/namespace.filterFactory/functions/function.members.md).

Use this option for highlights that do not require a UI to set them
or for highlights where you will supply your own UI components or use pre-built UI components. This is the most common option.

To learn more about using filter factory functions to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-functions-for-highlighting).

(2) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) controlled by filter UI components – for example [`MemberFilterTile`](../../sdk-ui/filter-tiles/function.MemberFilterTile.md).

Use this option for highlights that you want your users to set using pre-built UI components.

To learn more about using filter components to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components-for-highlighting).

ts.

To learn more about using filter components to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components-for-highlighting).

### Chart

#### dataOptions

> **dataOptions**: [`CategoricalChartDataOptions`](interface.CategoricalChartDataOptions.md)

Configurations for how to interpret and present the data passed to the chart

***

#### styleOptions

> **styleOptions**?: [`SunburstStyleOptions`](interface.SunburstStyleOptions.md)

Configurations for how to style and present a chart's data.

nt the data passed to the chart

***

#### styleOptions

> **styleOptions**?: [`SunburstStyleOptions`](interface.SunburstStyleOptions.md)

Configurations for how to style and present a chart's data.

### Callbacks

#### beforeRender

> **beforeRender**?: [`BeforeRenderHandler`](../type-aliases/type-alias.BeforeRenderHandler.md)

A callback that allows you to customize the underlying chart element before it is rendered. The returned options are then used when rendering the chart.

This callback is not supported for Areamap Chart, Scattermap Chart, Table, and PivotTable.

***

#### dataPointClick

> **dataPointClick**?: [`DataPointEventHandler`](../type-aliases/type-alias.DataPointEventHandler.md)

Click handler callback for a data point

***

#### dataPointContextMenu

> **dataPointContextMenu**?: [`DataPointEventHandler`](../type-aliases/type-alias.DataPointEventHandler.md)

Context menu handler callback for a data point

***

#### dataPointsSelect

> **dataPointsSelect**?: [`DataPointsEventHandler`](../type-aliases/type-alias.DataPointsEventHandler.md)

Handler callback for selection of multiple data points

***

#### dataReady

> **dataReady**?: (`data`) => [`Data`](../../sdk-data/interfaces/interface.Data.md)

A callback that allows to modify data immediately after it has been retrieved.
It can be used to inject modification of queried data.

##### Parameters

| Parameter | Type |
| :------ | :------ |
| `data` | [`Data`](../../sdk-data/interfaces/interface.Data.md) |

##### Returns

[`Data`](../../sdk-data/interfaces/interface.Data.md)

##### Parameters

| Parameter | Type |
| :------ | :------ |
| `data` | [`Data`](../../sdk-data/interfaces/interface.Data.md) |

##### Returns

[`Data`](../../sdk-data/interfaces/interface.Data.md)

# Interface SunburstStyleOptions

Configuration options that define functional style of the various elements of the SunburstChart component

## Properties

### dataLimits

> **dataLimits**?: [`DataLimits`](interface.DataLimits.md)

Data limit for series or categories that will be plotted

***

### height

> **height**?: `number`

Total height of the component, which is considered in the following order of priority:

1. Value passed to this property (in pixels).
2. Height of the container wrapping this component
3. Default value of 400px (for component without header) or 425px (for component with header).

***

### labels

> **labels**?: `object`

Labels options object

::: warning Deprecated
Please use `seriesLabels` instead
:::

#### Type declaration

> ##### `labels.category`
>
> **category**?: \{
> `enabled`: `boolean`;
> }[]
>
> Array with single label options objects (order of items relative to dataOptions.category)
>
>

***

### legend

> **legend**?: [`LegendOptions`](../../sdk-ui/type-aliases/type-alias.LegendOptions.md)

Configuration for legend - a key that provides information about the data series or colors used in chart

***

> **legend**?: [`LegendOptions`](../../sdk-ui/type-aliases/type-alias.LegendOptions.md)

Configuration for legend - a key that provides information about the data series or colors used in chart

***

### seriesLabels

> **seriesLabels**?: [`SunburstSeriesLabels`](../../sdk-ui/type-aliases/type-alias.SunburstSeriesLabels.md)

Configuration for series labels - titles/names identifying data series in a chart
Single label options object would be applied to all levels.
Array of label options objects would be applied to each level.

#### Example

Single label options object would enable labels for all levels.
```typescript
{
  seriesLabels: {
      enabled: true,
  },
}
```

#### Example

Array of label options objects would disable labels for first level and enable labels for second level.
```typescript
{
  seriesLabels: [
    {
      enabled: false,
    },
    {
      enabled: true,
    },
  ],
}
```

***

### tooltip

> **tooltip**?: `object`

Tooltip options object

#### Type declaration

> ##### `tooltip.mode`
>
> **mode**?: `"contribution"` \| `"value"`
>
> Define mode of data showing
>
>

***

### width

> **width**?: `number`

Total width of the component, which is considered in the following order of priority:

1. Value passed to this property (in pixels)
2. Width of the container wrapping this component
3. Default value of 400px

# Interface TableDataOptions

Configuration for how to query data and assign data to Table.

## Properties

ty (in pixels)
2. Width of the container wrapping this component
3. Default value of 400px

# Interface TableDataOptions

Configuration for how to query data and assign data to Table.

## Properties

### columns

> **columns**: ([`CalculatedMeasureColumn`](../../sdk-data/interfaces/interface.CalculatedMeasureColumn.md) \| [`Column`](../../sdk-data/interfaces/interface.Column.md) \| [`MeasureColumn`](../../sdk-data/interfaces/interface.MeasureColumn.md) \| [`StyledColumn`](interface.StyledColumn.md) \| [`StyledMeasureColumn`](interface.StyledMeasureColumn.md))[]

Columns (or attributes) whose values represent data columns in table

# Interface TableProps

Props of the [TableComponent](../data-grids/class.TableComponent.md).

## Properties

asureColumn.md))[]

Columns (or attributes) whose values represent data columns in table

# Interface TableProps

Props of the [TableComponent](../data-grids/class.TableComponent.md).

## Properties

### Data

#### dataSet

> **dataSet**?: [`Data`](../../sdk-data/interfaces/interface.Data.md) \| [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md)

Data set for a chart using one of the following options. If neither option is specified, the chart
will use the `defaultDataSource` specified in the parent `SisenseContextProvider`
component.

(1) Sisense data source name as a string. For example, `'Sample ECommerce'`. Typically, you
retrieve the data source name from a data model you create using the `get-data-model`
[command](https://developer.sisense.com/guides/sdk/guides/cli.html) of the Compose SDK CLI. The chart
connects to the data source, executes a query, and loads the data as specified in
`dataOptions`, `filters`, and `highlights`.

To learn more about using data from a Sisense data source, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#sisense-data).

OR

(2) Explicit [`Data`](../../sdk-data/interfaces/interface.Data.md), which is made up of an array of
[`Column`](../../sdk-data/interfaces/interface.Column.md) objects and a two-dimensional array of row data. This approach
allows the chart component to be used with any data you provide.

To learn more about using data from an external data source, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#explicit-data).

Example data in the proper format:

```ts
const sampleData = {
  columns: [
    { name: 'Years', type: 'date' },
    { name: 'Quantity', type: 'number' },
    { name: 'Units', type: 'number' },
  ],
  rows: [
    ['2019', 5500, 1500],
    ['2020', 4471, 7000],
    ['2021', 1812, 5000],
    ['2022', 5001, 6000],
    ['2023', 2045, 4000],
  ],
};
```

***

#### filters

> **filters**?: [`FilterRelations`](../../sdk-data/interfaces/interface.FilterRelations.md) \| [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Filters that will slice query results

ers

> **filters**?: [`FilterRelations`](../../sdk-data/interfaces/interface.FilterRelations.md) \| [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Filters that will slice query results

### Callbacks

#### dataReady

> **dataReady**?: (`data`) => [`Data`](../../sdk-data/interfaces/interface.Data.md)

A callback that allows to modify data immediately after it has been retrieved.
It can be used to inject modification of queried data.

##### Parameters

| Parameter | Type |
| :------ | :------ |
| `data` | [`Data`](../../sdk-data/interfaces/interface.Data.md) |

##### Returns

[`Data`](../../sdk-data/interfaces/interface.Data.md)

### Representation

#### dataOptions

> **dataOptions**: [`TableDataOptions`](interface.TableDataOptions.md)

Configurations for how to interpret and present the data passed to the component

***

#### styleOptions

> **styleOptions**?: [`TableStyleOptions`](interface.TableStyleOptions.md)

Configurations for how to style and present a table's data.

# Interface TableStyleOptions

Configuration options that define functional style of the various elements of the Table Component

## Properties

urations for how to style and present a table's data.

# Interface TableStyleOptions

Configuration options that define functional style of the various elements of the Table Component

## Properties

### columns

> **columns**?: `object`

Columns options

#### Type declaration

> ##### `columns.alternatingColor`
>
> **alternatingColor**?: [`TableColorOptions`](../../sdk-ui/type-aliases/type-alias.TableColorOptions.md)
>
> Alternating color for columns
>
> ##### `columns.width`
>
> **width**?: `"auto"` \| `"content"`
>
> Modes of columns width
> 'auto' - all columns will have the same width and fit the table width (no horizontal scroll)
> 'content' - columns width will be based on content (default option)
>
>

***

### header

> **header**?: `object`

Header options

#### Type declaration

> ##### `header.color`
>
> **color**?: [`TableColorOptions`](../../sdk-ui/type-aliases/type-alias.TableColorOptions.md)
>
> Color of header
>
>

***

### height

> **height**?: `number`

Total height of the component, which is considered in the following order of priority:

1. Value passed to this property (in pixels).
2. Height of the container wrapping this component
3. Default value of 500px (for component without header) or 525px (for component with header).

***

### paddingHorizontal

> **paddingHorizontal**?: `number`

Horizontal padding around whole table
Default value is 20px

***

(for component without header) or 525px (for component with header).

***

### paddingHorizontal

> **paddingHorizontal**?: `number`

Horizontal padding around whole table
Default value is 20px

***

### paddingVertical

> **paddingVertical**?: `number`

Vertical padding around whole table
Default value is 20px

***

### rows

> **rows**?: `object`

Rows options

#### Type declaration

> ##### `rows.alternatingColor`
>
> **alternatingColor**?: [`TableColorOptions`](../../sdk-ui/type-aliases/type-alias.TableColorOptions.md)
>
> Alternating color for rows
>
>

***

### rowsPerPage

> **rowsPerPage**?: `number`

Number of rows per page

Default value is 25

***

### width

> **width**?: `number`

Total width of the component, which is considered in the following order of priority:

1. Value passed to this property (in pixels)
2. Width of the container wrapping this component
3. Default value of 400px

# Interface TextWidgetProps

Props for the text widget.

## Properties

### Widget

#### styleOptions

> **styleOptions**: [`TextWidgetStyleOptions`](../../sdk-ui/type-aliases/type-alias.TextWidgetStyleOptions.md)

Style options for the text widget.

# Interface ThemeSettings

Theme settings defining the look and feel of components.

## Properties

### aiChat

> **aiChat**?: [`AiChatThemeSettings`](../../sdk-ui/interfaces/interface.AiChatThemeSettings.md)

Theme settings specific to the AI Chatbot component

***

of components.

## Properties

### aiChat

> **aiChat**?: [`AiChatThemeSettings`](../../sdk-ui/interfaces/interface.AiChatThemeSettings.md)

Theme settings specific to the AI Chatbot component

***

### chart

> **chart**?: [`ChartThemeSettings`](../../sdk-ui/interfaces/interface.ChartThemeSettings.md)

Chart theme settings

***

### filter

> **filter**?: [`FilterThemeSettings`](../../sdk-ui/type-aliases/type-alias.FilterThemeSettings.md)

Filter theme settings

***

### general

> **general**?: [`GeneralThemeSettings`](../../sdk-ui/interfaces/interface.GeneralThemeSettings.md)

General theme settings

***

### palette

> **palette**?: [`ColorPaletteTheme`](../type-aliases/type-alias.ColorPaletteTheme.md)

Collection of colors used to color various elements

***

### typography

> **typography**?: [`TypographyThemeSettings`](../../sdk-ui/interfaces/interface.TypographyThemeSettings.md)

Text theme settings

***

### widget

> **widget**?: [`WidgetThemeSettings`](../../sdk-ui/type-aliases/type-alias.WidgetThemeSettings.md)

Widget theme settings

# Interface TreemapChartProps

Props of the [TreemapChartComponent](../charts/class.TreemapChartComponent.md).

## Properties

/type-aliases/type-alias.WidgetThemeSettings.md)

Widget theme settings

# Interface TreemapChartProps

Props of the [TreemapChartComponent](../charts/class.TreemapChartComponent.md).

## Properties

### Data

#### dataSet

> **dataSet**?: [`Data`](../../sdk-data/interfaces/interface.Data.md) \| [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md)

Data set for a chart using one of the following options. If neither option is specified, the chart
will use the `defaultDataSource` specified in the parent `SisenseContextProvider`
component.

(1) Sisense data source name as a string. For example, `'Sample ECommerce'`. Typically, you
retrieve the data source name from a data model you create using the `get-data-model`
[command](https://developer.sisense.com/guides/sdk/guides/cli.html) of the Compose SDK CLI. The chart
connects to the data source, executes a query, and loads the data as specified in
`dataOptions`, `filters`, and `highlights`.

To learn more about using data from a Sisense data source, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#sisense-data).

OR

(2) Explicit [`Data`](../../sdk-data/interfaces/interface.Data.md), which is made up of an array of
[`Column`](../../sdk-data/interfaces/interface.Column.md) objects and a two-dimensional array of row data. This approach
allows the chart component to be used with any data you provide.

To learn more about using data from an external data source, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#explicit-data).

Example data in the proper format:

```ts
const sampleData = {
  columns: [
    { name: 'Years', type: 'date' },
    { name: 'Quantity', type: 'number' },
    { name: 'Units', type: 'number' },
  ],
  rows: [
    ['2019', 5500, 1500],
    ['2020', 4471, 7000],
    ['2021', 1812, 5000],
    ['2022', 5001, 6000],
    ['2023', 2045, 4000],
  ],
};
```

***

#### filters

> **filters**?: [`FilterRelations`](../../sdk-data/interfaces/interface.FilterRelations.md) \| [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Filters to limit (or slice) a chart’s data using one of the following options.

(1) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) or [FilterRelations](../../sdk-data/interfaces/interface.FilterRelations.md) returned from filter factory functions, such as
[`greaterThan()`](../../sdk-data/factories/namespace.filterFactory/functions/function.greaterThan.md) and [`members()`](../../sdk-data/factories/namespace.filterFactory/functions/function.members.md).

Use this option for filters that do not require a UI to set them
or for filters where you will supply your own UI components or use pre-built UI components. This is the most common option.

To learn more about using filter factory functions to create filters, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-functions).

(2) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) controlled by filter UI components – for example [`MemberFilterTile`](../../sdk-ui/filter-tiles/function.MemberFilterTile.md).

Use this option for filters that you want your users to set using pre-built UI components.

To learn more about using filter UI components to create filters, see the [Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components).

***

#### highlights

> **highlights**?: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Highlights based on filter criteria to apply to a chart using one of the following options.

NOTE that the filter dimensions used in highlights must match those defined in the
`dataOptions` of the chart. Otherwise, the filters will be applied as regular slice filters.

(1) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) returned from filter factory functions, such as
[`greaterThan()`](../../sdk-data/factories/namespace.filterFactory/functions/function.greaterThan.md) and [`members()`](../../sdk-data/factories/namespace.filterFactory/functions/function.members.md).

Use this option for highlights that do not require a UI to set them
or for highlights where you will supply your own UI components or use pre-built UI components. This is the most common option.

To learn more about using filter factory functions to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-functions-for-highlighting).

(2) Array of [Filter](../../sdk-data/interfaces/interface.Filter.md) controlled by filter UI components – for example [`MemberFilterTile`](../../sdk-ui/filter-tiles/function.MemberFilterTile.md).

Use this option for highlights that you want your users to set using pre-built UI components.

To learn more about using filter components to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components-for-highlighting).

ts.

To learn more about using filter components to create highlights, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#filter-components-for-highlighting).

### Chart

#### dataOptions

> **dataOptions**: [`CategoricalChartDataOptions`](interface.CategoricalChartDataOptions.md)

Configurations for how to interpret and present the data passed to the chart

***

#### styleOptions

> **styleOptions**?: [`TreemapStyleOptions`](interface.TreemapStyleOptions.md)

Configurations for how to style and present a chart's data.

sent the data passed to the chart

***

#### styleOptions

> **styleOptions**?: [`TreemapStyleOptions`](interface.TreemapStyleOptions.md)

Configurations for how to style and present a chart's data.

### Callbacks

#### beforeRender

> **beforeRender**?: [`BeforeRenderHandler`](../type-aliases/type-alias.BeforeRenderHandler.md)

A callback that allows you to customize the underlying chart element before it is rendered. The returned options are then used when rendering the chart.

This callback is not supported for Areamap Chart, Scattermap Chart, Table, and PivotTable.

***

#### dataPointClick

> **dataPointClick**?: [`DataPointEventHandler`](../type-aliases/type-alias.DataPointEventHandler.md)

Click handler callback for a data point

***

#### dataPointContextMenu

> **dataPointContextMenu**?: [`DataPointEventHandler`](../type-aliases/type-alias.DataPointEventHandler.md)

Context menu handler callback for a data point

***

#### dataPointsSelect

> **dataPointsSelect**?: [`DataPointsEventHandler`](../type-aliases/type-alias.DataPointsEventHandler.md)

Handler callback for selection of multiple data points

***

#### dataReady

> **dataReady**?: (`data`) => [`Data`](../../sdk-data/interfaces/interface.Data.md)

A callback that allows to modify data immediately after it has been retrieved.
It can be used to inject modification of queried data.

##### Parameters

| Parameter | Type |
| :------ | :------ |
| `data` | [`Data`](../../sdk-data/interfaces/interface.Data.md) |

##### Returns

[`Data`](../../sdk-data/interfaces/interface.Data.md)

##### Parameters

| Parameter | Type |
| :------ | :------ |
| `data` | [`Data`](../../sdk-data/interfaces/interface.Data.md) |

##### Returns

[`Data`](../../sdk-data/interfaces/interface.Data.md)

# Interface TreemapStyleOptions

Configuration options that define functional style of the various elements of TreemapChart

## Properties

### dataLimits

> **dataLimits**?: [`DataLimits`](interface.DataLimits.md)

Data limit for series or categories that will be plotted

***

### height

> **height**?: `number`

Total height of the component, which is considered in the following order of priority:

1. Value passed to this property (in pixels).
2. Height of the container wrapping this component
3. Default value of 400px (for component without header) or 425px (for component with header).

***

### labels

> **labels**?: `object`

Labels options object

::: warning Deprecated
Please use `seriesLabels` instead
:::

#### Type declaration

> ##### `labels.category`
>
> **category**?: \{
> `enabled`: `boolean`;
> }[]
>
> Array with single label options objects (order of items relative to dataOptions.category)
>
>

***

### legend

> **legend**?: [`LegendOptions`](../../sdk-ui/type-aliases/type-alias.LegendOptions.md)

Configuration for legend - a key that provides information about the data series or colors used in chart

***

> **legend**?: [`LegendOptions`](../../sdk-ui/type-aliases/type-alias.LegendOptions.md)

Configuration for legend - a key that provides information about the data series or colors used in chart

***

### seriesLabels

> **seriesLabels**?: [`TreemapSeriesLabels`](../../sdk-ui/type-aliases/type-alias.TreemapSeriesLabels.md)

Configuration for series labels - titles/names identifying data series in a chart
Single label options object would be applied to all levels.
Array of label options objects would be applied to each level.

#### Example

Single label options object would enable labels for all levels.
```typescript
{
  seriesLabels: {
      enabled: true,
  },
}
```

#### Example

Array of label options objects would disable labels for first level and enable labels for second level.
```typescript
{
  seriesLabels: [
    {
      enabled: false,
    },
    {
      enabled: true,
    },
  ],
}
```

***

### tooltip

> **tooltip**?: `object`

Tooltip options object

#### Type declaration

> ##### `tooltip.mode`
>
> **mode**?: `"contribution"` \| `"value"`
>
> Define mode of data showing
>
>

***

### width

> **width**?: `number`

Total width of the component, which is considered in the following order of priority:

1. Value passed to this property (in pixels)
2. Width of the container wrapping this component
3. Default value of 400px

# Interface WidgetByIdProps

Props of the [WidgetByIdComponent](../fusion-assets/class.WidgetByIdComponent.md).

## Properties

dth of the container wrapping this component
3. Default value of 400px

# Interface WidgetByIdProps

Props of the [WidgetByIdComponent](../fusion-assets/class.WidgetByIdComponent.md).

## Properties

### Data

#### filters

> **filters**?: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Filters that will slice query results

Provided filters will be merged with the existing filters from the widget configuration.

***

#### filtersMergeStrategy

> **filtersMergeStrategy**?: `"codeFirst"` \| `"codeOnly"` \| `"widgetFirst"`

Strategy for merging the existing widget filters (including highlights) with the filters provided via the `filters` and `highlights` props:

- `widgetFirst` - prioritizes the widget filters over the provided filters in case of filter conflicts by certain attributes.
- `codeFirst` - prioritizes the provided filters over the widget filters in case of filter conflicts by certain attributes.
- `codeOnly` - applies only the provided filters and completely ignores the widget filters.

If not specified, the default strategy is `codeFirst`.

***

#### highlights

> **highlights**?: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Highlight filters that will highlight results that pass filter criteria

***

#### includeDashboardFilters

> **includeDashboardFilters**?: `boolean`

Boolean flag whether to include dashboard filters in the widget's `filters` and `highlights`

If not specified, the default value is `false`.

boardFilters

> **includeDashboardFilters**?: `boolean`

Boolean flag whether to include dashboard filters in the widget's `filters` and `highlights`

If not specified, the default value is `false`.

### Widget

#### dashboardOid

> **dashboardOid**: `string`

Identifier of the dashboard that contains the widget

***

#### description

> **description**?: `string`

Description of the widget

If not specified, it takes the existing value from the widget configuration.

***

#### highlightSelectionDisabled

> **highlightSelectionDisabled**?: `boolean`

Boolean flag whether selecting data points triggers highlight filter of the selected data

Recommended to turn on when the Chart Widget component is enhanced with data drilldown by the Drilldown Widget component

If not specified, the default value is `false`

***

#### styleOptions

> **styleOptions**?: [`WidgetByIdStyleOptions`](interface.WidgetByIdStyleOptions.md)

Style options for the widget including the widget container and the chart or table inside.

***

#### title

> **title**?: `string`

Title of the widget

If not specified, it takes the existing value from the widget configuration.

***

#### widgetOid

> **widgetOid**: `string`

Identifier of the widget

e

> **title**?: `string`

Title of the widget

If not specified, it takes the existing value from the widget configuration.

***

#### widgetOid

> **widgetOid**: `string`

Identifier of the widget

### Callbacks

#### dataReady

> **dataReady**?: (`data`) => [`Data`](../../sdk-data/interfaces/interface.Data.md)

A callback that allows to modify data immediately after it has been retrieved.
It can be used to inject modification of queried data.

##### Parameters

| Parameter | Type |
| :------ | :------ |
| `data` | [`Data`](../../sdk-data/interfaces/interface.Data.md) |

##### Returns

[`Data`](../../sdk-data/interfaces/interface.Data.md)

# Interface WidgetByIdStyleOptions

Style settings defining the look and feel of the widget created in Fusion

## Properties

### backgroundColor

> **backgroundColor**?: `string`

Widget background color

Affects chart background color as well

***

### border

> **border**?: `boolean`

Widget container border toggle

***

### borderColor

> **borderColor**?: `string`

Widget container border color

***

### cornerRadius

> **cornerRadius**?: [`RadiusSizes`](../../sdk-ui/type-aliases/type-alias.RadiusSizes.md)

Corner radius of the widget container

***

`string`

Widget container border color

***

### cornerRadius

> **cornerRadius**?: [`RadiusSizes`](../../sdk-ui/type-aliases/type-alias.RadiusSizes.md)

Corner radius of the widget container

***

### header

> **header**?: `object`

Widget header styles

#### Type declaration

> ##### `header.backgroundColor`
>
> **backgroundColor**?: `string`
>
> Header background color
>
> ##### `header.dividerLine`
>
> **dividerLine**?: `boolean`
>
> Toggle of the divider line between widget header and chart
>
> ##### `header.dividerLineColor`
>
> **dividerLineColor**?: `string`
>
> Divider line color
>
> ##### `header.hidden`
>
> **hidden**?: `boolean`
>
> Header visibility toggle
>
> ##### `header.titleAlignment`
>
> **titleAlignment**?: [`AlignmentTypes`](../../sdk-ui/type-aliases/type-alias.AlignmentTypes.md)
>
> Header title alignment
>
> ##### `header.titleTextColor`
>
> **titleTextColor**?: `string`
>
> Header title text color
>
>

***

### height

> **height**?: `number`

Total height of the component, which is considered in the following order of priority:

1. Value passed to this property (in pixels).
2. Height of the container wrapping this component
3. Default value as specified per chart type

***

### shadow

> **shadow**?: [`ShadowsTypes`](../../sdk-ui/type-aliases/type-alias.ShadowsTypes.md)

Shadow level of the widget container

Effective only when spaceAround is defined

***

rt type

***

### shadow

> **shadow**?: [`ShadowsTypes`](../../sdk-ui/type-aliases/type-alias.ShadowsTypes.md)

Shadow level of the widget container

Effective only when spaceAround is defined

***

### spaceAround

> **spaceAround**?: [`SpaceSizes`](../../sdk-ui/type-aliases/type-alias.SpaceSizes.md)

Space between widget container edge and the chart

***

### width

> **width**?: `number`

Total width of the component, which is considered in the following order of priority:

1. Value passed to this property (in pixels)
2. Width of the container wrapping this component
3. Default value as specified per chart type

# Interface WidgetsPanelColumnLayout

Dashboard layout, which describes how widgets are arranged in the dashboard

## Properties

### columns

> **columns**: [`WidgetsPanelColumn`](../../sdk-ui/interfaces/interface.WidgetsPanelColumn.md)[]


## Type Aliases

ch describes how widgets are arranged in the dashboard

## Properties

### columns

> **columns**: [`WidgetsPanelColumn`](../../sdk-ui/interfaces/interface.WidgetsPanelColumn.md)[]


## Type Aliases

# Type Aliases

TypeScript type aliases for components and services listed above

- [AppConfig](type-alias.AppConfig.md)
- [AreamapChartType](type-alias.AreamapChartType.md)
- [AreamapDataPointEvent](type-alias.AreamapDataPointEvent.md)
- [AreamapDataPointEventHandler](type-alias.AreamapDataPointEventHandler.md)
- [AreaSubtype](type-alias.AreaSubtype.md)
- [AxisLabel](type-alias.AxisLabel.md)
- [BeforeRenderHandler](type-alias.BeforeRenderHandler.md)
- [BoxplotChartCustomDataOptions](type-alias.BoxplotChartCustomDataOptions.md)
- [BoxplotChartDataOptions](type-alias.BoxplotChartDataOptions.md)
- [BoxplotChartType](type-alias.BoxplotChartType.md)
- [BoxplotDataPoint](type-alias.BoxplotDataPoint.md)
- [BoxplotDataPointEvent](type-alias.BoxplotDataPointEvent.md)
- [BoxplotDataPointEventHandler](type-alias.BoxplotDataPointEventHandler.md)
- [BoxplotDataPointsEvent](type-alias.BoxplotDataPointsEvent.md)
- [BoxplotSubtype](type-alias.BoxplotSubtype.md)
- [BoxWhiskerType](type-alias.BoxWhiskerType.md)
- [CalendarDayOfWeek](type-alias.CalendarDayOfWeek.md)
- [CalendarHeatmapChartType](type-alias.CalendarHeatmapChartType.md)
- [CalendarHeatmapDataPoint](type-alias.CalendarHeatmapDataPoint.md)
- [CalendarHeatmapDataPointEvent](type-alias.CalendarHeatmapDataPointEvent.md)
- [CalendarHeatmapDataPointEventHandler](type-alias.CalendarHeatmapDataPointEventHandler.md)
- [CalendarHeatmapDataPointsEvent](type-alias.CalendarHeatmapDataPointsEvent.md)
- [CalendarHeatmapDataPointsEventHandler](type-alias.CalendarHeatmapDataPointsEventHandler.md)
- [CalendarHeatmapSubtype](type-alias.CalendarHeatmapSubtype.md)
- [CalendarHeatmapViewType](type-alias.CalendarHeatmapViewType.md)
- [CartesianChartType](type-alias.CartesianChartType.md)
- [CartesianWidgetType](type-alias.CartesianWidgetType.md)
- [CategoricalChartType](type-alias.CategoricalChartType.md)
- [CategoricalWidgetType](type-alias.CategoricalWidgetType.md)
- [ChartDataOptions](type-alias.ChartDataOptions.md)
- [ChartDataPointClickEvent](type-alias.ChartDataPointClickEvent.md)
- [ChartDataPointClickEventHandler](type-alias.ChartDataPointClickEventHandler.md)
- [ChartDataPointContextMenuEvent](type-alias.ChartDataPointContextMenuEvent.md)
- [ChartDataPointContextMenuEventHandler](type-alias.ChartDataPointContextMenuEventHandler.md)
- [ChartDataPointsEvent](type-alias.ChartDataPointsEvent.md)
- [ChartDataPointsEventHandler](type-alias.ChartDataPointsEventHandler.md)
- [ChartStyleOptions](type-alias.ChartStyleOptions.md)
- [ChartType](type-alias.ChartType.md)
- [ChartWidgetStyleOptions](type-alias.ChartWidgetStyleOptions.md)
- [Color](type-alias.Color.md)
- [ColorPaletteTheme](type-alias.ColorPaletteTheme.md)
- [ConditionalDataColorOptions](type-alias.ConditionalDataColorOptions.md)
- [Convolution](type-alias.Convolution.md)
- [CustomDrilldownResult](type-alias.CustomDrilldownResult.md)
- [CustomWidgetComponent](type-alias.CustomWidgetComponent.md)
- [DashStyle](type-alias.DashStyle.md)
- [DataColorCondition](type-alias.DataColorCondition.md)
- [DataColorOptions](type-alias.DataColorOptions.md)
- [DataOptionLocation](type-alias.DataOptionLocation.md)
- [DataPoint](type-alias.DataPoint.md)
- [DataPointEvent](type-alias.DataPointEvent.md)
- [DataPointEventHandler](type-alias.DataPointEventHandler.md)
- [DataPointsEvent](type-alias.DataPointsEvent.md)
- [DataPointsEventHandler](type-alias.DataPointsEventHandler.md)
- [DateConfig](type-alias.DateConfig.md)
- [DateLevel](type-alias.DateLevel.md)
- [DayOfWeek](type-alias.DayOfWeek.md)
- [DecimalScale](type-alias.DecimalScale.md)
- [DrilldownOptions](type-alias.DrilldownOptions.md)
- [DrilldownSelection](type-alias.DrilldownSelection.md)
- [EndCapType](type-alias.EndCapType.md)
- [FilterChangeEvent](type-alias.FilterChangeEvent.md)
- [FilterChangeEventHandler](type-alias.FilterChangeEventHandler.md)
- [FilterDeleteEventHandler](type-alias.FilterDeleteEventHandler.md)
- [FilterEditEvent](type-alias.FilterEditEvent.md)
- [FilterEditEventHandler](type-alias.FilterEditEventHandler.md)
- [FiltersPanelChangeEvent](type-alias.FiltersPanelChangeEvent.md)
- [FiltersPanelChangeEventHandler](type-alias.FiltersPanelChangeEventHandler.md)
- [FilterVariant](type-alias.FilterVariant.md)
- [GenericDataOptions](type-alias.GenericDataOptions.md)
- [IndicatorBeforeRenderHandler](type-alias.IndicatorBeforeRenderHandler.md)
- [IndicatorChartType](type-alias.IndicatorChartType.md)
- [IndicatorComponents](type-alias.IndicatorComponents.md)
- [IndicatorDataPoint](type-alias.IndicatorDataPoint.md)
- [IndicatorDataPointEvent](type-alias.IndicatorDataPointEvent.md)
- [IndicatorDataPointEventHandler](type-alias.IndicatorDataPointEventHandler.md)
- [IndicatorRenderOptions](type-alias.IndicatorRenderOptions.md)
- [IndicatorStyleOptions](type-alias.IndicatorStyleOptions.md)
- [Labels](type-alias.Labels.md)
- [Legend](type-alias.Legend.md)
- [LineOptions](type-alias.LineOptions.md)
- [LineSubtype](type-alias.LineSubtype.md)
- [LineWidth](type-alias.LineWidth.md)
- [Markers](type-alias.Markers.md)
- [MenuItemSection](type-alias.MenuItemSection.md)
- [MenuPosition](type-alias.MenuPosition.md)
- [MonthOfYear](type-alias.MonthOfYear.md)
- [MultiColumnValueToColorMap](type-alias.MultiColumnValueToColorMap.md)
- [Navigator](type-alias.Navigator.md)
- [NumberFormatConfig](type-alias.NumberFormatConfig.md)
- [PieSubtype](type-alias.PieSubtype.md)
- [PivotRowsSort](type-alias.PivotRowsSort.md)
- [PivotTableDataPointEvent](type-alias.PivotTableDataPointEvent.md)
- [PivotTableDataPointEventHandler](type-alias.PivotTableDataPointEventHandler.md)
- [PivotTableDrilldownOptions](type-alias.PivotTableDrilldownOptions.md)
- [PivotTableNonSelectableDrilldownOptions](type-alias.PivotTableNonSelectableDrilldownOptions.md)
- [PivotTableSelectableDrilldownOptions](type-alias.PivotTableSelectableDrilldownOptions.md)
- [PivotTableWidgetStyleOptions](type-alias.PivotTableWidgetStyleOptions.md)
- [PolarSubtype](type-alias.PolarSubtype.md)
- [RangeChartType](type-alias.RangeChartType.md)
- [RangeDataColorOptions](type-alias.RangeDataColorOptions.md)
- [ScatterChartType](type-alias.ScatterChartType.md)
- [ScatterDataPoint](type-alias.ScatterDataPoint.md)
- [ScatterDataPointEvent](type-alias.ScatterDataPointEvent.md)
- [ScatterDataPointEventHandler](type-alias.ScatterDataPointEventHandler.md)
- [ScatterDataPointsEvent](type-alias.ScatterDataPointsEvent.md)
- [ScatterDataPointsEventHandler](type-alias.ScatterDataPointsEventHandler.md)
- [ScattermapChartType](type-alias.ScattermapChartType.md)
- [ScattermapDataPointEvent](type-alias.ScattermapDataPointEvent.md)
- [ScattermapDataPointEventHandler](type-alias.ScattermapDataPointEventHandler.md)
- [ScattermapLocationLevel](type-alias.ScattermapLocationLevel.md)
- [ScattermapMarkers](type-alias.ScattermapMarkers.md)
- [ScatterMarkerSize](type-alias.ScatterMarkerSize.md)
- [SeriesChartType](type-alias.SeriesChartType.md)
- [SeriesLabels](type-alias.SeriesLabels.md)
- [SortDirection](type-alias.SortDirection.md)
- [StackableSubtype](type-alias.StackableSubtype.md)
- [TableType](type-alias.TableType.md)
- [TabularWidgetType](type-alias.TabularWidgetType.md)
- [TextWidgetDataPointEvent](type-alias.TextWidgetDataPointEvent.md)
- [ThemeConfig](type-alias.ThemeConfig.md)
- [ThemeOid](type-alias.ThemeOid.md)
- [TranslationConfig](type-alias.TranslationConfig.md)
- [UniformDataColorOptions](type-alias.UniformDataColorOptions.md)
- [ValueToColorMap](type-alias.ValueToColorMap.md)
- [WidgetDataOptions](type-alias.WidgetDataOptions.md)
- [WidgetDataPointClickEvent](type-alias.WidgetDataPointClickEvent.md)
- [WidgetDataPointClickEventHandler](type-alias.WidgetDataPointClickEventHandler.md)
- [WidgetDataPointContextMenuEvent](type-alias.WidgetDataPointContextMenuEvent.md)
- [WidgetDataPointContextMenuEventHandler](type-alias.WidgetDataPointContextMenuEventHandler.md)
- [WidgetId](type-alias.WidgetId.md)
- [WidgetProps](type-alias.WidgetProps.md)
- [WidgetsOptions](type-alias.WidgetsOptions.md)
- [WidgetsPanelLayout](type-alias.WidgetsPanelLayout.md)
- [WidgetStyleOptions](type-alias.WidgetStyleOptions.md)
- [WidgetType](type-alias.WidgetType.md)
- [WithCommonWidgetProps](type-alias.WithCommonWidgetProps.md)
- [X2Title](type-alias.X2Title.md)

d)
- [WidgetStyleOptions](type-alias.WidgetStyleOptions.md)
- [WidgetType](type-alias.WidgetType.md)
- [WithCommonWidgetProps](type-alias.WithCommonWidgetProps.md)
- [X2Title](type-alias.X2Title.md)

# Type alias AppConfig

> **AppConfig**: `object`

Application configuration

## Type declaration

### `accessibilityConfig`

**accessibilityConfig**?: `object`

Accessibility configuration. Set the `accessibilityConfig.enabled` property to `true` to enable accessibility features for charts built with Highcharts.

Once the accessibility configuration in enabled, you can use the default descriptions or choose to create custom configurations for the descriptions of a chart, its axes, its series, and values description formatting. To create custom configurations, use the `highchartsOptions` object that is passed to the [BeforeRenderHandler](type-alias.BeforeRenderHandler.md) of the chart's `onBeforeRender` callback. Modify the object using the accessibility options as described in the [Accessibility module documentation](https://www.highcharts.com/docs/accessibility/accessibility-module).

Note that enabling accessibility also causes markers to appear in charts even if they are disabled using the chart's `styleOptions`.

This feature is in alpha.

> #### `accessibilityConfig.enabled`
>
> **enabled**?: `boolean`
>
> Whether to enable accessibility features
>
> If not specified, the default value is `false`
>
>

***

This feature is in alpha.

> #### `accessibilityConfig.enabled`
>
> **enabled**?: `boolean`
>
> Whether to enable accessibility features
>
> If not specified, the default value is `false`
>
>

***

### `chartConfig`

**chartConfig**?: `object`

Global configuration for some specific aspects of data visualizations.

> #### `chartConfig.tabular`
>
> **tabular**?: `object`
>
> `Table` and `PivotTable` configuration
>
> > ##### `tabular.alwaysShowResultsPerPage`
> >
> > **alwaysShowResultsPerPage**?: `boolean`
> >
> > Boolean flag whether to always show the results per page select
> >
> > If `true`, the results per page select will be shown even if there is only one page of results.
> > Currently only supported for `PivotTable`.
> >
> > ###### Default
> >
> > ```ts
> > false
> > ```
> >
> > ##### `tabular.htmlContent`
> >
> > **htmlContent**?: `object`
> >
> > Configuration for HTML content in `Table` and `PivotTable`
> >
> > > ###### `htmlContent.enabled`
> > >
> > > **enabled**?: `boolean`
> > >
> > > If true, the contents of table and pivot table cells are rendered as HTML instead of text.
> > >
> > > **Note**: The [StyledColumn.isHtml](../interfaces/interface.StyledColumn.md#ishtml) property of columns in `dataOptions` are of higher precedence, and will therefore override this setting.
> > >
> > > ###### Default
> > >
> > > ```ts
> > > true
> > > ```
> > >
> > > ###### `htmlContent.sanitizeContents`
> > >
> > > **sanitizeContents**?: `boolean`
> > >
> > > Enables sanitization of HTML content before rendering to prevent XSS attacks.
> > >
> > > ###### Default
> > >
> > > ```ts
> > > true
> > > ```
> > >
> > >
> >
> >
>
>

***

*?: `boolean`
> > >
> > > Enables sanitization of HTML content before rendering to prevent XSS attacks.
> > >
> > > ###### Default
> > >
> > > ```ts
> > > true
> > > ```
> > >
> > >
> >
> >
>
>

***

### `dateConfig`

**dateConfig**?: [`DateConfig`](type-alias.DateConfig.md)

Date Configurations

***

### `errorBoundaryConfig`

**errorBoundaryConfig**?: `object`

Configuration of the component that is rendered in case of an error

> #### `errorBoundaryConfig.alwaysShowErrorText`
>
> **alwaysShowErrorText**?: `boolean`
>
> Whether to show error text without hovering over the error icon
>
> If not specified, the default value is `false`
>
>

***

aryConfig.alwaysShowErrorText`
>
> **alwaysShowErrorText**?: `boolean`
>
> Whether to show error text without hovering over the error icon
>
> If not specified, the default value is `false`
>
>

***

### `jumpToDashboardConfig`

**jumpToDashboardConfig**?: `object`

Configuration of the Jump To Dashboard feature

This feature is currently in Beta.

**Note:** Only widgets that are configured using the Fusion UI as documented
[here](https://docs.sisense.com/main/SisenseLinux/jump-to-dashboard.htm?tocpath=Add-ons%7C_____2#ConfiguringJTDPerWidget)
are supported in Compose SDK.

Widgets that are configured using an older version of Jump To Dashboard, or via scripts, are not supported.

Known limitations:
- Jump To Dashboard is not currently supported for Pivot widgets.
- Target dashboards are always opened in a popup window, options to open in new tab and new window are not supported.
- Show 'Header' and 'Dashboards panel' options are not supported (only relevant to Fusion).
- 'Reset filters after JTD' is not supported, since changes are never saved to the target dashboard using Compose SDK.

The following Jump To Dashboard configuration is supported:
  - Target dashboard set by Id, with configurable display title
  - 'Popup window' display type ('Allow Resize' not supported)
  - Display filter panel on the target dashboard (true/false)
  - Navigation setting (Click / Right click)
    - Note: 'Keep changes made by user' is not supported, since changes are never saved to the target dashboard using Compose SDK.
  - Apply filters to the target dashboard (select)
  - Merge target dashboard filters (true/false)

> #### `jumpToDashboardConfig.enabled`
>
> **enabled**?: `boolean`
>
> Whether to enable or disable the Jump To Dashboard feature
>
> If not specified, the default value is `true`
>
>

***

e/false)

> #### `jumpToDashboardConfig.enabled`
>
> **enabled**?: `boolean`
>
> Whether to enable or disable the Jump To Dashboard feature
>
> If not specified, the default value is `true`
>
>

***

### `loadingIndicatorConfig`

**loadingIndicatorConfig**?: [`LoadingIndicatorConfig`](../../sdk-ui/type-aliases/type-alias.LoadingIndicatorConfig.md)

Loading Indicator Configurations

***

### `locale`

**locale**?: `Locale`

A [date-fns Locale](https://date-fns.org/v2.30.0/docs/Locale)

***

### `queryCacheConfig`

**queryCacheConfig**?: `object`

Query Cache Configurations.

See [Client query caching guide](/guides/sdk/guides/client-query-caching.html) for more details.

> #### `queryCacheConfig.enabled`
>
> **enabled**?: `boolean`
>
> Whether to enable client-side query caching.
>
> If not specified, the default value is `false`
>
>

***

### `queryLimit`

**queryLimit**?: `number`

Query limit (max rows count that will be fetched in query)

#### Default

```ts
20000
```

***

> If not specified, the default value is `false`
>
>

***

### `queryLimit`

**queryLimit**?: `number`

Query limit (max rows count that will be fetched in query)

#### Default

```ts
20000
```

***

### `tabberConfig`

**tabberConfig**?: `object`

Configuration of the tabber widgets feature

Only tabber widgets that are configured using the Fusion UI as documented [here](https://docs.sisense.com/main/SisenseLinux/tabber.htm#Creating) are supported.

> #### `tabberConfig.enabled`
>
> **enabled**?: `boolean`
>
> Whether to enable tabber widget support
>
> If not specified, the default value is `true`
>
> ::: warning Deprecated
> Tabber widgets are now supported by default and this property is no longer needed.
> :::
>
>

***

### `trackingConfig`

**trackingConfig**?: `object`

Tracking configuration

> #### `trackingConfig.onTrackingEvent`
>
> **onTrackingEvent**?: (`payload`) => `void`
>
> Callback to be invoked when tracking event occurs
>
> ##### Parameters
>
>
> | Parameter | Type |
> | :------ | :------ |
> | `payload` | `TrackingEventDetails` |
>
>
> ##### Returns
>
> `void`
>
>
>
>

***

### `translationConfig`

**translationConfig**?: [`TranslationConfig`](type-alias.TranslationConfig.md)

Translation Configuration

rackingEventDetails` |
>
>
> ##### Returns
>
> `void`
>
>
>
>

***

### `translationConfig`

**translationConfig**?: [`TranslationConfig`](type-alias.TranslationConfig.md)

Translation Configuration

# Type alias AreaSubtype

> **AreaSubtype**: `"area/basic"` \| `"area/spline"` \| `"area/stacked"` \| `"area/stacked100"` \| `"area/stackedspline"` \| `"area/stackedspline100"`

Property of [AreaStyleOptions](../interfaces/interface.AreaStyleOptions.md)

Subtype of AreaChart

**Values**

- `area/basic` - straight lines showing areas that overlap so that smaller areas appear on top of larger areas and cover them.
- `area/stacked` - straight lines showing areas that are stacked on top of each other and do not overlap.
- `area/stacked100` - straight lines showing areas that are stacked on top of each other but do not overlap so that the combined area is stretched to the top representing 100%.
- `area/spline` - curved lines showing areas that overlap so that smaller areas appear on top of larger areas and cover them.
- `area/stackedspline` - curved lines showing areas that are stacked on top of each other and do not overlap.
- `area/stackedspline100` - curved lines showing areas that are stacked on top of each other but do not overlap so that the combined area is stretched to the top representing 100%.

# Type alias AreamapChartType

> **AreamapChartType**: `"areamap"`

Areamap chart types

# Type alias AreamapDataPointEvent

> **AreamapDataPointEvent**: `object`

ched to the top representing 100%.

# Type alias AreamapChartType

> **AreamapChartType**: `"areamap"`

Areamap chart types

# Type alias AreamapDataPointEvent

> **AreamapDataPointEvent**: `object`

## Type declaration

### `nativeEvent`

**nativeEvent**: `MouseEvent`

Native MouseEvent

***

### `point`

**point**: [`AreamapDataPoint`](../../sdk-ui/type-aliases/type-alias.AreamapDataPoint.md)

Data point that was clicked

# Type alias AreamapDataPointEventHandler

> **AreamapDataPointEventHandler**: (`event`) => `void`

Click handler for when a data point on Areamap is clicked.

## Parameters

| Parameter | Type |
| :------ | :------ |
| `event` | [`AreamapDataPointEvent`](type-alias.AreamapDataPointEvent.md) |

## Returns

`void`

# Type alias AxisLabel

> **AxisLabel**: `object`

Options that define configuration for certain chart axis.

## Type declaration

### `enabled`

**enabled**?: `boolean`

Boolean flag that defines if this axis should be shown on the chart

***

### `gridLines`

**gridLines**?: `boolean`

Boolean flag that defines if grid lines should be shown on the chart

***

### `intervalJumps`

**intervalJumps**?: `number`

Interval of the tick marks (jumps) in axis units.

***

### `isIntervalEnabled`

**isIntervalEnabled**?: `boolean`

Boolean flag that defines if tick marks should be shown on the axis

***

`number`

Interval of the tick marks (jumps) in axis units.

***

### `isIntervalEnabled`

**isIntervalEnabled**?: `boolean`

Boolean flag that defines if tick marks should be shown on the axis

***

### `labels`

**labels**?: `object`

Configuration for labels on the axis

> #### `labels.enabled`
>
> **enabled**: `boolean`
>
> Boolean flag that defines if labels should be shown on the axis
>
>

***

### `logarithmic`

**logarithmic**?: `boolean`

Boolean flag that defines if the axis should have logarithmic scale

***

### `max`

**max**?: `number`

The maximum value of the axis. If 'undefined' the max value is automatically calculated

***

### `min`

**min**?: `number`

The minimum value of the axis. If 'undefined' the min value is automatically calculated

***

### `templateMainYHasGridLines`

**templateMainYHasGridLines**?: `boolean`

Boolean flag that defines if the Y axis should have grid lines extending the ticks across the plot area

***

### `title`

**title**?: `object`

Configuration for title of the axis

> #### `title.enabled`
>
> **enabled**: `boolean`
>
> Boolean flag that defines if title should be shown
>
> #### `title.text`
>
> **text**?: `string`
>
> Textual content of the title
>
>

***

### `x2Title`

**x2Title**?: [`X2Title`](type-alias.X2Title.md)

Configuration for title of the second X axis

>
> #### `title.text`
>
> **text**?: `string`
>
> Textual content of the title
>
>

***

### `x2Title`

**x2Title**?: [`X2Title`](type-alias.X2Title.md)

Configuration for title of the second X axis

# Type alias BeforeRenderHandler

> **BeforeRenderHandler**: (`highchartsOptions`) => `HighchartsOptions`

A handler function that allows you to customize the underlying chart element before it is
rendered. Use the `highchartsOptions` object that is passed to the callback to change
[options values](https://api.highcharts.com/highcharts/) and then return the modified options
object. The returned options are then used when rendering the chart.

This callback is not supported for Indicator Chart, Areamap Chart, and Scattermap Chart.

For an example of how the `BeforeRenderHandler` function can be used, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#callbacks).

## See

[https://api.highcharts.com/highcharts/](https://api.highcharts.com/highcharts/)

## Parameters

| Parameter | Type |
| :------ | :------ |
| `highchartsOptions` | `HighchartsOptions` |

## Returns

`HighchartsOptions`

# Type alias BoxWhiskerType

> **BoxWhiskerType**: `"extremums"` \| `"iqr"` \| `"standardDeviation"`

Represents the type of box whisker data algorithm, which can be either `iqr`, `extremums`, or `standardDeviation`.

iskerType

> **BoxWhiskerType**: `"extremums"` \| `"iqr"` \| `"standardDeviation"`

Represents the type of box whisker data algorithm, which can be either `iqr`, `extremums`, or `standardDeviation`.

# Type alias BoxplotChartCustomDataOptions

> **BoxplotChartCustomDataOptions**: `object`

Configuration for how to query aggregate data and assign data
to axes of a Boxplot chart.

The Boxplot chart can receive multiple numeric columns, which represent all the metrics
such as `whisker max`, `whisker min`, `box max`, `box median`, and `box min`.

## Type declaration

### `category`

**category**: [(Column \| StyledColumn)?]

Columns (or attributes) whose values represent categories in the chart.

***

### `outliers`

**outliers**?: [[`Column`](../../sdk-data/interfaces/interface.Column.md) \| [`StyledColumn`](../interfaces/interface.StyledColumn.md)]

Optional measure columns (or measures) representing the boxplot outliers value.

***

### `value`

**value**: ([`CalculatedMeasureColumn`](../../sdk-data/interfaces/interface.CalculatedMeasureColumn.md) \| [`Column`](../../sdk-data/interfaces/interface.Column.md) \| [`MeasureColumn`](../../sdk-data/interfaces/interface.MeasureColumn.md) \| [`StyledColumn`](../interfaces/interface.StyledColumn.md) \| [`StyledMeasureColumn`](../interfaces/interface.StyledMeasureColumn.md))[]

Measure columns (or measures) representing the target numeric values used for computing boxplot metrics.

***

olumn.md) \| [`StyledMeasureColumn`](../interfaces/interface.StyledMeasureColumn.md))[]

Measure columns (or measures) representing the target numeric values used for computing boxplot metrics.

***

### `valueTitle`

**valueTitle**: `string`

The title for the numeric value column in the chart.

# Type alias BoxplotChartDataOptions

> **BoxplotChartDataOptions**: `object`

Configuration for how to query aggregate data and assign data
to axes of a Boxplot chart.

The Boxplot chart can receive a singular numeric column, which is utilized internally to calculate multiple metrics
such as `whisker max`, `whisker min`, `box max`, `box median`, and `box min`.

## Type declaration

### `boxType`

**boxType**: [`BoxWhiskerType`](type-alias.BoxWhiskerType.md)

The type of box whisker data algorithm to be used.

***

### `category`

**category**: [(Column \| StyledColumn)?]

Columns (or attributes) whose values represent categories in the chart.

***

### `outliersEnabled`

**outliersEnabled**?: `boolean`

Toggle flag whether outliers should be enabled in the boxplot chart.

***

### `value`

**value**: [[`Column`](../../sdk-data/interfaces/interface.Column.md) \| [`StyledColumn`](../interfaces/interface.StyledColumn.md)]

Columns (or attributes) whose values represent the target numeric value column for computing boxplot metrics according to the selected `boxType`

# Type alias BoxplotChartType

> **BoxplotChartType**: `"boxplot"`

Boxplot chart types

s represent the target numeric value column for computing boxplot metrics according to the selected `boxType`

# Type alias BoxplotChartType

> **BoxplotChartType**: `"boxplot"`

Boxplot chart types

# Type alias BoxplotDataPoint

> **BoxplotDataPoint**: `object`

Data point in a Boxplot chart.

## Type declaration

### `boxMax`

**boxMax**?: `number`

Value of the box maximum

***

### `boxMedian`

**boxMedian**?: `number`

Value of the box median

***

### `boxMin`

**boxMin**?: `number`

Value of the box minimum

***

### `categoryDisplayValue`

**categoryDisplayValue**?: `string`

Display value of category of the data point

***

### `categoryValue`

**categoryValue**?: `number` \| `string`

Value of the category for the data point

***

### `entries`

**entries**?: `object`

A collection of data point entries that represents values for all related `dataOptions`.

> #### `entries.category`
>
> **category**: [`DataPointEntry`](../../sdk-ui/type-aliases/type-alias.DataPointEntry.md)[]
>
> Data point entries for the `category` data options
>
> #### `entries.outliers`
>
> **outliers**: [`DataPointEntry`](../../sdk-ui/type-aliases/type-alias.DataPointEntry.md)[]
>
> Data point entries for the `outliers` data options
>
> #### `entries.value`
>
> **value**: [`DataPointEntry`](../../sdk-ui/type-aliases/type-alias.DataPointEntry.md)[]
>
> Data point entries for the `value` data options
>
>

***

### `outlier`

**outlier**?: `number`

Value of the outlier

***

aPointEntry`](../../sdk-ui/type-aliases/type-alias.DataPointEntry.md)[]
>
> Data point entries for the `value` data options
>
>

***

### `outlier`

**outlier**?: `number`

Value of the outlier

***

### `whiskerMax`

**whiskerMax**?: `number`

Value of the box maximal whisker

***

### `whiskerMin`

**whiskerMin**?: `number`

Value of the box minimal whisker

# Type alias BoxplotDataPointEvent

> **BoxplotDataPointEvent**: `object`

## Type declaration

### `nativeEvent`

**nativeEvent**: `PointerEvent`

Native PointerEvent

***

### `point`

**point**: [`BoxplotDataPoint`](type-alias.BoxplotDataPoint.md)

Data point that was clicked

# Type alias BoxplotDataPointEventHandler

> **BoxplotDataPointEventHandler**: (`event`) => `void`

Click handler for when a data point on Boxplot is clicked.

## Parameters

| Parameter | Type |
| :------ | :------ |
| `event` | [`BoxplotDataPointEvent`](type-alias.BoxplotDataPointEvent.md) |

## Returns

`void`

# Type alias BoxplotDataPointsEvent

> **BoxplotDataPointsEvent**: `object`

## Type declaration

### `nativeEvent`

**nativeEvent**: `MouseEvent`

Native MouseEvent

***

### `points`

**points**: [`BoxplotDataPoint`](type-alias.BoxplotDataPoint.md)[]

Data point that were selected

# Type alias BoxplotSubtype

> **BoxplotSubtype**: `"boxplot/full"` \| `"boxplot/hollow"`

`points`

**points**: [`BoxplotDataPoint`](type-alias.BoxplotDataPoint.md)[]

Data point that were selected

# Type alias BoxplotSubtype

> **BoxplotSubtype**: `"boxplot/full"` \| `"boxplot/hollow"`

# Type alias CalendarDayOfWeek

> **CalendarDayOfWeek**: `"friday"` \| `"monday"` \| `"saturday"` \| `"sunday"` \| `"thursday"` \| `"tuesday"` \| `"wednesday"`

Day of the week

# Type alias CalendarHeatmapChartType

> **CalendarHeatmapChartType**: `"calendar-heatmap"`

Calendar heatmap chart types

# Type alias CalendarHeatmapDataPoint

> **CalendarHeatmapDataPoint**: `object`

Data point in a CalendarHeatmap chart.

## Type declaration

### `entries`

**entries**?: `object`

A collection of data point entries that represents values for all related `dataOptions`.

> #### `entries.date`
>
> **date**: [`DataPointEntry`](../../sdk-ui/type-aliases/type-alias.DataPointEntry.md)
>
> Data point entry for the `date` data options
>
> #### `entries.value`
>
> **value**?: [`DataPointEntry`](../../sdk-ui/type-aliases/type-alias.DataPointEntry.md)
>
> Data point entry for the `value` data options
>
>

# Type alias CalendarHeatmapDataPointEvent

> **CalendarHeatmapDataPointEvent**: `object`

## Type declaration

### `nativeEvent`

**nativeEvent**: `PointerEvent`

Native PointerEvent

***

### `point`

**point**: [`CalendarHeatmapDataPoint`](type-alias.CalendarHeatmapDataPoint.md)

Data point that was clicked

## `nativeEvent`

**nativeEvent**: `PointerEvent`

Native PointerEvent

***

### `point`

**point**: [`CalendarHeatmapDataPoint`](type-alias.CalendarHeatmapDataPoint.md)

Data point that was clicked

# Type alias CalendarHeatmapDataPointEventHandler

> **CalendarHeatmapDataPointEventHandler**: (`event`) => `void`

Click handler for when a calendar-heatmap data point is clicked

## Parameters

| Parameter | Type |
| :------ | :------ |
| `event` | [`CalendarHeatmapDataPointEvent`](type-alias.CalendarHeatmapDataPointEvent.md) |

## Returns

`void`

# Type alias CalendarHeatmapDataPointsEvent

> **CalendarHeatmapDataPointsEvent**: `object`

## Type declaration

### `nativeEvent`

**nativeEvent**: `MouseEvent`

Native MouseEvent

***

### `points`

**points**: [`CalendarHeatmapDataPoint`](type-alias.CalendarHeatmapDataPoint.md)[]

Data points that were selected

# Type alias CalendarHeatmapDataPointsEventHandler

> **CalendarHeatmapDataPointsEventHandler**: (`event`) => `void`

Click handler for when multiple calendar-heatmap data points are selected.

## Parameters

| Parameter | Type |
| :------ | :------ |
| `event` | [`CalendarHeatmapDataPointsEvent`](type-alias.CalendarHeatmapDataPointsEvent.md) |

## Returns

`void`

# Type alias CalendarHeatmapSubtype

> **CalendarHeatmapSubtype**: `"calendar-heatmap/continuous"` \| `"calendar-heatmap/split"`

Calendar heatmap chart subtype

ointsEvent.md) |

## Returns

`void`

# Type alias CalendarHeatmapSubtype

> **CalendarHeatmapSubtype**: `"calendar-heatmap/continuous"` \| `"calendar-heatmap/split"`

Calendar heatmap chart subtype

# Type alias CalendarHeatmapViewType

> **CalendarHeatmapViewType**: `"half-year"` \| `"month"` \| `"quarter"` \| `"year"`

View type determines how many months to display: 'month' (1), 'quarter' (3), 'half-year' (6), 'year' (12)

# Type alias CartesianChartType

> **CartesianChartType**: `"area" | "bar" | "column" | "line" | "polar" | "streamgraph"`

Cartesian family of chart types

# Type alias CartesianWidgetType

> **CartesianWidgetType**: `"chart/area"` \| `"chart/bar"` \| `"chart/column"` \| `"chart/line"` \| `"chart/polar"`

The type of a widget on a dashboard that is a variant of Cartesian widget.

# Type alias CategoricalChartType

> **CategoricalChartType**: `"funnel" | "pie" | "sunburst" | "treemap"`

Categorical family of chart types

# Type alias CategoricalWidgetType

> **CategoricalWidgetType**: `"chart/funnel"` \| `"chart/pie"` \| `"sunburst"` \| `"treemap"`

The type of a widget on a dashboard that is a variant of Categorical widget.

ias CategoricalWidgetType

> **CategoricalWidgetType**: `"chart/funnel"` \| `"chart/pie"` \| `"sunburst"` \| `"treemap"`

The type of a widget on a dashboard that is a variant of Categorical widget.

# Type alias ChartDataOptions

> **ChartDataOptions**: [`RegularChartDataOptions`](../../sdk-ui/type-aliases/type-alias.RegularChartDataOptions.md) \| [`TabularChartDataOptions`](../../sdk-ui/type-aliases/type-alias.TabularChartDataOptions.md)

Configuration for querying aggregate data and assigning data to chart encodings.

There are separate configurations for [Cartesian](../interfaces/interface.CartesianChartDataOptions.md),
[Categorical](../interfaces/interface.CategoricalChartDataOptions.md),
[Scatter](../interfaces/interface.ScatterChartDataOptions.md),
[Indicator](../interfaces/interface.IndicatorChartDataOptions.md),
[Table](../interfaces/interface.TableDataOptions.md),
[Boxplot](type-alias.BoxplotChartDataOptions.md),
[Areamap](../interfaces/interface.AreamapChartDataOptions.md), and
[Scattermap](../interfaces/interface.ScattermapChartDataOptions.md) charts.

.md),
[Boxplot](type-alias.BoxplotChartDataOptions.md),
[Areamap](../interfaces/interface.AreamapChartDataOptions.md), and
[Scattermap](../interfaces/interface.ScattermapChartDataOptions.md) charts.

# Type alias ChartDataPointClickEvent

> **ChartDataPointClickEvent**: [`AreamapDataPointEvent`](type-alias.AreamapDataPointEvent.md) \| [`BoxplotDataPointEvent`](type-alias.BoxplotDataPointEvent.md) \| [`CalendarHeatmapDataPointEvent`](type-alias.CalendarHeatmapDataPointEvent.md) \| [`DataPointEvent`](type-alias.DataPointEvent.md) \| [`IndicatorDataPointEvent`](type-alias.IndicatorDataPointEvent.md) \| [`ScatterDataPointEvent`](type-alias.ScatterDataPointEvent.md) \| [`ScattermapDataPointEvent`](type-alias.ScattermapDataPointEvent.md)

# Type alias ChartDataPointClickEventHandler

> **ChartDataPointClickEventHandler**: (`event`) => `void`

Click handler for when a data point on Chart is clicked.

## Parameters

| Parameter | Type |
| :------ | :------ |
| `event` | [`ChartDataPointClickEvent`](type-alias.ChartDataPointClickEvent.md) |

## Returns

`void`

# Type alias ChartDataPointContextMenuEvent

> **ChartDataPointContextMenuEvent**: [`BoxplotDataPointEvent`](type-alias.BoxplotDataPointEvent.md) \| [`CalendarHeatmapDataPointEvent`](type-alias.CalendarHeatmapDataPointEvent.md) \| [`DataPointEvent`](type-alias.DataPointEvent.md) \| [`ScatterDataPointEvent`](type-alias.ScatterDataPointEvent.md)

| [`CalendarHeatmapDataPointEvent`](type-alias.CalendarHeatmapDataPointEvent.md) \| [`DataPointEvent`](type-alias.DataPointEvent.md) \| [`ScatterDataPointEvent`](type-alias.ScatterDataPointEvent.md)

# Type alias ChartDataPointContextMenuEventHandler

> **ChartDataPointContextMenuEventHandler**: (`event`) => `void`

Context menu handler for when a data point on the Chart is right-clicked.

## Parameters

| Parameter | Type |
| :------ | :------ |
| `event` | [`ChartDataPointContextMenuEvent`](type-alias.ChartDataPointContextMenuEvent.md) |

## Returns

`void`

# Type alias ChartDataPointsEvent

> **ChartDataPointsEvent**: [`CalendarHeatmapDataPointsEvent`](type-alias.CalendarHeatmapDataPointsEvent.md) \| [`DataPointsEvent`](type-alias.DataPointsEvent.md) \| [`ScatterDataPointsEvent`](type-alias.ScatterDataPointsEvent.md)

# Type alias ChartDataPointsEventHandler

> **ChartDataPointsEventHandler**: (`event`) => `void`

Click handler for when multiple data points on Chart are selected.

## Parameters

| Parameter | Type |
| :------ | :------ |
| `event` | [`ChartDataPointsEvent`](type-alias.ChartDataPointsEvent.md) |

## Returns

`void`

# Type alias ChartStyleOptions

> **ChartStyleOptions**: [`RegularChartStyleOptions`](../../sdk-ui/type-aliases/type-alias.RegularChartStyleOptions.md) \| [`TabularChartStyleOptions`](../../sdk-ui/type-aliases/type-alias.TabularChartStyleOptions.md)

Configuration options that define functional style of the various elements of chart.

yleOptions.md) \| [`TabularChartStyleOptions`](../../sdk-ui/type-aliases/type-alias.TabularChartStyleOptions.md)

Configuration options that define functional style of the various elements of chart.

# Type alias ChartType

> **ChartType**: [`AreamapChartType`](type-alias.AreamapChartType.md) \| [`BoxplotChartType`](type-alias.BoxplotChartType.md) \| [`CalendarHeatmapChartType`](type-alias.CalendarHeatmapChartType.md) \| [`CartesianChartType`](type-alias.CartesianChartType.md) \| [`CategoricalChartType`](type-alias.CategoricalChartType.md) \| [`IndicatorChartType`](type-alias.IndicatorChartType.md) \| [`RangeChartType`](type-alias.RangeChartType.md) \| [`ScatterChartType`](type-alias.ScatterChartType.md) \| [`ScattermapChartType`](type-alias.ScattermapChartType.md) \| [`TableChartType`](../../sdk-ui/type-aliases/type-alias.TableChartType.md)

Chart type of one of the supported chart families

# Type alias ChartWidgetStyleOptions

> **ChartWidgetStyleOptions**: [`ChartStyleOptions`](type-alias.ChartStyleOptions.md) & [`WidgetContainerStyleOptions`](../../sdk-ui/interfaces/interface.WidgetContainerStyleOptions.md)

Style settings defining the look and feel of ChartWidget

# Type alias Color

> **Color**: `null` \| `string`

HEX color value or CSS color name.

# Type alias ColorPaletteTheme

> **ColorPaletteTheme**: `object`

Collection of colors used to color various elements.

## Type declaration

: `null` \| `string`

HEX color value or CSS color name.

# Type alias ColorPaletteTheme

> **ColorPaletteTheme**: `object`

Collection of colors used to color various elements.

## Type declaration

### `variantColors`

**variantColors**: [`Color`](type-alias.Color.md)[]

Set of colors used to color chart elements

# Type alias ConditionalDataColorOptions

> **ConditionalDataColorOptions**: `object`

Conditional color options for data similar to the Conditional Color option in the Sisense UI.

This option allows you to define color conditions.
Each condition is a logical expression that defines how data values are mapped into colors.
These conditions are evaluated in the order in which they appear in the array.

## Example

An example of a condition stating that a negative data value is displayed in red
and another condition stating that a positive data value is green.

```ts
{
  type: 'conditional',
  conditions: [
    { color: 'red', expression: '0', operator: '<' },
    { color: 'green', expression: '0', operator: '>=' },
  ],
  defaultColor: 'red',
}
```

## Type declaration

### `conditions`

**conditions**?: [`DataColorCondition`](type-alias.DataColorCondition.md)[]

Array of color conditions

***

### `defaultColor`

**defaultColor**?: `string`

Default color when no condition is met

***

### `type`

**type**: `"conditional"`

Color options type

ndition.md)[]

Array of color conditions

***

### `defaultColor`

**defaultColor**?: `string`

Default color when no condition is met

***

### `type`

**type**: `"conditional"`

Color options type

# Type alias Convolution

> **Convolution**: `object`

Configuration that defines the ability of the Pie chart to collapse (convolve) and
hide part of the data under the single category "Others".

## Type declaration

### `enabled`

**enabled**: `boolean`

Boolean flag that defines if convolution ability should be enabled on chart

***

### `independentSlicesCount`

**independentSlicesCount**?: `number`

Number that defines of how many independent slices should be present in chart (other will be convolved)

***

### `minimalIndependentSlicePercentage`

**minimalIndependentSlicePercentage**?: `number`

Value that defines what minimal size in percent should a slice take to fall under the convolution

***

### `selectedConvolutionType`

**selectedConvolutionType**?: `"byPercentage"` \| `"bySlicesCount"`

Selected type of convolution behavior

# Type alias CustomDrilldownResult

> **CustomDrilldownResult**: [`CustomDrilldownResult`](../../sdk-ui/type-aliases/type-alias.CustomDrilldownResult.md) & \{
  `breadcrumbsComponent`: \{
    `render`: `ComponentRenderer`;
  };
 }

> ## `CustomDrilldownResult.breadcrumbsComponent`
>
> **breadcrumbsComponent**?: `object`
>
> > ### `breadcrumbsComponent.render`
> >
> > **render**: `ComponentRenderer`
> >
> >
>
>

derer`;
  };
 }

> ## `CustomDrilldownResult.breadcrumbsComponent`
>
> **breadcrumbsComponent**?: `object`
>
> > ### `breadcrumbsComponent.render`
> >
> > **render**: `ComponentRenderer`
> >
> >
>
>

# Type alias CustomWidgetComponent`<Props>`

> **CustomWidgetComponent**: <`Props`> `Type`\< `Props` \>

Type representing an Angular component class that can be used as a user-defined custom widget.

## Type parameters

| Parameter | Default |
| :------ | :------ |
| `Props` *extends* [`CustomWidgetComponentProps`](../interfaces/interface.CustomWidgetComponentProps.md) | [`CustomWidgetComponentProps`](../interfaces/interface.CustomWidgetComponentProps.md) |

# Type alias DashStyle

> **DashStyle**: `"Dash"` \| `"DashDot"` \| `"Dot"` \| `"LongDash"` \| `"LongDashDot"` \| `"LongDashDotDot"` \| `"ShortDash"` \| `"ShortDashDot"` \| `"ShortDashDotDot"` \| `"ShortDot"` \| `"Solid"`

Configuration that defines line dash type

# Type alias DataColorCondition

> **DataColorCondition**: `object`

Color condition for [ConditionalDataColorOptions](type-alias.ConditionalDataColorOptions.md) represented as a logical expression.

See [ConditionalDataColorOptions](type-alias.ConditionalDataColorOptions.md) for usage examples.

## Type declaration

### `color`

**color**: `string`

Color for this condition

***

### `expression`

**expression**: `string`

Expression representing the data value

***

md) for usage examples.

## Type declaration

### `color`

**color**: `string`

Color for this condition

***

### `expression`

**expression**: `string`

Expression representing the data value

***

### `operator`

**operator**: `"!="` \| `"<"` \| `"<="` \| `"="` \| `">"` \| `">="` \| `"≠"` \| `"≤"` \| `"≥"`

Supported operators for `expression`

# Type alias DataColorOptions

> **DataColorOptions**: [`ConditionalDataColorOptions`](type-alias.ConditionalDataColorOptions.md) \| [`RangeDataColorOptions`](type-alias.RangeDataColorOptions.md) \| [`UniformDataColorOptions`](type-alias.UniformDataColorOptions.md) \| `string`

All possible color options for data.

# Type alias DataOptionLocation

> **DataOptionLocation**: `object`

Location within component data options that identifies a specific data option.

## Example

```typescript
{ dataOptionName: 'category', dataOptionIndex: 0 } // First category
{ dataOptionName: 'value', dataOptionIndex: 1 }    // Second value measure
```

## Type declaration

### `dataOptionIndex`

**dataOptionIndex**?: `number`

Data option location zero-based index.

Required for array-based locations (e.g., `rows`, `columns`, `values`, `category`).
Optional for single-value locations (e.g., `x`, `y`, `date`).

#### Default

```ts
0
```

***

n zero-based index.

Required for array-based locations (e.g., `rows`, `columns`, `values`, `category`).
Optional for single-value locations (e.g., `x`, `y`, `date`).

#### Default

```ts
0
```

***

### `dataOptionName`

**dataOptionName**: `"breakBy"` \| `"breakByColor"` \| `"breakByPoint"` \| `"category"` \| `"color"` \| `"colorBy"` \| `"columns"` \| `"date"` \| `"details"` \| `"geo"` \| `"max"` \| `"min"` \| `"outliers"` \| `"rows"` \| `"secondary"` \| `"size"` \| `"value"` \| `"values"` \| `"x"` \| `"y"`

Data option location name that identifies the property containing the data option.

Examples:
- PivotTable: `'rows'` | `'columns'` | `'values'`
- Cartesian charts: `'category'` | `'value'` | `'breakBy'`
- Scatter charts: `'x'` | `'y'` | `'breakByPoint'` | `'breakByColor'` | `'size'`

# Type alias DataPoint

> **DataPoint**: `object`

Data point in a regular chart.

## Type declaration

### `categoryDisplayValue`

**categoryDisplayValue**?: `string`

Display value of categorical value of the data point

***

### `categoryValue`

**categoryValue**?: `number` \| `string`

Categorical value of the data point

***

*categoryDisplayValue**?: `string`

Display value of categorical value of the data point

***

### `categoryValue`

**categoryValue**?: `number` \| `string`

Categorical value of the data point

***

### `entries`

**entries**?: `object`

A collection of data point entries that represents values for all related `dataOptions`.

> #### `entries.breakBy`
>
> **breakBy**?: [`DataPointEntry`](../../sdk-ui/type-aliases/type-alias.DataPointEntry.md)[]
>
> Data point entries for the `breakBy` data options
>
> #### `entries.category`
>
> **category**: [`DataPointEntry`](../../sdk-ui/type-aliases/type-alias.DataPointEntry.md)[]
>
> Data point entries for the `category` data options
>
> #### `entries.value`
>
> **value**: [`DataPointEntry`](../../sdk-ui/type-aliases/type-alias.DataPointEntry.md)[]
>
> Data point entries for the `value` data options
>
>

***

### `seriesValue`

**seriesValue**?: `number` \| `string`

Series associated with the data point

***

### `value`

**value**?: `number` \| `string`

Value of the data point

# Type alias DataPointEvent

> **DataPointEvent**: `object`

## Type declaration

### `nativeEvent`

**nativeEvent**: `PointerEvent`

Native PointerEvent

***

### `point`

**point**: [`DataPoint`](type-alias.DataPoint.md)

Data point that was clicked

# Type alias DataPointEventHandler

> **DataPointEventHandler**: (`event`) => `void`

A handler function that allows you to customize what happens when certain events occur to
a data point.

clicked

# Type alias DataPointEventHandler

> **DataPointEventHandler**: (`event`) => `void`

A handler function that allows you to customize what happens when certain events occur to
a data point.

## Parameters

| Parameter | Type |
| :------ | :------ |
| `event` | [`DataPointEvent`](type-alias.DataPointEvent.md) |

## Returns

`void`

# Type alias DataPointsEvent

> **DataPointsEvent**: `object`

## Type declaration

### `nativeEvent`

**nativeEvent**: `MouseEvent`

Native MouseEvent

***

### `points`

**points**: [`DataPoint`](type-alias.DataPoint.md)[]

Data points that were selected

# Type alias DataPointsEventHandler

> **DataPointsEventHandler**: (`event`) => `void`

Click handler for when multiple data points are selected.

## Parameters

| Parameter | Type |
| :------ | :------ |
| `event` | [`DataPointsEvent`](type-alias.DataPointsEvent.md) |

## Returns

`void`

# Type alias DateConfig

> **DateConfig**: `object`

Date configurations

## Type declaration

### `fiscalMonth`

**fiscalMonth**: [`MonthOfYear`](type-alias.MonthOfYear.md)

First month of the fiscal year that is configured

***

### `isFiscalOn`

**isFiscalOn**: `boolean`

Boolean flag whether fiscal year is enabled

***

### `selectedDateLevel`

**selectedDateLevel**: [`DateLevel`](type-alias.DateLevel.md)

The selected date level for this particular column of data

***

### `timeZone`

**timeZone**: `string`

The IANA time zone

***

evel`

**selectedDateLevel**: [`DateLevel`](type-alias.DateLevel.md)

The selected date level for this particular column of data

***

### `timeZone`

**timeZone**: `string`

The IANA time zone

***

### `weekFirstDay`

**weekFirstDay**: [`DayOfWeek`](type-alias.DayOfWeek.md)

First day of the week

# Type alias DateLevel

> **DateLevel**: `"dateAndTime" | "days" | "minutes" | "months" | "quarters" | "weeks" | "years"`

# Type alias DayOfWeek

> **DayOfWeek**: `0` \| `1` \| `2` \| `3` \| `4` \| `5` \| `6`

# Type alias DecimalScale

> **DecimalScale**: `"auto"` \| `number`

The number of decimal places

# Type alias DrilldownOptions

> **DrilldownOptions**: `object`

Configuration for the drilldown

## Type declaration

### `drilldownPaths`

**drilldownPaths**?: ([`Attribute`](../../sdk-data/interfaces/interface.Attribute.md) \| [`Hierarchy`](../interfaces/interface.Hierarchy.md) \| [`HierarchyId`](../../sdk-ui/type-aliases/type-alias.HierarchyId.md))[]

Dimensions and hierarchies available for drilldown on.

***

### `drilldownSelections`

**drilldownSelections**?: [`DrilldownSelection`](type-alias.DrilldownSelection.md)[]

Current selections for multiple drilldowns

# Type alias DrilldownSelection

> **DrilldownSelection**: `object`

Selection for the drilldown

## Type declaration

### `nextDimension`

**nextDimension**: [`Attribute`](../../sdk-data/interfaces/interface.Attribute.md)

Dimension to drilldown to

***

*: `object`

Selection for the drilldown

## Type declaration

### `nextDimension`

**nextDimension**: [`Attribute`](../../sdk-data/interfaces/interface.Attribute.md)

Dimension to drilldown to

***

### `points`

**points**: [`ChartDataPoint`](../../sdk-ui/type-aliases/type-alias.ChartDataPoint.md)[]

Points selected for drilldown

# Type alias EndCapType

> **EndCapType**: `"Round"` \| `"Square"`

Configuration that defines line end cap type

# Type alias FilterChangeEvent

> **FilterChangeEvent**: `object`

## Type declaration

### `filter`

**filter**: [`Filter`](../../sdk-data/interfaces/interface.Filter.md) \| `null`

Filter that was changed

# Type alias FilterChangeEventHandler

> **FilterChangeEventHandler**: (`event`) => `void`

Filter change event handler.

## Parameters

| Parameter | Type |
| :------ | :------ |
| `event` | [`FilterChangeEvent`](type-alias.FilterChangeEvent.md) |

## Returns

`void`

# Type alias FilterDeleteEventHandler

> **FilterDeleteEventHandler**: () => `void`

Filter delete event handler.

## Returns

`void`

# Type alias FilterEditEvent

> **FilterEditEvent**: `object`

## Type declaration

### `levelIndex`

**levelIndex**?: `number`

Index of the filter level that triggers the edit event (in the case of a cascading filter)

# Type alias FilterEditEventHandler

> **FilterEditEventHandler**: (`event`) => `void`

Filter edit event handler.

the filter level that triggers the edit event (in the case of a cascading filter)

# Type alias FilterEditEventHandler

> **FilterEditEventHandler**: (`event`) => `void`

Filter edit event handler.

## Parameters

| Parameter | Type |
| :------ | :------ |
| `event` | [`FilterEditEvent`](type-alias.FilterEditEvent.md) |

## Returns

`void`

# Type alias FilterVariant

> **FilterVariant**: `"horizontal"` \| `"vertical"`

Orientation options for the filter tile. The filter tile can
be arranged vertically, or horizontally to fit most toolbars.

# Type alias FiltersPanelChangeEvent

> **FiltersPanelChangeEvent**: `object`

## Type declaration

### `filters`

**filters**: [`FilterRelations`](../../sdk-data/interfaces/interface.FilterRelations.md) \| [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

The updated filters

# Type alias FiltersPanelChangeEventHandler

> **FiltersPanelChangeEventHandler**: (`event`) => `void`

Filters panel change event handler.

## Parameters

| Parameter | Type |
| :------ | :------ |
| `event` | [`FiltersPanelChangeEvent`](type-alias.FiltersPanelChangeEvent.md) |

## Returns

`void`

# Type alias GenericDataOptions

> **GenericDataOptions**: `Record`\< `string`, ([`StyledColumn`](../interfaces/interface.StyledColumn.md) \| [`StyledMeasureColumn`](../interfaces/interface.StyledMeasureColumn.md))[] \>

Data options with arbitrary keys. This is typically used in the context of a custom widget.

terface.StyledColumn.md) \| [`StyledMeasureColumn`](../interfaces/interface.StyledMeasureColumn.md))[] \>

Data options with arbitrary keys. This is typically used in the context of a custom widget.

# Type alias IndicatorBeforeRenderHandler

> **IndicatorBeforeRenderHandler**: (`renderOptions`) => [`IndicatorRenderOptions`](type-alias.IndicatorRenderOptions.md)

A handler function that allows you to customize the underlying chart element before it is
rendered. Use the [IndicatorRenderOptions](type-alias.IndicatorRenderOptions.md) object that is passed to the callback to change
and then return the modified options object.
The returned options are then used when rendering the chart.

This callback is supported only for Indicator Chart.

## Parameters

| Parameter | Type |
| :------ | :------ |
| `renderOptions` | [`IndicatorRenderOptions`](type-alias.IndicatorRenderOptions.md) |

## Returns

[`IndicatorRenderOptions`](type-alias.IndicatorRenderOptions.md)

# Type alias IndicatorChartType

> **IndicatorChartType**: `"indicator"`

Indicator chart types

# Type alias IndicatorComponents

> **IndicatorComponents**: `object`

Configuration options that define components of an indicator chart.

## Type declaration

### `labels`

**labels**?: `object`

The value labels of the indicator chart

> #### `labels.shouldBeShown`
>
> **shouldBeShown**: `boolean`
>
> Whether the labels should be shown
>
>

***

laration

### `labels`

**labels**?: `object`

The value labels of the indicator chart

> #### `labels.shouldBeShown`
>
> **shouldBeShown**: `boolean`
>
> Whether the labels should be shown
>
>

***

### `secondaryTitle`

**secondaryTitle**?: `object`

The secondary title of the indicator chart to be shown when `secondary` is specified in [IndicatorChartDataOptions](../interfaces/interface.IndicatorChartDataOptions.md)

> #### `secondaryTitle.text`
>
> **text**?: `string`
>
> The text of the secondary title
>
>

***

### `ticks`

**ticks**?: `object`

The ticks displayed on the indicator chart

> #### `ticks.shouldBeShown`
>
> **shouldBeShown**: `boolean`
>
> Whether the ticks should be shown
>
>

***

### `title`

**title**?: `object`

The main title of the indicator chart

> #### `title.shouldBeShown`
>
> **shouldBeShown**: `boolean`
>
> Whether the title should be shown
>
> #### `title.text`
>
> **text**?: `string`
>
> The text of the title
>
>

# Type alias IndicatorDataPoint

> **IndicatorDataPoint**: `object`

Data point that represents the entire Indicator chart data.

## Type declaration

text**?: `string`
>
> The text of the title
>
>

# Type alias IndicatorDataPoint

> **IndicatorDataPoint**: `object`

Data point that represents the entire Indicator chart data.

## Type declaration

### `entries`

**entries**?: `object`

A collection of data point entries that represents values for all related `dataOptions`.

> #### `entries.max`
>
> **max**?: [`DataPointEntry`](../../sdk-ui/type-aliases/type-alias.DataPointEntry.md)
>
> Data point entry for the `max` data options
>
> #### `entries.min`
>
> **min**?: [`DataPointEntry`](../../sdk-ui/type-aliases/type-alias.DataPointEntry.md)
>
> Data point entry for the `min` data options
>
> #### `entries.secondary`
>
> **secondary**?: [`DataPointEntry`](../../sdk-ui/type-aliases/type-alias.DataPointEntry.md)
>
> Data point entry for the `secondary` data options
>
> #### `entries.value`
>
> **value**?: [`DataPointEntry`](../../sdk-ui/type-aliases/type-alias.DataPointEntry.md)
>
> Data point entry for the `value` data options
>
>

# Type alias IndicatorDataPointEvent

> **IndicatorDataPointEvent**: `object`

## Type declaration

### `nativeEvent`

**nativeEvent**: `MouseEvent`

Native MouseEvent

***

### `point`

**point**: [`IndicatorDataPoint`](type-alias.IndicatorDataPoint.md)

Data point that was clicked

# Type alias IndicatorDataPointEventHandler

> **IndicatorDataPointEventHandler**: (`event`) => `void`

Click handler for when a data point on Indicator is clicked.

md)

Data point that was clicked

# Type alias IndicatorDataPointEventHandler

> **IndicatorDataPointEventHandler**: (`event`) => `void`

Click handler for when a data point on Indicator is clicked.

## Parameters

| Parameter | Type |
| :------ | :------ |
| `event` | [`IndicatorDataPointEvent`](type-alias.IndicatorDataPointEvent.md) |

## Returns

`void`

# Type alias IndicatorRenderOptions

> **IndicatorRenderOptions**: `object`

Indicator render options.

## Type declaration

### `secondary`

**secondary**: `object`

The secondary value options.

> #### `secondary.color`
>
> **color**: `string`
>
> The secondary value color.
>
> #### `secondary.data`
>
> **data**: `number`
>
> The secondary value data.
>
> #### `secondary.fontWeight`
>
> **fontWeight**: `string`
>
> The secondary value font weight.
>
> #### `secondary.text`
>
> **text**: `string`
>
> The secondary value text.
>
>

***

### `secondaryTitle`

**secondaryTitle**: `object`

The secondary title options.

> #### `secondaryTitle.color`
>
> **color**: `string`
>
> The secondary title color.
>
> #### `secondaryTitle.text`
>
> **text**: `string`
>
> The secondary title text.
>
>

***

### `title`

**title**: `object`

The title options.

> #### `title.color`
>
> **color**: `string`
>
> The title color.
>
> #### `title.text`
>
> **text**: `string`
>
> The title text.
>
>

***

***

### `title`

**title**: `object`

The title options.

> #### `title.color`
>
> **color**: `string`
>
> The title color.
>
> #### `title.text`
>
> **text**: `string`
>
> The title text.
>
>

***

### `value`

**value**: `object`

The primary value options.

> #### `value.color`
>
> **color**: `string`
>
> The primary value color.
>
> #### `value.data`
>
> **data**: `number`
>
> The primary value data.
>
> #### `value.text`
>
> **text**: `string`
>
> The primary value text.
>
>

**color**: `string`
>
> The primary value color.
>
> #### `value.data`
>
> **data**: `number`
>
> The primary value data.
>
> #### `value.text`
>
> **text**: `string`
>
> The primary value text.
>
>

# Type alias IndicatorStyleOptions

> **IndicatorStyleOptions**: [`GaugeIndicatorStyleOptions`](../interfaces/interface.GaugeIndicatorStyleOptions.md) \| [`NumericBarIndicatorStyleOptions`](../interfaces/interface.NumericBarIndicatorStyleOptions.md) \| [`NumericSimpleIndicatorStyleOptions`](../interfaces/interface.NumericSimpleIndicatorStyleOptions.md) & \{
  `height`: `number`;
  `width`: `number`;
 }

Configuration options that define functional style of the various elements of IndicatorChart

> ## `IndicatorStyleOptions.height`
>
> **height**?: `number`
>
> Total height of the component, which is considered in the following order of priority:
>
> 1. Value passed to this property (in pixels).
> 2. Height of the container wrapping this component
> 3. Default value of 200px (for component without header) or 225px (for component with header).
>
> ## `IndicatorStyleOptions.width`
>
> **width**?: `number`
>
> Total width of the component, which is considered in the following order of priority:
>
> 1. Value passed to this property (in pixels)
> 2. Width of the container wrapping this component
> 3. Default value of 200px
>
>

# Type alias Labels

> **Labels**: `object`

Configuration that defines behavior of data labels on chart

## Type declaration

f the container wrapping this component
> 3. Default value of 200px
>
>

# Type alias Labels

> **Labels**: `object`

Configuration that defines behavior of data labels on chart

## Type declaration

### `categories`

**categories**?: `boolean`

Boolean flag that defines if categories names should be shown

***

### `decimals`

**decimals**?: `boolean`

Boolean flag that defines if decimals should be shown for percent labels

***

### `enabled`

**enabled**?: `boolean`

Boolean flag that defines if any labels should be shown

***

### `percent`

**percent**?: `boolean`

Boolean flag that defines if percents of Pie should be shown on slices

***

### `value`

**value**?: `boolean`

Boolean flag that defines if original values per category should be shown

# Type alias Legend

> **Legend**: [`LegendOptions`](../../sdk-ui/type-aliases/type-alias.LegendOptions.md)

Alias for LegendOptions for backward compatibility

::: warning Deprecated
Please use [LegendOptions](../../sdk-ui/type-aliases/type-alias.LegendOptions.md) instead
:::

# Type alias LineOptions

> **LineOptions**: `object`

Configuration options for styling lines in charts.

This type is used to customize the visual appearance of lines in various chart types
including Line charts, Area charts, and AreaRange charts.

## Type declaration

### `dashStyle`

**dashStyle**?: [`DashStyle`](type-alias.DashStyle.md)

Dash pattern for the line.

Defines the visual pattern of the line.

***

charts, and AreaRange charts.

## Type declaration

### `dashStyle`

**dashStyle**?: [`DashStyle`](type-alias.DashStyle.md)

Dash pattern for the line.

Defines the visual pattern of the line.

***

### `endCap`

**endCap**?: [`EndCapType`](type-alias.EndCapType.md)

Style of the line end caps.

Controls how the ends of lines are rendered:
- `'Round'`: Rounded ends for a softer appearance
- `'Square'`: Sharp, flat ends for a crisp appearance

***

### `shadow`

**shadow**?: `boolean`

Whether to apply a shadow effect to the line.

When enabled, adds a subtle shadow behind the line for enhanced.

***

### `width`

**width**?: `number`

Width of the line in pixels.

# Type alias LineSubtype

> **LineSubtype**: `"line/basic"` \| `"line/spline"` \| `"line/step"`

Property of [LineStyleOptions](../interfaces/interface.LineStyleOptions.md)

Subtype of LineChart

**Values**

- `line/spline` - curved line from point to point.
- `line/basic` - straight line from point to point.
- `line/step` - step line where segments create a step-like pattern.

# Type alias LineWidth

> **LineWidth**: `object`

Configuration that defines line width

## Type declaration

### `width`

**width**: `"bold"` \| `"thick"` \| `"thin"`

Line width type

# Type alias Markers

> **Markers**: `object`

Options that define  markers - symbols or data points that highlight specific values.

## Type declaration

` \| `"thick"` \| `"thin"`

Line width type

# Type alias Markers

> **Markers**: `object`

Options that define  markers - symbols or data points that highlight specific values.

## Type declaration

### `enabled`

**enabled**: `boolean`

Boolean flag that defines if markers should be shown on the chart

***

### `fill`

**fill**?: `"filled"` \| `"hollow"`

Marker fill style

***

### `size`

**size**?: `"large"` \| `"small"`

Size of markers

# Type alias MenuItemSection

> **MenuItemSection**: `object`

Context menu section
Used in [`ContextMenuProps`](../../sdk-ui/interfaces/interface.ContextMenuProps.md)

## Type declaration

### `items`

**items**?: \{
  `caption`: `string`;
  `key`: `number` \| `string`;
  `onClick`: () => `void`;
 }[]

Optional list of menu items

***

### `sectionTitle`

**sectionTitle**?: `string`

Optional section title

# Type alias MenuPosition

> **MenuPosition**: `object`

Context menu position coordinates
Used in [`ContextMenuProps`](../../sdk-ui/interfaces/interface.ContextMenuProps.md)

## Type declaration

### `left`

**left**: `number`

Horizontal position

***

### `top`

**top**: `number`

Vertical position

# Type alias MonthOfYear

> **MonthOfYear**: `0` \| `1` \| `10` \| `11` \| `2` \| `3` \| `4` \| `5` \| `6` \| `7` \| `8` \| `9`

# Type alias MultiColumnValueToColorMap

> **MultiColumnValueToColorMap**: `object`

Mapping of each of the chart columns with mapping of each value series to colors.

5` \| `6` \| `7` \| `8` \| `9`

# Type alias MultiColumnValueToColorMap

> **MultiColumnValueToColorMap**: `object`

Mapping of each of the chart columns with mapping of each value series to colors.

## Index signature

 \[`columnName`: `string`\]: [`ValueToColorMap`](type-alias.ValueToColorMap.md)

# Type alias Navigator

> **Navigator**: `object`

Options that define navigator - zoom/pan tool for large datasets in a chart.

## Type declaration

### `enabled`

**enabled**: `boolean`

Boolean flag that defines if navigator should be shown on the chart

***

### `scrollerLocation`

**scrollerLocation**?: `object`

The scroll location of the navigator scroller / auto zoom feature

> #### `scrollerLocation.max`
>
> **max**: `number`
>
> #### `scrollerLocation.min`
>
> **min**: `number`
>
>

# Type alias NumberFormatConfig

> **NumberFormatConfig**: `object`

Configuration for number formatting.

## Type declaration

### `billion`

**billion**?: `boolean`

Boolean flag whether to show an abbreviation
for a number greater than or equal one billion - e.g. 1B

***

### `decimalScale`

**decimalScale**?: [`DecimalScale`](type-alias.DecimalScale.md)

The number of decimal places

***

### `kilo`

**kilo**?: `boolean`

Boolean flag whether to show an abbreviation
for a number greater than or equal one thousand - e.g. 1K

***

### `million`

**million**?: `boolean`

Boolean flag whether to show an abbreviation
for a number greater than or equal one million - e.g. 1M

***

greater than or equal one thousand - e.g. 1K

***

### `million`

**million**?: `boolean`

Boolean flag whether to show an abbreviation
for a number greater than or equal one million - e.g. 1M

***

### `name`

**name**?: `"Currency"` \| `"Numbers"` \| `"Percent"`

Supported formats

***

### `prefix`

**prefix**?: `boolean`

Boolean flag whether `symbol` is shown in front of or after the number

If true, append `symbol` in front of the number, e.g. show `$1000` when `symbol` is `$`.

If false, append `symbol` after the number, e.g. show `1000¥` when `symbol` is `¥`.

***

### `symbol`

**symbol**?: `string`

Symbol to show in front of or after the number depending on the value of `prefix`.

***

### `thousandSeparator`

**thousandSeparator**?: `boolean`

Boolean flag whether the thousand separator is shown

If true, show the thousand separator, e.g. `1,000`. Otherwise, show `1000`

***

### `trillion`

**trillion**?: `boolean`

Boolean flag whether to show an abbreviation
for a number greater than or equal one trillion - e.g. 1T

separator, e.g. `1,000`. Otherwise, show `1000`

***

### `trillion`

**trillion**?: `boolean`

Boolean flag whether to show an abbreviation
for a number greater than or equal one trillion - e.g. 1T

# Type alias PieSubtype

> **PieSubtype**: `"pie/classic"` \| `"pie/donut"` \| `"pie/ring"`

Property of [PieStyleOptions](../interfaces/interface.PieStyleOptions.md)

Subtype of PieChart

**Values**

- `pie/classic` - a circle divided into a series of segments where each segment represents a particular category.
- `pie/donut` - a circle divided into a series of segments where each segment represents a particular category with its center cut out to look like a donut.
- `pie/ring` - a circle divided into a series of segments where each segment represents a particular category with its center cut out to look like a ring.

# Type alias PivotRowsSort

> **PivotRowsSort**: `object`

Sorting configuration for pivot "rows".

This configuration allows sorting pivot "rows" either by their data or by data in a specific "values" column.

s PivotRowsSort

> **PivotRowsSort**: `object`

Sorting configuration for pivot "rows".

This configuration allows sorting pivot "rows" either by their data or by data in a specific "values" column.

## Example

Examples of sorting configurations for various scenarios:

(1) Row sorted in ascending order by its data:
```ts
{ direction: 'sortAsc' }
```

(2) Row sorted in descending order by data in the first "values" column (index 0):
```ts
{
   direction: 'sortDesc',
   by: {
     valuesIndex: 0,
   }
}
```

(3) Row sorted in ascending order by data in the second "values" column (index 1) under the "columns" values of "Female" (for Gender) and "0-18" (for AgeRange):
```ts
{
   direction: 'sortAsc',
   by: {
     valuesIndex: 1,
     columnsMembersPath: ['Female', '0-18']
   }
}
```

## Type declaration

### `by`

**by**?: `object`

Sorting target configuration, allowing sorting "rows" by the data in a specific "values" column

> #### `by.columnsMembersPath`
>
> **columnsMembersPath**?: (`number` \| `string`)[]
>
> Path to the target column if selected "columns" items (dimensions) are involved
>
> #### `by.valuesIndex`
>
> **valuesIndex**?: `number`
>
> Index of the target "values" item (measure)
>
>

***

### `direction`

**direction**: [`SortDirection`](type-alias.SortDirection.md)

Sorting direction, either in Ascending order, Descending order, or None

# Type alias PivotTableDataPointEvent

> **PivotTableDataPointEvent**: `object`

## Type declaration

alias.SortDirection.md)

Sorting direction, either in Ascending order, Descending order, or None

# Type alias PivotTableDataPointEvent

> **PivotTableDataPointEvent**: `object`

## Type declaration

### `nativeEvent`

**nativeEvent**: `MouseEvent`

Native MouseEvent

***

### `point`

**point**: [`PivotTableDataPoint`](../../sdk-ui/type-aliases/type-alias.PivotTableDataPoint.md)

Data point that was clicked

# Type alias PivotTableDataPointEventHandler

> **PivotTableDataPointEventHandler**: (`event`) => `void`

Click handler for when a pivot table data point is clicked.

## Parameters

| Parameter | Type |
| :------ | :------ |
| `event` | [`PivotTableDataPointEvent`](type-alias.PivotTableDataPointEvent.md) |

## Returns

`void`

# Type alias PivotTableDrilldownOptions

> **PivotTableDrilldownOptions**: [`PivotTableNonSelectableDrilldownOptions`](type-alias.PivotTableNonSelectableDrilldownOptions.md) \| [`PivotTableSelectableDrilldownOptions`](type-alias.PivotTableSelectableDrilldownOptions.md)

Configuration for the pivot table drilldown

# Type alias PivotTableNonSelectableDrilldownOptions

> **PivotTableNonSelectableDrilldownOptions**: `object`

Configuration for the pivot table drilldown without initial target and selections

## Type declaration

votTableNonSelectableDrilldownOptions

> **PivotTableNonSelectableDrilldownOptions**: `object`

Configuration for the pivot table drilldown without initial target and selections

## Type declaration

### `drilldownPaths`

**drilldownPaths**?: ([`Attribute`](../../sdk-data/interfaces/interface.Attribute.md) \| [`Hierarchy`](../interfaces/interface.Hierarchy.md) \| [`HierarchyId`](../../sdk-ui/type-aliases/type-alias.HierarchyId.md))[]

Dimensions and hierarchies available for drilldown on

***

### `drilldownSelections`

**drilldownSelections**?: `never`

Current selections for multiple drilldowns

***

### `drilldownTarget`

**drilldownTarget**?: `never`

Current pivot table data option target for the drilldown

# Type alias PivotTableSelectableDrilldownOptions

> **PivotTableSelectableDrilldownOptions**: `object`

Configuration for the pivot table drilldown with initial target and selections defined

## Type declaration

### `drilldownPaths`

**drilldownPaths**?: ([`Attribute`](../../sdk-data/interfaces/interface.Attribute.md) \| [`Hierarchy`](../interfaces/interface.Hierarchy.md) \| [`HierarchyId`](../../sdk-ui/type-aliases/type-alias.HierarchyId.md))[]

Dimensions and hierarchies available for drilldown on

***

### `drilldownSelections`

**drilldownSelections**: [`DrilldownSelection`](type-alias.DrilldownSelection.md)[]

Current selections for multiple drilldowns

***

chies available for drilldown on

***

### `drilldownSelections`

**drilldownSelections**: [`DrilldownSelection`](type-alias.DrilldownSelection.md)[]

Current selections for multiple drilldowns

***

### `drilldownTarget`

**drilldownTarget**: [`Attribute`](../../sdk-data/interfaces/interface.Attribute.md) \| [`DataOptionLocation`](type-alias.DataOptionLocation.md)

Current pivot table data option target for the drilldown

Can be either:
- An `Attribute` directly (when you know the specific attribute to target)
- A `DataOptionLocation` (when you need to reference a data option by its position in the data options structure)

# Type alias PivotTableWidgetStyleOptions

> **PivotTableWidgetStyleOptions**: [`PivotTableStyleOptions`](../interfaces/interface.PivotTableStyleOptions.md) & [`WidgetContainerStyleOptions`](../../sdk-ui/interfaces/interface.WidgetContainerStyleOptions.md)

Style settings defining the look and feel of PivotTableWidget

# Type alias PolarSubtype

> **PolarSubtype**: `"polar/area"` \| `"polar/column"` \| `"polar/line"`

Property of [PolarStyleOptions](../interfaces/interface.PolarStyleOptions.md)

Subtype of PolarChart

**Values**

- `polar/column` - a chart where data points are displayed using the angle and distance from the center point.
- `polar/area` - a chart in which the data points are connected by a line with the area below the line filled.
- `polar/line` -  a chart in which the data points are connected by a line.

nter point.
- `polar/area` - a chart in which the data points are connected by a line with the area below the line filled.
- `polar/line` -  a chart in which the data points are connected by a line.

# Type alias RangeChartType

> **RangeChartType**: `"arearange"`

AreaRange chart types

# Type alias RangeDataColorOptions

> **RangeDataColorOptions**: `object`

Range color options for data similar to the Range option in the Sisense UI.

Use `minColor` and `maxColor` to define the start and end color of the range.
A color name (for example, `red`), or a hexadecimal value (for example, `#ff0000`) can be specified.

By default, the color range is set to match the minimum and maximum values of the data.
You can also override the default value range by
setting the `minValue`, `midValue`, and `maxValue` properties.

## Example

An example of specifying colors for data values ranging
from red (for min value) to blue (for max value)
with 2 more colors in between for a total of 4 colors:

```ts
{
  type: 'range',
  steps: 4,
  minColor: 'red',
  maxColor: 'blue',
}
```

## Type declaration

### `maxColor`

**maxColor**?: `string`

End color of the range

***

### `maxValue`

**maxValue**?: `number`

Maximum value explicitly set to override the maximum value of the data

***

### `midValue`

**midValue**?: `number`

Middle value explicitly set to override the middle value of the data

***

### `minColor`

**minColor**?: `string`

Start color of the range

***

data

***

### `midValue`

**midValue**?: `number`

Middle value explicitly set to override the middle value of the data

***

### `minColor`

**minColor**?: `string`

Start color of the range

***

### `minValue`

**minValue**?: `number`

Minimum value explicitly set to override the minimum value of the data

***

### `steps`

**steps**?: `number`

Distinct number of colors in the range

***

### `type`

**type**: `"range"`

Color options type

# Type alias ScatterChartType

> **ScatterChartType**: `"scatter"`

Scatter chart types

# Type alias ScatterDataPoint

> **ScatterDataPoint**: `object`

Data point in a Scatter chart.

## Type declaration

### `breakByColor`

**breakByColor**?: `string`

Value of the break by color

***

### `breakByPoint`

**breakByPoint**?: `string`

Value of the break by point

***

tter chart.

## Type declaration

### `breakByColor`

**breakByColor**?: `string`

Value of the break by color

***

### `breakByPoint`

**breakByPoint**?: `string`

Value of the break by point

***

### `entries`

**entries**?: `object`

A collection of data point entries that represents values for all related `dataOptions`.

> #### `entries.breakByColor`
>
> **breakByColor**?: [`DataPointEntry`](../../sdk-ui/type-aliases/type-alias.DataPointEntry.md)
>
> Data point entry for the `breakByColor` data options
>
> #### `entries.breakByPoint`
>
> **breakByPoint**?: [`DataPointEntry`](../../sdk-ui/type-aliases/type-alias.DataPointEntry.md)
>
> Data point entry for the `breakByPoint` data options
>
> #### `entries.size`
>
> **size**?: [`DataPointEntry`](../../sdk-ui/type-aliases/type-alias.DataPointEntry.md)
>
> Data point entry for the `size` data options
>
> #### `entries.x`
>
> **x**?: [`DataPointEntry`](../../sdk-ui/type-aliases/type-alias.DataPointEntry.md)
>
> Data point entry for the `x` data options
>
> #### `entries.y`
>
> **y**?: [`DataPointEntry`](../../sdk-ui/type-aliases/type-alias.DataPointEntry.md)
>
> Data point entry for the `y` data options
>
>

***

### `size`

**size**?: `number`

Size of the data point

***

### `x`

**x**?: `number` \| `string`

Value of the x axis

***

### `y`

**y**?: `number` \| `string`

Value of the y axis

# Type alias ScatterDataPointEvent

> **ScatterDataPointEvent**: `object`

## Type declaration

ber` \| `string`

Value of the x axis

***

### `y`

**y**?: `number` \| `string`

Value of the y axis

# Type alias ScatterDataPointEvent

> **ScatterDataPointEvent**: `object`

## Type declaration

### `nativeEvent`

**nativeEvent**: `PointerEvent`

Native PointerEvent

***

### `point`

**point**: [`ScatterDataPoint`](type-alias.ScatterDataPoint.md)

Data point that was clicked

# Type alias ScatterDataPointEventHandler

> **ScatterDataPointEventHandler**: (`event`) => `void`

Click handler for when a scatter data point is clicked

## Parameters

| Parameter | Type |
| :------ | :------ |
| `event` | [`ScatterDataPointEvent`](type-alias.ScatterDataPointEvent.md) |

## Returns

`void`

# Type alias ScatterDataPointsEvent

> **ScatterDataPointsEvent**: `object`

## Type declaration

### `nativeEvent`

**nativeEvent**: `MouseEvent`

Native MouseEvent

***

### `points`

**points**: [`ScatterDataPoint`](type-alias.ScatterDataPoint.md)[]

Data points that were selected

# Type alias ScatterDataPointsEventHandler

> **ScatterDataPointsEventHandler**: (`event`) => `void`

Click handler for when multiple scatter data points are selected.

## Parameters

| Parameter | Type |
| :------ | :------ |
| `event` | [`ScatterDataPointsEvent`](type-alias.ScatterDataPointsEvent.md) |

## Returns

`void`

# Type alias ScatterMarkerSize

> **ScatterMarkerSize**: `object`

## Type declaration

### `scatterBubbleMaxSize`

**scatterBubbleMaxSize**: `number`

***

DataPointsEvent.md) |

## Returns

`void`

# Type alias ScatterMarkerSize

> **ScatterMarkerSize**: `object`

## Type declaration

### `scatterBubbleMaxSize`

**scatterBubbleMaxSize**: `number`

***

### `scatterBubbleMinSize`

**scatterBubbleMinSize**: `number`

***

### `scatterDefaultSize`

**scatterDefaultSize**: `number`

# Type alias ScattermapChartType

> **ScattermapChartType**: `"scattermap"`

Scattermap chart types

# Type alias ScattermapDataPointEvent

> **ScattermapDataPointEvent**: `object`

## Type declaration

### `nativeEvent`

**nativeEvent**: `MouseEvent`

Native MouseEvent

***

### `point`

**point**: [`ScattermapDataPoint`](../../sdk-ui/type-aliases/type-alias.ScattermapDataPoint.md)

Data point that was clicked

# Type alias ScattermapDataPointEventHandler

> **ScattermapDataPointEventHandler**: (`event`) => `void`

Click handler for when a data point on Scattermap is clicked.

## Parameters

| Parameter | Type |
| :------ | :------ |
| `event` | [`ScattermapDataPointEvent`](type-alias.ScattermapDataPointEvent.md) |

## Returns

`void`

data point on Scattermap is clicked.

## Parameters

| Parameter | Type |
| :------ | :------ |
| `event` | [`ScattermapDataPointEvent`](type-alias.ScattermapDataPointEvent.md) |

## Returns

`void`

# Type alias ScattermapLocationLevel

> **ScattermapLocationLevel**: `"auto"` \| `"city"` \| `"country"` \| `"state"`

Geographic location level for Scattermap chart.
This type can have one of the following values:
- 'auto': Automatically determines the appropriate location level.
- 'country': Represents the country level in the geographical hierarchy.
- 'state': Represents the state or province level in the geographical hierarchy.
- 'city': Represents the city level in the geographical hierarchy.

# Type alias ScattermapMarkers

> **ScattermapMarkers**: `object`

Markers style configuration of Scattermap chart

## Type declaration

### `fill`

**fill**?: `"filled"` \| `"filled-light"` \| `"hollow"` \| `"hollow-bold"`

Specifies the fill style of the markers

***

### `size`

**size**?: `object`

Specifies the size configuration for the markers

> #### `size.defaultSize`
>
> **defaultSize**?: `number`
>
> The default size of the markers
>
> #### `size.maxSize`
>
> **maxSize**?: `number`
>
> The maximum size of the markers when using a "size" data field
>
> #### `size.minSize`
>
> **minSize**?: `number`
>
> The minimum size of the markers when using a "size" data field
>
>

`number`
>
> The maximum size of the markers when using a "size" data field
>
> #### `size.minSize`
>
> **minSize**?: `number`
>
> The minimum size of the markers when using a "size" data field
>
>

# Type alias SeriesChartType

> **SeriesChartType**: `"area"` \| `"arearange"` \| `"areaspline"` \| `"auto"` \| `"bar"` \| `"column"` \| `"line"` \| `"scatter"` \| `"spline"`

Series chart type, which is used with [StyledMeasureColumn](../interfaces/interface.StyledMeasureColumn.md) to customize
series in a mixed chart.

`"column"` \| `"line"` \| `"scatter"` \| `"spline"`

Series chart type, which is used with [StyledMeasureColumn](../interfaces/interface.StyledMeasureColumn.md) to customize
series in a mixed chart.

# Type alias SeriesLabels

> **SeriesLabels**: [`SeriesLabelsBase`](../../sdk-ui/type-aliases/type-alias.SeriesLabelsBase.md) & [`SeriesLabelsAligning`](../../sdk-ui/type-aliases/type-alias.SeriesLabelsAligning.md) & \{
  `showPercentage`: `boolean`;
  `showPercentDecimals`: `boolean`;
  `showValue`: `boolean`;
 }

Options that define series labels - titles/names identifying data series in a chart.

> ## `SeriesLabels.showPercentage`
>
> **showPercentage**?: `boolean`
>
> Boolean flag that defines if percentage should be shown in series labels
> (only applicable for subtypes that support percentage, like "stacked100")
>
> ## `SeriesLabels.showPercentDecimals`
>
> **showPercentDecimals**?: `boolean`
>
> Boolean flag that defines if percentage should be shown with decimals
> (will work only if `showPercentage` is `true`)
>
> ## `SeriesLabels.showValue`
>
> **showValue**?: `boolean`
>
> Boolean flag that defines if value should be shown in series labels
> (if not specified, default is determined by chart type)
>
>

# Type alias SortDirection

> **SortDirection**: `"sortAsc"` \| `"sortDesc"` \| `"sortNone"`

Sorting direction, either in Ascending order, Descending order, or None

s determined by chart type)
>
>

# Type alias SortDirection

> **SortDirection**: `"sortAsc"` \| `"sortDesc"` \| `"sortNone"`

Sorting direction, either in Ascending order, Descending order, or None

# Type alias StackableSubtype

> **StackableSubtype**: `"bar/classic"` \| `"bar/stacked"` \| `"bar/stacked100"` \| `"column/classic"` \| `"column/stackedcolumn"` \| `"column/stackedcolumn100"`

Property of [StackableSubtype](type-alias.StackableSubtype.md)

Subtype of BarChart

 **Values**
- `bar/classic` - y axis values displayed vertically.
- `bar/stacked` - y axis values are stacked next to each other and do not overlap.
- `bar/stacked100` - y axis values are stacked next to each other but do not overlap and combined and stretched to represent 100%.
- `column/classic` - columns are displayed side by side.
- `column/stackedcolumn` - columns are stacked on top of each other and do not overlap.
- `column/stackedcolumn100` - columns are stacked on top of each other but do not overlap and combined and stretched to represent 100%.

# Type alias TableType

> **TableType**: `"table"`

Table chart types

# Type alias TabularWidgetType

> **TabularWidgetType**: `"pivot"` \| `"pivot2"` \| `"tablewidget"` \| `"tablewidgetagg"`

The type of a widget on a dashboard that is a variant of tabular widget.

# Type alias TextWidgetDataPointEvent

> **TextWidgetDataPointEvent**: `object`

## Type declaration

### `nativeEvent`

**nativeEvent**: `MouseEvent`

Native MouseEvent

***

ant of tabular widget.

# Type alias TextWidgetDataPointEvent

> **TextWidgetDataPointEvent**: `object`

## Type declaration

### `nativeEvent`

**nativeEvent**: `MouseEvent`

Native MouseEvent

***

### `point`

**point**: `TextWidgetDataPoint`

Data point that was clicked

# Type alias ThemeConfig

> **ThemeConfig**: `PropsWithChildren`\< \{
  `theme`: [`ThemeOid`](type-alias.ThemeOid.md) \| [`ThemeSettings`](../interfaces/interface.ThemeSettings.md);
 } \>

Configurations for Theme.

Two options are supported:

(1) `ThemeSettings` -- Custom theme settings that override the default theme settings.

OR

(2) `ThemeOid` -- Theme identifier as defined in a Fusion instance (**Admin > App Configuration > Look and Feel**).
See [Customizing the Sisense User Interface](https://docs.sisense.com/main/SisenseLinux/customizing-the-sisense-user-interface.htm) for more details.

# Type alias ThemeOid

> **ThemeOid**: `string`

Identifier of a theme as defined in the Sisense instance.

# Type alias TranslationConfig

> **TranslationConfig**: `object`

Translation Configuration

## Type declaration

> **ThemeOid**: `string`

Identifier of a theme as defined in the Sisense instance.

# Type alias TranslationConfig

> **TranslationConfig**: `object`

Translation Configuration

## Type declaration

### `customTranslations`

**customTranslations**?: ([`CustomTranslationObject`](../../sdk-ui/type-aliases/type-alias.CustomTranslationObject.md) \| [`CustomTranslationObject`](../../sdk-ui/type-aliases/type-alias.CustomTranslationObject.md)[])[]

Additional translation resources to be loaded.

You can find the list of available translation keys in the translation folder of every package.

Translation keys that are not provided will default to the English translation.
If translation is provided for a package other than sdk-ui, please specify the namespace property.

Important: Do not translate parts in {{}} - these are placeholders for dynamic values and will be matched using provided variable names.

#### Example

```ts
customTranslations: [
  {
    language: 'fr',
    resources: {
      errors: {
       invalidFilterType: 'Type de filtre invalide',
      },
    },
  },
  {
    language: 'es',
    namespace: 'sdkData'
    resources: {
      errors: {
        measure: {
          unsupportedType: 'Tipo de medida no compatible',
        },
      },
    },
  },
]
```

***

### `language`

**language**?: `string`

Language code to be used for translations.

measure: {
          unsupportedType: 'Tipo de medida no compatible',
        },
      },
    },
  },
]
```

***

### `language`

**language**?: `string`

Language code to be used for translations.

# Type alias UniformDataColorOptions

> **UniformDataColorOptions**: `object`

Uniform color options for data similar to the Single Color option in the Sisense UI.

## Example

An example of specifying red as a uniform color for all data values.

```ts
{
  type: 'uniform',
  color: 'red',
}
```

## Type declaration

### `color`

**color**: `string`

Color name, e.g., `red`, or a hexadecimal value, e.g., `#ff0000`.

***

### `type`

**type**: `"uniform"`

Color options type

# Type alias ValueToColorMap

> **ValueToColorMap**: `object`

Mapping of each of the chart value series to colors.

## Index signature

 \[`value`: `string`\]: `string`

# Type alias WidgetDataOptions

> **WidgetDataOptions**: [`ChartDataOptions`](type-alias.ChartDataOptions.md) \| `EmptyObject` \| [`PivotTableDataOptions`](../interfaces/interface.PivotTableDataOptions.md)

Widget data options.

# Type alias WidgetDataPointClickEvent

> **WidgetDataPointClickEvent**: [`ChartDataPointClickEvent`](type-alias.ChartDataPointClickEvent.md) \| [`PivotTableDataPointEvent`](type-alias.PivotTableDataPointEvent.md) \| [`TextWidgetDataPointEvent`](type-alias.TextWidgetDataPointEvent.md)

ntClickEvent`](type-alias.ChartDataPointClickEvent.md) \| [`PivotTableDataPointEvent`](type-alias.PivotTableDataPointEvent.md) \| [`TextWidgetDataPointEvent`](type-alias.TextWidgetDataPointEvent.md)

# Type alias WidgetDataPointClickEventHandler

> **WidgetDataPointClickEventHandler**: (`event`) => `void`

Click handler for when a data point on Widget is clicked.

## Parameters

| Parameter | Type |
| :------ | :------ |
| `event` | [`WidgetDataPointClickEvent`](type-alias.WidgetDataPointClickEvent.md) |

## Returns

`void`

# Type alias WidgetDataPointContextMenuEvent

> **WidgetDataPointContextMenuEvent**: [`ChartDataPointContextMenuEvent`](type-alias.ChartDataPointContextMenuEvent.md) \| [`PivotTableDataPointEvent`](type-alias.PivotTableDataPointEvent.md)

# Type alias WidgetDataPointContextMenuEventHandler

> **WidgetDataPointContextMenuEventHandler**: (`event`) => `void`

Context menu handler for when a data point on Widget is right-clicked.

## Parameters

| Parameter | Type |
| :------ | :------ |
| `event` | [`WidgetDataPointContextMenuEvent`](type-alias.WidgetDataPointContextMenuEvent.md) |

## Returns

`void`

# Type alias WidgetId

> **WidgetId**: `string`

Widget ID

| :------ | :------ |
| `event` | [`WidgetDataPointContextMenuEvent`](type-alias.WidgetDataPointContextMenuEvent.md) |

## Returns

`void`

# Type alias WidgetId

> **WidgetId**: `string`

Widget ID

# Type alias WidgetProps

> **WidgetProps**: `SoftUnion`\< [`WithCommonWidgetProps`](type-alias.WithCommonWidgetProps.md)\< [`ChartWidgetProps`](../interfaces/interface.ChartWidgetProps.md), `"chart"` \> \| [`WithCommonWidgetProps`](type-alias.WithCommonWidgetProps.md)\< [`CustomWidgetProps`](../../sdk-ui/interfaces/interface.CustomWidgetProps.md), `"custom"` \> \| [`WithCommonWidgetProps`](type-alias.WithCommonWidgetProps.md)\< [`PivotTableWidgetProps`](../interfaces/interface.PivotTableWidgetProps.md), `"pivot"` \> \| [`WithCommonWidgetProps`](type-alias.WithCommonWidgetProps.md)\< [`TextWidgetProps`](../interfaces/interface.TextWidgetProps.md), `"text"` \> \> & \{
  `dataPointClick`: [`WidgetDataPointClickEventHandler`](type-alias.WidgetDataPointClickEventHandler.md);
  `dataPointContextMenu`: [`WidgetDataPointContextMenuEventHandler`](type-alias.WidgetDataPointContextMenuEventHandler.md);
  `dataPointsSelect`: [`ChartDataPointsEventHandler`](type-alias.ChartDataPointsEventHandler.md);
 }

Props of the [WidgetComponent](../dashboards/class.WidgetComponent.md).

> ## `WidgetProps.dataPointClick`
>
> **dataPointClick**?: [`WidgetDataPointClickEventHandler`](type-alias.WidgetDataPointClickEventHandler.md)
>
> ## `WidgetProps.dataPointContextMenu`
>
> **dataPointContextMenu**?: [`WidgetDataPointContextMenuEventHandler`](type-alias.WidgetDataPointContextMenuEventHandler.md)
>
> ## `WidgetProps.dataPointsSelect`
>
> **dataPointsSelect**?: [`ChartDataPointsEventHandler`](type-alias.ChartDataPointsEventHandler.md)
>
>

(type-alias.WidgetDataPointContextMenuEventHandler.md)
>
> ## `WidgetProps.dataPointsSelect`
>
> **dataPointsSelect**?: [`ChartDataPointsEventHandler`](type-alias.ChartDataPointsEventHandler.md)
>
>

# Type alias WidgetStyleOptions

> **WidgetStyleOptions**: [`ChartStyleOptions`](type-alias.ChartStyleOptions.md) \| [`CustomWidgetStyleOptions`](../../sdk-ui/type-aliases/type-alias.CustomWidgetStyleOptions.md) \| [`TableStyleOptions`](../interfaces/interface.TableStyleOptions.md) \| [`TextWidgetStyleOptions`](../../sdk-ui/type-aliases/type-alias.TextWidgetStyleOptions.md) & [`WidgetContainerStyleOptions`](../../sdk-ui/interfaces/interface.WidgetContainerStyleOptions.md)

Complete set of configuration options that define functional style of the various elements of the charts as well as the look and feel of widget itself and widget header.

# Type alias WidgetType

> **WidgetType**: `"chart"` \| `"custom"` \| `"pivot"` \| `"text"`

Type of the widget component.

# Type alias WidgetsOptions

> **WidgetsOptions**: `Record`\< [`WidgetId`](type-alias.WidgetId.md), [`SpecificWidgetOptions`](../../sdk-ui/type-aliases/type-alias.SpecificWidgetOptions.md) \>

Options for widgets in a dashboard

For example, how common filters defined at the dashboard level should be applied to widgets.

`](../../sdk-ui/type-aliases/type-alias.SpecificWidgetOptions.md) \>

Options for widgets in a dashboard

For example, how common filters defined at the dashboard level should be applied to widgets.

# Type alias WidgetsPanelLayout

> **WidgetsPanelLayout**: [`WidgetsPanelColumnLayout`](../interfaces/interface.WidgetsPanelColumnLayout.md)

Layout of dashboard widgets panel, which is a union of different layout algorithms

# Type alias WithCommonWidgetProps`<BaseWidget, Type>`

> **WithCommonWidgetProps**: <`BaseWidget`, `Type`> `BaseWidget` & \{
  `id`: `string`;
  `widgetType`: `Type`;
 }

A utility type that combines widget-specific properties (`BaseWidget`)
with a common widget props including corresponding widget type (`Type`).

> ## `WithCommonWidgetProps.id`
>
> **`readonly`** **id**: `string`
>
> Unique identifier of the widget within the container component (dashboard)
>
> ## `WithCommonWidgetProps.widgetType`
>
> **widgetType**: `Type`
>
> Widget type
>
>

## Type parameters

| Parameter | Description |
| :------ | :------ |
| `BaseWidget` |  |
| `Type` |  |

# Type alias X2Title

> **X2Title**: `object`

## Type declaration

### `enabled`

**enabled**: `boolean`

***

### `text`

**text**?: `string`


## Filters

# Filters

- [FilterService](class.FilterService.md)

# Class FilterService

Service for working with filter.

## Constructors

nabled**: `boolean`

***

### `text`

**text**?: `string`


## Filters

# Filters

- [FilterService](class.FilterService.md)

# Class FilterService

Service for working with filter.

## Constructors

### constructor

> **new FilterService**(`sisenseContextService`): [`FilterService`](class.FilterService.md)

#### Parameters

| Parameter | Type |
| :------ | :------ |
| `sisenseContextService` | [`SisenseContextService`](../contexts/class.SisenseContextService.md) |

#### Returns

[`FilterService`](class.FilterService.md)

## Methods

### getFilterMembers

> **getFilterMembers**(`params`): `Promise`\< [`GetFilterMembersData`](../interfaces/interface.GetFilterMembersData.md) \>

Retrieves members of the provided filter.

Those members can be used to display a list of members in a third-party filter component such as Material UI Select.

interface.GetFilterMembersData.md) \>

Retrieves members of the provided filter.

Those members can be used to display a list of members in a third-party filter component such as Material UI Select.

## Example

Retrieve selected members from a Filter on Country of the Sample ECommerce data model.

```ts
try {
  const data = await filterService.getFilterMembers({
    filter: filterFactory.members(DM.Country.Country, ['United States', 'Canada'])
  });

  const { selectedMembers, allMembers, excludeMembers, enableMultiSelection } = data;
  console.log('selectedMembers', selectedMembers);
} catch (error) {
  console.error('Error:', error);
}
```

#### Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `params` | [`GetFilterMembersParams`](../interfaces/interface.GetFilterMembersParams.md) | Parameters for retrieving filter members |

#### Returns

`Promise`\< [`GetFilterMembersData`](../interfaces/interface.GetFilterMembersData.md) \>

Promise that resolves to the filter members data
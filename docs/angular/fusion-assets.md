---
title: DashboardByIdComponent
---

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


---

---
title: DashboardService
---

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


---

---
title: FormulaService
---

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


---

---
title: HierarchyService
---

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


---

---
title: WidgetByIdComponent
---

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

### Callbacks

#### dataReady

> **dataReady**: (`data`) => [`Data`](../../sdk-data/interfaces/interface.Data.md) \| `undefined`

A callback that allows to modify data immediately after it has been retrieved.
It can be used to inject modification of queried data.


---

---
title: WidgetService
---

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


---

---
title: DashboardModel
---

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


---

---
title: WidgetModel
---

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


---

---
title: toDashboardProps
---

# Function toDashboardProps

> **toDashboardProps**(`dashboardModel`): [`DashboardProps`](../../../interfaces/interface.DashboardProps.md)

Translates [DashboardModel](../../interface.DashboardModel.md) to [DashboardProps](../../../interfaces/interface.DashboardProps.md).

## Parameters

| Parameter | Type |
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


---

---
title: toChartProps
---

# Function toChartProps

> **toChartProps**(`widgetModel`): [`ChartProps`](../../../interfaces/interface.ChartProps.md)

Translates a [WidgetModel](../../interface.WidgetModel.md) to the props for rendering a chart.

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


---

---
title: toChartWidgetProps
---

# Function toChartWidgetProps

> **toChartWidgetProps**(`widgetModel`): [`ChartWidgetProps`](../../../interfaces/interface.ChartWidgetProps.md)

Translates a [WidgetModel](../../interface.WidgetModel.md) to the props for rendering a chart widget.

## Parameters

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


---

---
title: toExecutePivotQueryParams
---

# Function toExecutePivotQueryParams

> **toExecutePivotQueryParams**(`widgetModel`): [`ExecutePivotQueryParams`](../../../interfaces/interface.ExecutePivotQueryParams.md)

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


---

---
title: toExecuteQueryParams
---

# Function toExecuteQueryParams

> **toExecuteQueryParams**(`widgetModel`): [`ExecuteQueryParams`](../../../interfaces/interface.ExecuteQueryParams.md)

Translates a [WidgetModel](../../interface.WidgetModel.md) to the parameters for executing a query for the widget.

## Parameters

| Parameter | Type |
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


---

---
title: toPivotTableProps
---

# Function toPivotTableProps

> **toPivotTableProps**(`widgetModel`): [`PivotTableProps`](../../../interfaces/interface.PivotTableProps.md)

Translates a [WidgetModel](../../interface.WidgetModel.md) to the props for rendering a pivot table.

## Parameters

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


---

---
title: toPivotTableWidgetProps
---

# Function toPivotTableWidgetProps

> **toPivotTableWidgetProps**(`widgetModel`): [`PivotTableWidgetProps`](../../../interfaces/interface.PivotTableWidgetProps.md)

Translates a [WidgetModel](../../interface.WidgetModel.md) to the props for rendering a pivot table widget.

## Parameters

| Parameter | Type |
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


---

---
title: toTableProps
---

# Function toTableProps

> **toTableProps**(`widgetModel`): [`TableProps`](../../../interfaces/interface.TableProps.md)

Translates a [WidgetModel](../../interface.WidgetModel.md) to the props for rendering a table.

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


---

---
title: toTextWidgetProps
---

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


---

---
title: toWidgetProps
---

# Function toWidgetProps

> **toWidgetProps**(`widgetModel`): [`WidgetProps`](../../../type-aliases/type-alias.WidgetProps.md)

Translates [WidgetModel](../../interface.WidgetModel.md) to [WidgetProps](../../../type-aliases/type-alias.WidgetProps.md).

## Parameters

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

---
title: ChartWidget
---

# Function ChartWidget

> **ChartWidget**(`props`): `ReactElement`\< `any`, `any` \> \| `null`

The Chart Widget component extending the [Chart](../charts/function.Chart.md) component to support widget style options.
It can be used along with the [DrilldownWidget](../drilldown/function.DrilldownWidget.md) component to support advanced data drilldown.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `props` | [`ChartWidgetProps`](../interfaces/interface.ChartWidgetProps.md) | ChartWidget properties |

## Returns

`ReactElement`\< `any`, `any` \> \| `null`

ChartWidget component representing a chart type as specified in `ChartWidgetProps.`[chartType](../interfaces/interface.ChartWidgetProps.md#charttype)

## Example

Example of using the `ChartWidget` component to
plot a bar chart of the `Sample ECommerce` data source hosted in a Sisense instance.
```ts
<ChartWidget
  dataSource={DM.DataSource}
  chartType="bar"
  dataOptions={{
    category: [DM.Category.Category],
    value: [measureFactory.sum(DM.Commerce.Revenue)],
    breakBy: [],
  }}
/>
```

<img src="../../../img/chart-widget-with-drilldown-example-1.png" width="800px" />


---

---
title: Dashboard
---

# Function Dashboard

> **Dashboard**(`props`): `ReactElement`\< `any`, `any` \> \| `null`

React component that renders a dashboard whose elements are customizable. It includes internal logic of applying common filters to widgets.

**Note:** Dashboard and Widget extensions based on JS scripts and add-ons in Fusion – for example, Blox and Jump To Dashboard – are not supported.

## Parameters

| Parameter | Type |
| :------ | :------ |
| `props` | [`DashboardProps`](../interfaces/interface.DashboardProps.md) |

## Returns

`ReactElement`\< `any`, `any` \> \| `null`

## Example

Example of rendering a Fusion dashboard using the `useGetDashboardModel hook and the `Dashboard` component.

```ts
import { Dashboard, useGetDashboardModel, dashboardModelTranslator } from '@sisense/sdk-ui';

const CodeExample = () => {
 const { dashboard } = useGetDashboardModel({
   dashboardOid: '65a82171719e7f004018691c',
   includeFilters: true,
   includeWidgets: true,
 });

 return (
   <>
     {dashboard && (
       <Dashboard {...dashboardModelTranslator.toDashboardProps(dashboard)} />
     )}
   </>
 );
};

export default CodeExample;
```

To learn more about this and related dashboard components,
see [Embedded Dashboards](/guides/sdk/guides/dashboards/index.html).


---

---
title: PivotTableWidget
---

# Function PivotTableWidget

> **PivotTableWidget**(`props`): `ReactElement`\< `any`, `any` \> \| `null`

React component extending `PivotTable` to support widget style options.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `props` | [`PivotTableWidgetProps`](../interfaces/interface.PivotTableWidgetProps.md) | Pivot Table Widget properties |

## Returns

`ReactElement`\< `any`, `any` \> \| `null`

Widget component representing a pivot table

## Example

Example of using the `PivotTableWidget` component to
plot a pivot table over the `Sample ECommerce` data source hosted in a Sisense instance.
```ts
<PivotTableWidget
  dataSource={DM.DataSource}
  dataOptions={{
    rows: [DM.Category.Category],
    values: [measureFactory.sum(DM.Commerce.Cost, 'Total Cost')]
  }}
  title="Pivot Table Widget Example"
  styleOptions={{
    spaceAround: 'Medium',
    cornerRadius: 'Large',
    shadow: 'Light',
    border: true,
    borderColor: '#e0e0e0',
    backgroundColor: '#ffffff',
    header: {
      hidden: false,
      titleTextColor: '#333333',
      titleAlignment: 'Center',
      dividerLine: true,
      dividerLineColor: '#e0e0e0',
      backgroundColor: '#f5f5f5'
    }
  }}
/>
```
<img src="../../../img/pivot-widget-example.png" width="800px" />


---

---
title: Widget
---

# Function Widget

> **Widget**(`props`): `ReactElement`\< `any`, `any` \> \| `null`

Facade component that renders a widget within a dashboard based on the widget type.

## Parameters

| Parameter | Type |
| :------ | :------ |
| `props` | [`WidgetProps`](../type-aliases/type-alias.WidgetProps.md) |

## Returns

`ReactElement`\< `any`, `any` \> \| `null`


---

---
title: extractDimensionsAndMeasures
---

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


---

---
title: useComposedDashboard
---

# Function useComposedDashboard

> **useComposedDashboard**<`D`>(`initialDashboard`, `options`? = `{}`): [`ComposedDashboardResult`](../type-aliases/type-alias.ComposedDashboardResult.md)\< `D` \>

React hook that takes in separate dashboard elements and
composes them into a coordinated dashboard with change detection, cross filtering, and drill down.

## Type parameters

| Parameter | Description |
| :------ | :------ |
| `D` *extends* [`ComposableDashboardProps`](../type-aliases/type-alias.ComposableDashboardProps.md) \| [`DashboardProps`](../interfaces/interface.DashboardProps.md) | The type parameter for a dashboard properties, restricted to ComposableDashboardProps or DashboardProps |

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `initialDashboard` | `D` | set of properties for the Dashboard component |
| `options`? | [`UseComposedDashboardOptions`](../type-aliases/type-alias.UseComposedDashboardOptions.md) | Options for the composable. |

## Returns

[`ComposedDashboardResult`](../type-aliases/type-alias.ComposedDashboardResult.md)\< `D` \>

An object containing the composed dashboard and APIs to interact with it.

## Example

```ts
import { useComposedDashboard } from '@sisense/sdk-ui/dashboard/use-composed-dashboard.js';
import { Widget } from '@sisense/sdk-ui';
import { DashboardProps } from '@/dashboard/types.js';
import { FilterTile } from '@/filters';

const CodeExample = () => {
  const dashboardProps: DashboardProps = { ... };

  const {
    dashboard: { title, widgets, filters = [] }
  } = useComposedDashboard(dashboardProps);

  return (
    <div>
      <span>{title}</span>
      <div>
        {widgets.map((widget) => (
          <Widget key={widget.id} {...widget} />
        ))}
      </div>

      {Array.isArray(filters) ? filters.map((filter) => (
        <FilterTile
          key={filter.name}
          filter={filter}
          onChange={(filter) => console.log('Updated filter', filter)}
        />
      )) : null}
    </div>
  );
}
  export default CodeExample;
```


---

---
title: useCustomWidgets
---

# Function useCustomWidgets

> **useCustomWidgets**(): `object`

Hook that provides API for configuring custom widgets.

## Returns

### `getCustomWidget`

**getCustomWidget**: (`customWidgetType`) => [`CustomWidgetComponent`](../type-aliases/type-alias.CustomWidgetComponent.md)\< `any` \> \| `undefined`

#### Parameters

| Parameter | Type |
| :------ | :------ |
| `customWidgetType` | `string` |

#### Returns

[`CustomWidgetComponent`](../type-aliases/type-alias.CustomWidgetComponent.md)\< `any` \> \| `undefined`

### `hasCustomWidget`

**hasCustomWidget**: (`customWidgetType`) => `boolean`

#### Parameters

| Parameter | Type |
| :------ | :------ |
| `customWidgetType` | `string` |

#### Returns

`boolean`

### `registerCustomWidget`

**registerCustomWidget**: <`T`>(`customWidgetType`, `customWidget`) => `void`

#### Type parameters

| Parameter | Default |
| :------ | :------ |
| `T` | `any` |

#### Parameters

| Parameter | Type |
| :------ | :------ |
| `customWidgetType` | `string` |
| `customWidget` | [`CustomWidgetComponent`](../type-aliases/type-alias.CustomWidgetComponent.md)\< `T` \> |

#### Returns

`void`

## Example

Example of registering a custom widget in a dashboard:
```ts
import { useCustomWidgets, DashboardById } from '@sisense/sdk-ui';
import CustomHistogramWidget from './custom-histogram-widget';

const Example = () => {
  const { registerCustomWidget } = useCustomWidgets();
  registerCustomWidget('histogramwidget', CustomHistogramWidget);

  return <DashboardById dashboardOid="your-dashboard-oid" />;
}
```


---

---
title: useJtdWidget
---

# Function useJtdWidget

> **useJtdWidget**(...`args`): [`WidgetProps`](../type-aliases/type-alias.WidgetProps.md) \| `null`

Hook to add Jump To Dashboard (JTD) functionality to individual Widget components.

Jump To Dashboard (JTD) allows users to navigate from one dashboard to another when interacting with widgets,
such as clicking on chart data points or using context menus. This hook is particularly useful when rendering
Widget components directly (not through a Dashboard component), but you still want JTD navigation functionality.

For widgets that are part of a dashboard, consider using `applyJtdConfig` or `applyJtdConfigs` instead,
as they apply JTD configuration at the dashboard level rather than individual widget level.

Note: dashboard-only 'includeDashboardFilters' is not supported and would just be ignored, since we do not have a dashboard in the current context.

This hook enhances the provided widget props with JTD navigation capabilities, including:
- Click and right-click event handlers for navigation
- Hyperlink styling for actionable pivot cells (when applicable)
- JTD icon display in widget headers

## Parameters

| Parameter | Type |
| :------ | :------ |
| ...`args` | [[`WidgetProps`](../type-aliases/type-alias.WidgetProps.md) \| `null`, [`JumpToDashboardConfig`](../interfaces/interface.JumpToDashboardConfig.md) \| [`JumpToDashboardConfigForPivot`](../interfaces/interface.JumpToDashboardConfigForPivot.md)] |

## Returns

[`WidgetProps`](../type-aliases/type-alias.WidgetProps.md) \| `null`

Enhanced widget props with JTD navigation capabilities, menu combination, and styling applied

## Example

Basic JTD configuration with right-click navigation.
```typescript
import { useJtdWidget } from '@sisense/sdk-ui';

const jtdConfig: JumpToDashboardConfig = {
  targets: [{ id: 'dashboard-1', caption: 'Sales Dashboard' }],
  interaction: {
    triggerMethod: 'rightclick',
    captionPrefix: 'Jump to'
  }
};

const MyComponent = () => {
  const widgetWithJtd = useJtdWidget(myWidgetProps, jtdConfig);

  return <Widget {...widgetWithJtd} />;
};
```

## Example

JTD configuration with multiple targets and custom styling.
```typescript
const jtdConfig: JumpToDashboardConfig = {
  enabled: true,
  targets: [
    { id: 'sales-dashboard', caption: 'Sales Analysis' },
    { id: 'marketing-dashboard', caption: 'Marketing Insights' }
  ],
  interaction: {
    triggerMethod: 'click',
    captionPrefix: 'Navigate to',
    showIcon: true
  },
  filtering: {
    mergeWithTargetFilters: true,
    includeWidgetFilters: true
  }
};

const widgetWithJtd = useJtdWidget(chartProps, jtdConfig);
```


---

---
title: addFilter
---

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


---

---
title: addFilters
---

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


---

---
title: applyJtdConfig
---

# Function applyJtdConfig

> **applyJtdConfig**(
  `dashboard`,
  `widgetOid`,
  `config`): [`DashboardProps`](../../../interfaces/interface.DashboardProps.md)

Creates a new `DashboardProps` instance with JTD (Jump To Dashboard) configuration applied to a single widget.

Jump To Dashboard (JTD) allows users to navigate from one dashboard to another when interacting with widgets,
such as clicking on chart data points or using context menus. This function applies JTD configuration to a specific
widget in a dashboard, enabling jump-to-dashboard functionality.

This function does not modify the original dashboard; instead, it returns a new `DashboardProps` instance with the JTD
configuration applied. If the specified widget does not exist in the dashboard, the function returns the original
`DashboardProps` unchanged and logs a warning to the console.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `dashboard` | [`DashboardProps`](../../../interfaces/interface.DashboardProps.md) | The original dashboard to modify. Must be a valid `DashboardProps` object containing the target widget. |
| `widgetOid` | `string` | The unique identifier (OID) of the widget to apply JTD configuration to. Must match an existing widget ID in the dashboard. |
| `config` | [`JumpToDashboardConfig`](../../../interfaces/interface.JumpToDashboardConfig.md) | The JTD configuration to apply. |

## Returns

[`DashboardProps`](../../../interfaces/interface.DashboardProps.md)

A new `DashboardProps` instance with the JTD configuration applied to the specified widget. If the widget doesn't exist, returns the original dashboard unchanged.

## Example

Apply JTD configuration to a dashboard widget.
```ts
const jtdConfig: JumpToDashboardConfig = {
  targets: [{ id: 'dashboardId1', caption: 'Analytics Dashboard' }],
  interaction: {
    triggerMethod: 'rightclick',
    contextMenuCaption: 'Jump to Analytics'
  }
};

const updatedDashboard = dashboardHelpers.applyJtdConfig(dashboard, 'widgetId3', jtdConfig);
```


---

---
title: applyJtdConfigs
---

# Function applyJtdConfigs

> **applyJtdConfigs**(`dashboard`, `jtdConfigs`): [`DashboardProps`](../../../interfaces/interface.DashboardProps.md)

Creates a new `DashboardProps` instance with JTD (Jump To Dashboard) configurations applied to multiple widgets in a single operation.

Jump To Dashboard (JTD) allows users to navigate from one dashboard to another when interacting with widgets.
This function efficiently applies JTD configurations to multiple widgets in a single operation.

This function does not modify the original dashboard; instead, it returns a new `DashboardProps` instance with all valid
JTD configurations applied. Configurations for non-existent widgets are automatically filtered out, and warnings
are logged to the console for invalid widget OIDs.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `dashboard` | [`DashboardProps`](../../../interfaces/interface.DashboardProps.md) | The original dashboard to modify. Must be a valid `DashboardProps` object with widgets to configure. |
| `jtdConfigs` | `Record`\< `string`, [`JumpToDashboardConfig`](../../../interfaces/interface.JumpToDashboardConfig.md) \> | An object mapping widget OIDs (keys) to their respective JTD configurations (values). |

## Returns

[`DashboardProps`](../../../interfaces/interface.DashboardProps.md)

A new `DashboardProps` instance with all valid JTD configurations applied to their respective widgets. Invalid widget configurations are skipped and warnings are logged.

## Example

Apply a variety of Jump To Dashboard configuration options to multiple widgets in a single operation.
```ts
import { dashboardHelpers } from '@sisense/sdk-ui';

const dashboard: DashboardProps = {
  title: 'Executive Dashboard',
  widgets: [
    { id: 'widgetId1', widgetType: 'chart', chartType: 'column', dataOptions: {...} },
    { id: 'widgetId2', widgetType: 'chart', chartType: 'pie', dataOptions: {...} },
    { id: 'widgetId3', widgetType: 'table', dataOptions: {...} }
  ]
};

const jtdConfigs = {
  'widgetId1': {
    enabled: true,
    targets: [{ id: 'dashboardId1', caption: 'Sales Breakdown' }],
    interaction: {
      triggerMethod: 'rightclick'
    }
  },
  'widgetId2': {
    targets: [{ id: 'dashboardId2', caption: 'Revenue Analysis' }],
    interaction: {
      triggerMethod: 'click',
      contextMenuCaption: 'Analyze Revenue'
    }
  },
  'widgetId3': {
    enabled: true,
    targets: [
      { id: 'dashboardId3', caption: 'Customer Details' },
      { id: 'dashboardId4', caption: 'Product Analytics' }
    ],
    interaction: {
      triggerMethod: 'rightclick'
    }
  }
};

const updatedDashboard = dashboardHelpers.applyJtdConfigs(dashboard, jtdConfigs);
```

## Example

Batch apply JTD configurations with error handling.
```ts
const configsWithInvalidWidget = {
  'widgetId1': { targets: [{ id: 'dashboardId1', caption: 'Target' }] },
  'invalidWidgetId': { targets: [{ id: 'dashboardId2', caption: 'Other' }] } // Will be filtered out
};

const result = dashboardHelpers.applyJtdConfigs(dashboard, configsWithInvalidWidget);
// Console warning: "Widgets with OIDs [invalidWidgetId] not found in dashboard..."
// Only 'widgetId1' gets the JTD configuration applied
```


---

---
title: removeFilter
---

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

## Example

Remove a filter from a dashboard.
```ts
const existingDashboard: DashboardProps = {...};
const filterToRemove: Filter = {...};
const updatedDashboard = dashboardHelpers.removeFilter(existingDashboard, filterToRemove);
```


---

---
title: removeFilters
---

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

## Example

Remove multiple filters from a dashboard.
```ts
const existingDashboard: DashboardProps = {...};
const filtersToRemove: Filter[] = [{...}, {...}, ...];
const updatedDashboard = dashboardHelpers.removeFilters(existingDashboard, filtersToRemove);
```


---

---
title: replaceFilter
---

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


---

---
title: replaceFilters
---

# Function replaceFilters

> **replaceFilters**(`dashboard`, `newFilters`): [`DashboardProps`](../../../interfaces/interface.DashboardProps.md)

Creates a new dashboard instance with its filters replaced by a new set of filters.

This function does not modify the original dashboard; instead, it returns a new dashboard with the updated filters.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `dashboard` | [`DashboardProps`](../../../interfaces/interface.DashboardProps.md) | The original dashboard (`DashboardProps`) whose filters are to be replaced. |
| `newFilters` | [`FilterRelations`](../../../../sdk-data/interfaces/interface.FilterRelations.md) \| [`Filter`](../../../../sdk-data/interfaces/interface.Filter.md)[] | An array of new filters or filter relations to set on the dashboard. |

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

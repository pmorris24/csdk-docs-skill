---
title: ChartWidgetComponent
---

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


---

---
title: CustomWidgetsService
---

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


---

---
title: DashboardComponent
---

# Class DashboardComponent

An Angular component used for easily rendering a dashboard created in Sisense Fusion.

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


---

---
title: PivotTableWidgetComponent
---

# Class PivotTableWidgetComponent

The Pivot Table Widget component extends the [PivotTableComponent](../data-grids/class.PivotTableComponent.md) component to support widget features,
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


---

---
title: WidgetComponent
---

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

### Chart

#### chartType

> **chartType**: [`ChartType`](../type-aliases/type-alias.ChartType.md) \| `undefined`

Default chart type of each series

***

#### dataOptions

> **dataOptions**: [`ChartDataOptions`](../type-aliases/type-alias.ChartDataOptions.md) \| [`GenericDataOptions`](../type-aliases/type-alias.GenericDataOptions.md) \| [`PivotTableDataOptions`](../interfaces/interface.PivotTableDataOptions.md) \| `undefined`

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

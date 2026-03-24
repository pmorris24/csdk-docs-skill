---
title: DashboardById
---

# Function DashboardById <Badge type="fusionEmbed" text="Fusion Embed" />

> **DashboardById**(`props`): `ReactElement`\< `any`, `any` \> \| `null`

React component that renders a dashboard created in Sisense Fusion by its ID.

**Note:** Dashboard and Widget extensions based on JS scripts and add-ons in Fusion – for example, Blox and Jump To Dashboard – are not supported.

## Parameters

| Parameter | Type |
| :------ | :------ |
| `props` | [`DashboardByIdProps`](../interfaces/interface.DashboardByIdProps.md) |

## Returns

`ReactElement`\< `any`, `any` \> \| `null`

## Example

```ts
import { DashboardById } from '@sisense/sdk-ui';

 const CodeExample = () => {
   return (
     <>
       <DashboardById
         dashboardOid="65a82171719e7f004018691c"
       />
     </>
   );
 };

 export default CodeExample;
```

To learn more about this and related dashboard components,
see [Embedded Dashboards](/guides/sdk/guides/dashboards/index.html).


---

---
title: ExecuteQueryByWidgetId
---

# Function ExecuteQueryByWidgetId <Badge type="fusionEmbed" text="Fusion Embed" />

> **ExecuteQueryByWidgetId**(`props`): `ReactElement`\< `any`, `any` \> \| `null`

Executes a query over the existing widget and renders a function as child component.
The child component is passed the state of the query as defined in [QueryByWidgetIdState](../type-aliases/type-alias.QueryByWidgetIdState.md).

This component takes the Children Prop Pattern and
offers an alternative approach to the [useExecuteQueryByWidgetId](function.useExecuteQueryByWidgetId.md) hook.

**Note:** Widget extensions based on JS scripts and add-ons in Fusion are not supported.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `props` | [`ExecuteQueryByWidgetIdProps`](../interfaces/interface.ExecuteQueryByWidgetIdProps.md) | ExecuteQueryByWidgetId properties |

## Returns

`ReactElement`\< `any`, `any` \> \| `null`

ExecuteQueryByWidgetId component

## Example

The example below executes a query over the existing dashboard widget with the specified widget and dashboard OIDs.
```ts
<ExecuteQueryByWidgetId
  widgetOid={'64473e07dac1920034bce77f'}
  dashboardOid={'6441e728dac1920034bce737'}
>
{
  ({data, isLoading, isError}) => {
    if (isLoading) {
      return <div>Loading...</div>;
    }
    if (isError) {
      return <div>Error</div>;
    }
    if (data) {
      console.log(data);
      return <div>{`Total Rows: ${data.rows.length}`}</div>;
    }
    return null;
  }
}
</ExecuteQueryByWidgetId>
```


---

---
title: WidgetById
---

# Function WidgetById <Badge type="fusionEmbed" text="Fusion Embed" />

> **WidgetById**(`props`): `ReactElement`\< `any`, `any` \> \| `null`

The WidgetById component, which is a thin wrapper on the [ChartWidget](../dashboards/function.ChartWidget.md) component,
is used to render a widget created in a Sisense Fusion instance.

To learn more about using Sisense Fusion Widgets in Compose SDK,
see [Sisense Fusion Widgets](/guides/sdk/guides/charts/guide-fusion-widgets.html).

**Note:** Widget extensions based on JS scripts and add-ons in Fusion are not supported.

## Example

Display two dashboard widgets from a Fusion instance.

<iframe
 src='https://csdk-playground.sisense.com/?example=fusion-assets%2Ffusion-widgets&mode=docs'
 width=800
 height=870
 style='border:none;'
/>

## Parameters

| Parameter | Type |
| :------ | :------ |
| `props` | [`WidgetByIdProps`](../interfaces/interface.WidgetByIdProps.md) |

## Returns

`ReactElement`\< `any`, `any` \> \| `null`


---

---
title: useExecuteQueryByWidgetId
---

# Function useExecuteQueryByWidgetId <Badge type="fusionEmbed" text="Fusion Embed" />

> **useExecuteQueryByWidgetId**(...`args`): [`QueryByWidgetIdState`](../type-aliases/type-alias.QueryByWidgetIdState.md)

React hook that executes a data query extracted from an existing widget in the Sisense instance.

This approach, which offers an alternative to [ExecuteQueryByWidgetId](function.ExecuteQueryByWidgetId.md) component, is similar to React Query's `useQuery` hook.

**Note:** Widget extensions based on JS scripts and add-ons in Fusion are not supported.

## Parameters

| Parameter | Type |
| :------ | :------ |
| ...`args` | [[`ExecuteQueryByWidgetIdParams`](../interfaces/interface.ExecuteQueryByWidgetIdParams.md)] |

## Returns

[`QueryByWidgetIdState`](../type-aliases/type-alias.QueryByWidgetIdState.md)

Query state that contains the status of the query execution, the result data, the constructed query parameters, or the error if any occurred

## Example

The example below executes a query over the existing dashboard widget with the specified widget and dashboard OIDs.
```ts
 const { data, isLoading, isError } = useExecuteQueryByWidgetId({
   widgetOid: '64473e07dac1920034bce77f',
   dashboardOid: '6441e728dac1920034bce737'
 });
 if (isLoading) {
   return <div>Loading...</div>;
 }
 if (isError) {
   return <div>Error</div>;
 }
 if (data) {
   return <div>{`Total Rows: ${data.rows.length}`}</div>;
 }
 return null;
```
See also hook [useExecuteQuery](../queries/function.useExecuteQuery.md), which execute a query specified in code.


---

---
title: useFetch
---

# Function useFetch

> **useFetch**<`TData`, `TError`>(...`args`): [`UseQueryResult`](../type-aliases/type-alias.UseQueryResult.md)\< `TData`, `TError` \>

React hook that allows to make authorized fetch request to any Sisense API.

## Type parameters

| Parameter | Default |
| :------ | :------ |
| `TData` | `unknown` |
| `TError` | `unknown` |

## Parameters

| Parameter | Type |
| :------ | :------ |
| ...`args` | [`string`, `RequestInit`, \{<br />  `enabled`: `boolean`;<br />  `requestConfig`: [`RequestConfig`](../type-aliases/type-alias.RequestConfig.md);<br /> }] |

## Returns

[`UseQueryResult`](../type-aliases/type-alias.UseQueryResult.md)\< `TData`, `TError` \>

Query state that contains the status of the query execution, the result data, or the error if any occurred

## Example

```ts
 const { data, isLoading, error } = useFetch<unknown, Error>('api/v1/elasticubes/getElasticubes', {
   method: 'POST',
 });
```


---

---
title: useGetDashboardModel
---

# Function useGetDashboardModel <Badge type="fusionEmbed" text="Fusion Embed" />

> **useGetDashboardModel**(...`args`): [`DashboardModelState`](../type-aliases/type-alias.DashboardModelState.md)

React hook that retrieves an existing dashboard model from the Sisense instance.

**Note:** Dashboard and Widget extensions based on JS scripts and add-ons in Fusion – for example, Blox and Jump To Dashboard – are not supported.

## Parameters

| Parameter | Type |
| :------ | :------ |
| ...`args` | [[`GetDashboardModelParams`](../interfaces/interface.GetDashboardModelParams.md)] |

## Returns

[`DashboardModelState`](../type-aliases/type-alias.DashboardModelState.md)

Dashboard load state that contains the status of the execution, the result dashboard model, or the error if any

## Example

An example of retrieving an existing dashboard model from the Sisense instance and render its widgets with component `WidgetById`:
```ts
 const { dashboard, isLoading, isError } = useGetDashboardModel({
   dashboardOid: '6448665edac1920034bce7a8',
   includeWidgets: true,
 });
 if (isLoading) {
   return <div>Loading...</div>;
 }
 if (isError) {
   return <div>Error</div>;
 }
 if (dashboard) {
   return (
     <div>
       {`Dashboard Title - ${dashboard.title}`}
       {dashboard.widgets?.map((widget) => (
         <WidgetById key={widget.oid} widgetOid={widget.oid} dashboardOid={dashboard.oid} />
       ))}
     </div>
   );
 }
 return null;
```


---

---
title: useGetDashboardModels
---

# Function useGetDashboardModels <Badge type="fusionEmbed" text="Fusion Embed" />

> **useGetDashboardModels**(...`args`): [`DashboardModelsState`](../type-aliases/type-alias.DashboardModelsState.md)

React hook that retrieves existing dashboards that the user can access to from the Sisense instance.

**Note:** Dashboard and Widget extensions based on JS scripts and add-ons in Fusion – for example, Blox and Jump To Dashboard – are not supported.

## Parameters

| Parameter | Type |
| :------ | :------ |
| ...`args` | [[`GetDashboardModelsParams`](../interfaces/interface.GetDashboardModelsParams.md)] |

## Returns

[`DashboardModelsState`](../type-aliases/type-alias.DashboardModelsState.md)

Load state that contains the status of the execution, the result dashboards, or the error if any

## Example

```ts
 const { dashboards, isLoading, isError } = useGetDashboardModels();
 if (isLoading) {
   return <div>Loading...</div>;
 }
 if (isError) {
   return <div>Error</div>;
 }
 if (dashboards) {
   return <div>{`Total Dashboards: ${dashboards.length}`}</div>;
 }
 return null;
```


---

---
title: useGetHierarchyModels
---

# Function useGetHierarchyModels <Badge type="fusionEmbed" text="Fusion Embed" />

> **useGetHierarchyModels**(...`args`): [`HierarchyModelsState`](../type-aliases/type-alias.HierarchyModelsState.md)

React hook that retrieves existing hierarchy models from a Fusion instance.

## Parameters

| Parameter | Type |
| :------ | :------ |
| ...`args` | [[`GetHierarchyModelsParams`](../interfaces/interface.GetHierarchyModelsParams.md)] |

## Returns

[`HierarchyModelsState`](../type-aliases/type-alias.HierarchyModelsState.md)

Load state that contains the status of the execution, the result hierarchy models, or the error if one has occurred

## Example

Retrieve the hierarchy models and render their counts.
```ts
 const { hierarchies, isLoading, isError } = useGetHierarchyModels({
   dataSource: DM.DataSource,
   dimension: DM.Commerce.AgeRange,
 });

 if (isLoading) {
   return <div>Loading...</div>;
 }
 if (isError) {
   return <div>Error</div>;
 }
 if (hierarchies) {
   return <div>{`Total Hierarchies: ${hierarchies.length}`}</div>;
 }
 return null;
```


---

---
title: useGetSharedFormula
---

# Function useGetSharedFormula <Badge type="fusionEmbed" text="Fusion Embed" />

> **useGetSharedFormula**(...`args`): [`SharedFormulaState`](../type-aliases/type-alias.SharedFormulaState.md)

Fetch a [shared formula](https://docs.sisense.com/main/SisenseLinux/shared-formulas.htm) from the a Fusion instance.

The formula can be identified either by `oid` or by name and data source pair.

When the retrieval is successful but the shared formula is not found, the resulting `formula` is `null`. When the retrieval is not successful the resulting `formula` is `undefined`.

## Parameters

| Parameter | Type |
| :------ | :------ |
| ...`args` | [[`UseGetSharedFormulaParams`](../interfaces/interface.UseGetSharedFormulaParams.md)] |

## Returns

[`SharedFormulaState`](../type-aliases/type-alias.SharedFormulaState.md)

Formula load state that contains the status of the execution, the result formula, or the error if any

## Example

An example of retrieving a shared formula by oid:
   ```ts
   const { formula, isLoading, isError } = useGetSharedFormula({ oid: 'd61c337b-fabc-4e9e-b4cc-a30116857153' })
   ```

## Example

An example of retrieving a shared formula by name and data source:
   ```ts
   const { formula, isLoading, isError } = useGetSharedFormula({ name: 'My Shared Formula', datasource: DM.DataSource })
   ```


---

---
title: useGetWidgetModel
---

# Function useGetWidgetModel <Badge type="fusionEmbed" text="Fusion Embed" />

> **useGetWidgetModel**(...`args`): [`WidgetModelState`](../type-aliases/type-alias.WidgetModelState.md)

React hook that retrieves an existing widget model from a Fusion instance.

**Note:** Widget extensions based on JS scripts and add-ons in Fusion are not supported.

## Example

Retrieve a widget model and use it to populate a `Chart` component

<iframe
 src='https://csdk-playground.sisense.com/?example=fusion-assets%2Fuse-get-widget-model&mode=docs'
 width=800
 height=870
 style='border:none;'
/>

Additional `useGetWidgetModel` examples:

- [Modify Chart Type](https://www.sisense.com/developers/playground/?example=fusion-assets%2Fuse-get-widget-model-change-chart-type)

## Parameters

| Parameter | Type |
| :------ | :------ |
| ...`args` | [[`GetWidgetModelParams`](../interfaces/interface.GetWidgetModelParams.md)] |

## Returns

[`WidgetModelState`](../type-aliases/type-alias.WidgetModelState.md)

Widget load state that contains the status of the execution, the result widget model, or the error if one has occurred


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

> **styleOptions**: `ChartStyleOptions | TextWidgetStyleOptions | CustomWidgetStyleOptions` & [`WidgetContainerStyleOptions`](../interfaces/interface.WidgetContainerStyleOptions.md)

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

```ts
<Dashboard {...dashboardModelTranslator.toDashboardProps(dashboardModel)} />
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

```ts
<Chart {...widgetModelTranslator.toChartProps(widgetModel)} />
```

Note: this method is not supported for pivot widgets.
Use [toPivotTableProps](function.toPivotTableProps.md) instead for getting props for the `<PivotTable>`  component.


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

```ts
<ChartWidget {...widgetModelTranslator.toChartWidgetProps(widgetModel)} />
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
const {data, isLoading, isError} = useExecutePivotQuery(widgetModelTranslator.toExecutePivotQueryParams(widgetModel));
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
const {data, isLoading, isError} = useExecuteQuery(widgetModelTranslator.toExecuteQueryParams(widgetModel));
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

```ts
<PivotTable {...widgetModelTranslator.toPivotTableProps(widgetModel)} />
```

Note: this method is not supported for chart or table widgets.
Use [toChartProps](function.toChartProps.md) instead for getting props for the `<Chart>`  component.
Use [toTableProps](function.toTableProps.md) instead for getting props for the `<Table>`  component.


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

```ts
<PivotTableWidget {...widgetModelTranslator.toPivotTableWidgetProps(widgetModel)} />
```

Note: this method is not supported for chart or table widgets.
Use [toChartWidgetProps](function.toChartWidgetProps.md) instead for getting props for the `<ChartWidget>`  component.


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

```ts
<Table {...widgetModelTranslator.toTableProps(widgetModel)} />
```

Note: this method is not supported for chart and pivot widgets.
Use [toChartProps](function.toChartProps.md) instead for getting props for the `<Chart>`  component.
Use [toPivotTableProps](function.toPivotTableProps.md) instead for getting props for the `<PivotTable>`  component.


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
<TextWidget {...widgetModelTranslator.toTextWidgetProps(widgetModel)} />
```

Note: this method is not supported for chart or pivot widgets.
Use [toChartWidgetProps](function.toChartWidgetProps.md) instead for getting props for the `<ChartWidget>`  component.
Use [toPivotTableWidgetProps](function.toPivotTableWidgetProps.md) instead for getting props for the `<PivotTableWidget>`  component.


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

```ts
<Widget {...widgetModelTranslator.toWidgetProps(widgetModel)} />
```

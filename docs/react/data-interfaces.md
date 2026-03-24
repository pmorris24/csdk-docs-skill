---
title: AttributeDataPointEntry
---

# Interface AttributeDataPointEntry

A data point entry that represents a single attribute within a multi-dimensional data point.

## Properties

### attribute

> **attribute**: [`Attribute`](../../sdk-data/interfaces/interface.Attribute.md)

The attribute associated with this data point entry

***

### dataOption

> **dataOption**: [`CalculatedMeasureColumn`](../../sdk-data/interfaces/interface.CalculatedMeasureColumn.md) \| [`Column`](../../sdk-data/interfaces/interface.Column.md) \| [`MeasureColumn`](../../sdk-data/interfaces/interface.MeasureColumn.md) \| [`StyledColumn`](interface.StyledColumn.md) \| [`StyledMeasureColumn`](interface.StyledMeasureColumn.md)

The data option associated with this entry

***

### displayValue

> **displayValue**?: `string`

The formatted value of the data point

***

### value

> **value**: `number` \| `string`

The raw value of the data point


---

---
title: BasicDataPointEntry
---

# Interface BasicDataPointEntry

A basic data point entry that represents a single dimension within a multi-dimensional data point.

## Properties

### dataOption

> **dataOption**: [`CalculatedMeasureColumn`](../../sdk-data/interfaces/interface.CalculatedMeasureColumn.md) \| [`Column`](../../sdk-data/interfaces/interface.Column.md) \| [`MeasureColumn`](../../sdk-data/interfaces/interface.MeasureColumn.md) \| [`StyledColumn`](interface.StyledColumn.md) \| [`StyledMeasureColumn`](interface.StyledMeasureColumn.md)

The data option associated with this entry

***

### displayValue

> **displayValue**?: `string`

The formatted value of the data point

***

### value

> **value**: `number` \| `string`

The raw value of the data point


---

---
title: DataLimits
---

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


---

---
title: ExecuteCsvQueryParams
---

# Interface ExecuteCsvQueryParams

Parameters for [useExecuteCsvQuery](../queries/function.useExecuteCsvQuery.md) hook.

## Properties

### config

> **config**?: [`ExecuteCSVQueryConfig`](../type-aliases/type-alias.ExecuteCSVQueryConfig.md)

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

### enabled

> **enabled**?: `boolean`

Boolean flag to control if query is executed

If not specified, the default value is `true`

***

### filters

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

### onBeforeQuery

> **onBeforeQuery**?: (`jaql`) => `any`

Sync or async callback that allows to modify the JAQL payload before it is sent to the server.

**Note:** In React, wrap this function in `useCallback` hook to avoid triggering query execution on each render.
```ts
const onBeforeQuery = useCallback((jaql) => {
  // modify jaql here
  return jaql;
}, []);
```

#### Parameters

| Parameter | Type |
| :------ | :------ |
| `jaql` | `any` |

#### Returns

`any`

***

### ungroup

> **ungroup**?: `boolean`

Boolean flag whether to include `ungroup: true` in non-aggregated JAQL queries.

This improves computation and performance of querying tables when no aggregation is needed

If not specified, the default value is `false`


---

---
title: ExecuteQueryParams
---

# Interface ExecuteQueryParams

Parameters for [useExecuteQuery](../queries/function.useExecuteQuery.md) hook.

## Properties

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

### enabled

> **enabled**?: `boolean`

Boolean flag to control if query is executed

If not specified, the default value is `true`

***

### filters

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

### onBeforeQuery

> **onBeforeQuery**?: (`jaql`) => `any`

Sync or async callback that allows to modify the JAQL payload before it is sent to the server.

**Note:** In React, wrap this function in `useCallback` hook to avoid triggering query execution on each render.
```ts
const onBeforeQuery = useCallback((jaql) => {
  // modify jaql here
  return jaql;
}, []);
```

#### Parameters

| Parameter | Type |
| :------ | :------ |
| `jaql` | `any` |

#### Returns

`any`

***

### ungroup

> **ungroup**?: `boolean`

Boolean flag whether to include `ungroup: true` in non-aggregated JAQL queries.

This improves computation and performance of querying tables when no aggregation is needed

If not specified, the default value is `false`


---

---
title: ExecuteQueryProps
---

# Interface ExecuteQueryProps

Props for [ExecuteQuery](../queries/function.ExecuteQuery.md) component.

## Properties

### children

> **children**?: (`queryResult`) => `ReactNode`

Function as child component that is called to render the query results

#### Parameters

| Parameter | Type |
| :------ | :------ |
| `queryResult` | [`ExecuteQueryResult`](../type-aliases/type-alias.ExecuteQueryResult.md) |

#### Returns

`ReactNode`

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

### onBeforeQuery

> **onBeforeQuery**?: (`jaql`) => `any`

Sync or async callback that allows to modify the JAQL payload before it is sent to the server.

**Note:** In React, wrap this function in `useCallback` hook to avoid triggering query execution on each render.
```ts
const onBeforeQuery = useCallback((jaql) => {
  // modify jaql here
  return jaql;
}, []);
```

#### Parameters

| Parameter | Type |
| :------ | :------ |
| `jaql` | `any` |

#### Returns

`any`

***

### onDataChanged

> **onDataChanged**?: (`data`) => `void`

Callback function that is evaluated when query results are ready

#### Parameters

| Parameter | Type |
| :------ | :------ |
| `data` | [`QueryResultData`](../../sdk-data/interfaces/interface.QueryResultData.md) |

#### Returns

`void`

***

### ungroup

> **ungroup**?: `boolean`

Boolean flag whether to include `ungroup: true` in non-aggregated JAQL queries.

This improves computation and performance of querying tables when no aggregation is needed

If not specified, the default value is `false`


---

---
title: GetDataSourceDimensionsParams
---

# Interface GetDataSourceDimensionsParams

Parameters for [useGetDataSourceDimensions](../functions/function.useGetDataSourceDimensions.md) hook.

## Properties

### count

> **count**?: `number`

The number of items to return

***

### dataSource

> **dataSource**: [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md) \| `undefined`

The data source to get the dimensions for. If no data source is provided, the default data source will be used.

***

### enabled

> **enabled**?: `boolean`

Whether the query should be enabled.

***

### offset

> **offset**?: `number`

The offset for pagination

***

### searchValue

> **searchValue**?: `string`

The search value to filter by


---

---
title: GetQueryRecommendationsParams
---

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


---

---
title: MeasureDataPointEntry
---

# Interface MeasureDataPointEntry

A data point entry that represents a single measure within a multi-dimensional data point.

## Properties

### dataOption

> **dataOption**: [`CalculatedMeasureColumn`](../../sdk-data/interfaces/interface.CalculatedMeasureColumn.md) \| [`Column`](../../sdk-data/interfaces/interface.Column.md) \| [`MeasureColumn`](../../sdk-data/interfaces/interface.MeasureColumn.md) \| [`StyledColumn`](interface.StyledColumn.md) \| [`StyledMeasureColumn`](interface.StyledMeasureColumn.md)

The data option associated with this entry

***

### displayValue

> **displayValue**?: `string`

The formatted value of the data point

***

### measure

> **measure**: [`Measure`](../../sdk-data/interfaces/interface.Measure.md)

The measure associated with this data point entry

***

### value

> **value**: `number` \| `string`

The raw value of the data point


---

---
title: NlqResponseData
---

# Interface NlqResponseData

Response data for NLQ request

## Properties

### detailedDescription

> **detailedDescription**: `string`

Detailed description of the response

***

### followupQuestions

> **followupQuestions**?: `string`[]

An array of suggested followup questions

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


---

---
title: QueryRecommendation
---

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

### widgetProps

> **widgetProps**?: [`WidgetProps`](../type-aliases/type-alias.WidgetProps.md)

Suggested widget props


---

---
title: TableDataOptions
---

# Interface TableDataOptions

Configuration for how to query data and assign data to Table.

## Properties

### columns

> **columns**: ([`CalculatedMeasureColumn`](../../sdk-data/interfaces/interface.CalculatedMeasureColumn.md) \| [`Column`](../../sdk-data/interfaces/interface.Column.md) \| [`MeasureColumn`](../../sdk-data/interfaces/interface.MeasureColumn.md) \| [`StyledColumn`](interface.StyledColumn.md) \| [`StyledMeasureColumn`](interface.StyledMeasureColumn.md))[]

Columns (or attributes) whose values represent data columns in table


---

---
title: UseGetQueryRecommendationsParams
---

# Interface UseGetQueryRecommendationsParams

Parameters for [useGetQueryRecommendations](../generative-ai/function.useGetQueryRecommendations.md) hook.

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

***

### enabled

> **enabled**?: `boolean`

Boolean flag to control if the hook is executed

If not specified, the default value is `true`


---

---
title: UseGetQueryRecommendationsState
---

# Interface UseGetQueryRecommendationsState

State for [useGetQueryRecommendations](../generative-ai/function.useGetQueryRecommendations.md) hook.

## Properties

### data

> **data**: [`QueryRecommendation`](interface.QueryRecommendation.md)[] \| `undefined`

The result data

***

### error

> **error**: `unknown`

The error if any occurred

***

### isError

> **isError**: `boolean`

Whether the data fetching has failed

***

### isLoading

> **isLoading**: `boolean`

Whether the data fetching is loading

***

### isSuccess

> **isSuccess**: `boolean`

Whether the data fetching has succeeded

***

### refetch

> **refetch**: () => `void`

Callback to trigger a refetch of the data

#### Returns

`void`

---
title: ExecuteQuery
---

# Function ExecuteQuery

> **ExecuteQuery**(`props`): `ReactElement`\< `any`, `any` \> \| `null`

Executes a query and renders a function as child component. The child
component is passed the state of the query as defined in [QueryState](../type-aliases/type-alias.QueryState.md).

This component takes the Children Prop Pattern and
offers an alternative approach to the [useExecuteQuery](function.useExecuteQuery.md) hook.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `props` | [`ExecuteQueryProps`](../interfaces/interface.ExecuteQueryProps.md) | ExecuteQuery properties |

## Returns

`ReactElement`\< `any`, `any` \> \| `null`

ExecuteQuery component

## Example

Example of using the component to query the `Sample ECommerce` data source:
```ts
<ExecuteQuery
  dataSource={DM.DataSource}
  dimensions={[DM.Commerce.AgeRange]}
  measures={[measureFactory.sum(DM.Commerce.Revenue)]}
  filters={[filterFactory.greaterThan(DM.Commerce.Revenue, 1000)]}
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
</ExecuteQuery>
```


---

---
title: useExecuteCsvQuery
---

# Function useExecuteCsvQuery

> **useExecuteCsvQuery**(...`args`): [`CsvQueryState`](../type-aliases/type-alias.CsvQueryState.md)

React hook that executes a CSV data query.
Similar to [useExecuteQuery](function.useExecuteQuery.md), but returns the data in CSV format as text or as a stream.

## Parameters

| Parameter | Type |
| :------ | :------ |
| ...`args` | [[`ExecuteCsvQueryParams`](../interfaces/interface.ExecuteCsvQueryParams.md)] |

## Returns

[`CsvQueryState`](../type-aliases/type-alias.CsvQueryState.md)

Query state that contains the status of the query execution, the result data, or the error if any occurred

## Example

An example of using the hook to obtain data in a CSV string:
```ts
const { data, isLoading, isError } = useExecuteCsvQuery({
  dataSource: DM.DataSource,
  dimensions: [DM.Commerce.AgeRange],
  measures: [measureFactory.sum(DM.Commerce.Revenue)],
  filters: [filterFactory.greaterThan(DM.Commerce.Revenue, 1000)],
});
if (isLoading) {
  return <div>Loading...</div>;
}
if (isError) {
  return <div>Error</div>;
}
if (data) {
  return <div>{`CSV as string: ${data}`}</div>;
}
return null;
```
An example of using the hook to obtain data in CSV format as a stream, translating headers, and triggering file download:
```ts
const { data, isLoading, isError } = useExecuteCsvQuery({
  dataSource: DM.DataSource,
  dimensions: [DM.Commerce.AgeRange],
  measures: [measureFactory.sum(DM.Commerce.Revenue)],
  filters: [filterFactory.greaterThan(DM.Commerce.Revenue, 1000)],
  config: { asDataStream: true },
});
if (isLoading) {
  return <div>Loading...</div>;
}
if (isError) {
  return <div>Error</div>;
}
if (data) {
  const reader = new FileReader();
  reader.onload = () => {
    if (reader.result) {
      const text = reader.result as string;
      const lines = text.split('\n');
      // Update headers
      if (lines.length > 0) {
        lines[0] = translateHeaders(lines[0]); // replace with own implementation
      }
      // Join modified lines back to a text
      const modifiedCsv = lines.join('\n');
      // Create a new Blob with modified content
      const modifiedBlob = new Blob([modifiedCsv], { type: 'text/csv' });
      // Trigger file download
      const blobURL = window.URL.createObjectURL(modifiedBlob);
      const a = document.createElement('a');
      a.href = blobURL;
      const fileName = 'data_translated_headers'
      a.download = fileName;
      document.body.appendChild(a);
      a.click();
      window.URL.revokeObjectURL(blobURL);
      document.body.removeChild(a);
    }
  };
  reader.readAsText(data as Blob);
}
return null;
```


---

---
title: useExecuteCustomWidgetQuery
---

# Function useExecuteCustomWidgetQuery

> **useExecuteCustomWidgetQuery**(...`args`): [`QueryState`](../type-aliases/type-alias.QueryState.md)

React hook that takes a custom widget component's props and executes a data query.

## Parameters

| Parameter | Type |
| :------ | :------ |
| ...`args` | [[`ExecuteCustomWidgetQueryParams`](../interfaces/interface.ExecuteCustomWidgetQueryParams.md)] |

## Returns

[`QueryState`](../type-aliases/type-alias.QueryState.md)


---

---
title: useExecutePivotQuery
---

# Function useExecutePivotQuery

> **useExecutePivotQuery**(...`args`): [`PivotQueryState`](../type-aliases/type-alias.PivotQueryState.md)

React hook that executes a data query for a pivot table.
This approach is similar to React Query's `useQuery` hook.

## Example

Execute a pivot query on the Sample ECommerce data model and display the results in a table.

<iframe
 src='https://csdk-playground.sisense.com/?example=queries%2Fuse-execute-pivot-query&mode=docs'
 width=800
 height=870
 style='border:none;'
/>

## Parameters

| Parameter | Type |
| :------ | :------ |
| ...`args` | [[`ExecutePivotQueryParams`](../interfaces/interface.ExecutePivotQueryParams.md)] |

## Returns

[`PivotQueryState`](../type-aliases/type-alias.PivotQueryState.md)

Query state that contains the status of the query execution, the result data, or the error if any occurred


---

---
title: useExecuteQuery
---

# Function useExecuteQuery

> **useExecuteQuery**(...`args`): [`ExecuteQueryResult`](../type-aliases/type-alias.ExecuteQueryResult.md)

React hook that executes a data query.

This approach, which offers an alternative to the [ExecuteQuery](function.ExecuteQuery.md) component, is similar to React Query's `useQuery` hook.

## Example

Execute a query to retrieve revenue per country per year from the Sample ECommerce data model. Then display the data in a table and column chart.

<iframe
 src='https://csdk-playground.sisense.com/?example=queries%2Fuse-execute-query-sorting&mode=docs'
 width=800
 height=870
 style='border:none;'
/>

Additional `useExecuteQuery()` examples:

- [Query with Sorting](https://www.sisense.com/developers/playground/?example=queries%2Fuse-execute-query-sorting)
- [Take Control of Your Data Visualizations]( https://www.sisense.com/blog/take-control-of-your-data-visualizations/) blog post with examples of using the hook to fetch data to display in third-party charts.

## Parameters

| Parameter | Type |
| :------ | :------ |
| ...`args` | [[`ExecuteQueryParams`](../interfaces/interface.ExecuteQueryParams.md)] |

## Returns

[`ExecuteQueryResult`](../type-aliases/type-alias.ExecuteQueryResult.md)

Query state that contains the status of the query execution, the result data, or the error if any occurred


---

---
title: useQueryCache
---

# Function useQueryCache <Badge type="beta" text="Beta" />

> **useQueryCache**(): \{
  `clear`: () => `void`;
 } \| `undefined`

React hook that returns the QueryCacheClient module instance to control query cache.

How to enable query cache see in [Query Caching guide](/guides/sdk/guides/client-query-caching.html)

## Returns

\{
  `clear`: () => `void`;
 } \| `undefined`

QueryCacheClient instance

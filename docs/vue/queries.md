---
title: useExecuteCsvQuery
---

# Function useExecuteCsvQuery

> **useExecuteCsvQuery**(`params`): `ToRefs`\< [`CsvQueryState`](../../sdk-ui/type-aliases/type-alias.CsvQueryState.md) \>

A Vue composable function `useExecuteCsvQuery` that executes a CSV data query.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `params` | [`MaybeRefOrWithRefs`](../type-aliases/type-alias.MaybeRefOrWithRefs.md)\< [`ExecuteCsvQueryParams`](../../sdk-ui/interfaces/interface.ExecuteCsvQueryParams.md) \> | The parameters for the query, supporting reactive Vue refs.<br />Includes details such as `dataSource`, `dimensions`, `measures`, `filters`, and more, allowing for comprehensive<br />query configuration. The `filters` parameter supports dynamic filtering based on user interaction or other application<br />state changes. |

## Returns

`ToRefs`\< [`CsvQueryState`](../../sdk-ui/type-aliases/type-alias.CsvQueryState.md) \>

## Example

How to use `useExecuteCsvQuery` within a Vue component:
```vue
<script setup>
import { ref } from 'vue';
import { useExecuteCsvQuery } from '@sisense/sdk-ui-vue';

const dataSource = ref('your_data_source_id');
// Set up other query parameters as needed (dimensions, measures, filters, etc.)

const { data, isLoading, isError, isSuccess, error } = useExecuteCsvQuery({
  dataSource,
  dimensions: [...],
  measures: [...],
  filters: [...],
  config: { asDataStream: false },
  // Additional query parameters
});
</script>
```

The composable returns an object with the following reactive properties to manage the query state:
- `data`: The CSV data (string or Blob) returned from the query. It remains `undefined` until the query completes successfully.
- `isLoading`: Indicates if the query is in progress.
- `isError`: Indicates if an error occurred during query execution.
- `isSuccess`: Indicates if the query executed successfully without errors.
- `error`: Contains the error object if an error occurred during the query.

This composable facilitates integrating Sisense data fetching into Vue applications, enabling developers
to easily manage query states and dynamically adjust query parameters based on application needs.


---

---
title: useExecuteCustomWidgetQuery
---

# Function useExecuteCustomWidgetQuery

> **useExecuteCustomWidgetQuery**(`params`): `ToRefs`\< [`QueryState`](../../sdk-ui/type-aliases/type-alias.QueryState.md) \>

Vue composable that takes a custom widget component's props and executes a data query.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `params` | [`MaybeRefOrWithRefs`](../type-aliases/type-alias.MaybeRefOrWithRefs.md)\< [`ExecuteCustomWidgetQueryParams`](../interfaces/interface.ExecuteCustomWidgetQueryParams.md) \> | Custom widget component props containing data source, data options, filters, etc. |

## Returns

`ToRefs`\< [`QueryState`](../../sdk-ui/type-aliases/type-alias.QueryState.md) \>

Query state object with data, loading, and error states

## Example

```vue
<script setup>
import {
  useExecuteCustomWidgetQuery,
  type CustomWidgetComponentProps,
  type ExecuteCustomWidgetQueryParams,
} from '@sisense/sdk-ui-vue';
import * as DM from './sample-ecommerce';

const props: CustomWidgetComponentProps = {
  dataSource: DM.DataSource,
  dataOptions: {
    category: [DM.Commerce.Gender],
    value: [DM.Measures.SumRevenue],
  },
  styleOptions: {},
};

const params: ExecuteCustomWidgetQueryParams = {
  ...props,
  count: 10,
  offset: 0,
};

const { data, isLoading, isError, isSuccess } = useExecuteCustomWidgetQuery(params);
</script>
```


---

---
title: useExecutePivotQuery
---

# Function useExecutePivotQuery

> **useExecutePivotQuery**(`params`): `ToRefs`\< [`PivotQueryState`](../../sdk-ui/type-aliases/type-alias.PivotQueryState.md) \>

A Vue composable function `useExecutePivotQuery` that executes a pivot data query.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `params` | [`MaybeRefOrWithRefs`](../type-aliases/type-alias.MaybeRefOrWithRefs.md)\< [`ExecutePivotQueryParams`](../../sdk-ui/interfaces/interface.ExecutePivotQueryParams.md) \> | The parameters for the query, supporting reactive Vue refs.<br />Includes details such as `dataSource`, `dimensions`, `rows`, `columns`, `values`, `filters` and more, allowing for comprehensive<br />query configuration. The `filters` parameter supports dynamic filtering based on user interaction or other application<br />state changes. |

## Returns

`ToRefs`\< [`PivotQueryState`](../../sdk-ui/type-aliases/type-alias.PivotQueryState.md) \>

## Example

How to use `useExecutePivotQuery` within a Vue component:
```vue
<script setup>
import { ref } from 'vue';
import { useExecutePivotQuery } from '@sisense/sdk-ui-vue';

const dataSource = ref('your_data_source_id');
// Set up other query parameters as needed (dimensions, rows, columns, values, filters, etc.)

const { data, isLoading, isError, isSuccess, error } = useExecutePivotQuery({
  dataSource,
  columns: [...],
  rows: [...],
  values: [...],
  filters: [...],
  // Additional query parameters
});
</script>
```

The composable returns an object with the following reactive properties to manage the query state:
- `data`: The Pivot query result data set returned from the query. It remains `undefined` until the query completes successfully.
- `isLoading`: Indicates if the query is in progress.
- `isError`: Indicates if an error occurred during query execution.
- `isSuccess`: Indicates if the query executed successfully without errors.
- `error`: Contains the error object if an error occurred during the query.

This composable facilitates integrating Sisense data fetching into Vue applications, enabling developers
to easily manage query states and dynamically adjust query parameters based on application needs.


---

---
title: useExecuteQuery
---

# Function useExecuteQuery

> **useExecuteQuery**(`params`): `ToRefs`\< [`QueryState`](../../sdk-ui/type-aliases/type-alias.QueryState.md) \>

A Vue composable function `useExecuteQuery` for executing Sisense queries with flexible parameters.
It handles query execution, including loading, error, and success states, and enables dynamic query configuration
through reactive parameters. This composable is particularly useful for applications requiring data from Sisense
analytics, offering a reactive and declarative approach to data fetching and state management.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `params` | [`MaybeRefOrWithRefs`](../type-aliases/type-alias.MaybeRefOrWithRefs.md)\< [`ExecuteQueryParams`](../interfaces/interface.ExecuteQueryParams.md) \> | The parameters for the query, supporting reactive Vue refs.<br />Includes details such as `dataSource`, `dimensions`, `measures`, `filters`, and more, allowing for comprehensive<br />query configuration. The `filters` parameter supports dynamic filtering based on user interaction or other application<br />state changes. |

## Returns

`ToRefs`\< [`QueryState`](../../sdk-ui/type-aliases/type-alias.QueryState.md) \>

## Example

How to use `useExecuteQuery` within a Vue component:
```vue
<script setup>
import { ref } from 'vue';
import { useExecuteQuery } from '@sisense/sdk-ui-vue';

const dataSource = ref('your_data_source_id');
// Set up other query parameters as needed (dimensions, measures, filters, etc.)

const { data, isLoading, isError, isSuccess, error } = useExecuteQuery({
  dataSource,
  dimensions: [...],
  measures: [...],
  filters: [...],
  // Additional query parameters
});
</script>
```

The composable returns an object with the following reactive properties to manage the query state:
- `data`: The data returned from the query. It remains `undefined` until the query completes successfully.
- `isLoading`: Indicates if the query is in progress.
- `isError`: Indicates if an error occurred during query execution.
- `isSuccess`: Indicates if the query executed successfully without errors.
- `error`: Contains the error object if an error occurred during the query.

This composable facilitates integrating Sisense data fetching into Vue applications, enabling developers
to easily manage query states and dynamically adjust query parameters based on application needs.

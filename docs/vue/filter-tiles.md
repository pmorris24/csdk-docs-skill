---
title: CriteriaFilterTile
---

# Class CriteriaFilterTile

UI component that allows the user to filter numeric or text attributes according to
a number of built-in operations defined in the numeric filter, text filter, or ranking filter.

The arrangement prop determines whether the filter is rendered vertically or horizontally, with the latter intended for toolbar use and omitting title, enable/disable, and collapse/expand functionality.

## Example

Here's how you can use the CriteriaFilterTile component in a Vue application:
```vue
<template>
  <CriteriaFilterTile
    :title="criteriaFilterTileProps.title"
    :filter="criteriaFilterTileProps.filter"
    :onUpdate="onUpdate"
  />
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { CriteriaFilterTile } from '@sisense/sdk-ui-vue';
import { filterFactory } from '@sisense/sdk-data';

const criteriaFilterTileProps = ref({
 title: 'Revenue',
 filter: filterFactory.greaterThanOrEqual(DM.Commerce.Revenue, 10000)
});

const onUpdate = (filter: Filter | null) => {
 ...
}
</script>
```
<img src="../../../img/vue-criteria-filter-tile-example.png" width="600px" />

## Param

Criteria filter tile props

## Properties

### arrangement

> **`readonly`** **arrangement**?: [`FilterVariant`](../type-aliases/type-alias.FilterVariant.md)

Arrangement of the filter inputs. Use vertical for standard filter tiles and horizontal for toolbars

***

### filter

> **`readonly`** **filter**: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)

Text or numeric filter object to initialize filter type and default values

***

### measures

> **`readonly`** **measures**?: [`Measure`](../../sdk-data/interfaces/interface.Measure.md)[]

List of available measures to rank by. Required only for ranking filters.

***

### onDelete

> **`readonly`** **onDelete**?: () => `void`

Filter delete callback

#### Returns

`void`

***

### onEdit

> **`readonly`** **onEdit**?: () => `void`

Filter edit callback

#### Returns

`void`

***

### onUpdate

> **`readonly`** **onUpdate**: (`filter`) => `void`

Callback returning updated filter object

#### Parameters

| Parameter | Type |
| :------ | :------ |
| `filter` | [`Filter`](../../sdk-data/interfaces/interface.Filter.md) |

#### Returns

`void`

***

### title

> **`readonly`** **title**: `string`

Title for the filter tile, which is rendered into the header


---

---
title: DateRangeFilterTile
---

# Class DateRangeFilterTile

Date Range Filter Tile component for filtering data by date range.

## Example

Vue example of configuring the date min max values and handling onChange event.
```vue
<template>
        <DateRangeFilterTile
          :title="dateRangeFilter.title"
          :datasource="dateRangeFilter.dataSource"
          :attribute="dateRangeFilter.attribute"
          :filter="dateRangeFilter.filter"
          :onChange="dateRangeFilter.onChange"
        />
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { DateRangeFilterTile, type DateRangeFilterTileProps } from '@sisense/sdk-ui-vue';
import { filterFactory } from '@sisense/sdk-data';
import * as DM from '../assets/sample-retail-model';

const dateRangeFilterValue = ref<Filter | null>(filterFactory.dateRange(DM.DimDate.Date.Years));

const dateRangeFilter = ref<DateRangeFilterTileProps>({
  title: 'Date Range',
  attribute: DM.DimDate.Date.Years,
  filter: dateRangeFilterValue.value!,
  onChange(filter) {
    dateRangeFilterValue.value = filter;
  },
});
</script>
```
<img src="../../../img/vue-date-range-filter-tile-example.png" width="600px" />

## Param

DateRangeFilterTile props

## Properties

### attribute

> **`readonly`** **attribute**: [`LevelAttribute`](../../sdk-data/interfaces/interface.LevelAttribute.md)

Date level attribute the filter is based on

***

### datasource

> **`readonly`** **datasource**?: [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md)

Data source the query is run against - e.g. `Sample ECommerce`

If not specified, the query will use the `defaultDataSource` specified in the parent Sisense Context.

***

### earliestDate

> **`readonly`** **earliestDate**?: `string`

Earliest allowed date for selection.

If not specified, the earliest date of the target date-level attribute will be used.

***

### filter

> **`readonly`** **filter**: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)

Date range filter.

***

### lastDate

> **`readonly`** **lastDate**?: `string`

Latest allowed date for selection.

If not specified, the latest date of the target date-level attribute will be used.

***

### onChange

> **`readonly`** **onChange**: (`filter`) => `void`

Callback function that is called when the date range filter object should be updated.

#### Parameters

| Parameter | Type |
| :------ | :------ |
| `filter` | [`Filter`](../../sdk-data/interfaces/interface.Filter.md) |

#### Returns

`void`

***

### onDelete

> **`readonly`** **onDelete**?: () => `void`

Filter delete callback

#### Returns

`void`

***

### onEdit

> **`readonly`** **onEdit**?: () => `void`

Filter edit callback

#### Returns

`void`

***

### parentFilters

> **`readonly`** **parentFilters**?: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

List of filters this filter is dependent on.

***

### title

> **`readonly`** **title**: `string`

Filter tile title


---

---
title: FilterTile
---

# Class FilterTile

UI component that renders a filter tile based on filter type

## Example

Here’s how to render a filter model as a filter tile.
```vue
<script setup lang="ts">
import { ref } from 'vue';
import { FilterTile } from '@sisense/sdk-ui-vue';
import { filterFactory, type Filter } from '@sisense/sdk-data';
import * as DM from '../assets/sample-ecommerce-model.js';

const filter = ref<Filter>(filterFactory.members(DM.Commerce.Gender, ['Male', 'Female']));
const handleFilterChange = (updatedFilter: Filter | null) => {
 if (updatedFilter) {
   filter.value = updatedFilter;
 }
};
</script>

<template>
 <FilterTile :filter="filter" :onChange="handleFilterChange" />
</template>
```
<img src="../../../img/vue-filter-tile-example.png" width="225px" />

## Param

FilterTile props

## Properties

### defaultDataSource

> **`readonly`** **defaultDataSource**?: [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md)

Default data source used for filter tiles

***

### filter

> **`readonly`** **filter**: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)

Filter to display

***

### onChange

> **`readonly`** **onChange**: (`filter`) => `void`

Callback to handle filter change

#### Parameters

| Parameter | Type |
| :------ | :------ |
| `filter` | [`Filter`](../../sdk-data/interfaces/interface.Filter.md) \| `null` |

#### Returns

`void`

***

### onDelete

> **`readonly`** **onDelete**?: () => `void`

Filter delete callback

#### Returns

`void`

***

### onEdit

> **`readonly`** **onEdit**?: (`levelIndex`?) => `void`

Filter edit callback

#### Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `levelIndex`? | `number` | Index of the filter level that triggers the onEdit action (in the case of a CascadingFilter) |

#### Returns

`void`


---

---
title: FiltersPanel
---

# Class FiltersPanel

Filters panel component that renders a list of filter tiles

## Example

Here's how to render a filters panel with a set of filters.
```vue
<script setup lang="ts">
import { ref } from 'vue';
import { FiltersPanel } from '@sisense/sdk-ui-vue';
import { filterFactory, type Filter, type FilterRelations } from '@sisense/sdk-data';
import * as DM from '../assets/sample-ecommerce-model.js';

const filters = ref<Filter[]>([
 filterFactory.members(DM.Commerce.Gender, ['Male', 'Female']),
 filterFactory.members(DM.Commerce.AgeRange, ['0-18', '19-24']),
]);

const handleFiltersChange = (updatedFilters: Filter[] | FilterRelations) => {
 filters.value = updatedFilters as Filter[];
 console.log('Filters changed:', updatedFilters);
};
</script>

<template>
 <FiltersPanel
   :filters="filters"
   :defaultDataSource="DM.DataSource"
   :onFiltersChange="handleFiltersChange"
 />
</template>
```

## Param

FiltersPanel props

## Properties

### config

> **`readonly`** **config**?: [`FiltersPanelConfig`](../../sdk-ui/interfaces/interface.FiltersPanelConfig.md)

The configuration for the filters panel

***

### defaultDataSource

> **`readonly`** **defaultDataSource**?: [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md)

Default data source used for filter tiles

***

### filters

> **`readonly`** **filters**: [`FilterRelations`](../../sdk-data/interfaces/interface.FilterRelations.md) \| [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Array of filters to display

***

### onFiltersChange

> **`readonly`** **onFiltersChange**: (`filters`) => `void`

Callback to handle changes in filters

#### Parameters

| Parameter | Type |
| :------ | :------ |
| `filters` | [`FilterRelations`](../../sdk-data/interfaces/interface.FilterRelations.md) \| [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[] |

#### Returns

`void`


---

---
title: MemberFilterTile
---

# Class MemberFilterTile

UI component that allows the user to select members to include/exclude in a
filter. A query is executed against the provided data source to fetch
all members that are selectable.

## Example

Below is an example for filtering countries in the `Country` dimension of the `Sample ECommerce` data model.
```vue
<template>
      <MemberFilterTile
        :attribute="memberFilter.attribute"
        :onChange="memberFilter.onChange"
        :dataSource="memberFilter.dataSource"
        :title="memberFilter.title"
      />
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { MemberFilterTile, type MemberFilterTileProps } from '@sisense/sdk-ui-vue';

const memberFilterValue = ref<Filter | null>(null);

const memberFilter = ref<MemberFilterTileProps>({
  dataSource: DM.DataSource,
  title: 'Member Filter',
  attribute: DM.DimProducts.ProductName,
  filter: memberFilterValue.value,
  onChange(filter) {
    memberFilterValue.value = filter;
  },
});

</script>
```
<img src="../../../img/vue-member-filter-tile-example.png" width="600px" />

## Param

MemberFilterTile props

## Properties

### attribute

> **`readonly`** **attribute**: [`Attribute`](../../sdk-data/interfaces/interface.Attribute.md)

Attribute to filter on. A query will run to fetch all this attribute's members

***

### dataSource

> **`readonly`** **dataSource**?: [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md)

Data source the query is run against - e.g. `Sample ECommerce`

If not specified, the query will use the `defaultDataSource` specified in the parent Sisense Context.

***

### filter

> **`readonly`** **filter**: [`Filter`](../../sdk-data/interfaces/interface.Filter.md) \| `null`

Source filter object. Caller is responsible for keeping track of filter state

***

### onChange

> **`readonly`** **onChange**: (`filter`) => `void`

Callback indicating when the source members filter should be updated

#### Parameters

| Parameter | Type |
| :------ | :------ |
| `filter` | [`Filter`](../../sdk-data/interfaces/interface.Filter.md) \| `null` |

#### Returns

`void`

***

### onDelete

> **`readonly`** **onDelete**?: () => `void`

Filter delete callback

#### Returns

`void`

***

### onEdit

> **`readonly`** **onEdit**?: () => `void`

Filter edit callback

#### Returns

`void`

***

### parentFilters

> **`readonly`** **parentFilters**?: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

List of filters this filter is dependent on

***

### title

> **`readonly`** **title**: `string`

Title for the filter tile, which is rendered into the header


---

---
title: RelativeDateFilterTile
---

# Class RelativeDateFilterTile

Relative Date Filter Tile component for filtering data by relative date.

## Example

Vue example of configuring the date min max values and handling onUpdate event.
```vue
<template>
  <RelativeDateFilterTile
    :title="relativeDateFilter.title"
    :filter="relativeDateFilter.filter"
    :arrangement="relativeDateFilter.arrangement"
    :onUpdate="relativeDateFilter.onUpdate"
  />
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { RelativeDateFilterTile, type RelativeDateFilterTileProps } from '@sisense/sdk-ui-vue';
import { filterFactory } from '@sisense/sdk-data';
import * as DM from '../assets/sample-retail-model';

const relativeDateFilterValue = ref<Filter | null>(filterFactory.dateRelativeTo(DM.DimDate.Date.Months, 0, 18));

const relativeDateFilter = ref<RelativeDateFilterTileProps>({
  title: 'Relative Date Filter Tile',
  filter: relativeDateFilterValue.value!,
  arrangement: 'vertical',
  onUpdate(filter) {
    relativeDateFilterValue.value = filter;
  },
});
</script>
```
<img src="../../../img/vue-relative-date-filter-tile-example.png" width="225px" />

## Param

RelativeDateFilterTile props

## Properties

### arrangement

> **`readonly`** **arrangement**?: [`FilterVariant`](../type-aliases/type-alias.FilterVariant.md)

Arrangement of the filter inputs. Use vertical for standard filter tiles and horizontal for toolbars

***

### filter

> **`readonly`** **filter**: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)

Relative date filter.

***

### limit

> **`readonly`** **limit**?: `object`

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

> **`readonly`** **onDelete**?: () => `void`

Filter delete callback

#### Returns

`void`

***

### onEdit

> **`readonly`** **onEdit**?: () => `void`

Filter edit callback

#### Returns

`void`

***

### onUpdate

> **`readonly`** **onUpdate**: (`filter`) => `void`

Callback function that is called when the relative date filter object should be updated.

#### Parameters

| Parameter | Type |
| :------ | :------ |
| `filter` | [`Filter`](../../sdk-data/interfaces/interface.Filter.md) |

#### Returns

`void`

***

### title

> **`readonly`** **title**: `string`

Filter tile title


---

---
title: useGetFilterMembers
---

# Function useGetFilterMembers

> **useGetFilterMembers**(`params`): `ToRefs`\< [`FilterMembersState`](../type-aliases/type-alias.FilterMembersState.md) \>

A Vue composable function `useGetFilterMembers` that fetches members of a provided filter.

Those members can be used to display a list of members in a third-party filter component.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `params` | [`MaybeRefOrWithRefs`](../type-aliases/type-alias.MaybeRefOrWithRefs.md)\< [`GetFilterMembersParams`](../interfaces/interface.GetFilterMembersParams.md) \> | The parameters for fetching filter members, supporting reactive Vue refs.<br />Includes the filter to fetch members for, optional default data source, parent filters, and count. |

## Returns

`ToRefs`\< [`FilterMembersState`](../type-aliases/type-alias.FilterMembersState.md) \>

## Example

How to use `useGetFilterMembers` within a Vue component:
```vue
<script setup>
import { ref } from 'vue';
import { useGetFilterMembers, filterFactory } from '@sisense/sdk-ui-vue';
import * as DM from './data-model';

const filter = ref(filterFactory.members(DM.Country.Country, ['United States', 'Canada']));

const { data, isLoading, isError, isSuccess, error, loadMore } = useGetFilterMembers({
  filter,
  // Optional parameters
  defaultDataSource: 'Sample ECommerce',
  parentFilters: [],
});
</script>
```

The composable returns an object with the following reactive properties to manage the filter members state:
- `data`: The filter members data containing selectedMembers, allMembers, excludeMembers, enableMultiSelection, and hasBackgroundFilter.
- `isLoading`: Indicates if the filter members fetching is in progress.
- `isError`: Indicates if an error occurred during filter members fetching.
- `isSuccess`: Indicates if the filter members fetching executed successfully without errors.
- `error`: Contains the error object if an error occurred during the fetching.
- `loadMore`: Function to load more data rows.

This composable facilitates integrating Sisense filter members fetching into Vue applications, enabling developers
to easily manage filter member states and dynamically adjust parameters based on application needs.

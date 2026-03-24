---
title: CriteriaFilterTile
---

# Function CriteriaFilterTile

> **CriteriaFilterTile**(`props`): `ReactElement`\< `any`, `any` \> \| `null`

UI component that allows the user to filter numeric or text attributes according to
a number of built-in operations defined in the numeric filter, text filter, or ranking filter.

The arrangement prop determines whether the filter is rendered vertically or horizontally, with the latter intended for toolbar use and omitting title, enable/disable, and collapse/expand functionality.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `props` | [`CriteriaFilterTileProps`](../interfaces/interface.CriteriaFilterTileProps.md) | Criteria filter tile props |

## Returns

`ReactElement`\< `any`, `any` \> \| `null`

Criteria filter tile component

## Example

```ts
const initialRevenueFilter = filterFactory.greaterThanOrEqual(DM.Commerce.Revenue, 10000);
const [revenueFilter, setRevenueFilter] = useState<Filter | null>(initialRevenueFilter);

return (
  <CriteriaFilterTile
    title={'Revenue'}
    filter={revenueFilter}
    onUpdate={setRevenueFilter}
  />
);
```

<img src="../../../img/criteria-filter-tile-example-1.png" width="300px" />


---

---
title: DateRangeFilterTile
---

# Function DateRangeFilterTile

> **DateRangeFilterTile**(`props`): `ReactElement`\< `any`, `any` \> \| `null`

Date Range Filter Tile component for filtering data by date range.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `props` | [`DateRangeFilterTileProps`](../interfaces/interface.DateRangeFilterTileProps.md) | Date Range Filter Tile Props |

## Returns

`ReactElement`\< `any`, `any` \> \| `null`

Date Range Filter Tile component

## Example

React example of configuring the date min max values and handling onChange event.
```ts
const [dateRangeFilter, setDateRangeFilter] = useState<Filter>(
  filterFactory.dateRange(DM.Commerce.Date.Years),
);

return (
  <DateRangeFilterTile
    title="Date Range"
    attribute={DM.Commerce.Date.Years}
    filter={dateRangeFilter}
    onChange={(filter: Filter) => {
      setDateRangeFilter(filter);
    }}
  />
);
```

<img src="../../../img/date-filter-example-1.png" width="800px" />


---

---
title: FilterTile
---

# Function FilterTile

> **FilterTile**(`props`): `ReactElement`\< `any`, `any` \> \| `null`

Facade component that renders a filter tile based on filter type

## Parameters

| Parameter | Type |
| :------ | :------ |
| `props` | [`FilterTileProps`](../interfaces/interface.FilterTileProps.md) |

## Returns

`ReactElement`\< `any`, `any` \> \| `null`


---

---
title: FiltersPanel
---

# Function FiltersPanel

> **FiltersPanel**(`props`): `ReactElement`\< `any`, `any` \> \| `null`

Filters panel component that renders a list of filter tiles

## Parameters

| Parameter | Type |
| :------ | :------ |
| `props` | [`FiltersPanelProps`](../interfaces/interface.FiltersPanelProps.md) |

## Returns

`ReactElement`\< `any`, `any` \> \| `null`

## Example

Here's how to render a filters panel with a set of filters.
```ts
import { useState } from 'react';
import { FiltersPanel } from '@sisense/sdk-ui';
import { filterFactory, type Filter, type FilterRelations } from '@sisense/sdk-data';
import * as DM from './sample-ecommerce-model';

export function Example() {
  const [filters, setFilters] = useState<Filter[]>([
    filterFactory.members(DM.Commerce.Gender, ['Male', 'Female']),
    filterFactory.members(DM.Commerce.AgeRange, ['0-18', '19-24']),
  ]);

  const handleFiltersChange = (updatedFilters: Filter[] | FilterRelations) => {
    console.log('Filters changed:', updatedFilters);
  };

  return (
    <FiltersPanel
      filters={filters}
      defaultDataSource={DM.DataSource}
      onFiltersChange={handleFiltersChange}
    />
  );
}
```


---

---
title: MemberFilterTile
---

# Function MemberFilterTile

> **MemberFilterTile**(`props`): `ReactElement`\< `any`, `any` \> \| `null`

UI component that allows the user to select members to include/exclude in a
filter. A query is executed against the provided data source to fetch
all members that are selectable.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `props` | [`MemberFilterTileProps`](../interfaces/interface.MemberFilterTileProps.md) | Member filter tile props |

## Returns

`ReactElement`\< `any`, `any` \> \| `null`

Member filter tile component

## Example

Below is an example for filtering countries in the `Country` dimension of the `Sample ECommerce` data model.
```ts
const [countryFilter, setCountryFilter] = useState<Filter | null>(null);

return (
<MemberFilterTile
  title={'Country'}
  attribute={DM.Country.Country}
  filter={countryFilter}
  onChange={setCountryFilter}
/>
);
```

<img src="../../../img/member-filter-tile-example-1.png" width="300px" />


---

---
title: RelativeDateFilterTile
---

# Function RelativeDateFilterTile

> **RelativeDateFilterTile**(`props`): `ReactElement`\< `any`, `any` \> \| `null`

UI component that allows the user to filter date attributes according to
a number of built-in operations defined in the relative date filter.
Useful for filtering data by relative date ranges, such as "last 7 days" or "next 30 days from Date".

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `props` | [`RelativeDateFilterTileProps`](../interfaces/interface.RelativeDateFilterTileProps.md) | Relative date filter tile props |

## Returns

`ReactElement`\< `any`, `any` \> \| `null`

Relative date filter tile component


---

---
title: useGetFilterMembers
---

# Function useGetFilterMembers

> **useGetFilterMembers**(...`args`): [`GetFilterMembersResult`](../type-aliases/type-alias.GetFilterMembersResult.md)

Hook that fetches members of the provided filter

Those members can be used to display a list of members in a third-party filter component such as Material UI Select.

## Example

Retrieve selected members from a Filter on Country of the Sample ECommerce data model.

```ts
const {
  isLoading,
  data: { selectedMembers, allMembers, excludeMembers, enableMultiSelection },
} = useGetFilterMembers({ filter: filterFactory.members(DM.Country.Country, ['United States', 'Canada']) });

if (isLoading) {
  return <div>Loading...</div>;
}
console.log('selectedMembers', selectedMembers);
```

## Parameters

| Parameter | Type |
| :------ | :------ |
| ...`args` | [[`GetFilterMembersParams`](../interfaces/interface.GetFilterMembersParams.md)] |

## Returns

[`GetFilterMembersResult`](../type-aliases/type-alias.GetFilterMembersResult.md)

Results that contains the status of the filter query execution, the result data, or the error if any occurred

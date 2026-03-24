---
title: boxWhiskerExtremumsValues
---

# Function boxWhiskerExtremumsValues

> **boxWhiskerExtremumsValues**(`target`): [`Measure`](../../../interfaces/interface.Measure.md)[]

Returns an array of extremum values for box whisker plot.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `target` | [`Attribute`](../../../interfaces/interface.Attribute.md) | The target attribute for calculations. |

## Returns

[`Measure`](../../../interfaces/interface.Measure.md)[]

An array of measures representing extremum values for box whisker plots.


---

---
title: boxWhiskerIqrOutliers
---

# Function boxWhiskerIqrOutliers

> **boxWhiskerIqrOutliers**(`target`): [`Attribute`](../../../interfaces/interface.Attribute.md)

Returns an attribute representing outlier points based on interquartile range (IQR) calculations.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `target` | [`Attribute`](../../../interfaces/interface.Attribute.md) | The target attribute for calculations. |

## Returns

[`Attribute`](../../../interfaces/interface.Attribute.md)

An attribute representing outliers for box whisker plots using IQR.


---

---
title: boxWhiskerIqrValues
---

# Function boxWhiskerIqrValues

> **boxWhiskerIqrValues**(`target`): [`Measure`](../../../interfaces/interface.Measure.md)[]

Returns an array of values for box whisker plot using interquartile range (IQR) calculations.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `target` | [`Attribute`](../../../interfaces/interface.Attribute.md) | The target attribute for calculations. |

## Returns

[`Measure`](../../../interfaces/interface.Measure.md)[]

An array of measures representing IQR values for box whisker plots.


---

---
title: boxWhiskerStdDevOutliers
---

# Function boxWhiskerStdDevOutliers

> **boxWhiskerStdDevOutliers**(`target`): [`Attribute`](../../../interfaces/interface.Attribute.md)

Returns an attribute representing outlier points based on standard deviation calculations.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `target` | [`Attribute`](../../../interfaces/interface.Attribute.md) | The target attribute for calculations. |

## Returns

[`Attribute`](../../../interfaces/interface.Attribute.md)

An attribute representing outliers for box whisker plots using standard deviation.


---

---
title: boxWhiskerStdDevValues
---

# Function boxWhiskerStdDevValues

> **boxWhiskerStdDevValues**(`target`): [`Measure`](../../../interfaces/interface.Measure.md)[]

Returns an array of values for box whisker plot using standard deviation calculations.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `target` | [`Attribute`](../../../interfaces/interface.Attribute.md) | The target attribute for calculations. |

## Returns

[`Measure`](../../../interfaces/interface.Measure.md)[]

An array of measures representing standard deviation values for box whisker plots.


---

---
title: between
---

# Function between

> **between**(
  `attribute`,
  `valueA`,
  `valueB`,
  `config`?): [`Filter`](../../../interfaces/interface.Filter.md)

Creates a filter to isolate attribute values within or exactly matching two specified numerical boundaries.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `attribute` | [`Attribute`](../../../interfaces/interface.Attribute.md) | Numeric attribute to filter on |
| `valueA` | `number` | Value to filter from |
| `valueB` | `number` | Value to filter to |
| `config`? | [`BaseFilterConfig`](../../../interfaces/interface.BaseFilterConfig.md) | Optional configuration for the filter |

## Returns

[`Filter`](../../../interfaces/interface.Filter.md)

A filter instance

## Example

Filter for items from the Sample ECommerce data model where the cost is greater than or equal to 100 and less than or equal to 200.
```ts
filterFactory.between(DM.Commerce.Cost, 100, 200)
```


---

---
title: betweenNotEqual
---

# Function betweenNotEqual

> **betweenNotEqual**(
  `attribute`,
  `valueA`,
  `valueB`,
  `config`?): [`Filter`](../../../interfaces/interface.Filter.md)

Creates a filter that isolates attribute values strictly within two specified numerical boundaries.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `attribute` | [`Attribute`](../../../interfaces/interface.Attribute.md) | Numeric attribute to filter on |
| `valueA` | `number` | Value to filter from |
| `valueB` | `number` | Value to filter to |
| `config`? | [`BaseFilterConfig`](../../../interfaces/interface.BaseFilterConfig.md) | Optional configuration for the filter |

## Returns

[`Filter`](../../../interfaces/interface.Filter.md)

A filter instance

## Example

Filter for items from the Sample ECommerce data model where the cost is greater than 100 and less than 200.
```ts
filterFactory.betweenNotEqual(DM.Commerce.Cost, 100, 200)
```


---

---
title: bottomRanking
---

# Function bottomRanking

> **bottomRanking**(
  `attribute`,
  `measure`,
  `count`,
  `config`?): [`Filter`](../../../interfaces/interface.Filter.md)

Creates a filter to isolate items that rank towards the bottom for a given measure.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `attribute` | [`Attribute`](../../../interfaces/interface.Attribute.md) | Attribute to filter |
| `measure` | [`Measure`](../../../interfaces/interface.Measure.md) | Measure to filter by |
| `count` | `number` | Number of members to return |
| `config`? | [`BaseFilterConfig`](../../../interfaces/interface.BaseFilterConfig.md) | Optional configuration for the filter |

## Returns

[`Filter`](../../../interfaces/interface.Filter.md)

A filter instance

## Example

Filter for age ranges with the bottom 3 lowest total revenue in the Sample ECommerce data model.
```ts
filterFactory.bottomRanking(
  DM.Commerce.AgeRange,
  measureFactory.sum(DM.Commerce.Revenue),
  3
)
```


---

---
title: cascading
---

# Function cascading

> **cascading**(`filters`, `config`?): [`Filter`](../../../interfaces/interface.Filter.md)

Creates a filter that contains a list of dependent/cascading filters,
where each filter depends on the results or state of the previous ones in the array.

Each filter in the array operates in the context of its predecessors, and the
cascading behavior ensures that all filters are applied sequentially.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `filters` | [`Filter`](../../../interfaces/interface.Filter.md)[] | Array of dependent filters |
| `config`? | [`BaseFilterConfig`](../../../interfaces/interface.BaseFilterConfig.md) | Optional configuration for the filter |

## Returns

[`Filter`](../../../interfaces/interface.Filter.md)

A filter instance

## Example

```ts
// Create a cascading filter for gender and age range
const cascadingFilter = filterFactory.cascading(
  [
    filterFactory.members(DM.Commerce.Gender, ['Male', 'Female']),
    filterFactory.members(DM.Commerce.AgeRange, ['0-18']),
  ],
  { disabled: true }, // Optional configuration to disable the cascading filter
);
```


---

---
title: contains
---

# Function contains

> **contains**(
  `attribute`,
  `value`,
  `config`?): [`Filter`](../../../interfaces/interface.Filter.md)

Creates a filter to isolate attribute values that contain a specified string.

Matching is case insensitive.

You can optionally use wildcard characters for pattern matching, as described in the
[`like()`](function.like.md) function.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `attribute` | [`Attribute`](../../../interfaces/interface.Attribute.md) | Text attribute to filter on |
| `value` | `string` | Value to filter by |
| `config`? | [`BaseFilterConfig`](../../../interfaces/interface.BaseFilterConfig.md) | Optional configuration for the filter |

## Returns

[`Filter`](../../../interfaces/interface.Filter.md)

A filter instance

## Example

Filter for categories in the Sample ECommerce data model where the category name contains
'digital'. This filter matches categories like 'Digital Cameras' and 'MP3 & Digital Media Players'.
```ts
filterFactory.contains(DM.Category.Category, 'digital')
```


---

---
title: dateFrom
---

# Function dateFrom

> **dateFrom**(
  `level`,
  `from`,
  `config`?): [`Filter`](../../../interfaces/interface.Filter.md)

Creates a filter to isolate date values starting from and including the given date and level.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `level` | [`LevelAttribute`](../../../interfaces/interface.LevelAttribute.md) | Date [LevelAttribute](../../../interfaces/interface.LevelAttribute.md) to filter on |
| `from` | `Date` \| `string` | Date or string representing the value to filter from |
| `config`? | [`BaseFilterConfig`](../../../interfaces/interface.BaseFilterConfig.md) | Optional configuration for the filter |

## Returns

[`Filter`](../../../interfaces/interface.Filter.md)

A filter instance

## Example

Filter for items in the Sample ECommerce data model where the date is not before the year 2010.
```ts
filterFactory.dateFrom(DM.Commerce.Date.Years, '2010-01')
```


---

---
title: dateRange
---

# Function dateRange

> **dateRange**(
  `level`,
  `from`?,
  `to`?,
  `config`?): [`Filter`](../../../interfaces/interface.Filter.md)

Creates a filter to isolate items between and including the given dates and level.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `level` | [`LevelAttribute`](../../../interfaces/interface.LevelAttribute.md) | Date [LevelAttribute](../../../interfaces/interface.LevelAttribute.md) to filter on |
| `from`? | `Date` \| `string` | Date or string representing the start member to filter from |
| `to`? | `Date` \| `string` | Date or string representing the end member to filter to |
| `config`? | [`BaseFilterConfig`](../../../interfaces/interface.BaseFilterConfig.md) | Optional configuration for the filter |

## Returns

[`Filter`](../../../interfaces/interface.Filter.md)

A filter instance

## Example

Filter for items in the Sample ECommerce data model where the date is from the years 2009, 2010, or 2011.
```ts
filterFactory.dateRange(DM.Commerce.Date.Years, '2009-01', '2011-01')
```


---

---
title: dateRelative
---

# Function dateRelative

> **dateRelative**(
  `level`,
  `offset`,
  `count`,
  `anchor`?,
  `config`?): [`Filter`](../../../interfaces/interface.Filter.md)

Creates a filter to isolate items with a date dimension value within a specified range after a
given date and level.

Although the `offset` can be used to set a beginning date prior to the `anchor`, the filter range always
continues forward after the offset beginning date. So, using an `offset` of `-6` and a `count` of `18` when `level`
is a month level creates a range that begins 6 month before the `anchor` date and extends to 12 months after
the `anchor` date.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `level` | [`LevelAttribute`](../../../interfaces/interface.LevelAttribute.md) | Date [LevelAttribute](../../../interfaces/interface.LevelAttribute.md) to filter on |
| `offset` | `number` | Number of levels to skip from the given `anchor` or the default of the current day.<br />Positive numbers skip forwards and negative numbers skip backwards (e.g. `-6` is 6 months backwards when `level` is a months level attribute) |
| `count` | `number` | Number of levels to include in the filter (e.g. `6` is 6 months when `level` is a months level attribute) |
| `anchor`? | `Date` \| `string` | Date to filter from, defaults to the current day |
| `config`? | [`BaseFilterConfig`](../../../interfaces/interface.BaseFilterConfig.md) | Optional configuration for the filter |

## Returns

[`Filter`](../../../interfaces/interface.Filter.md)

A filter instance

## Example

Filter for items in the Sample ECommerce data model where the date is in 2011 or the first half of 2012.
```ts
filterFactory.dateRelative(DM.Commerce.Date.Months, 0, 18, '2011-01'),
```

Filter for items in the Sample ECommerce data model where the date is in the second half of 2010 or in 2011.
```ts
filterFactory.dateRelative(DM.Commerce.Date.Months, -6, 18, '2011-01'),
```

Filter for items in the Sample ECommerce data model where the date is in the past 6 months.
```ts
filterFactory.dateRelative(DM.Commerce.Date.Months, -6, 6),
```


---

---
title: dateRelativeFrom
---

# Function dateRelativeFrom

> **dateRelativeFrom**(
  `level`,
  `offset`,
  `count`,
  `anchor`?,
  `config`?): [`Filter`](../../../interfaces/interface.Filter.md)

Creates a filter to isolate items with a date dimension value within a specified range after a
given date and level.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `level` | [`LevelAttribute`](../../../interfaces/interface.LevelAttribute.md) | Date [LevelAttribute](../../../interfaces/interface.LevelAttribute.md) to filter on |
| `offset` | `number` | Number of levels to skip from the given `anchor` or the default of the current day (e.g. `6` is 6 months when `level` is a months level attribute) |
| `count` | `number` | Number of levels to include in the filter (e.g. `6` is 6 months when `level` is a months level attribute) |
| `anchor`? | `Date` \| `string` | Date to filter from, defaults to the current day |
| `config`? | [`BaseFilterConfig`](../../../interfaces/interface.BaseFilterConfig.md) | Optional configuration for the filter |

## Returns

[`Filter`](../../../interfaces/interface.Filter.md)

A filter instance

## Example

Filter for items in the Sample ECommerce data model where the date is in 2011 or the first half of 2012.
```ts
filterFactory.dateRelativeFrom(DM.Commerce.Date.Months, 0, 18, '2011-01'),
```


---

---
title: dateRelativeTo
---

# Function dateRelativeTo

> **dateRelativeTo**(
  `level`,
  `offset`,
  `count`,
  `anchor`?,
  `config`?): [`Filter`](../../../interfaces/interface.Filter.md)

Creates a filter to isolate items with a date dimension value within a specified range before a
given date and level.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `level` | [`LevelAttribute`](../../../interfaces/interface.LevelAttribute.md) | Date [LevelAttribute](../../../interfaces/interface.LevelAttribute.md) to filter on |
| `offset` | `number` | Number of levels to skip from the given `anchor` or the default of the current day (e.g. `6` is 6 months when `level` is a months level attribute) |
| `count` | `number` | Number of levels to include in the filter (e.g. `6` is 6 months when `level` is a months level attribute) |
| `anchor`? | `Date` \| `string` | Date to filter to, defaults to the current day |
| `config`? | [`BaseFilterConfig`](../../../interfaces/interface.BaseFilterConfig.md) | Optional configuration for the filter |

## Returns

[`Filter`](../../../interfaces/interface.Filter.md)

A filter instance

## Example

Filter for items in the Sample ECommerce data model where the date is in the first half of 2010 or in 2011.
```ts
filterFactory.dateRelativeTo(DM.Commerce.Date.Months, 0, 18, '2011-12'),
```


---

---
title: dateTo
---

# Function dateTo

> **dateTo**(
  `level`,
  `to`,
  `config`?): [`Filter`](../../../interfaces/interface.Filter.md)

Creates a filter to isolate items up until and including the given date and level.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `level` | [`LevelAttribute`](../../../interfaces/interface.LevelAttribute.md) | Date [LevelAttribute](../../../interfaces/interface.LevelAttribute.md) to filter on |
| `to` | `Date` \| `string` | Date or string representing the last member to filter to |
| `config`? | [`BaseFilterConfig`](../../../interfaces/interface.BaseFilterConfig.md) | Optional configuration for the filter |

## Returns

[`Filter`](../../../interfaces/interface.Filter.md)

A filter instance

## Example

Filter for items where the date is from the year 2010 or earlier in the Sample ECommerce data model.
```ts
filterFactory.dateTo(DM.Commerce.Date.Years, '2010-01')
```


---

---
title: doesntContain
---

# Function doesntContain

> **doesntContain**(
  `attribute`,
  `value`,
  `config`?): [`Filter`](../../../interfaces/interface.Filter.md)

Creates a filter to isolate attribute values that do not contain a specified string.

Matching is case insensitive.

You can optionally use wildcard characters for pattern matching, as described in the
[`like()`](function.like.md) function.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `attribute` | [`Attribute`](../../../interfaces/interface.Attribute.md) | Text attribute to filter on |
| `value` | `string` | Value to filter by |
| `config`? | [`BaseFilterConfig`](../../../interfaces/interface.BaseFilterConfig.md) | Optional configuration for the filter |

## Returns

[`Filter`](../../../interfaces/interface.Filter.md)

A filter instance

## Example

Filter for categories in the Sample ECommerce data model where the category name doesn't contain
'digital'. This filter matches categories not like 'Digital Cameras' and 'MP3 & Digital Media Players'.
```ts
filterFactory.contains(DM.Category.Category, 'digital')
```


---

---
title: doesntEndWith
---

# Function doesntEndWith

> **doesntEndWith**(
  `attribute`,
  `value`,
  `config`?): [`Filter`](../../../interfaces/interface.Filter.md)

Creates a filter to isolate attribute values that do not end with a specified string.

Matching is case insensitive.

You can optionally use wildcard characters for pattern matching, as described in the
[`like()`](function.like.md) function.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `attribute` | [`Attribute`](../../../interfaces/interface.Attribute.md) | Text attribute to filter on |
| `value` | `string` | Value to filter by |
| `config`? | [`BaseFilterConfig`](../../../interfaces/interface.BaseFilterConfig.md) | Optional configuration for the filter |

## Returns

[`Filter`](../../../interfaces/interface.Filter.md)

A filter instance

## Example

Filter for countries in the Sample ECommerce data model where the country name doesn't end with
'land'. This filter matches countries not like 'Iceland' and 'Ireland'.
```ts
filterFactory.doesntEndWith(DM.Country.Country, 'land')
```


---

---
title: doesntEqual
---

# Function doesntEqual

> **doesntEqual**(
  `attribute`,
  `value`,
  `config`?): [`Filter`](../../../interfaces/interface.Filter.md)

Creates a filter to isolate attribute values that do not equal a specified string or number.

When filtering against a string:

 + Matching is case insensitive.
 + You can optionally use wildcard characters for pattern matching, as described in the
[`like()`](function.like.md) function.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `attribute` | [`Attribute`](../../../interfaces/interface.Attribute.md) | Text or numeric attribute to filter on |
| `value` | `number` \| `string` | Value to filter by |
| `config`? | [`BaseFilterConfig`](../../../interfaces/interface.BaseFilterConfig.md) | Optional configuration for the filter |

## Returns

[`Filter`](../../../interfaces/interface.Filter.md)

A filter instance

## Example

Filter for items not in new condition from the Sample ECommerce data model.
```ts
filterFactory.doesntEqual(DM.Commerce.Condition, 'New')
```


---

---
title: doesntStartWith
---

# Function doesntStartWith

> **doesntStartWith**(
  `attribute`,
  `value`,
  `config`?): [`Filter`](../../../interfaces/interface.Filter.md)

Creates a filter to isolate attribute values that do not start with a specified string.

Matching is case insensitive.

You can optionally use wildcard characters for pattern matching, as described in the
[`like()`](function.like.md) function.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `attribute` | [`Attribute`](../../../interfaces/interface.Attribute.md) | Text attribute to filter on |
| `value` | `string` | Value to filter by |
| `config`? | [`BaseFilterConfig`](../../../interfaces/interface.BaseFilterConfig.md) | Optional configuration for the filter |

## Returns

[`Filter`](../../../interfaces/interface.Filter.md)

A filter instance

## Example

Filter for countries in the Sample ECommerce data model where the country name doesn't start with
'United'. This filter matches countries not like 'United States' and 'United Kingdom'.
```ts
filterFactory.doesntStartWith(DM.Country.Country, 'United')
```


---

---
title: endsWith
---

# Function endsWith

> **endsWith**(
  `attribute`,
  `value`,
  `config`?): [`Filter`](../../../interfaces/interface.Filter.md)

Creates a filter to isolate attribute values that end with a specified string.

Matching is case insensitive.

You can optionally use wildcard characters for pattern matching, as described in the
[`like()`](function.like.md) function.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `attribute` | [`Attribute`](../../../interfaces/interface.Attribute.md) | Text attribute to filter on |
| `value` | `string` | Value to filter by |
| `config`? | [`BaseFilterConfig`](../../../interfaces/interface.BaseFilterConfig.md) | Optional configuration for the filter |

## Returns

[`Filter`](../../../interfaces/interface.Filter.md)

A filter instance

## Example

Filter for countries in the Sample ECommerce data model where the country name ends with
'land'. This filter matches countries like 'Ireland' and 'Iceland'.
```ts
filterFactory.endsWith(DM.Country.Country, 'land')
```


---

---
title: equals
---

# Function equals

> **equals**(
  `attribute`,
  `value`,
  `config`?): [`Filter`](../../../interfaces/interface.Filter.md)

Creates a filter to isolate attribute values that equal a specified string or number.

When filtering against a string:

 + Matching is case insensitive.
 + You can optionally use wildcard characters for pattern matching, as described in the
[`like()`](function.like.md) function.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `attribute` | [`Attribute`](../../../interfaces/interface.Attribute.md) | Text or numeric attribute to filter on |
| `value` | `number` \| `string` | Value to filter by |
| `config`? | [`BaseFilterConfig`](../../../interfaces/interface.BaseFilterConfig.md) | Optional configuration for the filter |

## Returns

[`Filter`](../../../interfaces/interface.Filter.md)

A filter instance

## Example

Filter for items in new condition from the Sample ECommerce data model.
```ts
filterFactory.equals(DM.Commerce.Condition, 'New')
```


---

---
title: exclude
---

# Function exclude

> **exclude**(
  `filter`,
  `input`?,
  `config`?): [`Filter`](../../../interfaces/interface.Filter.md)

Creates a filter that excludes items matching the given filter
from all items or from items matching the optional input filter.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `filter` | [`Filter`](../../../interfaces/interface.Filter.md) | Filter to exclude |
| `input`? | [`Filter`](../../../interfaces/interface.Filter.md) | Input filter to exclude from, on the same attribute. If not provided, the filter excludes from all items. |
| `config`? | [`BaseFilterConfig`](../../../interfaces/interface.BaseFilterConfig.md) | Optional configuration for the filter |

## Returns

[`Filter`](../../../interfaces/interface.Filter.md)

A filter representing an exclusion of the given filter
from all attribute members or from the optional input filter

## Example

Filter for items where the country name does not contain the letter 'A'
from the Sample ECommerce data model.
```ts
filterFactory.exclude(filterFactory.contains(DM.Country.Country, 'A'))
```

Filter for items where the country name starts with the letter 'B' but does not contain the letter 'A'
from the Sample ECommerce data model. This filter will match countries like 'Belgium', but will not
match countries like 'Bermuda'.
```ts
filterFactory.exclude(
  filterFactory.contains(DM.Country.Country, 'A'),
  filterFactory.startsWith(DM.Country.Country, 'B')
)
```


---

---
title: greaterThan
---

# Function greaterThan

> **greaterThan**(
  `attribute`,
  `value`,
  `config`?): [`Filter`](../../../interfaces/interface.Filter.md)

Creates a filter to isolate attribute values strictly greater than a specified number.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `attribute` | [`Attribute`](../../../interfaces/interface.Attribute.md) | Numeric attribute to filter on |
| `value` | `number` | Value to filter by |
| `config`? | [`BaseFilterConfig`](../../../interfaces/interface.BaseFilterConfig.md) | Optional configuration for the filter |

## Returns

[`Filter`](../../../interfaces/interface.Filter.md)

A filter instance

## Example

Filter for items where the cost is greater than 100 from the Sample ECommerce data model.
```ts
filterFactory.greaterThan(DM.Commerce.Cost, 100)
```


---

---
title: greaterThanOrEqual
---

# Function greaterThanOrEqual

> **greaterThanOrEqual**(
  `attribute`,
  `value`,
  `config`?): [`Filter`](../../../interfaces/interface.Filter.md)

Creates a filter to isolate attribute values greater than or equal to a specified number.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `attribute` | [`Attribute`](../../../interfaces/interface.Attribute.md) | Numeric attribute to filter on |
| `value` | `number` | Value to filter by |
| `config`? | [`BaseFilterConfig`](../../../interfaces/interface.BaseFilterConfig.md) | Optional configuration for the filter |

## Returns

[`Filter`](../../../interfaces/interface.Filter.md)

A filter instance

## Example

Filter for items where the cost is greater than or equal to 100 from the Sample ECommerce data model.
```ts
filterFactory.greaterThanOrEqual(DM.Commerce.Cost, 100)
```


---

---
title: intersection
---

# Function intersection

> **intersection**(`filters`, `config`?): [`Filter`](../../../interfaces/interface.Filter.md)

Creates a filter representing the intersection of multiple filters on the same attribute. The resulting
intersection filter filters on items that match all of the given filters.

To create 'and' filters using different attributes, use the [`and()`](../namespaces/namespace.logic/functions/function.and.md) function.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `filters` | [`Filter`](../../../interfaces/interface.Filter.md)[] | Filters to intersect. The filters must all be on the same attribute. |
| `config`? | [`BaseFilterConfig`](../../../interfaces/interface.BaseFilterConfig.md) | Optional configuration for the filter |

## Returns

[`Filter`](../../../interfaces/interface.Filter.md)

A filter instance

## Example

Filter for countries that start with the letter 'A' **and** end with the letter 'A'
in the Sample ECommerce data model.
```ts
filterFactory.intersection([
  filterFactory.startsWith(DM.Country.Country, 'A'),
  filterFactory.endsWith(DM.Country.Country, 'A'),
])
```


---

---
title: lessThan
---

# Function lessThan

> **lessThan**(
  `attribute`,
  `value`,
  `config`?): [`Filter`](../../../interfaces/interface.Filter.md)

Creates a filter to isolate attribute values strictly less than a specified number.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `attribute` | [`Attribute`](../../../interfaces/interface.Attribute.md) | Numeric attribute to filter on |
| `value` | `number` | Value to filter by |
| `config`? | [`BaseFilterConfig`](../../../interfaces/interface.BaseFilterConfig.md) | Optional configuration for the filter |

## Returns

[`Filter`](../../../interfaces/interface.Filter.md)

A filter instance

## Example

Filter for items where the cost is less than 100 from the Sample ECommerce data model.
```ts
filterFactory.lessThan(DM.Commerce.Cost, 100)
```


---

---
title: lessThanOrEqual
---

# Function lessThanOrEqual

> **lessThanOrEqual**(
  `attribute`,
  `value`,
  `config`?): [`Filter`](../../../interfaces/interface.Filter.md)

Creates a filter to isolate attribute values less than or equal to a specified number.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `attribute` | [`Attribute`](../../../interfaces/interface.Attribute.md) | Numeric attribute to filter on |
| `value` | `number` | Value to filter by |
| `config`? | [`BaseFilterConfig`](../../../interfaces/interface.BaseFilterConfig.md) | Optional configuration for the filter |

## Returns

[`Filter`](../../../interfaces/interface.Filter.md)

A filter instance

## Example

Filter for items where the cost is less than or equal to 100 from the Sample ECommerce data model.
```ts
filterFactory.lessThanOrEqual(DM.Commerce.Cost, 100)
```


---

---
title: like
---

# Function like

> **like**(
  `attribute`,
  `value`,
  `config`?): [`Filter`](../../../interfaces/interface.Filter.md)

Creates a filter to isolate attribute values that match a specified string pattern.

The pattern can include the following wildcard characters:

+ `_`: Matches a single character
+ `%`: Matches multiple characters

To search for a literal underscore (`_`) or percent symbol (`%`), use the backslash (``) escape
character.

Matching is case insensitive.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `attribute` | [`Attribute`](../../../interfaces/interface.Attribute.md) | Text attribute to filter on |
| `value` | `string` | Value to filter by |
| `config`? | [`BaseFilterConfig`](../../../interfaces/interface.BaseFilterConfig.md) | Optional configuration for the filter |

## Returns

[`Filter`](../../../interfaces/interface.Filter.md)

A filter instance

## Example

Filter for countries from the Sample ECommerce data model where the country name starts with an
'A' and ends with an 'a'. This filter matches countries like 'Argentina' and 'Australia'.
```ts
filterFactory.like(DM.Country.Country, 'A%a')
```


---

---
title: measureBetween
---

# Function measureBetween

> **measureBetween**(
  `measure`,
  `valueA`,
  `valueB`,
  `config`?): [`Filter`](../../../interfaces/interface.Filter.md)

Creates a filter to isolate a measure value between or equal to two given numbers.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `measure` | [`BaseMeasure`](../../../interfaces/interface.BaseMeasure.md) \| [`CalculatedMeasure`](../../../interfaces/interface.CalculatedMeasure.md) | Measure to filter by |
| `valueA` | `number` | Min value |
| `valueB` | `number` | Max value |
| `config`? | [`BaseFilterConfig`](../../../interfaces/interface.BaseFilterConfig.md) | Optional configuration for the filter |

## Returns

[`Filter`](../../../interfaces/interface.Filter.md)

A filter instance

## Example

Filter for categories that have an average revenue greater than or equal to 50 and less than
or equal to 100 in the Sample ECommerce data model.
```ts
filterFactory.measureBetween(
  measureFactory.average(DM.Commerce.Revenue),
  50,
  100
)
```


---

---
title: measureBetweenNotEqual
---

# Function measureBetweenNotEqual

> **measureBetweenNotEqual**(
  `measure`,
  `valueA`,
  `valueB`,
  `config`?): [`Filter`](../../../interfaces/interface.Filter.md)

Creates a filter to isolate a measure value between but not equal to two given numbers.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `measure` | [`BaseMeasure`](../../../interfaces/interface.BaseMeasure.md) \| [`CalculatedMeasure`](../../../interfaces/interface.CalculatedMeasure.md) | Measure to filter by |
| `valueA` | `number` | Min value |
| `valueB` | `number` | Max value |
| `config`? | [`BaseFilterConfig`](../../../interfaces/interface.BaseFilterConfig.md) | Optional configuration for the filter |

## Returns

[`Filter`](../../../interfaces/interface.Filter.md)

A filter instance

## Example

Filter for categories that have an average revenue greater than 50 and less than
100 in the Sample ECommerce data model.
```ts
filterFactory.measureBetweenNotEqual(
  measureFactory.average(DM.Commerce.Revenue),
  50,
  100
)
```


---

---
title: measureBottomRanking
---

# Function measureBottomRanking

> **measureBottomRanking**(
  `measure`,
  `count`,
  `config`?): [`Filter`](../../../interfaces/interface.Filter.md)

Creates a filter that returns the bottom N values of the last dimension,
independently for each unique combination of all preceding dimensions.

This filter applies ranking within groups rather than globally. It shows the bottom N values
of the rightmost dimension for every unique combination of the other dimensions to its left.
The order of dimensions in your query determines the grouping behavior.

**Key Differences from [bottomRanking](function.bottomRanking.md):**
- `bottomRanking`: Filters a specific dimension globally (you specify which dimension)
- `measureBottomRanking`: Always filters the last/rightmost dimension, grouped by all others

**How it works:**
- With 1 dimension: Returns the bottom N values of that dimension
- With 2+ dimensions: Returns the bottom N values of the LAST dimension for each combination of the others

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `measure` | [`BaseMeasure`](../../../interfaces/interface.BaseMeasure.md) | Base measure to rank by |
| `count` | `number` | Number of items to return per group (applies to the last dimension) |
| `config`? | [`BaseFilterConfig`](../../../interfaces/interface.BaseFilterConfig.md) | Optional configuration for the filter |

## Returns

[`Filter`](../../../interfaces/interface.Filter.md)

A filter instance

## Example

**Example 1: Single dimension (equivalent to bottomRanking) - Query with one dimension [Category]**
```ts
// Returns bottom 5 Categories by revenue
filterFactory.measureBottomRanking(
  measureFactory.sum(DM.Commerce.Revenue),
  5
)
```
Result: 5 categories with lowest revenue (e.g., Accessories, Cables, etc.)

This produces the same result as:
```ts
filterFactory.bottomRanking(
  DM.Commerce.Category,
  measureFactory.sum(DM.Commerce.Revenue),
  5
)
```

**Note:** With only one dimension, there are no groups to rank within,
so the behavior is identical to `bottomRanking`.

## Example

**Example 2: Two dimensions - Query with dimensions [Gender, Category]**
```ts
// Returns bottom 2 Categories for each Gender
filterFactory.measureBottomRanking(
  measureFactory.sum(DM.Commerce.Revenue),
  2
)
```
Result: 3 genders × 2 categories each = 6 rows
- Male: Bottom 2 categories by revenue
- Female: Bottom 2 categories by revenue
- Unspecified: Bottom 2 categories by revenue

## Example

**Example 3: Three dimensions - Query with dimensions [Gender, Age Range, Category]**
```ts
// Returns bottom 2 Categories for each (Gender, Age Range) combination
filterFactory.measureBottomRanking(
  measureFactory.sum(DM.Commerce.Revenue),
  2
)
```
Result: 3 genders × 7 age ranges × 2 categories per combination = ~42 rows


---

---
title: measureEquals
---

# Function measureEquals

> **measureEquals**(
  `measure`,
  `value`,
  `config`?): [`Filter`](../../../interfaces/interface.Filter.md)

Creates a filter to isolate a measure value equal to a given number.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `measure` | [`BaseMeasure`](../../../interfaces/interface.BaseMeasure.md) \| [`CalculatedMeasure`](../../../interfaces/interface.CalculatedMeasure.md) | Measure to filter by |
| `value` | `number` | Value |
| `config`? | [`BaseFilterConfig`](../../../interfaces/interface.BaseFilterConfig.md) | Optional configuration for the filter |

## Returns

[`Filter`](../../../interfaces/interface.Filter.md)

A filter instance

## Example

Filter for categories that have an average revenue equal 50 in the Sample ECommerce data model.
```ts
filterFactory.measureEquals(
  measureFactory.average(DM.Commerce.Revenue),
  50
)
```


---

---
title: measureGreaterThan
---

# Function measureGreaterThan

> **measureGreaterThan**(
  `measure`,
  `value`,
  `config`?): [`Filter`](../../../interfaces/interface.Filter.md)

Creates a filter to isolate a measure value greater than to a given number.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `measure` | [`BaseMeasure`](../../../interfaces/interface.BaseMeasure.md) \| [`CalculatedMeasure`](../../../interfaces/interface.CalculatedMeasure.md) | Measure to filter by |
| `value` | `number` | Min value |
| `config`? | [`BaseFilterConfig`](../../../interfaces/interface.BaseFilterConfig.md) | Optional configuration for the filter |

## Returns

[`Filter`](../../../interfaces/interface.Filter.md)

A filter instance

## Example

Filter for categories that have an average revenue greater than
to 50 in the Sample ECommerce data model.
```ts
filterFactory.measureGreaterThan(
  measureFactory.average(DM.Commerce.Revenue),
  50
)
```


---

---
title: measureGreaterThanOrEqual
---

# Function measureGreaterThanOrEqual

> **measureGreaterThanOrEqual**(
  `measure`,
  `value`,
  `config`?): [`Filter`](../../../interfaces/interface.Filter.md)

Creates a filter to isolate a measure value greater than or equal to a given number.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `measure` | [`BaseMeasure`](../../../interfaces/interface.BaseMeasure.md) \| [`CalculatedMeasure`](../../../interfaces/interface.CalculatedMeasure.md) | Measure to filter by |
| `value` | `number` | Min value |
| `config`? | [`BaseFilterConfig`](../../../interfaces/interface.BaseFilterConfig.md) | Optional configuration for the filter |

## Returns

[`Filter`](../../../interfaces/interface.Filter.md)

A filter instance

## Example

Filter for categories that have an average revenue greater than
or equal to 50 in the Sample ECommerce data model.
```ts
filterFactory.measureGreaterThanOrEqual(
  measureFactory.average(DM.Commerce.Revenue),
  50
)
```


---

---
title: measureLessThan
---

# Function measureLessThan

> **measureLessThan**(
  `measure`,
  `value`,
  `config`?): [`Filter`](../../../interfaces/interface.Filter.md)

Creates a filter to isolate a measure value less than a given number.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `measure` | [`BaseMeasure`](../../../interfaces/interface.BaseMeasure.md) \| [`CalculatedMeasure`](../../../interfaces/interface.CalculatedMeasure.md) | Measure to filter by |
| `value` | `number` | Value |
| `config`? | [`BaseFilterConfig`](../../../interfaces/interface.BaseFilterConfig.md) | Optional configuration for the filter |

## Returns

[`Filter`](../../../interfaces/interface.Filter.md)

A filter instance

## Example

Filter for categories that have an average revenue less than 100 in the Sample ECommerce data model.
```ts
filterFactory.measureLessThan(
  measureFactory.average(DM.Commerce.Revenue),
  100
)
```


---

---
title: measureLessThanOrEqual
---

# Function measureLessThanOrEqual

> **measureLessThanOrEqual**(
  `measure`,
  `value`,
  `config`?): [`Filter`](../../../interfaces/interface.Filter.md)

Creates a filter to isolate a measure value less than or equal to a given number.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `measure` | [`BaseMeasure`](../../../interfaces/interface.BaseMeasure.md) \| [`CalculatedMeasure`](../../../interfaces/interface.CalculatedMeasure.md) | Measure to filter by |
| `value` | `number` | Max value |
| `config`? | [`BaseFilterConfig`](../../../interfaces/interface.BaseFilterConfig.md) | Optional configuration for the filter |

## Returns

[`Filter`](../../../interfaces/interface.Filter.md)

A filter instance

## Example

Filter for categories that have an average revenue less than
or equal to 100 in the Sample ECommerce data model.
```ts
filterFactory.measureLessThanOrEqual(
  measureFactory.average(DM.Commerce.Revenue),
  100
)
```


---

---
title: measureTopRanking
---

# Function measureTopRanking

> **measureTopRanking**(
  `measure`,
  `count`,
  `config`?): [`Filter`](../../../interfaces/interface.Filter.md)

Creates a filter that returns the top N values of the last dimension,
independently for each unique combination of all preceding dimensions.

This filter applies ranking within groups rather than globally. It shows the top N values
of the rightmost dimension for every unique combination of the other dimensions to its left.
The order of dimensions in your query determines the grouping behavior.

**Key Differences from [topRanking](function.topRanking.md):**
- `topRanking`: Filters a specific dimension globally (you specify which dimension)
- `measureTopRanking`: Always filters the last/rightmost dimension, grouped by all others

**How it works:**
- With 1 dimension: Returns the top N values of that dimension
- With 2+ dimensions: Returns the top N values of the LAST dimension for each combination of the others

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `measure` | [`BaseMeasure`](../../../interfaces/interface.BaseMeasure.md) | Base measure to rank by |
| `count` | `number` | Number of items to return per group (applies to the last dimension) |
| `config`? | [`BaseFilterConfig`](../../../interfaces/interface.BaseFilterConfig.md) | Optional configuration for the filter |

## Returns

[`Filter`](../../../interfaces/interface.Filter.md)

A filter instance

## Example

**Example 1: Single dimension (equivalent to topRanking) - Query with one dimension [Category]**
```ts
// Returns top 5 Categories by total revenue
filterFactory.measureTopRanking(
  measureFactory.sum(DM.Commerce.Revenue),
  5
)
```
Result: 5 categories (e.g., Cell Phones, Computers, TVs, etc.)

This produces the same result as:
```ts
filterFactory.topRanking(
  DM.Commerce.Category,
  measureFactory.sum(DM.Commerce.Revenue),
  5
)
```

**Note:** With only one dimension, there are no groups to rank within,
so the behavior is identical to `topRanking`.

## Example

**Example 2: Two dimensions - Query with dimensions [Gender, Category]**
```ts
// Returns top 2 Categories for each Gender
filterFactory.measureTopRanking(
  measureFactory.sum(DM.Commerce.Revenue),
  2
)
```
Result: 3 genders × 2 categories each = 6 rows
- Male: Top 2 categories by revenue
- Female: Top 2 categories by revenue
- Unspecified: Top 2 categories by revenue

## Example

**Example 3: Three dimensions - Query with dimensions [Gender, Age Range, Category]**
```ts
// Returns top 2 Categories for each (Gender, Age Range) combination
filterFactory.measureTopRanking(
  measureFactory.sum(DM.Commerce.Revenue),
  2
)
```
Result: 3 genders × 7 age ranges × 2 categories per combination = ~42 rows


---

---
title: members
---

# Function members

> **members**(
  `attribute`,
  `members`,
  `config`?): [`Filter`](../../../interfaces/interface.Filter.md)

Creates a filter to isolate attribute values that match any of the specified strings.

Matching is case sensitive.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `attribute` | [`Attribute`](../../../interfaces/interface.Attribute.md) | Attribute to filter on |
| `members` | `string`[] | Array of member values to filter by |
| `config`? | [`MembersFilterConfig`](../../../interfaces/interface.MembersFilterConfig.md) | Optional configuration for the filter |

## Returns

[`Filter`](../../../interfaces/interface.Filter.md)

A filter instance

## Example

Filter for items where the condition is 'Used' or 'Refurbished'
from the Sample ECommerce data model.
```ts
filterFactory.members(DM.Commerce.Condition, ['Used', 'Refurbished'])
```


---

---
title: numeric
---

# Function numeric

> **numeric**(
  `attribute`,
  `operatorA`?,
  `valueA`?,
  `operatorB`?,
  `valueB`?,
  `config`?): [`Filter`](../../../interfaces/interface.Filter.md)

Creates a custom numeric filter that filters for given attribute values.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `attribute` | [`Attribute`](../../../interfaces/interface.Attribute.md) | Numeric attribute to filter |
| `operatorA`? | `string` | First operator |
| `valueA`? | `number` | First value |
| `operatorB`? | `string` | Second operator |
| `valueB`? | `number` | Second value |
| `config`? | [`BaseFilterConfig`](../../../interfaces/interface.BaseFilterConfig.md) | Optional configuration for the filter |

## Returns

[`Filter`](../../../interfaces/interface.Filter.md)

A custom numeric filter of the given attribute

## Example

Filter for items where the cost is greater than 100 and less than 200
from the Sample ECommerce data model.
```ts
filterFactory.numeric(
  DM.Commerce.Cost,
  NumericOperators.From,
  100,
  NumericOperators.To,
  200
)
```


---

---
title: startsWith
---

# Function startsWith

> **startsWith**(
  `attribute`,
  `value`,
  `config`?): [`Filter`](../../../interfaces/interface.Filter.md)

Creates a filter to isolate attribute values that start with a specified string.

Matching is case insensitive.

You can optionally use wildcard characters for pattern matching, as described in the
[`like()`](function.like.md) function.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `attribute` | [`Attribute`](../../../interfaces/interface.Attribute.md) | Text attribute to filter on |
| `value` | `string` | Value to filter by |
| `config`? | [`BaseFilterConfig`](../../../interfaces/interface.BaseFilterConfig.md) | Optional configuration for the filter |

## Returns

[`Filter`](../../../interfaces/interface.Filter.md)

A filter instance

## Example

Filter for countries in the Sample ECommerce data model where the country name starts with
'United'. This filter matches countries like 'United States' and 'United Kingdom'.
```ts
filterFactory.startsWith(DM.Country.Country, 'United')
```


---

---
title: thisMonth
---

# Function thisMonth

> **thisMonth**(`dimension`, `config`?): [`Filter`](../../../interfaces/interface.Filter.md)

Creates a filter to isolate items with a date dimension value in the current calendar month.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `dimension` | [`DateDimension`](../../../interfaces/interface.DateDimension.md) | Date dimension to filter |
| `config`? | [`BaseFilterConfig`](../../../interfaces/interface.BaseFilterConfig.md) | Optional configuration for the filter |

## Returns

[`Filter`](../../../interfaces/interface.Filter.md)

A filter instance

## Example

Filter for items where the date is in the current calendar month in the Sample ECommerce data model.
```ts
filterFactory.thisMonth(DM.Commerce.Date)
```


---

---
title: thisQuarter
---

# Function thisQuarter

> **thisQuarter**(`dimension`, `config`?): [`Filter`](../../../interfaces/interface.Filter.md)

Creates a filter to isolate items with a date dimension value in the current quarter.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `dimension` | [`DateDimension`](../../../interfaces/interface.DateDimension.md) | Date dimension to filter |
| `config`? | [`BaseFilterConfig`](../../../interfaces/interface.BaseFilterConfig.md) | Optional configuration for the filter |

## Returns

[`Filter`](../../../interfaces/interface.Filter.md)

A filter instance

## Example

Filter for items where the date is in the current quarter in the Sample ECommerce data model.
```ts
filterFactory.thisQuarter(DM.Commerce.Date)
```


---

---
title: thisYear
---

# Function thisYear

> **thisYear**(`dimension`, `config`?): [`Filter`](../../../interfaces/interface.Filter.md)

Creates a filter to isolate items with a date dimension value in the current calendar year.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `dimension` | [`DateDimension`](../../../interfaces/interface.DateDimension.md) | Date dimension to filter |
| `config`? | [`BaseFilterConfig`](../../../interfaces/interface.BaseFilterConfig.md) | Optional configuration for the filter |

## Returns

[`Filter`](../../../interfaces/interface.Filter.md)

A filter instance

## Example

Filter for items where the date is in the current calendar year in the Sample ECommerce data model.
```ts
filterFactory.thisYear(DM.Commerce.Date)
```


---

---
title: today
---

# Function today

> **today**(`dimension`, `config`?): [`Filter`](../../../interfaces/interface.Filter.md)

Creates a filter to isolate items with a date dimension value of the current date.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `dimension` | [`DateDimension`](../../../interfaces/interface.DateDimension.md) | date dimension to filter |
| `config`? | [`BaseFilterConfig`](../../../interfaces/interface.BaseFilterConfig.md) | Optional configuration for the filter |

## Returns

[`Filter`](../../../interfaces/interface.Filter.md)

A filter instance

## Example

Filter for items where the date is today in the Sample ECommerce data model.
```ts
filterFactory.today(DM.Commerce.Date)
```


---

---
title: topRanking
---

# Function topRanking

> **topRanking**(
  `attribute`,
  `measure`,
  `count`,
  `config`?): [`Filter`](../../../interfaces/interface.Filter.md)

Creates a filter to isolate items that rank towards the top for a given measure.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `attribute` | [`Attribute`](../../../interfaces/interface.Attribute.md) | Attribute to filter |
| `measure` | [`Measure`](../../../interfaces/interface.Measure.md) | Measure to filter by |
| `count` | `number` | Number of members to return |
| `config`? | [`BaseFilterConfig`](../../../interfaces/interface.BaseFilterConfig.md) | Optional configuration for the filter |

## Returns

[`Filter`](../../../interfaces/interface.Filter.md)

A filter instance

## Example

Filter for age ranges with the top 3 highest total revenue in the Sample ECommerce data model.
```ts
filterFactory.topRanking(
  DM.Commerce.AgeRange,
  measureFactory.sum(DM.Commerce.Revenue),
  3
)
```


---

---
title: union
---

# Function union

> **union**(`filters`, `config`?): [`Filter`](../../../interfaces/interface.Filter.md)

Creates a filter representing the union of multiple filters on the same attribute. The resulting
union filter filters on items that match any of the given filters.

To create 'or' filters using different attributes, use the [`or()`](../namespaces/namespace.logic/functions/function.and.md) function.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `filters` | [`Filter`](../../../interfaces/interface.Filter.md)[] | Filters to union. The filters must all be on the same attribute. |
| `config`? | [`BaseFilterConfig`](../../../interfaces/interface.BaseFilterConfig.md) | Optional configuration for the filter |

## Returns

[`Filter`](../../../interfaces/interface.Filter.md)

A filter instance

## Example

Filter for countries that start with the letter 'A' **or** end with the letter 'A'
in the Sample ECommerce data model.
```ts
filterFactory.union([
  filterFactory.startsWith(DM.Country.Country, 'A'),
  filterFactory.endsWith(DM.Country.Country, 'A'),
])
```


---

---
title: and
---

# Function and <Badge type="beta" text="Beta" />

> **and**(`left`, `right`): [`FilterRelations`](../../../../../interfaces/interface.FilterRelations.md)

Creates an 'AND' filter relations

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `left` | [`FilterRelationsNode`](../../../../../type-aliases/type-alias.FilterRelationsNode.md) | First filter or filter relations |
| `right` | [`FilterRelationsNode`](../../../../../type-aliases/type-alias.FilterRelationsNode.md) | Second filter or filter relations |

## Returns

[`FilterRelations`](../../../../../interfaces/interface.FilterRelations.md)

Filter relations

## Example

Create filter relations for items that have a revenue greater than 100 and are in new condition
in the Sample ECommerce data model.
```ts
const revenueFilter = filterFactory.greaterThan(DM.Commerce.Revenue, 100);
const conditionFilter = filterFactory.equals(DM.Commerce.Condition, 'New');

const andFilerRelation = filterFactory.logic.and(revenueFilter, conditionFilter);
```


---

---
title: or
---

# Function or <Badge type="beta" text="Beta" />

> **or**(`left`, `right`): [`FilterRelations`](../../../../../interfaces/interface.FilterRelations.md)

Creates an 'OR' filter relations

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `left` | [`FilterRelationsNode`](../../../../../type-aliases/type-alias.FilterRelationsNode.md) | First filter or filter relations |
| `right` | [`FilterRelationsNode`](../../../../../type-aliases/type-alias.FilterRelationsNode.md) | Second filter or filter relations |

## Returns

[`FilterRelations`](../../../../../interfaces/interface.FilterRelations.md)

Filter relations

## Example

Create filter relations for items that have a revenue greater than 100 or are in new condition
in the Sample ECommerce data model.
```ts
const revenueFilter = filterFactory.greaterThan(DM.Commerce.Revenue, 100);
const conditionFilter = filterFactory.equals(DM.Commerce.Condition, 'New');

const orFilerRelation = filterFactory.logic.or(revenueFilter, conditionFilter);
```


---

---
title: add
---

# Function add

> **add**(
  `value1`,
  `value2`,
  `name`?,
  `withParentheses`?): [`CalculatedMeasure`](../../../interfaces/interface.CalculatedMeasure.md)

Creates a calculated measure by adding two given numbers or measures.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `value1` | [`Measure`](../../../interfaces/interface.Measure.md) \| `number` | First value |
| `value2` | [`Measure`](../../../interfaces/interface.Measure.md) \| `number` | Second value |
| `name`? | `string` | Optional name for the new measure |
| `withParentheses`? | `boolean` | Optional boolean flag whether to wrap the arithmetic operation with parentheses |

## Returns

[`CalculatedMeasure`](../../../interfaces/interface.CalculatedMeasure.md)

A calculated measure instance

## Example

```ts
const measure1 = measureFactory.sum(DM.Dimension.Attribute1);
const measure2 = measureFactory.sum(DM.Dimension.Attribute2);
const measureSum = measureFactory.add(measure1, measure2);
```


---

---
title: aggregate
---

# Function aggregate

> **aggregate**(
  `attribute`,
  `aggregationType`,
  `name`?,
  `format`?): [`BaseMeasure`](../../../interfaces/interface.BaseMeasure.md)

Creates an aggregated measure.

This is a base function to build other aggregation functions (e.g., `sum`, `average`, etc.)
as listed in [AggregationTypes](../../../variables/variable.AggregationTypes.md).

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `attribute` | [`Attribute`](../../../interfaces/interface.Attribute.md) | Attribute to aggregate |
| `aggregationType` | `string` | Aggregation type. See [AggregationTypes](../../../variables/variable.AggregationTypes.md) |
| `name`? | `string` | Optional name for the new measure |
| `format`? | `string` | Optional numeric formatting to apply using a Numeral.js format string. Can only be used for explicit queries. Cannot be used in charts, tables, etc. |

## Returns

[`BaseMeasure`](../../../interfaces/interface.BaseMeasure.md)

A measure instance

## Example

Calculate the total cost across all items in a category from the Sample Ecommerce data model.
```ts
measureFactory.aggregate(DM.Commerce.Cost, 'sum'),
```


---

---
title: average
---

# Function average

> **average**(
  `attribute`,
  `name`?,
  `format`?): [`BaseMeasure`](../../../interfaces/interface.BaseMeasure.md)

Creates an average aggregation measure over the given attribute.

Both `average()` and `avg()` can be used interchangeably.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `attribute` | [`Attribute`](../../../interfaces/interface.Attribute.md) | Attribute to aggregate |
| `name`? | `string` | Optional name for the new measure |
| `format`? | `string` | Optional numeric formatting to apply using a Numeral.js format string. Can only be used for explicit queries. Cannot be used in charts, tables, etc. |

## Returns

[`BaseMeasure`](../../../interfaces/interface.BaseMeasure.md)

A measure instance

## Example

Calculate the average cost across all items in a category from the Sample Ecommerce data model.
```ts
measureFactory.average(DM.Commerce.Cost)
```


---

---
title: avg
---

# Function avg

> **avg**(
  `attribute`,
  `name`?,
  `format`?): [`BaseMeasure`](../../../interfaces/interface.BaseMeasure.md)

Creates an average aggregation measure over the given attribute.

Both `average()` and `avg()` can be used interchangeably.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `attribute` | [`Attribute`](../../../interfaces/interface.Attribute.md) | Attribute to aggregate |
| `name`? | `string` | Optional name for the new measure |
| `format`? | `string` | Optional numeric formatting to apply using a Numeral.js format string. Can only be used for explicit queries. Cannot be used in charts, tables, etc. |

## Returns

[`BaseMeasure`](../../../interfaces/interface.BaseMeasure.md)

A measure instance

## Example

Calculate the average cost across all items in a category from the Sample Ecommerce data model.
```ts
measureFactory.avg(DM.Commerce.Cost)
```


---

---
title: constant
---

# Function constant

> **constant**(`value`): [`CalculatedMeasure`](../../../interfaces/interface.CalculatedMeasure.md)

Creates a calculated measure from a numeric value.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `value` | `number` | Value to be returned as a measure |

## Returns

[`CalculatedMeasure`](../../../interfaces/interface.CalculatedMeasure.md)

A calculated measure instance

## Example

Creates a calculated measure from a numeric value.
```ts
measureFactory.constant(42)
```


---

---
title: contribution
---

# Function contribution

> **contribution**(`measure`, `name`?): [`CalculatedMeasure`](../../../interfaces/interface.CalculatedMeasure.md)

Creates a calculated contribution measure.

A contribution measure calculates the contribution, in percentage, of a measure towards the total.
Percentages are expressed as a number between 0 and 1 (e.g. 42% is `0.42`).

For example, using the Sample Ecommerce data model you can retrieve the total cost of products
categorized by age range. Using a contribution measure you can calculate how much each age range's
total cost contributes to the total cost across all age ranges. So, the total cost for the 35-44
age range is 23.64M, which is 22% of the 107.27M of all age ranges together. Therefore, the
contribution of the 35-44 age range is `.22`.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `measure` | [`Measure`](../../../interfaces/interface.Measure.md) | Measure to apply the Contribution logic to |
| `name`? | `string` | Name for the new measure |

## Returns

[`CalculatedMeasure`](../../../interfaces/interface.CalculatedMeasure.md)

A calculated measure instance

## Example

Calculates the percentage of the total cost across all categories for items in a category from the
Sample Ecommerce data model.
```ts
measureFactory.contribution(measureFactory.sum(DM.Commerce.Cost))
```

Contribution values from the Sample Ecommerce data model when categorizing by age range.
| AgeRange | Cost | Contribution |
| --- | --- | --- |
| 0-18 | 4.32M | 0.04 |
| 19-24 | 8.66M | 0.08 |
| 25-34 | 21.19M | 0.2 |
| 35-44 | 23.64M | 0.22 |
| 45-54 | 20.39M | 0.19 |
| 55-64 | 11.82M | 0.11 |
| 65+ | 17.26M | 0.16 |


---

---
title: count
---

# Function count

> **count**(
  `attribute`,
  `name`?,
  `format`?): [`BaseMeasure`](../../../interfaces/interface.BaseMeasure.md)

Creates a count aggregation measure over the given attribute.

To count distinct values in the given attribute, use [countDistinct](function.countDistinct.md).

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `attribute` | [`Attribute`](../../../interfaces/interface.Attribute.md) | Attribute to aggregate |
| `name`? | `string` | Optional name for the new measure |
| `format`? | `string` | Optional numeric formatting to apply using a Numeral.js format string. Can only be used for explicit queries. Cannot be used in charts, tables, etc. |

## Returns

[`BaseMeasure`](../../../interfaces/interface.BaseMeasure.md)

A measure instance

## Example

Counts the number of Commerce items from the Sample Ecommerce data model.
```ts
measureFactory.count(DM.Commerce.BrandID)
```


---

---
title: countDistinct
---

# Function countDistinct

> **countDistinct**(
  `attribute`,
  `name`?,
  `format`?): [`BaseMeasure`](../../../interfaces/interface.BaseMeasure.md)

Creates a count distinct aggregation measure over the given attribute.

To count all values in the given attribute, use [count](function.count.md).

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `attribute` | [`Attribute`](../../../interfaces/interface.Attribute.md) | Attribute to aggregate |
| `name`? | `string` | Optional name for the new measure |
| `format`? | `string` | Optional numeric formatting to apply using a Numeral.js format string. Can only be used for explicit queries. Cannot be used in charts, tables, etc. |

## Returns

[`BaseMeasure`](../../../interfaces/interface.BaseMeasure.md)

A measure instance

## Example

Calculate the number of distinct brands from the Sample Ecommerce data model.
```ts
measureFactory.countDistinct(DM.Brand.BrandID)
```


---

---
title: customFormula
---

# Function customFormula

> **customFormula**(
  `title`,
  `formula`,
  `context`,
  `format`?,
  `description`?): [`CalculatedMeasure`](../../../interfaces/interface.CalculatedMeasure.md)

Creates a calculated measure for a valid custom formula built from [base functions](/guides/sdk/reference/functions.html#measured-value-functions).

Use square brackets (`[]`) within the `formula` property to include dimensions, measures, or filters.
Each unique dimension, measure, or filter included in the `formula` must be defined using a property:value pair in the `context` parameter.

You can nest custom formulas by placing one inside the `formula` parameter of another.

Note: To use [shared formulas](https://docs.sisense.com/main/SisenseLinux/shared-formulas.htm)
from a Fusion instance, you must fetch them first using [useGetSharedFormula](../../../../sdk-ui/fusion-assets/function.useGetSharedFormula.md).

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `title` | `string` | Title of the measure to be displayed in legend |
| `formula` | `string` | Formula to be used for the measure |
| `context` | [`CustomFormulaContext`](../../../interfaces/interface.CustomFormulaContext.md) | Formula context as a map of strings to attributes, measures, or filters |
| `format`? | `string` | Optional format string for the measure |
| `description`? | `string` | Optional description of the measure |

## Returns

[`CalculatedMeasure`](../../../interfaces/interface.CalculatedMeasure.md)

A calculated measure instance

## Example

An example of constructing a custom formulas using dimensions, measures, and nested custom formulas
from the Sample Ecommerce data model.
```ts
// Custom formula
const profitabilityRatio = measureFactory.customFormula(
  'Profitability Ratio',
  '([totalRevenue] - SUM([cost])) / [totalRevenue]',
  {
    totalRevenue: measureFactory.sum(DM.Commerce.Revenue),
    cost: DM.Commerce.Cost,
  },
);

// Nested custom formula
const profitabilityRatioRank = measureFactory.customFormula(
  'Profitability Ratio Rank',
  'RANK([profRatio], "ASC", "1224")',
  {
    profRatio: profitabilityRatio,
  },
);
```

Another example of constructing a custom formula using measures and filters
```ts
const totalCostWithFilter = measureFactory.customFormula(
  'Total Cost with Filter',
  '(SUM([cost]), [categoryFilter])',
  {
    cost: DM.Commerce.Cost,
    categoryFilter: filterFactory.members(DM.Category.Category, ['Apple Mac Desktops']),
  },
);
```


---

---
title: diffPastMonth
---

# Function diffPastMonth

> **diffPastMonth**(`measure`, `name`?): [`CalculatedMeasure`](../../../interfaces/interface.CalculatedMeasure.md)

Creates a calculated measure that calculates the difference between this month's data
and the data from the previous month for the given measure.

The date dimension will be dynamically taken from the query that uses the returned measure.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `measure` | [`Measure`](../../../interfaces/interface.Measure.md) | Measure to apply difference to |
| `name`? | `string` | Name for the new measure |

## Returns

[`CalculatedMeasure`](../../../interfaces/interface.CalculatedMeasure.md)

A calculated measure instance

## Example

Calculate the difference between this month's total cost and the previous month's total cost from
the Sample Ecommerce data model.
```ts
measureFactory.diffPastMonth(measureFactory.sum(DM.Commerce.Cost))
```


---

---
title: diffPastQuarter
---

# Function diffPastQuarter

> **diffPastQuarter**(`measure`, `name`?): [`CalculatedMeasure`](../../../interfaces/interface.CalculatedMeasure.md)

Creates a calculated measure that calculates the difference between this quarter's data
and the data from the previous quarter for the given measure.

The date dimension will be dynamically taken from the query that uses the returned measure.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `measure` | [`Measure`](../../../interfaces/interface.Measure.md) | Measure to apply difference to |
| `name`? | `string` | Name for the new measure |

## Returns

[`CalculatedMeasure`](../../../interfaces/interface.CalculatedMeasure.md)

A calculated measure instance

## Example

Calculate the difference between this quarter's total cost and the previous quarter's total cost
from the Sample Ecommerce data model.
```ts
measureFactory.diffPastQuarter(measureFactory.sum(DM.Commerce.Cost))
```


---

---
title: diffPastWeek
---

# Function diffPastWeek

> **diffPastWeek**(`measure`, `name`?): [`CalculatedMeasure`](../../../interfaces/interface.CalculatedMeasure.md)

Creates a calculated measure that calculates the difference between this week's data
and the data from the previous week for the given measure.

The date dimension will be dynamically taken from the query that uses the returned measure.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `measure` | [`Measure`](../../../interfaces/interface.Measure.md) | Measure to apply difference to |
| `name`? | `string` | Name for the new measure |

## Returns

[`CalculatedMeasure`](../../../interfaces/interface.CalculatedMeasure.md)

A calculated measure instance

## Example

Calculate the difference between this week's total cost and the previous week's total cost from
the Sample Ecommerce data model.
```ts
measureFactory.diffPastWeek(measureFactory.sum(DM.Commerce.Cost))
```


---

---
title: diffPastYear
---

# Function diffPastYear

> **diffPastYear**(`measure`, `name`?): [`CalculatedMeasure`](../../../interfaces/interface.CalculatedMeasure.md)

Creates a calculated measure that calculates the difference between this year's data
and the data from the previous year for the given measure.

The date dimension will be dynamically taken from the query that uses the returned measure.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `measure` | [`Measure`](../../../interfaces/interface.Measure.md) | Measure to apply difference to |
| `name`? | `string` | Name for the new measure |

## Returns

[`CalculatedMeasure`](../../../interfaces/interface.CalculatedMeasure.md)

A calculated measure instance

## Example

Calculate the difference between this year's total cost and the previous year's total cost from
the Sample Ecommerce data model.
```ts
measureFactory.diffPastYear(measureFactory.sum(DM.Commerce.Cost))
```


---

---
title: difference
---

# Function difference

> **difference**(`measure`, `name`?): [`CalculatedMeasure`](../../../interfaces/interface.CalculatedMeasure.md)

Creates a calculated measure that calculates the difference between this period's data
and the data from the previous period for the given measure.

The time resolution is determined by the minimum date level of the date dimension in the query
that uses the returned measure.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `measure` | [`Measure`](../../../interfaces/interface.Measure.md) | Measure to apply difference to |
| `name`? | `string` | Name for the new measure |

## Returns

[`CalculatedMeasure`](../../../interfaces/interface.CalculatedMeasure.md)

A calculated measure instance

## Example

Calculate the difference between this period's total cost and the previous period's total cost
from the Sample Ecommerce data model.
```ts
measureFactory.difference(measureFactory.sum(DM.Commerce.Cost))
```


---

---
title: divide
---

# Function divide

> **divide**(
  `value1`,
  `value2`,
  `name`?,
  `withParentheses`?): [`CalculatedMeasure`](../../../interfaces/interface.CalculatedMeasure.md)

Creates a calculated measure by dividing two given numbers or measures. Divides `value1` by `value2`.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `value1` | [`Measure`](../../../interfaces/interface.Measure.md) \| `number` | First value |
| `value2` | [`Measure`](../../../interfaces/interface.Measure.md) \| `number` | Second value |
| `name`? | `string` | Optional name for the new measure |
| `withParentheses`? | `boolean` | Optional boolean flag whether to wrap the arithmetic operation with parentheses |

## Returns

[`CalculatedMeasure`](../../../interfaces/interface.CalculatedMeasure.md)

A calculated measure instance

## Example

```ts
const measure1 = measureFactory.sum(DM.Dimension.Attribute1);
const measure2 = measureFactory.sum(DM.Dimension.Attribute2);
const measureQuotient = measureFactory.divide(measure1, measure2);
```


---

---
title: forecast
---

# Function forecast

> **forecast**(
  `measure`,
  `name`?,
  `options`?): [`CalculatedMeasure`](../../../interfaces/interface.CalculatedMeasure.md)

Creates a calculated measure that generates a forecast based on a specified measure employing
advanced autoML techniques.

This function offers flexible options allowing you to:
+ Let the function auto-select the best statistical model or explicitly choose a preferred model
+ Control the time period used for training the model
+ Set additional options to improve forecast accuracy by supplying expected lower and upper limits.

In addition to the forecast, upper and lower confidence intervals are returned
with the name of the new measure and a suffix of _upper and _lower
respectively.

Forecast requires a Sisense instance version of L2023.6.0 or greater.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `measure` | [`Measure`](../../../interfaces/interface.Measure.md) | Measure to apply the forecast logic to |
| `name`? | `string` | Name for the new measure |
| `options`? | [`ForecastFormulaOptions`](../../../type-aliases/type-alias.ForecastFormulaOptions.md) | Forecast options |

## Returns

[`CalculatedMeasure`](../../../interfaces/interface.CalculatedMeasure.md)

A calculated measure instance

## Example

Calculate a forecast for total cost from the Sample Ecommerce data model from the Sample
Ecommerce data model.
```ts
measureFactory.forecast(
  measureFactory.sum(DM.Commerce.Cost),
  'Total Cost Forecast',
  {
    modelType: 'prophet',
    roundToInt: true,
  }
)
```


---

---
title: growth
---

# Function growth

> **growth**(`measure`, `name`?): [`CalculatedMeasure`](../../../interfaces/interface.CalculatedMeasure.md)

Creates a calculated measure that calculates growth over a period of time.

The time resolution is determined by the minimum date level of the date dimension in the query
that uses the returned measure.

Growth is calculated using the following formula: `(currentPeriod – previousPeriod) / previousPeriod`.

For example, if this period the value is 12 and the previous period's value was 10, the growth for
this period is 20%, returned as '0.2' (calculation: `(12 – 10) / 10 = 0.2`).

If the previous period's value is greater than the current period, the growth will be negative.

For example, if this period the value is 80, and the previous period's was 100, the growth for
this period is -20%, returned as `-0.2` (calculation: `(80 – 100) / 100 = -0.2`).

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `measure` | [`Measure`](../../../interfaces/interface.Measure.md) | Measure to apply growth to |
| `name`? | `string` | Name for the new measure |

## Returns

[`CalculatedMeasure`](../../../interfaces/interface.CalculatedMeasure.md)

A calculated measure instance

## Example

Calculate the growth in total cost this period in comparison to the previous period from the
Sample Ecommerce data model.
```ts
measureFactory.growth(measureFactory.sum(DM.Commerce.Cost))
```


---

---
title: growthPastMonth
---

# Function growthPastMonth

> **growthPastMonth**(`measure`, `name`?): [`CalculatedMeasure`](../../../interfaces/interface.CalculatedMeasure.md)

Creates a calculated measure that calculates the growth from the previous month to the current month.

The date dimension will be dynamically taken from the query that uses the returned measure.

Growth is calculated using the following formula: `(currentMonth – previousMonth) / previousMonth`.

For example, if this month the value is 12 and the previous month's value was 10, the growth for
this month is 20%, returned as '0.2' (calculation: `(12 – 10) / 10 = 0.2`).

If the previous month's value is greater than the current month, the growth will be negative.

For example, if this month the value is 80, and the previous month's was 100, the growth for
this month is -20%, returned as `-0.2` (calculation: `(80 – 100) / 100 = -0.2`).

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `measure` | [`Measure`](../../../interfaces/interface.Measure.md) | Measure to apply growth to |
| `name`? | `string` | Name for the new measure |

## Returns

[`CalculatedMeasure`](../../../interfaces/interface.CalculatedMeasure.md)

A calculated measure instance

## Example

Calculate the growth in total cost this month in comparison to the previous month from the Sample
Ecommerce data model.
```ts
measureFactory.growthPastMonth(measureFactory.sum(DM.Commerce.Cost))
```


---

---
title: growthPastQuarter
---

# Function growthPastQuarter

> **growthPastQuarter**(`measure`, `name`?): [`CalculatedMeasure`](../../../interfaces/interface.CalculatedMeasure.md)

Creates a calculated measure that calculates the growth from the previous quarter to the current quarter.

The date dimension will be dynamically taken from the query that uses the returned measure.

Growth is calculated using the following formula: `(currentQuarter – previousQuarter) / previousQuarter`.

For example, if this quarter the value is 12 and the previous quarter's value was 10, the growth for
this quarter is 20%, returned as '0.2' (calculation: `(12 – 10) / 10 = 0.2`).

If the previous quarter's value is greater than the current quarter, the growth will be negative.

For example, if this quarter the value is 80, and the previous quarter's was 100, the growth for
this quarter is -20%, returned as `-0.2` (calculation: `(80 – 100) / 100 = -0.2`).

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `measure` | [`Measure`](../../../interfaces/interface.Measure.md) | Measure to apply growth to |
| `name`? | `string` | Name for the new measure |

## Returns

[`CalculatedMeasure`](../../../interfaces/interface.CalculatedMeasure.md)

A calculated measure instance

## Example

Calculate the growth in total cost this quarter in comparison to the previous quarter from the
Sample Ecommerce data model.
```ts
measureFactory.growthPastQuarter(measureFactory.sum(DM.Commerce.Cost))
```


---

---
title: growthPastWeek
---

# Function growthPastWeek

> **growthPastWeek**(`measure`, `name`?): [`CalculatedMeasure`](../../../interfaces/interface.CalculatedMeasure.md)

Creates a calculated measure that calculates the growth from the previous week to the current week.

The date dimension will be dynamically taken from the query that uses the returned measure.

Growth is calculated using the following formula: `(currentWeek – previousWeek) / previousWeek`.

For example, if this week the value is 12 and the previous week's value was 10, the growth for
this week is 20%, returned as '0.2' (calculation: `(12 – 10) / 10 = 0.2`).

If the previous week's value is greater than the current week, the growth will be negative.

For example, if this week the value is 80, and the previous week's was 100, the growth for
this week is -20%, returned as `-0.2` (calculation: `(80 – 100) / 100 = -0.2`).

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `measure` | [`Measure`](../../../interfaces/interface.Measure.md) | Measure to apply growth to |
| `name`? | `string` | Name for the new measure |

## Returns

[`CalculatedMeasure`](../../../interfaces/interface.CalculatedMeasure.md)

A calculated measure instance

## Example

Calculate the growth in total cost this week in comparison to the previous week from the Sample
Ecommerce data model.
```ts
measureFactory.growthPastWeek(measureFactory.sum(DM.Commerce.Cost))
```


---

---
title: growthPastYear
---

# Function growthPastYear

> **growthPastYear**(`measure`, `name`?): [`CalculatedMeasure`](../../../interfaces/interface.CalculatedMeasure.md)

Creates a calculated measure that calculates the growth from the previous year to the current year.

The date dimension will be dynamically taken from the query that uses the returned measure.

Growth is calculated using the following formula: `(currentYear – previousYear) / previousYear`.

For example, if this year the value is 12 and the previous year's value was 10, the growth for
this year is 20%, returned as '0.2' (calculation: `(12 – 10) / 10 = 0.2`).

If the previous year's value is greater than the current year, the growth will be negative.

For example, if this year the value is 80, and the previous year's was 100, the growth for
this year is -20%, returned as `-0.2` (calculation: `(80 – 100) / 100 = -0.2`).

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `measure` | [`Measure`](../../../interfaces/interface.Measure.md) | Measure to apply growth to |
| `name`? | `string` | Name for the new measure |

## Returns

[`CalculatedMeasure`](../../../interfaces/interface.CalculatedMeasure.md)

A calculated measure instance

## Example

Calculate the growth in total cost this year in comparison to the previous year from the Sample
Ecommerce data model.
```ts
measureFactory.growthPastYear(measureFactory.sum(DM.Commerce.Cost))
```


---

---
title: growthRate
---

# Function growthRate

> **growthRate**(`measure`, `name`?): [`CalculatedMeasure`](../../../interfaces/interface.CalculatedMeasure.md)

Creates a calculated measure that calculates growth rate over a period of time.

The time resolution is determined by the minimum date level of the date dimension in the query
that uses the returned measure.

Growth rate is calculated using the following formula: `currentPeriod / previousPeriod`.

For example, if this period the value is 12 and the previous period's value was 10, the growth rate for
this period is 120%, returned as '1.2' (calculation: `12 / 10 = 1.2`).

If the previous period's value is greater than the current period, the growth rate will be less than one.

For example, if this period the value is 80, and the previous period's was 100, the growth for
this period is 80%, returned as `0.8` (calculation: `80 / 100 = .8`).

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `measure` | [`Measure`](../../../interfaces/interface.Measure.md) | Measure to apply the Growth rate |
| `name`? | `string` | Name for the new measure |

## Returns

[`CalculatedMeasure`](../../../interfaces/interface.CalculatedMeasure.md)

A calculated measure instance

## Example

Calculate the growth rate in total cost this period in comparison to the previous period from the
Sample Ecommerce data model.
```ts
measureFactory.growthRate(measureFactory.sum(DM.Commerce.Cost))
```


---

---
title: max
---

# Function max

> **max**(
  `attribute`,
  `name`?,
  `format`?): [`BaseMeasure`](../../../interfaces/interface.BaseMeasure.md)

Creates a max aggregation measure over the given attribute.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `attribute` | [`Attribute`](../../../interfaces/interface.Attribute.md) | Attribute to aggregate |
| `name`? | `string` | Optional name for the new measure |
| `format`? | `string` | Optional numeric formatting to apply using a Numeral.js format string. Can only be used for explicit queries. Cannot be used in charts, tables, etc. |

## Returns

[`BaseMeasure`](../../../interfaces/interface.BaseMeasure.md)

A measure instance

## Example

Calculate the maximum cost across all items in a category from the Sample Ecommerce data model.
```ts
measureFactory.max(DM.Commerce.Cost)
```


---

---
title: measuredValue
---

# Function measuredValue

> **measuredValue**(
  `measure`,
  `filters`,
  `name`?,
  `format`?): [`CalculatedMeasure`](../../../interfaces/interface.CalculatedMeasure.md)

Creates a measured value with the given measure and set of filters.

A measured value only includes values from items that match the provided filters.

For example you can use a measured value to get a total cost for all items where the cost is greater than 100.

Note that the filters on the measured value override the filters on the query, chart, or table the
measured value is used in.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `measure` | [`Measure`](../../../interfaces/interface.Measure.md) | Measure to filter |
| `filters` | [`Filter`](../../../interfaces/interface.Filter.md)[] | Filters to apply to the measure |
| `name`? | `string` | Optional name for the new measure |
| `format`? | `string` | Optional numeric formatting to apply using a Numeral.js format string. Can only be used for explicit queries. Cannot be used in charts, tables, etc. |

## Returns

[`CalculatedMeasure`](../../../interfaces/interface.CalculatedMeasure.md)

A calculated measure instance

## Example

Calculate the total cost across all items in a category from the Sample Ecommerce data model,
where the cost is greater than 100. Additional filtering on the cost will not affect this measure.
```ts
measureFactory.measuredValue(
  measureFactory.sum(DM.Commerce.Cost),
  [filterFactory.greaterThan(DM.Commerce.Cost, 100)],
  'Cost Greater Than 100'
),
```


---

---
title: median
---

# Function median

> **median**(
  `attribute`,
  `name`?,
  `format`?): [`BaseMeasure`](../../../interfaces/interface.BaseMeasure.md)

Creates a median aggregation measure over the given attribute.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `attribute` | [`Attribute`](../../../interfaces/interface.Attribute.md) | Attribute to aggregate |
| `name`? | `string` | Optional name for the new measure |
| `format`? | `string` | Optional numeric formatting to apply using a Numeral.js format string. Can only be used for explicit queries. Cannot be used in charts, tables, etc. |

## Returns

[`BaseMeasure`](../../../interfaces/interface.BaseMeasure.md)

A measure instance

## Example

Calculate the median cost across all items in a category from the Sample Ecommerce data model.
```ts
measureFactory.median(DM.Commerce.Cost)
```


---

---
title: min
---

# Function min

> **min**(
  `attribute`,
  `name`?,
  `format`?): [`BaseMeasure`](../../../interfaces/interface.BaseMeasure.md)

Creates a min aggregation measure over the given attribute.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `attribute` | [`Attribute`](../../../interfaces/interface.Attribute.md) | Attribute to aggregate |
| `name`? | `string` | Optional name for the new measure |
| `format`? | `string` | Optional numeric formatting to apply using a Numeral.js format string. Can only be used for explicit queries. Cannot be used in charts, tables, etc. |

## Returns

[`BaseMeasure`](../../../interfaces/interface.BaseMeasure.md)

A measure instance

## Example

Calculate the minimum cost across all items in a category from the Sample Ecommerce data model.
```ts
measureFactory.min(DM.Commerce.Cost)
```


---

---
title: monthToDateSum
---

# Function monthToDateSum

> **monthToDateSum**(`measure`, `name`?): [`CalculatedMeasure`](../../../interfaces/interface.CalculatedMeasure.md)

Creates a calculated measure that calculates the running total starting from the beginning
of the month up to the current day or week.

The time resolution is determined by the minimum date level of the date dimension in the query
that uses the returned measure.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `measure` | [`Measure`](../../../interfaces/interface.Measure.md) | Measure to apply the MTD Sum to |
| `name`? | `string` | Name for the new measure |

## Returns

[`CalculatedMeasure`](../../../interfaces/interface.CalculatedMeasure.md)

A calculated measure instance

## Example

Calculate the running total of total cost from the Sample Ecommerce data model, starting from the
beginning of the month up to the current day or week.
```ts
measureFactory.monthToDateSum(measureFactory.sum(DM.Commerce.Cost))
```


---

---
title: multiply
---

# Function multiply

> **multiply**(
  `value1`,
  `value2`,
  `name`?,
  `withParentheses`?): [`CalculatedMeasure`](../../../interfaces/interface.CalculatedMeasure.md)

Creates a calculated measure by multiplying two given numbers or measures.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `value1` | [`Measure`](../../../interfaces/interface.Measure.md) \| `number` | First value |
| `value2` | [`Measure`](../../../interfaces/interface.Measure.md) \| `number` | Second value |
| `name`? | `string` | Optional name for the new measure |
| `withParentheses`? | `boolean` | Optional boolean flag whether to wrap the arithmetic operation with parentheses |

## Returns

[`CalculatedMeasure`](../../../interfaces/interface.CalculatedMeasure.md)

A calculated measure instance

## Example

```ts
const measure1 = measureFactory.sum(DM.Dimension.Attribute1);
const measure2 = measureFactory.sum(DM.Dimension.Attribute2);
const measureProduct = measureFactory.multiply(measure1, measure2);
```


---

---
title: pastDay
---

# Function pastDay

> **pastDay**(`measure`, `name`?): [`CalculatedMeasure`](../../../interfaces/interface.CalculatedMeasure.md)

Creates a calculated measure that calculates the value for the previous day.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `measure` | [`Measure`](../../../interfaces/interface.Measure.md) | Measure to apply past value to |
| `name`? | `string` | Name for the new measure |

## Returns

[`CalculatedMeasure`](../../../interfaces/interface.CalculatedMeasure.md)

A calculated measure instance

## Example

Calculate total cost for the previous day from the Sample Ecommerce data model.
```ts
measureFactory.pastDay(measureFactory.sum(DM.Commerce.Cost))
```


---

---
title: pastMonth
---

# Function pastMonth

> **pastMonth**(`measure`, `name`?): [`CalculatedMeasure`](../../../interfaces/interface.CalculatedMeasure.md)

Creates a calculated measure that calculates the value for the same day or week in the previous month.

The time resolution is determined by the minimum date level of the date dimension in the query
that uses the returned measure.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `measure` | [`Measure`](../../../interfaces/interface.Measure.md) | Measure to apply past value to |
| `name`? | `string` | Name for the new measure |

## Returns

[`CalculatedMeasure`](../../../interfaces/interface.CalculatedMeasure.md)

A calculated measure instance

## Example

Calculate total cost for the corresponding day or week one month ago from the Sample Ecommerce
data model.
```ts
measureFactory.pastMonth(measureFactory.sum(DM.Commerce.Cost))
```


---

---
title: pastQuarter
---

# Function pastQuarter

> **pastQuarter**(`measure`, `name`?): [`CalculatedMeasure`](../../../interfaces/interface.CalculatedMeasure.md)

Creates a calculated measure that calculates the value for the same day, week, or month in the previous quarter.

The time resolution is determined by the minimum date level of the date dimension in the query
that uses the returned measure.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `measure` | [`Measure`](../../../interfaces/interface.Measure.md) | Measure to apply past value to |
| `name`? | `string` | Name for the new measure |

## Returns

[`CalculatedMeasure`](../../../interfaces/interface.CalculatedMeasure.md)

A calculated measure instance

## Example

Calculate total cost for the corresponding day, week, or month one quarter ago from the Sample
Ecommerce data model.
```ts
measureFactory.pastQuarter(measureFactory.sum(DM.Commerce.Cost))
```


---

---
title: pastWeek
---

# Function pastWeek

> **pastWeek**(`measure`, `name`?): [`CalculatedMeasure`](../../../interfaces/interface.CalculatedMeasure.md)

Creates a calculated measure that calculates the value for the same day in the previous week.

The time resolution is determined by the minimum date level of the date dimension in the query
that uses the returned measure.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `measure` | [`Measure`](../../../interfaces/interface.Measure.md) | Measure to apply past value to |
| `name`? | `string` | Name for the new measure |

## Returns

[`CalculatedMeasure`](../../../interfaces/interface.CalculatedMeasure.md)

A calculated measure instance

## Example

Calculate total cost for the corresponding day one week ago from the Sample Ecommerce data model.
```ts
measureFactory.pastWeek(measureFactory.sum(DM.Commerce.Cost))
```


---

---
title: pastYear
---

# Function pastYear

> **pastYear**(`measure`, `name`?): [`CalculatedMeasure`](../../../interfaces/interface.CalculatedMeasure.md)

Creates a calculated measure that calculates the value for the same day, week, month, or quarter in the previous year.

The time resolution is determined by the minimum date level of the date dimension in the query
that uses the returned measure.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `measure` | [`Measure`](../../../interfaces/interface.Measure.md) | Measure to apply past value to |
| `name`? | `string` | Name for the new measure |

## Returns

[`CalculatedMeasure`](../../../interfaces/interface.CalculatedMeasure.md)

A calculated measure instance

## Example

Calculate total cost for the corresponding day, week, month, or quarter one year ago from the
Sample Ecommerce data model.
```ts
measureFactory.pastYear(measureFactory.sum(DM.Commerce.Cost))
```


---

---
title: quarterToDateSum
---

# Function quarterToDateSum

> **quarterToDateSum**(`measure`, `name`?): [`CalculatedMeasure`](../../../interfaces/interface.CalculatedMeasure.md)

Creates a calculated measure that calculates the running total starting from the beginning
of the quarter up to the current day, week, or month.

The time resolution is determined by the minimum date level of the date dimension in the query
that uses the returned measure.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `measure` | [`Measure`](../../../interfaces/interface.Measure.md) | Measure to apply the QTD Sum to |
| `name`? | `string` | Name for the new measure |

## Returns

[`CalculatedMeasure`](../../../interfaces/interface.CalculatedMeasure.md)

A calculated measure instance

## Example

Calculate the running total of total cost from the Sample Ecommerce data model, starting from the
beginning of the quarter up to the current day, week, or month.
```ts
measureFactory.quarterToDateSum(measureFactory.sum(DM.Commerce.Cost))
```


---

---
title: rank
---

# Function rank

> **rank**(
  `measure`,
  `name`?,
  `sort`?,
  `rankType`?,
  `groupBy`?): [`CalculatedMeasure`](../../../interfaces/interface.CalculatedMeasure.md)

Creates a calculated measure that calculates the rank of a value in a list of values.

This function includes options that allow you do customize the ranking order and how to handle
equally ranked items.

The order options are:
+ `'DESC'` (default): Descending, meaning the largest number is ranked first.
+ `'ASC'`: Ascending, meaning the smallest number is ranked first.

The rank type options are:
+ `'1224'`: Standard competition, meaning items that rank equally receive the same ranking number,
  and then a gap is left after the equally ranked items in the ranking numbers.
+ `'1334'`: Modified competition ranking, meaning items that rank equally receive the same ranking number,
  and a gap is left before the equally ranked items in the ranking numbers.
+ `'1223'`: Dense ranking, meaning items that rank equally receive the same ranking number,
  and the next items receive the immediately following ranking number.
+ `'1234'`: Ordinal ranking, meaning all items receive distinct ordinal numbers,
  including items that rank equally. The assignment of distinct ordinal numbers for equal-ranking items is arbitrary.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `measure` | [`Measure`](../../../interfaces/interface.Measure.md) | Measure to apply the ranking logic to |
| `name`? | `string` | Name for the new measure |
| `sort`? | `string` | Sorting for ranking. By default sort order is descending, where the largest number is ranked first. |
| `rankType`? | `string` | How to handle equally ranked items. By default the type is standard competition ranking. |
| `groupBy`? | [`Attribute`](../../../interfaces/interface.Attribute.md)[] | Rank partition attributes |

## Returns

[`CalculatedMeasure`](../../../interfaces/interface.CalculatedMeasure.md)

A calculated measure instance

## Example

Calculate the rank of the total cost per category, sorted with the smallest cost ranked first,
and ranking ties are handled using the ordinal ranking type from the Sample Ecommerce data model.
```ts
measureFactory.rank(
  measureFactory.sum(DM.Commerce.Cost),
  'Cost Rank',
  measureFactory.RankingSortTypes.Ascending,
  measureFactory.RankingTypes.Ordinal
)
```

Ranking values from the Sample Ecommerce data model when categorizing by age range using the above ranking.
| AgeRange | Cost | Cost Rank |
| --- | --- | --- |
| 0-18 | 4.32M | 1 |
| 19-24 | 8.66M | 2 |
| 25-34 | 21.19M | 6 |
| 35-44 | 23.64M | 7 |
| 45-54 | 20.39M | 5 |
| 55-64 | 11.82M | 3 |
| 65+ | 17.26M | 4 |


---

---
title: runningSum
---

# Function runningSum

> **runningSum**(
  `measure`,
  `_continuous`?,
  `name`?): [`CalculatedMeasure`](../../../interfaces/interface.CalculatedMeasure.md)

Creates a calculated measure that calculates the running total of a given measure.

The running sum is calculated using the current sort order of the query it's used in.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `measure` | [`Measure`](../../../interfaces/interface.Measure.md) | Measure to apply the running sum to |
| `_continuous`? | `boolean` | Boolean flag whether to accumulate the sum continuously<br />when there are two or more dimensions. The default value is false. |
| `name`? | `string` | Name for the new measure |

## Returns

[`CalculatedMeasure`](../../../interfaces/interface.CalculatedMeasure.md)

A calculated measure instance

## Example

Calculate the running sum of the total cost from the Sample Ecommerce data model across all categories.
```ts
measureFactory.runningSum(measureFactory.sum(DM.Commerce.Cost)),
```

Running sum values from the Sample Ecommerce data model when categorizing by age range.
| AgeRange | Cost | Running Cost |
| --- | --- | --- |
| 0-18 | 4.32M | 4.32M |
| 19-24 | 8.66M | 12.98M |
| 25-34 | 21.19M | 34.16M |
| 35-44 | 23.64M | 57.8M |
| 45-54 | 20.39M | 78.19M |
| 55-64 | 11.82M | 90.01M |
| 65+ | 17.26M | 107.27M |


---

---
title: subtract
---

# Function subtract

> **subtract**(
  `value1`,
  `value2`,
  `name`?,
  `withParentheses`?): [`CalculatedMeasure`](../../../interfaces/interface.CalculatedMeasure.md)

Creates a calculated measure by subtracting two given numbers or measures. Subtracts `value2` from `value1`.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `value1` | [`Measure`](../../../interfaces/interface.Measure.md) \| `number` | First value |
| `value2` | [`Measure`](../../../interfaces/interface.Measure.md) \| `number` | Second value |
| `name`? | `string` | Optional name for the new measure |
| `withParentheses`? | `boolean` | Optional boolean flag whether to wrap the arithmetic operation with parentheses |

## Returns

[`CalculatedMeasure`](../../../interfaces/interface.CalculatedMeasure.md)

A calculated measure instance

## Example

```ts
const measure1 = measureFactory.sum(DM.Dimension.Attribute1);
const measure2 = measureFactory.sum(DM.Dimension.Attribute2);
const measureDifference = measureFactory.subtract(measure1, measure2);
```


---

---
title: sum
---

# Function sum

> **sum**(
  `attribute`,
  `name`?,
  `format`?): [`BaseMeasure`](../../../interfaces/interface.BaseMeasure.md)

Creates a sum aggregation measure over the given attribute.

To create a running sum, use [runningSum](function.runningSum.md).

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `attribute` | [`Attribute`](../../../interfaces/interface.Attribute.md) | Attribute to aggregate |
| `name`? | `string` | Optional name for the new measure |
| `format`? | `string` | Optional numeric formatting to apply using a Numeral.js format string. Can only be used for explicit queries. Cannot be used in charts, tables, etc. |

## Returns

[`BaseMeasure`](../../../interfaces/interface.BaseMeasure.md)

A measure instance

## Example

Calculate the total cost across all items in a category from the Sample Ecommerce data model.
```ts
measureFactory.sum(DM.Commerce.Cost)
```


---

---
title: trend
---

# Function trend

> **trend**(
  `measure`,
  `name`?,
  `options`?): [`CalculatedMeasure`](../../../interfaces/interface.CalculatedMeasure.md)

Creates a calculated measure that computes a specified trend type for a given measure.

The trend types include linear (the default), logarithmic, advanced smoothing, and local estimates.
You can also opt to automatically identify and ignore anomalous values in the series.

Trend requires a Sisense instance version of L2023.6.0 or greater.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `measure` | [`Measure`](../../../interfaces/interface.Measure.md) | Measure to apply the trend logic to |
| `name`? | `string` | Name for the new measure |
| `options`? | [`TrendFormulaOptions`](../../../type-aliases/type-alias.TrendFormulaOptions.md) | Trend options |

## Returns

[`CalculatedMeasure`](../../../interfaces/interface.CalculatedMeasure.md)

A calculated measure instance

## Example

Calculate the trend in total cost from the Sample Ecommerce data model.
```ts
measureFactory.trend(
  measureFactory.sum(DM.Commerce.Cost),
  'Total Cost Trend',
  {
    modelType: 'advancedSmoothing',
    ignoreAnomalies: true,
  }
)
```


---

---
title: weekToDateSum
---

# Function weekToDateSum

> **weekToDateSum**(`measure`, `name`?): [`CalculatedMeasure`](../../../interfaces/interface.CalculatedMeasure.md)

Creates a calculated measure that calculates the running total starting from the beginning
of the week up to the current day.

The time resolution is determined by the minimum date level of the date dimension in the query
that uses the returned measure.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `measure` | [`Measure`](../../../interfaces/interface.Measure.md) | Measure to apply the WTD Sum to |
| `name`? | `string` | Name for the new measure |

## Returns

[`CalculatedMeasure`](../../../interfaces/interface.CalculatedMeasure.md)

A calculated measure instance

## Example

Calculate the running total of total cost from the Sample Ecommerce data model, starting from the
beginning of the week up to the current day.
```ts
measureFactory.weekToDateSum(measureFactory.sum(DM.Commerce.Cost))
```


---

---
title: yearToDateSum
---

# Function yearToDateSum

> **yearToDateSum**(`measure`, `name`?): [`CalculatedMeasure`](../../../interfaces/interface.CalculatedMeasure.md)

Creates a calculated measure that calculates the running total starting from the beginning
of the year up to the current day, week, month, or quarter.

The time resolution is determined by the minimum date level of the date dimension in the query
that uses the returned measure.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `measure` | [`Measure`](../../../interfaces/interface.Measure.md) | Measure to apply the YTD Sum to |
| `name`? | `string` | Name for the new measure |

## Returns

[`CalculatedMeasure`](../../../interfaces/interface.CalculatedMeasure.md)

A calculated measure instance

## Example

Calculate the running total of total cost from the Sample Ecommerce data model, starting from the
beginning of the year up to the current day, week, month, or quarter.
```ts
measureFactory.yearToDateSum(measureFactory.sum(DM.Commerce.Cost))
```

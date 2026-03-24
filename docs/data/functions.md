---
title: createAttribute
---

# Function createAttribute

> **createAttribute**(`json`): [`Attribute`](../interfaces/interface.Attribute.md)

Creates an Attribute instance from the given JSON object.
If the JSON object contains a granularity property, a [LevelAttribute](../interfaces/interface.LevelAttribute.md) instance is created.

This function is used in the generated data model code to create dimension attributes from an input data source.

See also functions [createDimension](function.createDimension.md) and [createDateDimension](function.createDateDimension.md).

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `json` | `any` | JSON object representing the attribute |

## Returns

[`Attribute`](../interfaces/interface.Attribute.md)

An Attribute instance


---

---
title: createDateDimension
---

# Function createDateDimension

> **createDateDimension**(`json`): [`DateDimension`](../interfaces/interface.DateDimension.md)

Creates a new Date Dimension instance from the given JSON object.

This function is used in the generated data model code to create date dimensions for an input data source.

See also functions [createDimension](function.createDimension.md) and [createAttribute](function.createAttribute.md).

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `json` | `any` | JSON object representing the Date Dimension |

## Returns

[`DateDimension`](../interfaces/interface.DateDimension.md)

A new Date Dimension instance


---

---
title: createDimension
---

# Function createDimension

> **createDimension**(`json`): [`Dimension`](../interfaces/interface.Dimension.md)

Creates a new Dimension instance from the given JSON object.

This function is used in the generated data model code to create dimensions for an input data source.

See also functions [createDateDimension](function.createDateDimension.md) and [createAttribute](function.createAttribute.md).

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `json` | `any` | JSON object representing the Dimension |

## Returns

[`Dimension`](../interfaces/interface.Dimension.md)

A new Dimension instance


---

---
title: findFilter
---

# Function findFilter

> **findFilter**(`filters`, `searchFn`): [`Filter`](../interfaces/interface.Filter.md) \| `undefined`

Finds a filter in an array of filters or filter relations.
Returns the first filter that satisfies the provided search function.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `filters` | [`FilterRelations`](../interfaces/interface.FilterRelations.md) \| [`Filter`](../interfaces/interface.Filter.md)[] \| `undefined` | An array of filters or filter relations to search. |
| `searchFn` | (`filter`) => `boolean` | A function that takes a filter and returns a boolean indicating whether the filter satisfies the search criteria. |

## Returns

[`Filter`](../interfaces/interface.Filter.md) \| `undefined`

The first filter that satisfies the search function, or `undefined` if no filter is found.


---

---
title: isFilterRelations
---

# Function isFilterRelations

> **isFilterRelations**(`filters`): `filters is FilterRelations`

Type guard for checking if the provided filters are FilterRelations.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `filters` | [`FilterRelations`](../interfaces/interface.FilterRelations.md) \| [`Filter`](../interfaces/interface.Filter.md)[] \| `undefined` | The filters to check. |

## Returns

`filters is FilterRelations`

`true` if the filters are FilterRelations, `false` otherwise.


---

---
title: withAddedFilter
---

# Function withAddedFilter

> **withAddedFilter**(`filter`): (`filters`) => [`FilterRelations`](../interfaces/interface.FilterRelations.md) \| [`Filter`](../interfaces/interface.Filter.md)[]

Returns a function that adds a filter to existing filters or filter relations.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `filter` | [`Filter`](../interfaces/interface.Filter.md) | The filter to add. |

## Returns

A function that takes existing filters or filter relations and returns updated filters or filter relations with the new filter added.

> > (`filters`): [`FilterRelations`](../interfaces/interface.FilterRelations.md) \| [`Filter`](../interfaces/interface.Filter.md)[]
>
> ### Parameters
>
>
> | Parameter | Type |
> | :------ | :------ |
> | `filters` | [`FilterRelations`](../interfaces/interface.FilterRelations.md) \| [`Filter`](../interfaces/interface.Filter.md)[] \| `undefined` |
>
>
> ### Returns
>
> [`FilterRelations`](../interfaces/interface.FilterRelations.md) \| [`Filter`](../interfaces/interface.Filter.md)[]
>
>

## Example

```ts
// Using with an array of filters
const originalFilters = [filterByAgeRange];
const updatedFilters = withAddedFilter(filterByCost)(originalFilters);
// [filterByAgeRange, filterByCost]

// Using with filter relations
const originalFilterRelations = filterFactory.logic.or(filterByAgeRange, filterByRevenue);
const updatedFilterRelations = withAddedFilter(filterByCost)(originalFilterRelations);
// (filterByAgeRange OR filterByRevenue) AND filterByCost
```


---

---
title: withAddedFilters
---

# Function withAddedFilters

> **withAddedFilters**(`filtersToAdd`): (`filters`) => [`FilterRelations`](../interfaces/interface.FilterRelations.md) \| [`Filter`](../interfaces/interface.Filter.md)[]

Returns a function that adds multiple filters to existing filters or filter relations.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `filtersToAdd` | [`Filter`](../interfaces/interface.Filter.md)[] | An array of filters to add. |

## Returns

A function that takes existing filters or filter relations and returns updated filters or filter relations with the new filters added.

> > (`filters`): [`FilterRelations`](../interfaces/interface.FilterRelations.md) \| [`Filter`](../interfaces/interface.Filter.md)[]
>
> ### Parameters
>
>
> | Parameter | Type |
> | :------ | :------ |
> | `filters` | [`FilterRelations`](../interfaces/interface.FilterRelations.md) \| [`Filter`](../interfaces/interface.Filter.md)[] \| `undefined` |
>
>
> ### Returns
>
> [`FilterRelations`](../interfaces/interface.FilterRelations.md) \| [`Filter`](../interfaces/interface.Filter.md)[]
>
>

## Example

```ts
// Using with an array of filters
const originalFilters = [filterByAgeRange];
const updatedFilters = withAddedFilters([filterByCost, filterByRevenue])(originalFilters);
// [filterByAgeRange, filterByCost, filterByRevenue]

// Using with filter relations
const originalFilterRelations = filterFactory.logic.or(filterByAgeRange, filterByRevenue);
const updatedFilterRelations = withAddedFilters([filterByCost, filterByRevenue])(originalFilterRelations);
// (filterByAgeRange OR filterByRevenue) AND filterByCost AND filterByRevenue
```


---

---
title: withReplacedFilter
---

# Function withReplacedFilter

> **withReplacedFilter**(`filterToReplace`, `newFilter`): (`filters`) => [`FilterRelations`](../interfaces/interface.FilterRelations.md) \| [`Filter`](../interfaces/interface.Filter.md)[]

Returns a function that replaces a filter with a new filter in existing filters or filter relations.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `filterToReplace` | [`Filter`](../interfaces/interface.Filter.md) | The filter to replace. |
| `newFilter` | [`Filter`](../interfaces/interface.Filter.md) | The new filter to use as a replacement. |

## Returns

A function that takes existing filters or filter relations and returns updated filters or filter relations with the filter replaced.

> > (`filters`): [`FilterRelations`](../interfaces/interface.FilterRelations.md) \| [`Filter`](../interfaces/interface.Filter.md)[]
>
> ### Parameters
>
>
> | Parameter | Type |
> | :------ | :------ |
> | `filters` | [`FilterRelations`](../interfaces/interface.FilterRelations.md) \| [`Filter`](../interfaces/interface.Filter.md)[] \| `undefined` |
>
>
> ### Returns
>
> [`FilterRelations`](../interfaces/interface.FilterRelations.md) \| [`Filter`](../interfaces/interface.Filter.md)[]
>
>

## Example

```ts
// Using with an array of filters
const originalFilters = [filterByAgeRange, filterByRevenue];
const updatedFilters = withReplacedFilter(filterByRevenue, filterByCost)(originalFilters);
// [filterByAgeRange, filterByCost]

// Using with filter relations
const originalFilterRelations = filterFactory.logic.or(filterByAgeRange, filterByRevenue);
const updatedFilterRelations = withReplacedFilter(filterByRevenue, filterByCost)(originalFilterRelations);
// (filterByAgeRange OR filterByCost)
```


---

---
title: withoutFilter
---

# Function withoutFilter

> **withoutFilter**(`filterToRemove`): (`filters`) => [`FilterRelations`](../interfaces/interface.FilterRelations.md) \| [`Filter`](../interfaces/interface.Filter.md)[]

Returns a function that removes a filter from existing filters or filter relations.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `filterToRemove` | [`Filter`](../interfaces/interface.Filter.md) | The filter to remove. |

## Returns

A function that takes existing filters or filter relations and returns updated filters or filter relations without the specified filter.

> > (`filters`): [`FilterRelations`](../interfaces/interface.FilterRelations.md) \| [`Filter`](../interfaces/interface.Filter.md)[]
>
> ### Parameters
>
>
> | Parameter | Type |
> | :------ | :------ |
> | `filters` | [`FilterRelations`](../interfaces/interface.FilterRelations.md) \| [`Filter`](../interfaces/interface.Filter.md)[] \| `undefined` |
>
>
> ### Returns
>
> [`FilterRelations`](../interfaces/interface.FilterRelations.md) \| [`Filter`](../interfaces/interface.Filter.md)[]
>
>

## Example

```ts
// Using with an array of filters
const originalFilters = [filterByAgeRange, filterByRevenue, filterByCost];
const updatedFilters = withoutFilter(filterByCost)(originalFilters);
// [filterByAgeRange, filterByRevenue]

// Using with filter relations
const originalFilterRelations = filterFactory.logic.or(filterByAgeRange, filterByRevenue);
const updatedFiltersRelations = withoutFilter(filterByRevenue)(originalFilterRelations);
// filterByAgeRange
```


---

---
title: withoutFilters
---

# Function withoutFilters

> **withoutFilters**(`filtersToRemove`): (`filters`) => [`FilterRelations`](../interfaces/interface.FilterRelations.md) \| [`Filter`](../interfaces/interface.Filter.md)[]

Returns a function that removes multiple filters from existing filters or filter relations.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `filtersToRemove` | [`Filter`](../interfaces/interface.Filter.md)[] | An array of filters to remove. |

## Returns

A function that takes existing filters or filter relations and returns updated filters or filter relations without the specified filters.

> > (`filters`): [`FilterRelations`](../interfaces/interface.FilterRelations.md) \| [`Filter`](../interfaces/interface.Filter.md)[]
>
> ### Parameters
>
>
> | Parameter | Type |
> | :------ | :------ |
> | `filters` | [`FilterRelations`](../interfaces/interface.FilterRelations.md) \| [`Filter`](../interfaces/interface.Filter.md)[] \| `undefined` |
>
>
> ### Returns
>
> [`FilterRelations`](../interfaces/interface.FilterRelations.md) \| [`Filter`](../interfaces/interface.Filter.md)[]
>
>

## Example

```ts
// Using with an array of filters
const originalFilters = [filterByAgeRange, filterByRevenue, filterByCost];
const updatedFilters = withRemovedFilters([filterByRevenue, filterByCost])(originalFilters);
// [filterByAgeRange]

// Using with filter relations
const originalFilterRelations = filterFactory.logic.or(filterByAgeRange, filterByRevenue);
const updatedFiltersRelations = withRemovedFilters([filterByRevenue])(originalFilterRelations);
// filterByAgeRange
```


---

---
title: Sort
---

# Enumeration Sort

Different sort types.

## Enumeration Members

### Ascending

> **Ascending**: `1`

Sort Ascending

***

### Descending

> **Descending**: `2`

Sort Descending

***

### None

> **None**: `0`

No sort definition


---

---
title: AggregationTypes
---

# Variable AggregationTypes

> **`const`** **AggregationTypes**: `object`

Different aggregation types

## Type declaration

### `Average`

**`readonly`** **Average**: `"avg"` = `'avg'`

Average aggregation type

***

### `Count`

**`readonly`** **Count**: `"count"` = `'count'`

Count aggregation type

***

### `CountDistinct`

**`readonly`** **CountDistinct**: `"countDistinct"` = `'countDistinct'`

Count distinct aggregation type

***

### `Max`

**`readonly`** **Max**: `"max"` = `'max'`

Max aggregation type

***

### `Median`

**`readonly`** **Median**: `"median"` = `'median'`

Median aggregation type

***

### `Min`

**`readonly`** **Min**: `"min"` = `'min'`

Min aggregation type

***

### `StandardDeviation`

**`readonly`** **StandardDeviation**: `"stdev"` = `'stdev'`

Standard deviation aggregation type

***

### `Sum`

**`readonly`** **Sum**: `"sum"` = `'sum'`

Sum aggregation type

***

### `Variance`

**`readonly`** **Variance**: `"var"` = `'var'`

Variance aggregation type


---

---
title: DateLevels
---

# Variable DateLevels

> **`const`** **DateLevels**: `object`

Levels for [DateDimension](../interfaces/interface.DateDimension.md)

## Type declaration

### `AggHours`

**`readonly`** **AggHours**: `"AggHours"` = `'AggHours'`

***

### `AggMinutesRoundTo1`

**`readonly`** **AggMinutesRoundTo1**: `"AggMinutesRoundTo1"` = `'AggMinutesRoundTo1'`

***

### `AggMinutesRoundTo15`

**`readonly`** **AggMinutesRoundTo15**: `"AggMinutesRoundTo15"` = `'AggMinutesRoundTo15'`

***

### `AggMinutesRoundTo30`

**`readonly`** **AggMinutesRoundTo30**: `"AggMinutesRoundTo30"` = `'AggMinutesRoundTo30'`

***

### `Days`

**`readonly`** **Days**: `"Days"` = `'Days'`

***

### `Hours`

**`readonly`** **Hours**: `"Hours"` = `'Hours'`

***

### `Minutes`

**`readonly`** **Minutes**: `"Minutes"` = `'Minutes'`

***

### `MinutesRoundTo15`

**`readonly`** **MinutesRoundTo15**: `"MinutesRoundTo15"` = `'MinutesRoundTo15'`

***

### `MinutesRoundTo30`

**`readonly`** **MinutesRoundTo30**: `"MinutesRoundTo30"` = `'MinutesRoundTo30'`

***

### `Months`

**`readonly`** **Months**: `"Months"` = `'Months'`

***

### `Quarters`

**`readonly`** **Quarters**: `"Quarters"` = `'Quarters'`

***

### `Seconds`

**`readonly`** **Seconds**: `"Seconds"` = `'Seconds'`

***

### `Weeks`

**`readonly`** **Weeks**: `"Weeks"` = `'Weeks'`

***

### `Years`

**`readonly`** **Years**: `"Years"` = `'Years'`


---

---
title: NumericOperators
---

# Variable NumericOperators

> **`const`** **NumericOperators**: `object`

Different numeric operators that can be used with numeric filters

## Type declaration

### `DoesntEqual`

**`readonly`** **DoesntEqual**: `"doesntEqual"` = `'doesntEqual'`

***

### `Equals`

**`readonly`** **Equals**: `"equals"` = `'equals'`

***

### `From`

**`readonly`** **From**: `"from"` = `'from'`

***

### `FromNotEqual`

**`readonly`** **FromNotEqual**: `"fromNotEqual"` = `'fromNotEqual'`

***

### `To`

**`readonly`** **To**: `"to"` = `'to'`

***

### `ToNotEqual`

**`readonly`** **ToNotEqual**: `"toNotEqual"` = `'toNotEqual'`


---

---
title: Attribute
---

# Interface Attribute

Common interface of an attribute as in a dimensional model.

An attribute is an extension of a [Column](interface.Column.md) in a generic [data set](interface.Data.md).

## Methods

### getSort

> **getSort**(): [`Sort`](../enumerations/enumeration.Sort.md)

Gets the sort definition.

#### Returns

[`Sort`](../enumerations/enumeration.Sort.md)

The Sort definition

***

### sort

> **sort**(`sort`): [`Attribute`](interface.Attribute.md)

Sorts the attribute by the given definition

#### Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `sort` | [`Sort`](../enumerations/enumeration.Sort.md) | Sort definition |

#### Returns

[`Attribute`](interface.Attribute.md)

A sorted instance of the attribute

## Properties

### expression

> **`readonly`** **expression**: `string`

Expression representing the element in a [JAQL query](https://developer.sisense.com/guides/querying/useJaql/).
It is typically populated automatically in the data model generated by the data model generator.

***

### name

> **name**: `string`

Element name

***

### type

> **`readonly`** **type**: `string`

Element type


---

---
title: BaseFilterConfig
---

# Interface BaseFilterConfig

Base filter configuration

## Properties

### Base Configurations

#### disabled

> **disabled**?: `boolean`

Boolean flag whether the filter is disabled

If not specified, the default value is `false`.

***

#### guid

> **`readonly`** **guid**?: `string`

Optional filter identifier

If not provided, a unique identifier will be generated.

***

#### locked

> **locked**?: `boolean`

Boolean flag whether the filter is locked

If not specified, the default value is `false`.


---

---
title: BaseMeasure
---

# Interface BaseMeasure

Common interface of a Base measure, which is aggregation over [Attribute](interface.Attribute.md).

## Methods

### format

> **format**(`format`): [`Measure`](interface.Measure.md)

Formats the measure according to the given `format` definition.

#### Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `format` | `string` | Format string |

#### Returns

[`Measure`](interface.Measure.md)

A formatted instance of this measure

***

### getFormat

> **getFormat**(): `string` \| `undefined`

Gets the formatting string of this measure.

#### Returns

`string` \| `undefined`

Formatting string

***

### getSort

> **getSort**(): [`Sort`](../enumerations/enumeration.Sort.md)

Gets the sort definition of this measure.

#### Returns

[`Sort`](../enumerations/enumeration.Sort.md)

***

### sort

> **sort**(`sort`): [`Measure`](interface.Measure.md)

Sorts the measure by the given `sort` definition.

#### Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `sort` | [`Sort`](../enumerations/enumeration.Sort.md) | Sort definition |

#### Returns

[`Measure`](interface.Measure.md)

A sorted instance of measure

## Properties

### aggregation

> **`readonly`** **aggregation**: `string`

Aggregation type

***

### attribute

> **`readonly`** **attribute**: [`Attribute`](interface.Attribute.md)

Aggregated attribute

***

### name

> **name**: `string`

Element name

***

### type

> **`readonly`** **type**: `string`

Element type


---

---
title: CalculatedMeasure
---

# Interface CalculatedMeasure

Interface for a Calculated Measure, extending [Measure](interface.Measure.md).

## See

[Using the JAQL to Add A Formula](https://developer.sisense.com/guides/querying/useJaql/#step-7-adding-a-formula)

## Methods

### format

> **format**(`format`): [`Measure`](interface.Measure.md)

Formats the measure according to the given `format` definition.

#### Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `format` | `string` | Format string |

#### Returns

[`Measure`](interface.Measure.md)

A formatted instance of this measure

***

### getFormat

> **getFormat**(): `string` \| `undefined`

Gets the formatting string of this measure.

#### Returns

`string` \| `undefined`

Formatting string

***

### getSort

> **getSort**(): [`Sort`](../enumerations/enumeration.Sort.md)

Gets the sort definition of this measure.

#### Returns

[`Sort`](../enumerations/enumeration.Sort.md)

***

### sort

> **sort**(`sort`): [`Measure`](interface.Measure.md)

Sorts the measure by the given `sort` definition.

#### Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `sort` | [`Sort`](../enumerations/enumeration.Sort.md) | Sort definition |

#### Returns

[`Measure`](interface.Measure.md)

A sorted instance of measure

## Properties

### context

> **context**: [`MeasureContext`](interface.MeasureContext.md)

Context of the calculated measure

***

### expression

> **expression**: `string`

Expression of the calculated measure

***

### name

> **name**: `string`

Element name

***

### type

> **`readonly`** **type**: `string`

Element type


---

---
title: CalculatedMeasureColumn
---

# Interface CalculatedMeasureColumn

Calculated Aggregate function applied to a [Column](interface.Column.md)(s).
When associated with a dimensional model, a Calculated Measure Column is
equivalent to a [CalculatedMeasure](interface.CalculatedMeasure.md).

## Properties

### context

> **context**: [`MeasureContext`](interface.MeasureContext.md)

Measure context

***

### expression

> **expression**: `string`

Expression representing the element in a [JAQL query](https://developer.sisense.com/guides/querying/useJaql/).

***

### name

> **name**: `string`

Column name

***

### title

> **title**?: `string`

Optional title for the column after aggregation.
If not specified, the column `name` will be used.

***

### type

> **type**: `string`

Measure type


---

---
title: Cell
---

# Interface Cell

Data cell, which is a storage unit in a [user-provided data set](interface.Data.md)
or [query result data set](interface.QueryResultData.md).

## Properties

### blur

> **blur**?: `boolean`

Boolean flag representing three states that can be visualized in a chart:
- `true`: the data value is in blur state
- `false`: the data value is in highlight state
- if not specified, the data value is neither in highlight nor blur state

***

### color

> **color**?: `string`

Color associated with the data value when visualized in a chart

***

### data

> **data**: `any`

Cell data value

***

### text

> **text**?: `string`

Display text


---

---
title: Column
---

# Interface Column

Column (or field) in a data set.
When associated with a dimensional model, a column is equivalent to an [Attribute](interface.Attribute.md).

## Properties

### name

> **name**: `string`

Column name

***

### type

> **type**: `string`

Column type


---

---
title: CustomFormulaContext
---

# Interface CustomFormulaContext

Context for a custom formula, as defined by `measureFactory.customFormula()`

## Indexable

 \[`key`: `string`\]: [`Attribute`](interface.Attribute.md) \| [`Filter`](interface.Filter.md) \| [`Measure`](interface.Measure.md)


---

---
title: Data
---

# Interface Data

Data set, which is made up of an array of [columns](interface.Column.md)
and a two-dimensional array of data [cells](interface.Cell.md).

This structure can be used for user-provided data in [Chart components](../../sdk-ui/interfaces/interface.ChartProps.md).

## Properties

### columns

> **columns**: [`Column`](interface.Column.md)[]

Array of [columns](interface.Column.md)

***

### rows

> **rows**: ([`Cell`](interface.Cell.md) \| `number` \| `string`)[][]

Two-dimensional array of data cells, each of which is either a string, number, or type [Cell](interface.Cell.md)


---

---
title: DateDimension
---

# Interface DateDimension

Date Dimension extending [Dimension](interface.Dimension.md).

## Methods

### getSort

> **getSort**(): [`Sort`](../enumerations/enumeration.Sort.md)

Gets the sort definition.

#### Returns

[`Sort`](../enumerations/enumeration.Sort.md)

The Sort definition

***

### sort

> **sort**(`sort`): [`Attribute`](interface.Attribute.md)

Sorts the attribute by the given definition

#### Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `sort` | [`Sort`](../enumerations/enumeration.Sort.md) | Sort definition |

#### Returns

[`Attribute`](interface.Attribute.md)

A sorted instance of the attribute

## Properties

### AggHours

> **`readonly`** **AggHours**: [`LevelAttribute`](interface.LevelAttribute.md)

Aggregated Hours level (for Live Models)

***

### AggMinutesRoundTo1

> **`readonly`** **AggMinutesRoundTo1**: [`LevelAttribute`](interface.LevelAttribute.md)

Aggregated Minutes (every minute) level

***

### AggMinutesRoundTo15

> **`readonly`** **AggMinutesRoundTo15**: [`LevelAttribute`](interface.LevelAttribute.md)

Aggregated Minutes (round to 15) level

***

### AggMinutesRoundTo30

> **`readonly`** **AggMinutesRoundTo30**: [`LevelAttribute`](interface.LevelAttribute.md)

Aggregated Minutes (round to 30) level

***

### Days

> **`readonly`** **Days**: [`LevelAttribute`](interface.LevelAttribute.md)

Days level

***

### expression

> **`readonly`** **expression**: `string`

Expression representing the element in a [JAQL query](https://developer.sisense.com/guides/querying/useJaql/).
It is typically populated automatically in the data model generated by the data model generator.

***

### Hours

> **`readonly`** **Hours**: [`LevelAttribute`](interface.LevelAttribute.md)

Hours level (for Live Models)

***

### Minutes

> **`readonly`** **Minutes**: [`LevelAttribute`](interface.LevelAttribute.md)

Minutes level (for Live Models)

***

### MinutesRoundTo15

> **`readonly`** **MinutesRoundTo15**: [`LevelAttribute`](interface.LevelAttribute.md)

Minutes (round to 15) level (for Live Models)

***

### MinutesRoundTo30

> **`readonly`** **MinutesRoundTo30**: [`LevelAttribute`](interface.LevelAttribute.md)

Minutes (round to 30) level (for Live Models)

***

### Months

> **`readonly`** **Months**: [`LevelAttribute`](interface.LevelAttribute.md)

Months level

***

### name

> **name**: `string`

Element name

***

### Quarters

> **`readonly`** **Quarters**: [`LevelAttribute`](interface.LevelAttribute.md)

Quarters level

***

### Seconds

> **`readonly`** **Seconds**: [`LevelAttribute`](interface.LevelAttribute.md)

Seconds level (for Live Models)

***

### type

> **`readonly`** **type**: `string`

Element type

***

### Weeks

> **`readonly`** **Weeks**: [`LevelAttribute`](interface.LevelAttribute.md)

Weeks level

***

### Years

> **`readonly`** **Years**: [`LevelAttribute`](interface.LevelAttribute.md)

Years level


---

---
title: Dimension
---

# Interface Dimension

Common interface of a Dimension, which serves as a container for [Attribute](interface.Attribute.md)(s)
and other [DateDimension](interface.DateDimension.md)(s).

## Methods

### getSort

> **getSort**(): [`Sort`](../enumerations/enumeration.Sort.md)

Gets the sort definition.

#### Returns

[`Sort`](../enumerations/enumeration.Sort.md)

The Sort definition

***

### sort

> **sort**(`sort`): [`Attribute`](interface.Attribute.md)

Sorts the attribute by the given definition

#### Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `sort` | [`Sort`](../enumerations/enumeration.Sort.md) | Sort definition |

#### Returns

[`Attribute`](interface.Attribute.md)

A sorted instance of the attribute

## Properties

### expression

> **`readonly`** **expression**: `string`

Expression representing the element in a [JAQL query](https://developer.sisense.com/guides/querying/useJaql/).
It is typically populated automatically in the data model generated by the data model generator.

***

### name

> **name**: `string`

Element name

***

### type

> **`readonly`** **type**: `string`

Element type


---

---
title: Filter
---

# Interface Filter

Base interface for filter. See [filterFactory](../factories/namespace.filterFactory/index.md) for how to create filters.

## Properties

### filterType

> **`readonly`** **filterType**: `string`

Filter type

***

### name

> **name**: `string`

Element name

***

### type

> **`readonly`** **type**: `string`

Element type


---

---
title: FilterRelations
---

# Interface FilterRelations

Representation of filter logical relations (AND/OR)

## Properties

### left

> **left**: [`FilterRelationsNode`](../type-aliases/type-alias.FilterRelationsNode.md)

***

### operator

> **operator**: `"AND"` \| `"OR"`

***

### right

> **right**: [`FilterRelationsNode`](../type-aliases/type-alias.FilterRelationsNode.md)


---

---
title: LevelAttribute
---

# Interface LevelAttribute

Date Level Attribute associated with a granularity - for example, Years, Quarters, Months, Days.

## Methods

### format

> **format**(`format`): [`LevelAttribute`](interface.LevelAttribute.md)

Gets a formatted instance with the given definition.

#### Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `format` | `string` | Format string |

#### Returns

[`LevelAttribute`](interface.LevelAttribute.md)

A formatted instance of this level attribute

***

### getFormat

> **getFormat**(): `string` \| `undefined`

String formatting of this instance.

#### Returns

`string` \| `undefined`

string formatting

***

### getSort

> **getSort**(): [`Sort`](../enumerations/enumeration.Sort.md)

Gets the sort definition.

#### Returns

[`Sort`](../enumerations/enumeration.Sort.md)

The Sort definition

***

### sort

> **sort**(`sort`): [`Attribute`](interface.Attribute.md)

Sorts the attribute by the given definition

#### Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `sort` | [`Sort`](../enumerations/enumeration.Sort.md) | Sort definition |

#### Returns

[`Attribute`](interface.Attribute.md)

A sorted instance of the attribute

## Properties

### expression

> **`readonly`** **expression**: `string`

Expression representing the element in a [JAQL query](https://developer.sisense.com/guides/querying/useJaql/).
It is typically populated automatically in the data model generated by the data model generator.

***

### granularity

> **`readonly`** **granularity**: `string`

Granularity of the level. See supported granularity values at [DateLevels](../variables/variable.DateLevels.md).

***

### name

> **name**: `string`

Element name

***

### type

> **`readonly`** **type**: `string`

Element type


---

---
title: Measure
---

# Interface Measure

Base interface for measure, which is typically numeric aggregation over [Attribute](interface.Attribute.md)(s).
See [measureFactory](../factories/namespace.measureFactory/index.md) for how to create measures.

## Methods

### format

> **format**(`format`): [`Measure`](interface.Measure.md)

Formats the measure according to the given `format` definition.

#### Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `format` | `string` | Format string |

#### Returns

[`Measure`](interface.Measure.md)

A formatted instance of this measure

***

### getFormat

> **getFormat**(): `string` \| `undefined`

Gets the formatting string of this measure.

#### Returns

`string` \| `undefined`

Formatting string

***

### getSort

> **getSort**(): [`Sort`](../enumerations/enumeration.Sort.md)

Gets the sort definition of this measure.

#### Returns

[`Sort`](../enumerations/enumeration.Sort.md)

***

### sort

> **sort**(`sort`): [`Measure`](interface.Measure.md)

Sorts the measure by the given `sort` definition.

#### Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `sort` | [`Sort`](../enumerations/enumeration.Sort.md) | Sort definition |

#### Returns

[`Measure`](interface.Measure.md)

A sorted instance of measure

## Properties

### name

> **name**: `string`

Element name

***

### type

> **`readonly`** **type**: `string`

Element type


---

---
title: MeasureColumn
---

# Interface MeasureColumn

Aggregate function applied to a [Column](interface.Column.md).
When associated with a dimensional model, a Measure Column is equivalent to a [Measure](interface.Measure.md).

## Properties

### aggregation

> **aggregation**?: `string`

Aggregate function -- for example, `sum`, `count`.
If not specified, default value, `sum`, will be used.

***

### name

> **name**: `string`

Column name

***

### title

> **title**?: `string`

Optional title for the column after aggregation.
If not specified, the column `name` will be used.


---

---
title: MeasureContext
---

# Interface MeasureContext

Context of a calculated measure.

## Indexable

 \[`propName`: `string`\]: `any`


---

---
title: MembersFilterConfig
---

# Interface MembersFilterConfig

Configurations for members filter

## Properties

### Base Configurations

#### disabled

> **disabled**?: `boolean`

Boolean flag whether the filter is disabled

If not specified, the default value is `false`.

***

#### guid

> **`readonly`** **guid**?: `string`

Optional filter identifier

If not provided, a unique identifier will be generated.

***

#### locked

> **locked**?: `boolean`

Boolean flag whether the filter is locked

If not specified, the default value is `false`.

### Extended Configurations

#### deactivatedMembers

> **deactivatedMembers**?: `string`[]

Optional list of members to be shown as deactivated in the `MemberFilterTile` component.

This list should not contain members that are already included in the filter.

***

#### enableMultiSelection

> **enableMultiSelection**?: `boolean`

Boolean flag whether selection of multiple members is enabled

If not specified, the default value is `true`.

***

#### excludeMembers

> **excludeMembers**?: `boolean`

Boolean flag whether selected members are excluded or included in the filter

If not specified, the default value is false.

### Other

#### backgroundFilter

> **backgroundFilter**?: [`Filter`](interface.Filter.md)

Optional filter to be applied in the background


---

---
title: PivotAttribute
---

# Interface PivotAttribute

Wrapped attribute with additional options for pivot table

## Properties

### attribute

> **attribute**: [`Attribute`](interface.Attribute.md)

***

### includeSubTotals

> **includeSubTotals**?: `boolean`

***

### name

> **name**?: `string`

Custom name to override the default attribute name in pivot table headers.
If provided, this will be used as the display title in the pivot table.

***

### sort

> **sort**?: [`PivotRowsSort`](../type-aliases/type-alias.PivotRowsSort.md)


---

---
title: PivotMeasure
---

# Interface PivotMeasure

Wrapped measure with additional options for pivot table

## Properties

### measure

> **measure**: [`Measure`](interface.Measure.md)

***

### totalsCalculation

> **totalsCalculation**?: [`TotalsCalculation`](../type-aliases/type-alias.TotalsCalculation.md)


---

---
title: PivotQueryResultData
---

# Interface PivotQueryResultData

Pivot query result data set, which includes both a flat table of [QueryResultData](interface.QueryResultData.md) and grids of tree structures.

## Properties

### Table

#### table

> **table**: [`QueryResultData`](interface.QueryResultData.md)

Flat table structure

### Tree Structures

#### grids

> **grids**?: `object`

Grids of tree structures

##### Type declaration

> ###### `grids.columns`
>
> **columns**: [`PivotGrid`](../type-aliases/type-alias.PivotGrid.md)
>
> ###### `grids.corner`
>
> **corner**: [`PivotGrid`](../type-aliases/type-alias.PivotGrid.md)
>
> ###### `grids.rows`
>
> **rows**: [`PivotGrid`](../type-aliases/type-alias.PivotGrid.md)
>
> ###### `grids.values`
>
> **values**: [`PivotGrid`](../type-aliases/type-alias.PivotGrid.md)
>
>


---

---
title: QueryResultData
---

# Interface QueryResultData

Query result data set, which is made of an array of [columns](interface.Column.md)
and a two-dimensional array of data [cells](interface.Cell.md).

## Properties

### columns

> **columns**: [`Column`](interface.Column.md)[]

Array of [columns](interface.Column.md)

***

### rows

> **rows**: [`Cell`](interface.Cell.md)[][]

Two-dimensional array of data [cells](interface.Cell.md)


---

---
title: AnyObject
---

# Type alias AnyObject

> **AnyObject**: `Record`\< `string`, `any` \>

Abstract object with any unknown values


---

---
title: DataSource
---

# Type alias DataSource

> **DataSource**: [`DataSourceInfo`](type-alias.DataSourceInfo.md) \| `string`

Data source for queries to run against


---

---
title: DataSourceInfo
---

# Type alias DataSourceInfo

> **DataSourceInfo**: `object`

Info of data source

## Type declaration

### `title`

**title**: `string`

***

### `type`

**type**: `"elasticube"` \| `"live"`


---

---
title: FilterRelationsNode
---

# Type alias FilterRelationsNode

> **FilterRelationsNode**: [`Filter`](../interfaces/interface.Filter.md) \| [`FilterRelations`](../interfaces/interface.FilterRelations.md) \| [`Filter`](../interfaces/interface.Filter.md)[]

A node or a subtree of a [FilterRelations](../interfaces/interface.FilterRelations.md) tree


---

---
title: ForecastFormulaOptions
---

# Type alias ForecastFormulaOptions

> **ForecastFormulaOptions**: `object`

Forecast formula options.

## Type declaration

### `confidenceInterval`

**confidenceInterval**?: `number`

Confidence interval showing the probabilistic upper and lower limits of the
forecasted series according to the uncertainty level. The valid range is (0.8 <= X < 1).

#### Default Value

```ts
0.8
```

***

### `endDate`

**endDate**?: `Date` \| `string`

End date of the time series data that the forecasting model will be
trained on. This parameter can be used to discard the end of the series.
Specify a ISO 8601 date string or Date object.

***

### `forecastHorizon`

**forecastHorizon**?: `number`

Number of data points to be predicted.
The accepted value range is between 1-1,000

#### Default Value

```ts
3
```

***

### `lowerBound`

**lowerBound**?: `number`

Expected lower limit to improve the forecast accuracy when reaching
the limit. Note that values in the confidence interval can exceed
this limit.

***

### `modelType`

**modelType**?: `"auto"` \| `"autoArima"` \| `"holtWinters"` \| `"prophet"`

Forecasting model type. The 'auto' option automatically
fits the best combination of models.

#### Default Value

```ts
"auto"
```

***

### `roundToInt`

**roundToInt**?: `boolean`

Boolean flag to round the predicted result to an integer if set to true.
Otherwise, the predicted result is left as a float

#### Default Value

```ts
false
```

***

### `startDate`

**startDate**?: `Date` \| `string`

Start date of the time series data that the forecasting model will
be trained on. This parameter can be used to discard the beginning of
the series. Specify a ISO 8601 date string or Date object.

***

### `upperBound`

**upperBound**?: `number`

Expected upper limit to improve the forecast accuracy when reaching
the limit. Note that values in the confidence interval can exceed
this limit.


---

---
title: PivotGrandTotals
---

# Type alias PivotGrandTotals

> **PivotGrandTotals**: `object`

Data options for grand totals of a pivot table

## Type declaration

### `columns`

**columns**?: `boolean`

***

### `rows`

**rows**?: `boolean`


---

---
title: PivotGrid
---

# Type alias PivotGrid

> **PivotGrid**: ([`TreeNode`](type-alias.TreeNode.md) \| `string`)[][]

Grid of tree nodes


---

---
title: PivotRowsSort
---

# Type alias PivotRowsSort

> **PivotRowsSort**: `object`

Sorting configuration for pivot "rows".

This configuration allows sorting pivot "rows" either by their data or by data in a specific "values" column.

## Example

Examples of sorting configurations for various scenarios:

(1) Row sorted in ascending order by its data:
```ts
{ direction: 'sortAsc' }
```

(2) Row sorted in descending order by data in the first "values" column (index 0):
```ts
{
   direction: 'sortDesc',
   by: {
     valuesIndex: 0,
   }
}
```

(3) Row sorted in ascending order by data in the second "values" column (index 1) under the "columns" values of "Female" (for Gender) and "0-18" (for AgeRange):
```ts
{
   direction: 'sortAsc',
   by: {
     valuesIndex: 1,
     columnsMembersPath: ['Female', '0-18']
   }
}
```

## Type declaration

### `by`

**by**?: `object`

Sorting target configuration, allowing sorting "rows" by the data in a specific "values" column

> #### `by.columnsMembersPath`
>
> **columnsMembersPath**?: (`number` \| `string`)[]
>
> Path to the target column if selected "columns" items (dimensions) are involved
>
> #### `by.valuesIndex`
>
> **valuesIndex**?: `number`
>
> Index of the target "values" item (measure)
>
>

***

### `direction`

**direction**: [`SortDirection`](type-alias.SortDirection.md)

Sorting direction, either in Ascending order, Descending order, or None


---

---
title: SortDirection
---

# Type alias SortDirection

> **SortDirection**: `"sortAsc"` \| `"sortDesc"` \| `"sortNone"`

Sorting direction, either in Ascending order, Descending order, or None


---

---
title: TotalsCalculation
---

# Type alias TotalsCalculation

> **TotalsCalculation**: `"avg"` \| `"max"` \| `"median"` \| `"min"` \| `"sum"`


---

---
title: TreeNode
---

# Type alias TreeNode

> **TreeNode**: `object`

Tree node representing data in a pivot table

## Type declaration

### `children`

**children**?: [`TreeNode`](type-alias.TreeNode.md)[]

List of children of this node

***

### `data`

**data**?: `any`[]

Data list for rows nodes

***

### `index`

**index**?: `number`

Index in data list for columns nodes

***

### `value`

**value**?: `string`

Raw data


---

---
title: TrendFormulaOptions
---

# Type alias TrendFormulaOptions

> **TrendFormulaOptions**: `object`

Trend formula options.

## Type declaration

### `ignoreAnomalies`

**ignoreAnomalies**?: `boolean`

Boolean flag that enables the function to automatically identify and ignore
anomalous values in the series. This can be particularly useful when you want
to maintain the integrity of your analysis by avoiding potential outliers.

#### Default Value

```ts
false
```

***

### `modelType`

**modelType**?: `"advancedSmoothing"` \| `"linear"` \| `"localEstimates"` \| `"logarithmic"`

Trend analysis model type to be used for the operation.

#### Default Value

```ts
"linear"
```

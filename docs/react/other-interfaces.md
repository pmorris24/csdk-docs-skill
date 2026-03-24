---
title: EditModeConfig
---

# Interface EditModeConfig

Edit mode configuration

## Properties

### applyChangesAsBatch

> **applyChangesAsBatch**?: `object`

Configuration for the edit mode user experience

#### Type declaration

> ##### `applyChangesAsBatch.enabled`
>
> **enabled**: `boolean`
>
> If `true`, a history of changes will be accumulated during editing,
> and users may undo/redo through the history of changes made during the current edit.
>
> The current layout state will be applied to the dashboard when the user clicks 'Apply',
> or discarded when the user clicks 'Cancel'.
>
> If `false`, the layout changes will be applied immediately after the user makes each change,
> without confirmation or the ability to cancel/undo.
>
> @default: true
>
> ##### `applyChangesAsBatch.historyLimit`
>
> **historyLimit**?: `number`
>
> The maximum number of history items to keep while applying changes in batch mode.
>
> History will be temporarily stored in the browser during editing.
>
> ###### Default
>
> ```ts
> 20
> ```
>
>

***

### enabled

> **enabled**: `boolean`

If `true` the editable layout feature is enabled for the end user.

If `false` the end user is unable to edit the layout of widgets in the dashboard.

When persistence is enabled combined with `editMode` for a Fusion dashboard, changes to the layout will saved to Fusion.

#### Default

```ts
false
```

***

### isEditing

> **isEditing**?: `boolean`

Indicates whether the dashboard is currently in edit mode.

If set, this controls whether editing is currently in progress,
which by default is automatically managed from UI interactions with the dashboard toolbar menu/buttons.

***

### showDragHandleIcon

> **showDragHandleIcon**?: `boolean`

Determines whether the drag handle icon should be displayed on the
header of each widget when layout editing is possible.

#### Default

```ts
true
```


---

---
title: FontsLoaderSettings
---

# Interface FontsLoaderSettings

Settings for fonts loading

## Properties

### fonts

> **fonts**: [`ThemeSettingsFont`](interface.ThemeSettingsFont.md)[]

List of fonts


---

---
title: GetHierarchyModelsParams
---

# Interface GetHierarchyModelsParams

Parameters for [useGetHierarchyModels](../fusion-assets/function.useGetHierarchyModels.md) hook.

## Properties

### alwaysIncluded

> **alwaysIncluded**?: `boolean`

A flag indicating whether to filter the retrieved hierarchies based on the `alwaysIncluded` field.

When set to true, only hierarchies with `alwaysIncluded: true` will be returned.
When set to false, only hierarchies with `alwaysIncluded: false` will be returned.
If not specified, all hierarchies will be returned.

***

### dataSource

> **dataSource**?: [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md)

The data source from which to retrieve the hierarchies - e.g. `Sample ECommerce`.

If not specified, the query will use the `defaultDataSource` specified in the parent Sisense Context.

***

### dimension

> **dimension**: [`Attribute`](../../sdk-data/interfaces/interface.Attribute.md)

The dimension for which to retrieve the hierarchies.

***

### enabled

> **enabled**?: `boolean`

Boolean flag to control if the hook is executed

If not specified, the default value is `true`

***

### ids

> **ids**?: `string`[]

A list of hierarchy IDs to retrieve specific hierarchies.


---

---
title: GetSharedFormulaParams
---

# Interface GetSharedFormulaParams

Parameters for [useGetSharedFormula](../fusion-assets/function.useGetSharedFormula.md) hook.

## Properties

### dashboardOid

> **dashboardOid**: `string`

Dashboard identifier

***

### dataSource

> **dataSource**?: [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md)

Data source - e.g. `Sample ECommerce`

***

### enabled

> **enabled**?: `boolean`

Boolean flag to control if the hook is executed

If not specified, the default value is `true`

***

### name

> **name**?: `string`

Formula name

***

### oid

> **oid**?: `string`

Formula identifier


---

---
title: GradientStop
---

# Interface GradientStop

A gradient stop defining a color at a specific position in the gradient.

## Example

```ts
const stop: GradientStop = {
  position: 0.5,
  color: '#ffffff'
};
```

## Properties

### color

> **color**: `string`

Color at this position. Can be any valid CSS color value.

***

### position

> **position**: `number`

Position in the gradient where 0 is the start and 1 is the end.
Must be between 0 and 1 inclusive.


---

---
title: Hierarchy
---

# Interface Hierarchy

Hierarchy with a title and associated levels.

## Properties

### levels

> **levels**: [`Attribute`](../../sdk-data/interfaces/interface.Attribute.md)[]

Hierarchy levels.

***

### title

> **title**: `string`

Hierarchy title.


---

---
title: HierarchyModel
---

# Interface HierarchyModel

Model of Sisense hierarchy defined in the abstractions of Compose SDK.

## Properties

### id

> **id**: `string`

Unique identifier of the hierarchy.

***

### levels

> **levels**: [`Attribute`](../../sdk-data/interfaces/interface.Attribute.md)[]

Hierarchy levels.

***

### title

> **title**: `string`

Hierarchy title.


---

---
title: RadialGradientColor
---

# Interface RadialGradientColor

Radial gradient color configuration.

## Example

```ts
const radialGradient: RadialGradientColor = {
  type: 'radial',
  center: { centerX: 0.5, centerY: 0.5, radius: 0.8 },
  stops: [
    { position: 0, color: '#ff0000' },
    { position: 1, color: '#0000ff' }
  ]
};
```

## Properties

### center

> **center**: [`RadialGradientConfig`](interface.RadialGradientConfig.md)

Center and radius configuration

***

### stops

> **stops**: *readonly* [`GradientStop`](interface.GradientStop.md)[]

Color stops along the gradient

***

### type

> **type**: `"radial"`

Type discriminator for radial gradients


---

---
title: RadialGradientConfig
---

# Interface RadialGradientConfig

Radial gradient configuration.

## Example

```ts
const radial: RadialGradientConfig = {
  centerX: 0.5,
  centerY: 0.5,
  radius: 0.8
};
```

## Properties

### centerX

> **centerX**: `number`

X coordinate of the center point (0-1)

***

### centerY

> **centerY**: `number`

Y coordinate of the center point (0-1)

***

### radius

> **radius**: `number`

Radius of the gradient (0-1)


---

---
title: StackableStyleOptions
---

# Interface StackableStyleOptions

Configuration options that define functional style of the various elements of stackable charts, like Column or Bar

## Properties

### dataLimits

> **dataLimits**?: [`DataLimits`](interface.DataLimits.md)

Data limit for series or categories that will be plotted

***

### height

> **height**?: `number`

Total height of the component, which is considered in the following order of priority:

1. Value passed to this property (in pixels).
2. Height of the container wrapping this component
3. Default value of 400px (for component without header) or 425px (for component with header).

***

### legend

> **legend**?: [`LegendOptions`](../type-aliases/type-alias.LegendOptions.md)

Configuration for legend - a key that provides information about the data series or colors used in chart

***

### markers

> **markers**?: [`Markers`](../type-aliases/type-alias.Markers.md)

Configuration for markers - symbols or data points that highlight specific values

***

### navigator

> **navigator**?: [`Navigator`](../type-aliases/type-alias.Navigator.md)

Configuration for navigator - zoom/pan tool for large datasets in a chart

***

### series

> **series**?: `object`

Configuration for series styling

#### Type declaration

> ##### `series.borderRadius`
>
> **borderRadius**?: `number` \| `string`
>
> The corner radius of the border surrounding each column or bar.
> A number signifies pixels.
> A percentage string, like for example 50%, signifies a relative size.
>
> ###### Default
>
> ```ts
> 0
> ```
>
> ##### `series.groupPadding`
>
> **groupPadding**?: `number`
>
> Padding between each value groups, in x axis units.
>
> ###### Default
>
> ```ts
> 0.1
> ```
>
> ##### `series.padding`
>
> **padding**?: `number`
>
> Padding between each column or bar, in x axis units.
>
> ###### Default
>
> ```ts
> 0.01
> ```
>
>

***

### seriesLabels

> **seriesLabels**?: [`SeriesLabels`](../type-aliases/type-alias.SeriesLabels.md)

Configuration for series labels - titles/names identifying data series in a chart

***

### subtype

> **subtype**?: [`StackableSubtype`](../type-aliases/type-alias.StackableSubtype.md)

Subtype of stackable chart

***

### totalLabels

> **totalLabels**?: [`TotalLabels`](../type-aliases/type-alias.TotalLabels.md)

Configuration for total labels
Only supported for stacked chart subtypes

***

### width

> **width**?: `number`

Total width of the component, which is considered in the following order of priority:

1. Value passed to this property (in pixels)
2. Width of the container wrapping this component
3. Default value of 400px

***

### xAxis

> **xAxis**?: [`AxisLabel`](../type-aliases/type-alias.AxisLabel.md)

Configuration for X axis

***

### y2Axis

> **y2Axis**?: [`AxisLabel`](../type-aliases/type-alias.AxisLabel.md)

Configuration for second Y axis

***

### yAxis

> **yAxis**?: [`AxisLabel`](../type-aliases/type-alias.AxisLabel.md)

Configuration for Y axis


---

---
title: TableProps
---

# Interface TableProps

Props of the [Table](../data-grids/function.Table.md) component.

## Properties

### Data

#### dataSet

> **dataSet**?: [`Data`](../../sdk-data/interfaces/interface.Data.md) \| [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md)

Data set for a chart using one of the following options. If neither option is specified, the chart
will use the `defaultDataSource` specified in the parent `SisenseContextProvider`
component.

(1) Sisense data source name as a string. For example, `'Sample ECommerce'`. Typically, you
retrieve the data source name from a data model you create using the `get-data-model`
[command](https://developer.sisense.com/guides/sdk/guides/cli.html) of the Compose SDK CLI. The chart
connects to the data source, executes a query, and loads the data as specified in
`dataOptions`, `filters`, and `highlights`.

To learn more about using data from a Sisense data source, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#sisense-data).

OR

(2) Explicit [`Data`](../../sdk-data/interfaces/interface.Data.md), which is made up of an array of
[`Column`](../../sdk-data/interfaces/interface.Column.md) objects and a two-dimensional array of row data. This approach
allows the chart component to be used with any data you provide.

To learn more about using data from an external data source, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#explicit-data).

Example data in the proper format:

```ts
const sampleData = {
  columns: [
    { name: 'Years', type: 'date' },
    { name: 'Quantity', type: 'number' },
    { name: 'Units', type: 'number' },
  ],
  rows: [
    ['2019', 5500, 1500],
    ['2020', 4471, 7000],
    ['2021', 1812, 5000],
    ['2022', 5001, 6000],
    ['2023', 2045, 4000],
  ],
};
```

***

#### filters

> **filters**?: [`FilterRelations`](../../sdk-data/interfaces/interface.FilterRelations.md) \| [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Filters that will slice query results

### Callbacks

#### onDataReady

> **onDataReady**?: (`data`) => [`Data`](../../sdk-data/interfaces/interface.Data.md)

A callback that allows to modify data immediately after it has been retrieved.
It can be used to inject modification of queried data.

##### Parameters

| Parameter | Type |
| :------ | :------ |
| `data` | [`Data`](../../sdk-data/interfaces/interface.Data.md) |

##### Returns

[`Data`](../../sdk-data/interfaces/interface.Data.md)

### Representation

#### dataOptions

> **dataOptions**: [`TableDataOptions`](interface.TableDataOptions.md)

Configurations for how to interpret and present the data passed to the component

***

#### styleOptions

> **styleOptions**?: [`TableStyleOptions`](interface.TableStyleOptions.md)

Configurations for how to style and present a table's data.


---

---
title: TableStyleOptions
---

# Interface TableStyleOptions

Configuration options that define functional style of the various elements of the Table Component

## Properties

### columns

> **columns**?: `object`

Columns options

#### Type declaration

> ##### `columns.alternatingColor`
>
> **alternatingColor**?: [`TableColorOptions`](../type-aliases/type-alias.TableColorOptions.md)
>
> Alternating color for columns
>
> ##### `columns.width`
>
> **width**?: `"auto"` \| `"content"`
>
> Modes of columns width
> 'auto' - all columns will have the same width and fit the table width (no horizontal scroll)
> 'content' - columns width will be based on content (default option)
>
>

***

### header

> **header**?: `object`

Header options

#### Type declaration

> ##### `header.color`
>
> **color**?: [`TableColorOptions`](../type-aliases/type-alias.TableColorOptions.md)
>
> Color of header
>
>

***

### height

> **height**?: `number`

Total height of the component, which is considered in the following order of priority:

1. Value passed to this property (in pixels).
2. Height of the container wrapping this component
3. Default value of 500px (for component without header) or 525px (for component with header).

***

### paddingHorizontal

> **paddingHorizontal**?: `number`

Horizontal padding around whole table
Default value is 20px

***

### paddingVertical

> **paddingVertical**?: `number`

Vertical padding around whole table
Default value is 20px

***

### rows

> **rows**?: `object`

Rows options

#### Type declaration

> ##### `rows.alternatingColor`
>
> **alternatingColor**?: [`TableColorOptions`](../type-aliases/type-alias.TableColorOptions.md)
>
> Alternating color for rows
>
>

***

### rowsPerPage

> **rowsPerPage**?: `number`

Number of rows per page

Default value is 25

***

### width

> **width**?: `number`

Total width of the component, which is considered in the following order of priority:

1. Value passed to this property (in pixels)
2. Width of the container wrapping this component
3. Default value of 400px


---

---
title: UseGetSharedFormulaParams
---

# Interface UseGetSharedFormulaParams

Params of the [useGetSharedFormula](../fusion-assets/function.useGetSharedFormula.md) hook

Can consist either of an oid or a name/dataSource pair

## Properties

### dataSource

> **dataSource**?: [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md)

Data source - e.g. `Sample ECommerce`

***

### enabled

> **enabled**?: `boolean`

Boolean flag to control if the hook is executed

If not specified, the default value is `true`

***

### name

> **name**?: `string`

Formula name

***

### oid

> **oid**?: `string`

Formula identifier

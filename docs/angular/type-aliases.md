---
title: AppConfig
---

# Type alias AppConfig

> **AppConfig**: `object`

Application configuration

## Type declaration

### `accessibilityConfig`

**accessibilityConfig**?: `object`

Accessibility configuration. Set the `accessibilityConfig.enabled` property to `true` to enable accessibility features for charts built with Highcharts.

Once the accessibility configuration in enabled, you can use the default descriptions or choose to create custom configurations for the descriptions of a chart, its axes, its series, and values description formatting. To create custom configurations, use the `highchartsOptions` object that is passed to the [BeforeRenderHandler](type-alias.BeforeRenderHandler.md) of the chart's `onBeforeRender` callback. Modify the object using the accessibility options as described in the [Accessibility module documentation](https://www.highcharts.com/docs/accessibility/accessibility-module).

Note that enabling accessibility also causes markers to appear in charts even if they are disabled using the chart's `styleOptions`.

This feature is in alpha.

> #### `accessibilityConfig.enabled`
>
> **enabled**?: `boolean`
>
> Whether to enable accessibility features
>
> If not specified, the default value is `false`
>
>

***

### `chartConfig`

**chartConfig**?: `object`

Global configuration for some specific aspects of data visualizations.

> #### `chartConfig.tabular`
>
> **tabular**?: `object`
>
> `Table` and `PivotTable` configuration
>
> > ##### `tabular.alwaysShowResultsPerPage`
> >
> > **alwaysShowResultsPerPage**?: `boolean`
> >
> > Boolean flag whether to always show the results per page select
> >
> > If `true`, the results per page select will be shown even if there is only one page of results.
> > Currently only supported for `PivotTable`.
> >
> > ###### Default
> >
> > ```ts
> > false
> > ```
> >
> > ##### `tabular.htmlContent`
> >
> > **htmlContent**?: `object`
> >
> > Configuration for HTML content in `Table` and `PivotTable`
> >
> > > ###### `htmlContent.enabled`
> > >
> > > **enabled**?: `boolean`
> > >
> > > If true, the contents of table and pivot table cells are rendered as HTML instead of text.
> > >
> > > **Note**: The [StyledColumn.isHtml](../interfaces/interface.StyledColumn.md#ishtml) property of columns in `dataOptions` are of higher precedence, and will therefore override this setting.
> > >
> > > ###### Default
> > >
> > > ```ts
> > > true
> > > ```
> > >
> > > ###### `htmlContent.sanitizeContents`
> > >
> > > **sanitizeContents**?: `boolean`
> > >
> > > Enables sanitization of HTML content before rendering to prevent XSS attacks.
> > >
> > > ###### Default
> > >
> > > ```ts
> > > true
> > > ```
> > >
> > >
> >
> >
>
>

***

### `dateConfig`

**dateConfig**?: [`DateConfig`](type-alias.DateConfig.md)

Date Configurations

***

### `errorBoundaryConfig`

**errorBoundaryConfig**?: `object`

Configuration of the component that is rendered in case of an error

> #### `errorBoundaryConfig.alwaysShowErrorText`
>
> **alwaysShowErrorText**?: `boolean`
>
> Whether to show error text without hovering over the error icon
>
> If not specified, the default value is `false`
>
>

***

### `jumpToDashboardConfig`

**jumpToDashboardConfig**?: `object`

Configuration of the Jump To Dashboard feature

This feature is currently in Beta.

**Note:** Only widgets that are configured using the Fusion UI as documented
[here](https://docs.sisense.com/main/SisenseLinux/jump-to-dashboard.htm?tocpath=Add-ons%7C_____2#ConfiguringJTDPerWidget)
are supported in Compose SDK.

Widgets that are configured using an older version of Jump To Dashboard, or via scripts, are not supported.

Known limitations:
- Jump To Dashboard is not currently supported for Pivot widgets.
- Target dashboards are always opened in a popup window, options to open in new tab and new window are not supported.
- Show 'Header' and 'Dashboards panel' options are not supported (only relevant to Fusion).
- 'Reset filters after JTD' is not supported, since changes are never saved to the target dashboard using Compose SDK.

The following Jump To Dashboard configuration is supported:
  - Target dashboard set by Id, with configurable display title
  - 'Popup window' display type ('Allow Resize' not supported)
  - Display filter panel on the target dashboard (true/false)
  - Navigation setting (Click / Right click)
    - Note: 'Keep changes made by user' is not supported, since changes are never saved to the target dashboard using Compose SDK.
  - Apply filters to the target dashboard (select)
  - Merge target dashboard filters (true/false)

> #### `jumpToDashboardConfig.enabled`
>
> **enabled**?: `boolean`
>
> Whether to enable or disable the Jump To Dashboard feature
>
> If not specified, the default value is `true`
>
>

***

### `loadingIndicatorConfig`

**loadingIndicatorConfig**?: [`LoadingIndicatorConfig`](../../sdk-ui/type-aliases/type-alias.LoadingIndicatorConfig.md)

Loading Indicator Configurations

***

### `locale`

**locale**?: `Locale`

A [date-fns Locale](https://date-fns.org/v2.30.0/docs/Locale)

***

### `queryCacheConfig`

**queryCacheConfig**?: `object`

Query Cache Configurations.

See [Client query caching guide](/guides/sdk/guides/client-query-caching.html) for more details.

> #### `queryCacheConfig.enabled`
>
> **enabled**?: `boolean`
>
> Whether to enable client-side query caching.
>
> If not specified, the default value is `false`
>
>

***

### `queryLimit`

**queryLimit**?: `number`

Query limit (max rows count that will be fetched in query)

#### Default

```ts
20000
```

***

### `tabberConfig`

**tabberConfig**?: `object`

Configuration of the tabber widgets feature

Only tabber widgets that are configured using the Fusion UI as documented [here](https://docs.sisense.com/main/SisenseLinux/tabber.htm#Creating) are supported.

> #### `tabberConfig.enabled`
>
> **enabled**?: `boolean`
>
> Whether to enable tabber widget support
>
> If not specified, the default value is `true`
>
> ::: warning Deprecated
> Tabber widgets are now supported by default and this property is no longer needed.
> :::
>
>

***

### `trackingConfig`

**trackingConfig**?: `object`

Tracking configuration

> #### `trackingConfig.onTrackingEvent`
>
> **onTrackingEvent**?: (`payload`) => `void`
>
> Callback to be invoked when tracking event occurs
>
> ##### Parameters
>
>
> | Parameter | Type |
> | :------ | :------ |
> | `payload` | `TrackingEventDetails` |
>
>
> ##### Returns
>
> `void`
>
>
>
>

***

### `translationConfig`

**translationConfig**?: [`TranslationConfig`](type-alias.TranslationConfig.md)

Translation Configuration


---

---
title: AreaSubtype
---

# Type alias AreaSubtype

> **AreaSubtype**: `"area/basic"` \| `"area/spline"` \| `"area/stacked"` \| `"area/stacked100"` \| `"area/stackedspline"` \| `"area/stackedspline100"`

Property of [AreaStyleOptions](../interfaces/interface.AreaStyleOptions.md)

Subtype of AreaChart

**Values**

- `area/basic` - straight lines showing areas that overlap so that smaller areas appear on top of larger areas and cover them.
- `area/stacked` - straight lines showing areas that are stacked on top of each other and do not overlap.
- `area/stacked100` - straight lines showing areas that are stacked on top of each other but do not overlap so that the combined area is stretched to the top representing 100%.
- `area/spline` - curved lines showing areas that overlap so that smaller areas appear on top of larger areas and cover them.
- `area/stackedspline` - curved lines showing areas that are stacked on top of each other and do not overlap.
- `area/stackedspline100` - curved lines showing areas that are stacked on top of each other but do not overlap so that the combined area is stretched to the top representing 100%.


---

---
title: AreamapChartType
---

# Type alias AreamapChartType

> **AreamapChartType**: `"areamap"`

Areamap chart types


---

---
title: AreamapDataPointEvent
---

# Type alias AreamapDataPointEvent

> **AreamapDataPointEvent**: `object`

## Type declaration

### `nativeEvent`

**nativeEvent**: `MouseEvent`

Native MouseEvent

***

### `point`

**point**: [`AreamapDataPoint`](../../sdk-ui/type-aliases/type-alias.AreamapDataPoint.md)

Data point that was clicked


---

---
title: AreamapDataPointEventHandler
---

# Type alias AreamapDataPointEventHandler

> **AreamapDataPointEventHandler**: (`event`) => `void`

Click handler for when a data point on Areamap is clicked.

## Parameters

| Parameter | Type |
| :------ | :------ |
| `event` | [`AreamapDataPointEvent`](type-alias.AreamapDataPointEvent.md) |

## Returns

`void`


---

---
title: AxisLabel
---

# Type alias AxisLabel

> **AxisLabel**: `object`

Options that define configuration for certain chart axis.

## Type declaration

### `enabled`

**enabled**?: `boolean`

Boolean flag that defines if this axis should be shown on the chart

***

### `gridLines`

**gridLines**?: `boolean`

Boolean flag that defines if grid lines should be shown on the chart

***

### `intervalJumps`

**intervalJumps**?: `number`

Interval of the tick marks (jumps) in axis units.

***

### `isIntervalEnabled`

**isIntervalEnabled**?: `boolean`

Boolean flag that defines if tick marks should be shown on the axis

***

### `labels`

**labels**?: `object`

Configuration for labels on the axis

> #### `labels.enabled`
>
> **enabled**: `boolean`
>
> Boolean flag that defines if labels should be shown on the axis
>
>

***

### `logarithmic`

**logarithmic**?: `boolean`

Boolean flag that defines if the axis should have logarithmic scale

***

### `max`

**max**?: `number`

The maximum value of the axis. If 'undefined' the max value is automatically calculated

***

### `min`

**min**?: `number`

The minimum value of the axis. If 'undefined' the min value is automatically calculated

***

### `templateMainYHasGridLines`

**templateMainYHasGridLines**?: `boolean`

Boolean flag that defines if the Y axis should have grid lines extending the ticks across the plot area

***

### `title`

**title**?: `object`

Configuration for title of the axis

> #### `title.enabled`
>
> **enabled**: `boolean`
>
> Boolean flag that defines if title should be shown
>
> #### `title.text`
>
> **text**?: `string`
>
> Textual content of the title
>
>

***

### `x2Title`

**x2Title**?: [`X2Title`](type-alias.X2Title.md)

Configuration for title of the second X axis


---

---
title: BeforeRenderHandler
---

# Type alias BeforeRenderHandler

> **BeforeRenderHandler**: (`highchartsOptions`) => `HighchartsOptions`

A handler function that allows you to customize the underlying chart element before it is
rendered. Use the `highchartsOptions` object that is passed to the callback to change
[options values](https://api.highcharts.com/highcharts/) and then return the modified options
object. The returned options are then used when rendering the chart.

This callback is not supported for Indicator Chart, Areamap Chart, and Scattermap Chart.

For an example of how the `BeforeRenderHandler` function can be used, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#callbacks).

## See

[https://api.highcharts.com/highcharts/](https://api.highcharts.com/highcharts/)

## Parameters

| Parameter | Type |
| :------ | :------ |
| `highchartsOptions` | `HighchartsOptions` |

## Returns

`HighchartsOptions`


---

---
title: BoxWhiskerType
---

# Type alias BoxWhiskerType

> **BoxWhiskerType**: `"extremums"` \| `"iqr"` \| `"standardDeviation"`

Represents the type of box whisker data algorithm, which can be either `iqr`, `extremums`, or `standardDeviation`.


---

---
title: BoxplotChartCustomDataOptions
---

# Type alias BoxplotChartCustomDataOptions

> **BoxplotChartCustomDataOptions**: `object`

Configuration for how to query aggregate data and assign data
to axes of a Boxplot chart.

The Boxplot chart can receive multiple numeric columns, which represent all the metrics
such as `whisker max`, `whisker min`, `box max`, `box median`, and `box min`.

## Type declaration

### `category`

**category**: [(Column \| StyledColumn)?]

Columns (or attributes) whose values represent categories in the chart.

***

### `outliers`

**outliers**?: [[`Column`](../../sdk-data/interfaces/interface.Column.md) \| [`StyledColumn`](../interfaces/interface.StyledColumn.md)]

Optional measure columns (or measures) representing the boxplot outliers value.

***

### `value`

**value**: ([`CalculatedMeasureColumn`](../../sdk-data/interfaces/interface.CalculatedMeasureColumn.md) \| [`Column`](../../sdk-data/interfaces/interface.Column.md) \| [`MeasureColumn`](../../sdk-data/interfaces/interface.MeasureColumn.md) \| [`StyledColumn`](../interfaces/interface.StyledColumn.md) \| [`StyledMeasureColumn`](../interfaces/interface.StyledMeasureColumn.md))[]

Measure columns (or measures) representing the target numeric values used for computing boxplot metrics.

***

### `valueTitle`

**valueTitle**: `string`

The title for the numeric value column in the chart.


---

---
title: BoxplotChartDataOptions
---

# Type alias BoxplotChartDataOptions

> **BoxplotChartDataOptions**: `object`

Configuration for how to query aggregate data and assign data
to axes of a Boxplot chart.

The Boxplot chart can receive a singular numeric column, which is utilized internally to calculate multiple metrics
such as `whisker max`, `whisker min`, `box max`, `box median`, and `box min`.

## Type declaration

### `boxType`

**boxType**: [`BoxWhiskerType`](type-alias.BoxWhiskerType.md)

The type of box whisker data algorithm to be used.

***

### `category`

**category**: [(Column \| StyledColumn)?]

Columns (or attributes) whose values represent categories in the chart.

***

### `outliersEnabled`

**outliersEnabled**?: `boolean`

Toggle flag whether outliers should be enabled in the boxplot chart.

***

### `value`

**value**: [[`Column`](../../sdk-data/interfaces/interface.Column.md) \| [`StyledColumn`](../interfaces/interface.StyledColumn.md)]

Columns (or attributes) whose values represent the target numeric value column for computing boxplot metrics according to the selected `boxType`


---

---
title: BoxplotChartType
---

# Type alias BoxplotChartType

> **BoxplotChartType**: `"boxplot"`

Boxplot chart types


---

---
title: BoxplotDataPoint
---

# Type alias BoxplotDataPoint

> **BoxplotDataPoint**: `object`

Data point in a Boxplot chart.

## Type declaration

### `boxMax`

**boxMax**?: `number`

Value of the box maximum

***

### `boxMedian`

**boxMedian**?: `number`

Value of the box median

***

### `boxMin`

**boxMin**?: `number`

Value of the box minimum

***

### `categoryDisplayValue`

**categoryDisplayValue**?: `string`

Display value of category of the data point

***

### `categoryValue`

**categoryValue**?: `number` \| `string`

Value of the category for the data point

***

### `entries`

**entries**?: `object`

A collection of data point entries that represents values for all related `dataOptions`.

> #### `entries.category`
>
> **category**: [`DataPointEntry`](../../sdk-ui/type-aliases/type-alias.DataPointEntry.md)[]
>
> Data point entries for the `category` data options
>
> #### `entries.outliers`
>
> **outliers**: [`DataPointEntry`](../../sdk-ui/type-aliases/type-alias.DataPointEntry.md)[]
>
> Data point entries for the `outliers` data options
>
> #### `entries.value`
>
> **value**: [`DataPointEntry`](../../sdk-ui/type-aliases/type-alias.DataPointEntry.md)[]
>
> Data point entries for the `value` data options
>
>

***

### `outlier`

**outlier**?: `number`

Value of the outlier

***

### `whiskerMax`

**whiskerMax**?: `number`

Value of the box maximal whisker

***

### `whiskerMin`

**whiskerMin**?: `number`

Value of the box minimal whisker


---

---
title: BoxplotDataPointEvent
---

# Type alias BoxplotDataPointEvent

> **BoxplotDataPointEvent**: `object`

## Type declaration

### `nativeEvent`

**nativeEvent**: `PointerEvent`

Native PointerEvent

***

### `point`

**point**: [`BoxplotDataPoint`](type-alias.BoxplotDataPoint.md)

Data point that was clicked


---

---
title: BoxplotDataPointEventHandler
---

# Type alias BoxplotDataPointEventHandler

> **BoxplotDataPointEventHandler**: (`event`) => `void`

Click handler for when a data point on Boxplot is clicked.

## Parameters

| Parameter | Type |
| :------ | :------ |
| `event` | [`BoxplotDataPointEvent`](type-alias.BoxplotDataPointEvent.md) |

## Returns

`void`


---

---
title: BoxplotDataPointsEvent
---

# Type alias BoxplotDataPointsEvent

> **BoxplotDataPointsEvent**: `object`

## Type declaration

### `nativeEvent`

**nativeEvent**: `MouseEvent`

Native MouseEvent

***

### `points`

**points**: [`BoxplotDataPoint`](type-alias.BoxplotDataPoint.md)[]

Data point that were selected


---

---
title: BoxplotSubtype
---

# Type alias BoxplotSubtype

> **BoxplotSubtype**: `"boxplot/full"` \| `"boxplot/hollow"`


---

---
title: CalendarDayOfWeek
---

# Type alias CalendarDayOfWeek

> **CalendarDayOfWeek**: `"friday"` \| `"monday"` \| `"saturday"` \| `"sunday"` \| `"thursday"` \| `"tuesday"` \| `"wednesday"`

Day of the week


---

---
title: CalendarHeatmapChartType
---

# Type alias CalendarHeatmapChartType

> **CalendarHeatmapChartType**: `"calendar-heatmap"`

Calendar heatmap chart types


---

---
title: CalendarHeatmapDataPoint
---

# Type alias CalendarHeatmapDataPoint

> **CalendarHeatmapDataPoint**: `object`

Data point in a CalendarHeatmap chart.

## Type declaration

### `entries`

**entries**?: `object`

A collection of data point entries that represents values for all related `dataOptions`.

> #### `entries.date`
>
> **date**: [`DataPointEntry`](../../sdk-ui/type-aliases/type-alias.DataPointEntry.md)
>
> Data point entry for the `date` data options
>
> #### `entries.value`
>
> **value**?: [`DataPointEntry`](../../sdk-ui/type-aliases/type-alias.DataPointEntry.md)
>
> Data point entry for the `value` data options
>
>


---

---
title: CalendarHeatmapDataPointEvent
---

# Type alias CalendarHeatmapDataPointEvent

> **CalendarHeatmapDataPointEvent**: `object`

## Type declaration

### `nativeEvent`

**nativeEvent**: `PointerEvent`

Native PointerEvent

***

### `point`

**point**: [`CalendarHeatmapDataPoint`](type-alias.CalendarHeatmapDataPoint.md)

Data point that was clicked


---

---
title: CalendarHeatmapDataPointEventHandler
---

# Type alias CalendarHeatmapDataPointEventHandler

> **CalendarHeatmapDataPointEventHandler**: (`event`) => `void`

Click handler for when a calendar-heatmap data point is clicked

## Parameters

| Parameter | Type |
| :------ | :------ |
| `event` | [`CalendarHeatmapDataPointEvent`](type-alias.CalendarHeatmapDataPointEvent.md) |

## Returns

`void`


---

---
title: CalendarHeatmapDataPointsEvent
---

# Type alias CalendarHeatmapDataPointsEvent

> **CalendarHeatmapDataPointsEvent**: `object`

## Type declaration

### `nativeEvent`

**nativeEvent**: `MouseEvent`

Native MouseEvent

***

### `points`

**points**: [`CalendarHeatmapDataPoint`](type-alias.CalendarHeatmapDataPoint.md)[]

Data points that were selected


---

---
title: CalendarHeatmapDataPointsEventHandler
---

# Type alias CalendarHeatmapDataPointsEventHandler

> **CalendarHeatmapDataPointsEventHandler**: (`event`) => `void`

Click handler for when multiple calendar-heatmap data points are selected.

## Parameters

| Parameter | Type |
| :------ | :------ |
| `event` | [`CalendarHeatmapDataPointsEvent`](type-alias.CalendarHeatmapDataPointsEvent.md) |

## Returns

`void`


---

---
title: CalendarHeatmapSubtype
---

# Type alias CalendarHeatmapSubtype

> **CalendarHeatmapSubtype**: `"calendar-heatmap/continuous"` \| `"calendar-heatmap/split"`

Calendar heatmap chart subtype


---

---
title: CalendarHeatmapViewType
---

# Type alias CalendarHeatmapViewType

> **CalendarHeatmapViewType**: `"half-year"` \| `"month"` \| `"quarter"` \| `"year"`

View type determines how many months to display: 'month' (1), 'quarter' (3), 'half-year' (6), 'year' (12)


---

---
title: CartesianChartType
---

# Type alias CartesianChartType

> **CartesianChartType**: `"area" | "bar" | "column" | "line" | "polar" | "streamgraph"`

Cartesian family of chart types


---

---
title: CartesianWidgetType
---

# Type alias CartesianWidgetType

> **CartesianWidgetType**: `"chart/area"` \| `"chart/bar"` \| `"chart/column"` \| `"chart/line"` \| `"chart/polar"`

The type of a widget on a dashboard that is a variant of Cartesian widget.


---

---
title: CategoricalChartType
---

# Type alias CategoricalChartType

> **CategoricalChartType**: `"funnel" | "pie" | "sunburst" | "treemap"`

Categorical family of chart types


---

---
title: CategoricalWidgetType
---

# Type alias CategoricalWidgetType

> **CategoricalWidgetType**: `"chart/funnel"` \| `"chart/pie"` \| `"sunburst"` \| `"treemap"`

The type of a widget on a dashboard that is a variant of Categorical widget.


---

---
title: ChartDataOptions
---

# Type alias ChartDataOptions

> **ChartDataOptions**: [`RegularChartDataOptions`](../../sdk-ui/type-aliases/type-alias.RegularChartDataOptions.md) \| [`TabularChartDataOptions`](../../sdk-ui/type-aliases/type-alias.TabularChartDataOptions.md)

Configuration for querying aggregate data and assigning data to chart encodings.

There are separate configurations for [Cartesian](../interfaces/interface.CartesianChartDataOptions.md),
[Categorical](../interfaces/interface.CategoricalChartDataOptions.md),
[Scatter](../interfaces/interface.ScatterChartDataOptions.md),
[Indicator](../interfaces/interface.IndicatorChartDataOptions.md),
[Table](../interfaces/interface.TableDataOptions.md),
[Boxplot](type-alias.BoxplotChartDataOptions.md),
[Areamap](../interfaces/interface.AreamapChartDataOptions.md), and
[Scattermap](../interfaces/interface.ScattermapChartDataOptions.md) charts.


---

---
title: ChartDataPointClickEvent
---

# Type alias ChartDataPointClickEvent

> **ChartDataPointClickEvent**: [`AreamapDataPointEvent`](type-alias.AreamapDataPointEvent.md) \| [`BoxplotDataPointEvent`](type-alias.BoxplotDataPointEvent.md) \| [`CalendarHeatmapDataPointEvent`](type-alias.CalendarHeatmapDataPointEvent.md) \| [`DataPointEvent`](type-alias.DataPointEvent.md) \| [`IndicatorDataPointEvent`](type-alias.IndicatorDataPointEvent.md) \| [`ScatterDataPointEvent`](type-alias.ScatterDataPointEvent.md) \| [`ScattermapDataPointEvent`](type-alias.ScattermapDataPointEvent.md)


---

---
title: ChartDataPointClickEventHandler
---

# Type alias ChartDataPointClickEventHandler

> **ChartDataPointClickEventHandler**: (`event`) => `void`

Click handler for when a data point on Chart is clicked.

## Parameters

| Parameter | Type |
| :------ | :------ |
| `event` | [`ChartDataPointClickEvent`](type-alias.ChartDataPointClickEvent.md) |

## Returns

`void`


---

---
title: ChartDataPointContextMenuEvent
---

# Type alias ChartDataPointContextMenuEvent

> **ChartDataPointContextMenuEvent**: [`BoxplotDataPointEvent`](type-alias.BoxplotDataPointEvent.md) \| [`CalendarHeatmapDataPointEvent`](type-alias.CalendarHeatmapDataPointEvent.md) \| [`DataPointEvent`](type-alias.DataPointEvent.md) \| [`ScatterDataPointEvent`](type-alias.ScatterDataPointEvent.md)


---

---
title: ChartDataPointContextMenuEventHandler
---

# Type alias ChartDataPointContextMenuEventHandler

> **ChartDataPointContextMenuEventHandler**: (`event`) => `void`

Context menu handler for when a data point on the Chart is right-clicked.

## Parameters

| Parameter | Type |
| :------ | :------ |
| `event` | [`ChartDataPointContextMenuEvent`](type-alias.ChartDataPointContextMenuEvent.md) |

## Returns

`void`


---

---
title: ChartDataPointsEvent
---

# Type alias ChartDataPointsEvent

> **ChartDataPointsEvent**: [`CalendarHeatmapDataPointsEvent`](type-alias.CalendarHeatmapDataPointsEvent.md) \| [`DataPointsEvent`](type-alias.DataPointsEvent.md) \| [`ScatterDataPointsEvent`](type-alias.ScatterDataPointsEvent.md)


---

---
title: ChartDataPointsEventHandler
---

# Type alias ChartDataPointsEventHandler

> **ChartDataPointsEventHandler**: (`event`) => `void`

Click handler for when multiple data points on Chart are selected.

## Parameters

| Parameter | Type |
| :------ | :------ |
| `event` | [`ChartDataPointsEvent`](type-alias.ChartDataPointsEvent.md) |

## Returns

`void`


---

---
title: ChartStyleOptions
---

# Type alias ChartStyleOptions

> **ChartStyleOptions**: [`RegularChartStyleOptions`](../../sdk-ui/type-aliases/type-alias.RegularChartStyleOptions.md) \| [`TabularChartStyleOptions`](../../sdk-ui/type-aliases/type-alias.TabularChartStyleOptions.md)

Configuration options that define functional style of the various elements of chart.


---

---
title: ChartType
---

# Type alias ChartType

> **ChartType**: [`AreamapChartType`](type-alias.AreamapChartType.md) \| [`BoxplotChartType`](type-alias.BoxplotChartType.md) \| [`CalendarHeatmapChartType`](type-alias.CalendarHeatmapChartType.md) \| [`CartesianChartType`](type-alias.CartesianChartType.md) \| [`CategoricalChartType`](type-alias.CategoricalChartType.md) \| [`IndicatorChartType`](type-alias.IndicatorChartType.md) \| [`RangeChartType`](type-alias.RangeChartType.md) \| [`ScatterChartType`](type-alias.ScatterChartType.md) \| [`ScattermapChartType`](type-alias.ScattermapChartType.md) \| [`TableChartType`](../../sdk-ui/type-aliases/type-alias.TableChartType.md)

Chart type of one of the supported chart families


---

---
title: ChartWidgetStyleOptions
---

# Type alias ChartWidgetStyleOptions

> **ChartWidgetStyleOptions**: [`ChartStyleOptions`](type-alias.ChartStyleOptions.md) & [`WidgetContainerStyleOptions`](../../sdk-ui/interfaces/interface.WidgetContainerStyleOptions.md)

Style settings defining the look and feel of ChartWidget


---

---
title: Color
---

# Type alias Color

> **Color**: `null` \| `string`

HEX color value or CSS color name.


---

---
title: ColorPaletteTheme
---

# Type alias ColorPaletteTheme

> **ColorPaletteTheme**: `object`

Collection of colors used to color various elements.

## Type declaration

### `variantColors`

**variantColors**: [`Color`](type-alias.Color.md)[]

Set of colors used to color chart elements


---

---
title: ConditionalDataColorOptions
---

# Type alias ConditionalDataColorOptions

> **ConditionalDataColorOptions**: `object`

Conditional color options for data similar to the Conditional Color option in the Sisense UI.

This option allows you to define color conditions.
Each condition is a logical expression that defines how data values are mapped into colors.
These conditions are evaluated in the order in which they appear in the array.

## Example

An example of a condition stating that a negative data value is displayed in red
and another condition stating that a positive data value is green.

```ts
{
  type: 'conditional',
  conditions: [
    { color: 'red', expression: '0', operator: '<' },
    { color: 'green', expression: '0', operator: '>=' },
  ],
  defaultColor: 'red',
}
```

## Type declaration

### `conditions`

**conditions**?: [`DataColorCondition`](type-alias.DataColorCondition.md)[]

Array of color conditions

***

### `defaultColor`

**defaultColor**?: `string`

Default color when no condition is met

***

### `type`

**type**: `"conditional"`

Color options type


---

---
title: Convolution
---

# Type alias Convolution

> **Convolution**: `object`

Configuration that defines the ability of the Pie chart to collapse (convolve) and
hide part of the data under the single category "Others".

## Type declaration

### `enabled`

**enabled**: `boolean`

Boolean flag that defines if convolution ability should be enabled on chart

***

### `independentSlicesCount`

**independentSlicesCount**?: `number`

Number that defines of how many independent slices should be present in chart (other will be convolved)

***

### `minimalIndependentSlicePercentage`

**minimalIndependentSlicePercentage**?: `number`

Value that defines what minimal size in percent should a slice take to fall under the convolution

***

### `selectedConvolutionType`

**selectedConvolutionType**?: `"byPercentage"` \| `"bySlicesCount"`

Selected type of convolution behavior


---

---
title: CustomDrilldownResult
---

# Type alias CustomDrilldownResult

> **CustomDrilldownResult**: [`CustomDrilldownResult`](../../sdk-ui/type-aliases/type-alias.CustomDrilldownResult.md) & \{
  `breadcrumbsComponent`: \{
    `render`: `ComponentRenderer`;
  };
 }

> ## `CustomDrilldownResult.breadcrumbsComponent`
>
> **breadcrumbsComponent**?: `object`
>
> > ### `breadcrumbsComponent.render`
> >
> > **render**: `ComponentRenderer`
> >
> >
>
>


---

---
title: CustomWidgetComponent
---

# Type alias CustomWidgetComponent`<Props>`

> **CustomWidgetComponent**: <`Props`> `Type`\< `Props` \>

Type representing an Angular component class that can be used as a user-defined custom widget.

## Type parameters

| Parameter | Default |
| :------ | :------ |
| `Props` *extends* [`CustomWidgetComponentProps`](../interfaces/interface.CustomWidgetComponentProps.md) | [`CustomWidgetComponentProps`](../interfaces/interface.CustomWidgetComponentProps.md) |


---

---
title: DashStyle
---

# Type alias DashStyle

> **DashStyle**: `"Dash"` \| `"DashDot"` \| `"Dot"` \| `"LongDash"` \| `"LongDashDot"` \| `"LongDashDotDot"` \| `"ShortDash"` \| `"ShortDashDot"` \| `"ShortDashDotDot"` \| `"ShortDot"` \| `"Solid"`

Configuration that defines line dash type


---

---
title: DataColorCondition
---

# Type alias DataColorCondition

> **DataColorCondition**: `object`

Color condition for [ConditionalDataColorOptions](type-alias.ConditionalDataColorOptions.md) represented as a logical expression.

See [ConditionalDataColorOptions](type-alias.ConditionalDataColorOptions.md) for usage examples.

## Type declaration

### `color`

**color**: `string`

Color for this condition

***

### `expression`

**expression**: `string`

Expression representing the data value

***

### `operator`

**operator**: `"!="` \| `"<"` \| `"<="` \| `"="` \| `">"` \| `">="` \| `"≠"` \| `"≤"` \| `"≥"`

Supported operators for `expression`


---

---
title: DataColorOptions
---

# Type alias DataColorOptions

> **DataColorOptions**: [`ConditionalDataColorOptions`](type-alias.ConditionalDataColorOptions.md) \| [`RangeDataColorOptions`](type-alias.RangeDataColorOptions.md) \| [`UniformDataColorOptions`](type-alias.UniformDataColorOptions.md) \| `string`

All possible color options for data.


---

---
title: DataOptionLocation
---

# Type alias DataOptionLocation

> **DataOptionLocation**: `object`

Location within component data options that identifies a specific data option.

## Example

```typescript
{ dataOptionName: 'category', dataOptionIndex: 0 } // First category
{ dataOptionName: 'value', dataOptionIndex: 1 }    // Second value measure
```

## Type declaration

### `dataOptionIndex`

**dataOptionIndex**?: `number`

Data option location zero-based index.

Required for array-based locations (e.g., `rows`, `columns`, `values`, `category`).
Optional for single-value locations (e.g., `x`, `y`, `date`).

#### Default

```ts
0
```

***

### `dataOptionName`

**dataOptionName**: `"breakBy"` \| `"breakByColor"` \| `"breakByPoint"` \| `"category"` \| `"color"` \| `"colorBy"` \| `"columns"` \| `"date"` \| `"details"` \| `"geo"` \| `"max"` \| `"min"` \| `"outliers"` \| `"rows"` \| `"secondary"` \| `"size"` \| `"value"` \| `"values"` \| `"x"` \| `"y"`

Data option location name that identifies the property containing the data option.

Examples:
- PivotTable: `'rows'` | `'columns'` | `'values'`
- Cartesian charts: `'category'` | `'value'` | `'breakBy'`
- Scatter charts: `'x'` | `'y'` | `'breakByPoint'` | `'breakByColor'` | `'size'`


---

---
title: DataPoint
---

# Type alias DataPoint

> **DataPoint**: `object`

Data point in a regular chart.

## Type declaration

### `categoryDisplayValue`

**categoryDisplayValue**?: `string`

Display value of categorical value of the data point

***

### `categoryValue`

**categoryValue**?: `number` \| `string`

Categorical value of the data point

***

### `entries`

**entries**?: `object`

A collection of data point entries that represents values for all related `dataOptions`.

> #### `entries.breakBy`
>
> **breakBy**?: [`DataPointEntry`](../../sdk-ui/type-aliases/type-alias.DataPointEntry.md)[]
>
> Data point entries for the `breakBy` data options
>
> #### `entries.category`
>
> **category**: [`DataPointEntry`](../../sdk-ui/type-aliases/type-alias.DataPointEntry.md)[]
>
> Data point entries for the `category` data options
>
> #### `entries.value`
>
> **value**: [`DataPointEntry`](../../sdk-ui/type-aliases/type-alias.DataPointEntry.md)[]
>
> Data point entries for the `value` data options
>
>

***

### `seriesValue`

**seriesValue**?: `number` \| `string`

Series associated with the data point

***

### `value`

**value**?: `number` \| `string`

Value of the data point


---

---
title: DataPointEvent
---

# Type alias DataPointEvent

> **DataPointEvent**: `object`

## Type declaration

### `nativeEvent`

**nativeEvent**: `PointerEvent`

Native PointerEvent

***

### `point`

**point**: [`DataPoint`](type-alias.DataPoint.md)

Data point that was clicked


---

---
title: DataPointEventHandler
---

# Type alias DataPointEventHandler

> **DataPointEventHandler**: (`event`) => `void`

A handler function that allows you to customize what happens when certain events occur to
a data point.

## Parameters

| Parameter | Type |
| :------ | :------ |
| `event` | [`DataPointEvent`](type-alias.DataPointEvent.md) |

## Returns

`void`


---

---
title: DataPointsEvent
---

# Type alias DataPointsEvent

> **DataPointsEvent**: `object`

## Type declaration

### `nativeEvent`

**nativeEvent**: `MouseEvent`

Native MouseEvent

***

### `points`

**points**: [`DataPoint`](type-alias.DataPoint.md)[]

Data points that were selected


---

---
title: DataPointsEventHandler
---

# Type alias DataPointsEventHandler

> **DataPointsEventHandler**: (`event`) => `void`

Click handler for when multiple data points are selected.

## Parameters

| Parameter | Type |
| :------ | :------ |
| `event` | [`DataPointsEvent`](type-alias.DataPointsEvent.md) |

## Returns

`void`


---

---
title: DateConfig
---

# Type alias DateConfig

> **DateConfig**: `object`

Date configurations

## Type declaration

### `fiscalMonth`

**fiscalMonth**: [`MonthOfYear`](type-alias.MonthOfYear.md)

First month of the fiscal year that is configured

***

### `isFiscalOn`

**isFiscalOn**: `boolean`

Boolean flag whether fiscal year is enabled

***

### `selectedDateLevel`

**selectedDateLevel**: [`DateLevel`](type-alias.DateLevel.md)

The selected date level for this particular column of data

***

### `timeZone`

**timeZone**: `string`

The IANA time zone

***

### `weekFirstDay`

**weekFirstDay**: [`DayOfWeek`](type-alias.DayOfWeek.md)

First day of the week


---

---
title: DateLevel
---

# Type alias DateLevel

> **DateLevel**: `"dateAndTime" | "days" | "minutes" | "months" | "quarters" | "weeks" | "years"`


---

---
title: DayOfWeek
---

# Type alias DayOfWeek

> **DayOfWeek**: `0` \| `1` \| `2` \| `3` \| `4` \| `5` \| `6`


---

---
title: DecimalScale
---

# Type alias DecimalScale

> **DecimalScale**: `"auto"` \| `number`

The number of decimal places


---

---
title: DrilldownOptions
---

# Type alias DrilldownOptions

> **DrilldownOptions**: `object`

Configuration for the drilldown

## Type declaration

### `drilldownPaths`

**drilldownPaths**?: ([`Attribute`](../../sdk-data/interfaces/interface.Attribute.md) \| [`Hierarchy`](../interfaces/interface.Hierarchy.md) \| [`HierarchyId`](../../sdk-ui/type-aliases/type-alias.HierarchyId.md))[]

Dimensions and hierarchies available for drilldown on.

***

### `drilldownSelections`

**drilldownSelections**?: [`DrilldownSelection`](type-alias.DrilldownSelection.md)[]

Current selections for multiple drilldowns


---

---
title: DrilldownSelection
---

# Type alias DrilldownSelection

> **DrilldownSelection**: `object`

Selection for the drilldown

## Type declaration

### `nextDimension`

**nextDimension**: [`Attribute`](../../sdk-data/interfaces/interface.Attribute.md)

Dimension to drilldown to

***

### `points`

**points**: [`ChartDataPoint`](../../sdk-ui/type-aliases/type-alias.ChartDataPoint.md)[]

Points selected for drilldown


---

---
title: EndCapType
---

# Type alias EndCapType

> **EndCapType**: `"Round"` \| `"Square"`

Configuration that defines line end cap type


---

---
title: FilterChangeEvent
---

# Type alias FilterChangeEvent

> **FilterChangeEvent**: `object`

## Type declaration

### `filter`

**filter**: [`Filter`](../../sdk-data/interfaces/interface.Filter.md) \| `null`

Filter that was changed


---

---
title: FilterChangeEventHandler
---

# Type alias FilterChangeEventHandler

> **FilterChangeEventHandler**: (`event`) => `void`

Filter change event handler.

## Parameters

| Parameter | Type |
| :------ | :------ |
| `event` | [`FilterChangeEvent`](type-alias.FilterChangeEvent.md) |

## Returns

`void`


---

---
title: FilterDeleteEventHandler
---

# Type alias FilterDeleteEventHandler

> **FilterDeleteEventHandler**: () => `void`

Filter delete event handler.

## Returns

`void`


---

---
title: FilterEditEvent
---

# Type alias FilterEditEvent

> **FilterEditEvent**: `object`

## Type declaration

### `levelIndex`

**levelIndex**?: `number`

Index of the filter level that triggers the edit event (in the case of a cascading filter)


---

---
title: FilterEditEventHandler
---

# Type alias FilterEditEventHandler

> **FilterEditEventHandler**: (`event`) => `void`

Filter edit event handler.

## Parameters

| Parameter | Type |
| :------ | :------ |
| `event` | [`FilterEditEvent`](type-alias.FilterEditEvent.md) |

## Returns

`void`


---

---
title: FilterVariant
---

# Type alias FilterVariant

> **FilterVariant**: `"horizontal"` \| `"vertical"`

Orientation options for the filter tile. The filter tile can
be arranged vertically, or horizontally to fit most toolbars.


---

---
title: FiltersPanelChangeEvent
---

# Type alias FiltersPanelChangeEvent

> **FiltersPanelChangeEvent**: `object`

## Type declaration

### `filters`

**filters**: [`FilterRelations`](../../sdk-data/interfaces/interface.FilterRelations.md) \| [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

The updated filters


---

---
title: FiltersPanelChangeEventHandler
---

# Type alias FiltersPanelChangeEventHandler

> **FiltersPanelChangeEventHandler**: (`event`) => `void`

Filters panel change event handler.

## Parameters

| Parameter | Type |
| :------ | :------ |
| `event` | [`FiltersPanelChangeEvent`](type-alias.FiltersPanelChangeEvent.md) |

## Returns

`void`


---

---
title: GenericDataOptions
---

# Type alias GenericDataOptions

> **GenericDataOptions**: `Record`\< `string`, ([`StyledColumn`](../interfaces/interface.StyledColumn.md) \| [`StyledMeasureColumn`](../interfaces/interface.StyledMeasureColumn.md))[] \>

Data options with arbitrary keys. This is typically used in the context of a custom widget.


---

---
title: IndicatorBeforeRenderHandler
---

# Type alias IndicatorBeforeRenderHandler

> **IndicatorBeforeRenderHandler**: (`renderOptions`) => [`IndicatorRenderOptions`](type-alias.IndicatorRenderOptions.md)

A handler function that allows you to customize the underlying chart element before it is
rendered. Use the [IndicatorRenderOptions](type-alias.IndicatorRenderOptions.md) object that is passed to the callback to change
and then return the modified options object.
The returned options are then used when rendering the chart.

This callback is supported only for Indicator Chart.

## Parameters

| Parameter | Type |
| :------ | :------ |
| `renderOptions` | [`IndicatorRenderOptions`](type-alias.IndicatorRenderOptions.md) |

## Returns

[`IndicatorRenderOptions`](type-alias.IndicatorRenderOptions.md)


---

---
title: IndicatorChartType
---

# Type alias IndicatorChartType

> **IndicatorChartType**: `"indicator"`

Indicator chart types


---

---
title: IndicatorComponents
---

# Type alias IndicatorComponents

> **IndicatorComponents**: `object`

Configuration options that define components of an indicator chart.

## Type declaration

### `labels`

**labels**?: `object`

The value labels of the indicator chart

> #### `labels.shouldBeShown`
>
> **shouldBeShown**: `boolean`
>
> Whether the labels should be shown
>
>

***

### `secondaryTitle`

**secondaryTitle**?: `object`

The secondary title of the indicator chart to be shown when `secondary` is specified in [IndicatorChartDataOptions](../interfaces/interface.IndicatorChartDataOptions.md)

> #### `secondaryTitle.text`
>
> **text**?: `string`
>
> The text of the secondary title
>
>

***

### `ticks`

**ticks**?: `object`

The ticks displayed on the indicator chart

> #### `ticks.shouldBeShown`
>
> **shouldBeShown**: `boolean`
>
> Whether the ticks should be shown
>
>

***

### `title`

**title**?: `object`

The main title of the indicator chart

> #### `title.shouldBeShown`
>
> **shouldBeShown**: `boolean`
>
> Whether the title should be shown
>
> #### `title.text`
>
> **text**?: `string`
>
> The text of the title
>
>


---

---
title: IndicatorDataPoint
---

# Type alias IndicatorDataPoint

> **IndicatorDataPoint**: `object`

Data point that represents the entire Indicator chart data.

## Type declaration

### `entries`

**entries**?: `object`

A collection of data point entries that represents values for all related `dataOptions`.

> #### `entries.max`
>
> **max**?: [`DataPointEntry`](../../sdk-ui/type-aliases/type-alias.DataPointEntry.md)
>
> Data point entry for the `max` data options
>
> #### `entries.min`
>
> **min**?: [`DataPointEntry`](../../sdk-ui/type-aliases/type-alias.DataPointEntry.md)
>
> Data point entry for the `min` data options
>
> #### `entries.secondary`
>
> **secondary**?: [`DataPointEntry`](../../sdk-ui/type-aliases/type-alias.DataPointEntry.md)
>
> Data point entry for the `secondary` data options
>
> #### `entries.value`
>
> **value**?: [`DataPointEntry`](../../sdk-ui/type-aliases/type-alias.DataPointEntry.md)
>
> Data point entry for the `value` data options
>
>


---

---
title: IndicatorDataPointEvent
---

# Type alias IndicatorDataPointEvent

> **IndicatorDataPointEvent**: `object`

## Type declaration

### `nativeEvent`

**nativeEvent**: `MouseEvent`

Native MouseEvent

***

### `point`

**point**: [`IndicatorDataPoint`](type-alias.IndicatorDataPoint.md)

Data point that was clicked


---

---
title: IndicatorDataPointEventHandler
---

# Type alias IndicatorDataPointEventHandler

> **IndicatorDataPointEventHandler**: (`event`) => `void`

Click handler for when a data point on Indicator is clicked.

## Parameters

| Parameter | Type |
| :------ | :------ |
| `event` | [`IndicatorDataPointEvent`](type-alias.IndicatorDataPointEvent.md) |

## Returns

`void`


---

---
title: IndicatorRenderOptions
---

# Type alias IndicatorRenderOptions

> **IndicatorRenderOptions**: `object`

Indicator render options.

## Type declaration

### `secondary`

**secondary**: `object`

The secondary value options.

> #### `secondary.color`
>
> **color**: `string`
>
> The secondary value color.
>
> #### `secondary.data`
>
> **data**: `number`
>
> The secondary value data.
>
> #### `secondary.fontWeight`
>
> **fontWeight**: `string`
>
> The secondary value font weight.
>
> #### `secondary.text`
>
> **text**: `string`
>
> The secondary value text.
>
>

***

### `secondaryTitle`

**secondaryTitle**: `object`

The secondary title options.

> #### `secondaryTitle.color`
>
> **color**: `string`
>
> The secondary title color.
>
> #### `secondaryTitle.text`
>
> **text**: `string`
>
> The secondary title text.
>
>

***

### `title`

**title**: `object`

The title options.

> #### `title.color`
>
> **color**: `string`
>
> The title color.
>
> #### `title.text`
>
> **text**: `string`
>
> The title text.
>
>

***

### `value`

**value**: `object`

The primary value options.

> #### `value.color`
>
> **color**: `string`
>
> The primary value color.
>
> #### `value.data`
>
> **data**: `number`
>
> The primary value data.
>
> #### `value.text`
>
> **text**: `string`
>
> The primary value text.
>
>


---

---
title: IndicatorStyleOptions
---

# Type alias IndicatorStyleOptions

> **IndicatorStyleOptions**: [`GaugeIndicatorStyleOptions`](../interfaces/interface.GaugeIndicatorStyleOptions.md) \| [`NumericBarIndicatorStyleOptions`](../interfaces/interface.NumericBarIndicatorStyleOptions.md) \| [`NumericSimpleIndicatorStyleOptions`](../interfaces/interface.NumericSimpleIndicatorStyleOptions.md) & \{
  `height`: `number`;
  `width`: `number`;
 }

Configuration options that define functional style of the various elements of IndicatorChart

> ## `IndicatorStyleOptions.height`
>
> **height**?: `number`
>
> Total height of the component, which is considered in the following order of priority:
>
> 1. Value passed to this property (in pixels).
> 2. Height of the container wrapping this component
> 3. Default value of 200px (for component without header) or 225px (for component with header).
>
> ## `IndicatorStyleOptions.width`
>
> **width**?: `number`
>
> Total width of the component, which is considered in the following order of priority:
>
> 1. Value passed to this property (in pixels)
> 2. Width of the container wrapping this component
> 3. Default value of 200px
>
>


---

---
title: Labels
---

# Type alias Labels

> **Labels**: `object`

Configuration that defines behavior of data labels on chart

## Type declaration

### `categories`

**categories**?: `boolean`

Boolean flag that defines if categories names should be shown

***

### `decimals`

**decimals**?: `boolean`

Boolean flag that defines if decimals should be shown for percent labels

***

### `enabled`

**enabled**?: `boolean`

Boolean flag that defines if any labels should be shown

***

### `percent`

**percent**?: `boolean`

Boolean flag that defines if percents of Pie should be shown on slices

***

### `value`

**value**?: `boolean`

Boolean flag that defines if original values per category should be shown


---

---
title: Legend
---

# Type alias Legend

> **Legend**: [`LegendOptions`](../../sdk-ui/type-aliases/type-alias.LegendOptions.md)

Alias for LegendOptions for backward compatibility

::: warning Deprecated
Please use [LegendOptions](../../sdk-ui/type-aliases/type-alias.LegendOptions.md) instead
:::


---

---
title: LineOptions
---

# Type alias LineOptions

> **LineOptions**: `object`

Configuration options for styling lines in charts.

This type is used to customize the visual appearance of lines in various chart types
including Line charts, Area charts, and AreaRange charts.

## Type declaration

### `dashStyle`

**dashStyle**?: [`DashStyle`](type-alias.DashStyle.md)

Dash pattern for the line.

Defines the visual pattern of the line.

***

### `endCap`

**endCap**?: [`EndCapType`](type-alias.EndCapType.md)

Style of the line end caps.

Controls how the ends of lines are rendered:
- `'Round'`: Rounded ends for a softer appearance
- `'Square'`: Sharp, flat ends for a crisp appearance

***

### `shadow`

**shadow**?: `boolean`

Whether to apply a shadow effect to the line.

When enabled, adds a subtle shadow behind the line for enhanced.

***

### `width`

**width**?: `number`

Width of the line in pixels.


---

---
title: LineSubtype
---

# Type alias LineSubtype

> **LineSubtype**: `"line/basic"` \| `"line/spline"` \| `"line/step"`

Property of [LineStyleOptions](../interfaces/interface.LineStyleOptions.md)

Subtype of LineChart

**Values**

- `line/spline` - curved line from point to point.
- `line/basic` - straight line from point to point.
- `line/step` - step line where segments create a step-like pattern.


---

---
title: LineWidth
---

# Type alias LineWidth

> **LineWidth**: `object`

Configuration that defines line width

## Type declaration

### `width`

**width**: `"bold"` \| `"thick"` \| `"thin"`

Line width type


---

---
title: Markers
---

# Type alias Markers

> **Markers**: `object`

Options that define  markers - symbols or data points that highlight specific values.

## Type declaration

### `enabled`

**enabled**: `boolean`

Boolean flag that defines if markers should be shown on the chart

***

### `fill`

**fill**?: `"filled"` \| `"hollow"`

Marker fill style

***

### `size`

**size**?: `"large"` \| `"small"`

Size of markers


---

---
title: MenuItemSection
---

# Type alias MenuItemSection

> **MenuItemSection**: `object`

Context menu section
Used in [`ContextMenuProps`](../../sdk-ui/interfaces/interface.ContextMenuProps.md)

## Type declaration

### `items`

**items**?: \{
  `caption`: `string`;
  `key`: `number` \| `string`;
  `onClick`: () => `void`;
 }[]

Optional list of menu items

***

### `sectionTitle`

**sectionTitle**?: `string`

Optional section title


---

---
title: MenuPosition
---

# Type alias MenuPosition

> **MenuPosition**: `object`

Context menu position coordinates
Used in [`ContextMenuProps`](../../sdk-ui/interfaces/interface.ContextMenuProps.md)

## Type declaration

### `left`

**left**: `number`

Horizontal position

***

### `top`

**top**: `number`

Vertical position


---

---
title: MonthOfYear
---

# Type alias MonthOfYear

> **MonthOfYear**: `0` \| `1` \| `10` \| `11` \| `2` \| `3` \| `4` \| `5` \| `6` \| `7` \| `8` \| `9`


---

---
title: MultiColumnValueToColorMap
---

# Type alias MultiColumnValueToColorMap

> **MultiColumnValueToColorMap**: `object`

Mapping of each of the chart columns with mapping of each value series to colors.

## Index signature

 \[`columnName`: `string`\]: [`ValueToColorMap`](type-alias.ValueToColorMap.md)


---

---
title: Navigator
---

# Type alias Navigator

> **Navigator**: `object`

Options that define navigator - zoom/pan tool for large datasets in a chart.

## Type declaration

### `enabled`

**enabled**: `boolean`

Boolean flag that defines if navigator should be shown on the chart

***

### `scrollerLocation`

**scrollerLocation**?: `object`

The scroll location of the navigator scroller / auto zoom feature

> #### `scrollerLocation.max`
>
> **max**: `number`
>
> #### `scrollerLocation.min`
>
> **min**: `number`
>
>


---

---
title: NumberFormatConfig
---

# Type alias NumberFormatConfig

> **NumberFormatConfig**: `object`

Configuration for number formatting.

## Type declaration

### `billion`

**billion**?: `boolean`

Boolean flag whether to show an abbreviation
for a number greater than or equal one billion - e.g. 1B

***

### `decimalScale`

**decimalScale**?: [`DecimalScale`](type-alias.DecimalScale.md)

The number of decimal places

***

### `kilo`

**kilo**?: `boolean`

Boolean flag whether to show an abbreviation
for a number greater than or equal one thousand - e.g. 1K

***

### `million`

**million**?: `boolean`

Boolean flag whether to show an abbreviation
for a number greater than or equal one million - e.g. 1M

***

### `name`

**name**?: `"Currency"` \| `"Numbers"` \| `"Percent"`

Supported formats

***

### `prefix`

**prefix**?: `boolean`

Boolean flag whether `symbol` is shown in front of or after the number

If true, append `symbol` in front of the number, e.g. show `$1000` when `symbol` is `$`.

If false, append `symbol` after the number, e.g. show `1000¥` when `symbol` is `¥`.

***

### `symbol`

**symbol**?: `string`

Symbol to show in front of or after the number depending on the value of `prefix`.

***

### `thousandSeparator`

**thousandSeparator**?: `boolean`

Boolean flag whether the thousand separator is shown

If true, show the thousand separator, e.g. `1,000`. Otherwise, show `1000`

***

### `trillion`

**trillion**?: `boolean`

Boolean flag whether to show an abbreviation
for a number greater than or equal one trillion - e.g. 1T


---

---
title: PieSubtype
---

# Type alias PieSubtype

> **PieSubtype**: `"pie/classic"` \| `"pie/donut"` \| `"pie/ring"`

Property of [PieStyleOptions](../interfaces/interface.PieStyleOptions.md)

Subtype of PieChart

**Values**

- `pie/classic` - a circle divided into a series of segments where each segment represents a particular category.
- `pie/donut` - a circle divided into a series of segments where each segment represents a particular category with its center cut out to look like a donut.
- `pie/ring` - a circle divided into a series of segments where each segment represents a particular category with its center cut out to look like a ring.


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
title: PivotTableDataPointEvent
---

# Type alias PivotTableDataPointEvent

> **PivotTableDataPointEvent**: `object`

## Type declaration

### `nativeEvent`

**nativeEvent**: `MouseEvent`

Native MouseEvent

***

### `point`

**point**: [`PivotTableDataPoint`](../../sdk-ui/type-aliases/type-alias.PivotTableDataPoint.md)

Data point that was clicked


---

---
title: PivotTableDataPointEventHandler
---

# Type alias PivotTableDataPointEventHandler

> **PivotTableDataPointEventHandler**: (`event`) => `void`

Click handler for when a pivot table data point is clicked.

## Parameters

| Parameter | Type |
| :------ | :------ |
| `event` | [`PivotTableDataPointEvent`](type-alias.PivotTableDataPointEvent.md) |

## Returns

`void`


---

---
title: PivotTableDrilldownOptions
---

# Type alias PivotTableDrilldownOptions

> **PivotTableDrilldownOptions**: [`PivotTableNonSelectableDrilldownOptions`](type-alias.PivotTableNonSelectableDrilldownOptions.md) \| [`PivotTableSelectableDrilldownOptions`](type-alias.PivotTableSelectableDrilldownOptions.md)

Configuration for the pivot table drilldown


---

---
title: PivotTableNonSelectableDrilldownOptions
---

# Type alias PivotTableNonSelectableDrilldownOptions

> **PivotTableNonSelectableDrilldownOptions**: `object`

Configuration for the pivot table drilldown without initial target and selections

## Type declaration

### `drilldownPaths`

**drilldownPaths**?: ([`Attribute`](../../sdk-data/interfaces/interface.Attribute.md) \| [`Hierarchy`](../interfaces/interface.Hierarchy.md) \| [`HierarchyId`](../../sdk-ui/type-aliases/type-alias.HierarchyId.md))[]

Dimensions and hierarchies available for drilldown on

***

### `drilldownSelections`

**drilldownSelections**?: `never`

Current selections for multiple drilldowns

***

### `drilldownTarget`

**drilldownTarget**?: `never`

Current pivot table data option target for the drilldown


---

---
title: PivotTableSelectableDrilldownOptions
---

# Type alias PivotTableSelectableDrilldownOptions

> **PivotTableSelectableDrilldownOptions**: `object`

Configuration for the pivot table drilldown with initial target and selections defined

## Type declaration

### `drilldownPaths`

**drilldownPaths**?: ([`Attribute`](../../sdk-data/interfaces/interface.Attribute.md) \| [`Hierarchy`](../interfaces/interface.Hierarchy.md) \| [`HierarchyId`](../../sdk-ui/type-aliases/type-alias.HierarchyId.md))[]

Dimensions and hierarchies available for drilldown on

***

### `drilldownSelections`

**drilldownSelections**: [`DrilldownSelection`](type-alias.DrilldownSelection.md)[]

Current selections for multiple drilldowns

***

### `drilldownTarget`

**drilldownTarget**: [`Attribute`](../../sdk-data/interfaces/interface.Attribute.md) \| [`DataOptionLocation`](type-alias.DataOptionLocation.md)

Current pivot table data option target for the drilldown

Can be either:
- An `Attribute` directly (when you know the specific attribute to target)
- A `DataOptionLocation` (when you need to reference a data option by its position in the data options structure)


---

---
title: PivotTableWidgetStyleOptions
---

# Type alias PivotTableWidgetStyleOptions

> **PivotTableWidgetStyleOptions**: [`PivotTableStyleOptions`](../interfaces/interface.PivotTableStyleOptions.md) & [`WidgetContainerStyleOptions`](../../sdk-ui/interfaces/interface.WidgetContainerStyleOptions.md)

Style settings defining the look and feel of PivotTableWidget


---

---
title: PolarSubtype
---

# Type alias PolarSubtype

> **PolarSubtype**: `"polar/area"` \| `"polar/column"` \| `"polar/line"`

Property of [PolarStyleOptions](../interfaces/interface.PolarStyleOptions.md)

Subtype of PolarChart

**Values**

- `polar/column` - a chart where data points are displayed using the angle and distance from the center point.
- `polar/area` - a chart in which the data points are connected by a line with the area below the line filled.
- `polar/line` -  a chart in which the data points are connected by a line.


---

---
title: RangeChartType
---

# Type alias RangeChartType

> **RangeChartType**: `"arearange"`

AreaRange chart types


---

---
title: RangeDataColorOptions
---

# Type alias RangeDataColorOptions

> **RangeDataColorOptions**: `object`

Range color options for data similar to the Range option in the Sisense UI.

Use `minColor` and `maxColor` to define the start and end color of the range.
A color name (for example, `red`), or a hexadecimal value (for example, `#ff0000`) can be specified.

By default, the color range is set to match the minimum and maximum values of the data.
You can also override the default value range by
setting the `minValue`, `midValue`, and `maxValue` properties.

## Example

An example of specifying colors for data values ranging
from red (for min value) to blue (for max value)
with 2 more colors in between for a total of 4 colors:

```ts
{
  type: 'range',
  steps: 4,
  minColor: 'red',
  maxColor: 'blue',
}
```

## Type declaration

### `maxColor`

**maxColor**?: `string`

End color of the range

***

### `maxValue`

**maxValue**?: `number`

Maximum value explicitly set to override the maximum value of the data

***

### `midValue`

**midValue**?: `number`

Middle value explicitly set to override the middle value of the data

***

### `minColor`

**minColor**?: `string`

Start color of the range

***

### `minValue`

**minValue**?: `number`

Minimum value explicitly set to override the minimum value of the data

***

### `steps`

**steps**?: `number`

Distinct number of colors in the range

***

### `type`

**type**: `"range"`

Color options type


---

---
title: ScatterChartType
---

# Type alias ScatterChartType

> **ScatterChartType**: `"scatter"`

Scatter chart types


---

---
title: ScatterDataPoint
---

# Type alias ScatterDataPoint

> **ScatterDataPoint**: `object`

Data point in a Scatter chart.

## Type declaration

### `breakByColor`

**breakByColor**?: `string`

Value of the break by color

***

### `breakByPoint`

**breakByPoint**?: `string`

Value of the break by point

***

### `entries`

**entries**?: `object`

A collection of data point entries that represents values for all related `dataOptions`.

> #### `entries.breakByColor`
>
> **breakByColor**?: [`DataPointEntry`](../../sdk-ui/type-aliases/type-alias.DataPointEntry.md)
>
> Data point entry for the `breakByColor` data options
>
> #### `entries.breakByPoint`
>
> **breakByPoint**?: [`DataPointEntry`](../../sdk-ui/type-aliases/type-alias.DataPointEntry.md)
>
> Data point entry for the `breakByPoint` data options
>
> #### `entries.size`
>
> **size**?: [`DataPointEntry`](../../sdk-ui/type-aliases/type-alias.DataPointEntry.md)
>
> Data point entry for the `size` data options
>
> #### `entries.x`
>
> **x**?: [`DataPointEntry`](../../sdk-ui/type-aliases/type-alias.DataPointEntry.md)
>
> Data point entry for the `x` data options
>
> #### `entries.y`
>
> **y**?: [`DataPointEntry`](../../sdk-ui/type-aliases/type-alias.DataPointEntry.md)
>
> Data point entry for the `y` data options
>
>

***

### `size`

**size**?: `number`

Size of the data point

***

### `x`

**x**?: `number` \| `string`

Value of the x axis

***

### `y`

**y**?: `number` \| `string`

Value of the y axis


---

---
title: ScatterDataPointEvent
---

# Type alias ScatterDataPointEvent

> **ScatterDataPointEvent**: `object`

## Type declaration

### `nativeEvent`

**nativeEvent**: `PointerEvent`

Native PointerEvent

***

### `point`

**point**: [`ScatterDataPoint`](type-alias.ScatterDataPoint.md)

Data point that was clicked


---

---
title: ScatterDataPointEventHandler
---

# Type alias ScatterDataPointEventHandler

> **ScatterDataPointEventHandler**: (`event`) => `void`

Click handler for when a scatter data point is clicked

## Parameters

| Parameter | Type |
| :------ | :------ |
| `event` | [`ScatterDataPointEvent`](type-alias.ScatterDataPointEvent.md) |

## Returns

`void`


---

---
title: ScatterDataPointsEvent
---

# Type alias ScatterDataPointsEvent

> **ScatterDataPointsEvent**: `object`

## Type declaration

### `nativeEvent`

**nativeEvent**: `MouseEvent`

Native MouseEvent

***

### `points`

**points**: [`ScatterDataPoint`](type-alias.ScatterDataPoint.md)[]

Data points that were selected


---

---
title: ScatterDataPointsEventHandler
---

# Type alias ScatterDataPointsEventHandler

> **ScatterDataPointsEventHandler**: (`event`) => `void`

Click handler for when multiple scatter data points are selected.

## Parameters

| Parameter | Type |
| :------ | :------ |
| `event` | [`ScatterDataPointsEvent`](type-alias.ScatterDataPointsEvent.md) |

## Returns

`void`


---

---
title: ScatterMarkerSize
---

# Type alias ScatterMarkerSize

> **ScatterMarkerSize**: `object`

## Type declaration

### `scatterBubbleMaxSize`

**scatterBubbleMaxSize**: `number`

***

### `scatterBubbleMinSize`

**scatterBubbleMinSize**: `number`

***

### `scatterDefaultSize`

**scatterDefaultSize**: `number`


---

---
title: ScattermapChartType
---

# Type alias ScattermapChartType

> **ScattermapChartType**: `"scattermap"`

Scattermap chart types


---

---
title: ScattermapDataPointEvent
---

# Type alias ScattermapDataPointEvent

> **ScattermapDataPointEvent**: `object`

## Type declaration

### `nativeEvent`

**nativeEvent**: `MouseEvent`

Native MouseEvent

***

### `point`

**point**: [`ScattermapDataPoint`](../../sdk-ui/type-aliases/type-alias.ScattermapDataPoint.md)

Data point that was clicked


---

---
title: ScattermapDataPointEventHandler
---

# Type alias ScattermapDataPointEventHandler

> **ScattermapDataPointEventHandler**: (`event`) => `void`

Click handler for when a data point on Scattermap is clicked.

## Parameters

| Parameter | Type |
| :------ | :------ |
| `event` | [`ScattermapDataPointEvent`](type-alias.ScattermapDataPointEvent.md) |

## Returns

`void`


---

---
title: ScattermapLocationLevel
---

# Type alias ScattermapLocationLevel

> **ScattermapLocationLevel**: `"auto"` \| `"city"` \| `"country"` \| `"state"`

Geographic location level for Scattermap chart.
This type can have one of the following values:
- 'auto': Automatically determines the appropriate location level.
- 'country': Represents the country level in the geographical hierarchy.
- 'state': Represents the state or province level in the geographical hierarchy.
- 'city': Represents the city level in the geographical hierarchy.


---

---
title: ScattermapMarkers
---

# Type alias ScattermapMarkers

> **ScattermapMarkers**: `object`

Markers style configuration of Scattermap chart

## Type declaration

### `fill`

**fill**?: `"filled"` \| `"filled-light"` \| `"hollow"` \| `"hollow-bold"`

Specifies the fill style of the markers

***

### `size`

**size**?: `object`

Specifies the size configuration for the markers

> #### `size.defaultSize`
>
> **defaultSize**?: `number`
>
> The default size of the markers
>
> #### `size.maxSize`
>
> **maxSize**?: `number`
>
> The maximum size of the markers when using a "size" data field
>
> #### `size.minSize`
>
> **minSize**?: `number`
>
> The minimum size of the markers when using a "size" data field
>
>


---

---
title: SeriesChartType
---

# Type alias SeriesChartType

> **SeriesChartType**: `"area"` \| `"arearange"` \| `"areaspline"` \| `"auto"` \| `"bar"` \| `"column"` \| `"line"` \| `"scatter"` \| `"spline"`

Series chart type, which is used with [StyledMeasureColumn](../interfaces/interface.StyledMeasureColumn.md) to customize
series in a mixed chart.


---

---
title: SeriesLabels
---

# Type alias SeriesLabels

> **SeriesLabels**: [`SeriesLabelsBase`](../../sdk-ui/type-aliases/type-alias.SeriesLabelsBase.md) & [`SeriesLabelsAligning`](../../sdk-ui/type-aliases/type-alias.SeriesLabelsAligning.md) & \{
  `showPercentage`: `boolean`;
  `showPercentDecimals`: `boolean`;
  `showValue`: `boolean`;
 }

Options that define series labels - titles/names identifying data series in a chart.

> ## `SeriesLabels.showPercentage`
>
> **showPercentage**?: `boolean`
>
> Boolean flag that defines if percentage should be shown in series labels
> (only applicable for subtypes that support percentage, like "stacked100")
>
> ## `SeriesLabels.showPercentDecimals`
>
> **showPercentDecimals**?: `boolean`
>
> Boolean flag that defines if percentage should be shown with decimals
> (will work only if `showPercentage` is `true`)
>
> ## `SeriesLabels.showValue`
>
> **showValue**?: `boolean`
>
> Boolean flag that defines if value should be shown in series labels
> (if not specified, default is determined by chart type)
>
>


---

---
title: SortDirection
---

# Type alias SortDirection

> **SortDirection**: `"sortAsc"` \| `"sortDesc"` \| `"sortNone"`

Sorting direction, either in Ascending order, Descending order, or None


---

---
title: StackableSubtype
---

# Type alias StackableSubtype

> **StackableSubtype**: `"bar/classic"` \| `"bar/stacked"` \| `"bar/stacked100"` \| `"column/classic"` \| `"column/stackedcolumn"` \| `"column/stackedcolumn100"`

Property of [StackableSubtype](type-alias.StackableSubtype.md)

Subtype of BarChart

 **Values**
- `bar/classic` - y axis values displayed vertically.
- `bar/stacked` - y axis values are stacked next to each other and do not overlap.
- `bar/stacked100` - y axis values are stacked next to each other but do not overlap and combined and stretched to represent 100%.
- `column/classic` - columns are displayed side by side.
- `column/stackedcolumn` - columns are stacked on top of each other and do not overlap.
- `column/stackedcolumn100` - columns are stacked on top of each other but do not overlap and combined and stretched to represent 100%.


---

---
title: TableType
---

# Type alias TableType

> **TableType**: `"table"`

Table chart types


---

---
title: TabularWidgetType
---

# Type alias TabularWidgetType

> **TabularWidgetType**: `"pivot"` \| `"pivot2"` \| `"tablewidget"` \| `"tablewidgetagg"`

The type of a widget on a dashboard that is a variant of tabular widget.


---

---
title: TextWidgetDataPointEvent
---

# Type alias TextWidgetDataPointEvent

> **TextWidgetDataPointEvent**: `object`

## Type declaration

### `nativeEvent`

**nativeEvent**: `MouseEvent`

Native MouseEvent

***

### `point`

**point**: `TextWidgetDataPoint`

Data point that was clicked


---

---
title: ThemeConfig
---

# Type alias ThemeConfig

> **ThemeConfig**: `PropsWithChildren`\< \{
  `theme`: [`ThemeOid`](type-alias.ThemeOid.md) \| [`ThemeSettings`](../interfaces/interface.ThemeSettings.md);
 } \>

Configurations for Theme.

Two options are supported:

(1) `ThemeSettings` -- Custom theme settings that override the default theme settings.

OR

(2) `ThemeOid` -- Theme identifier as defined in a Fusion instance (**Admin > App Configuration > Look and Feel**).
See [Customizing the Sisense User Interface](https://docs.sisense.com/main/SisenseLinux/customizing-the-sisense-user-interface.htm) for more details.


---

---
title: ThemeOid
---

# Type alias ThemeOid

> **ThemeOid**: `string`

Identifier of a theme as defined in the Sisense instance.


---

---
title: TranslationConfig
---

# Type alias TranslationConfig

> **TranslationConfig**: `object`

Translation Configuration

## Type declaration

### `customTranslations`

**customTranslations**?: ([`CustomTranslationObject`](../../sdk-ui/type-aliases/type-alias.CustomTranslationObject.md) \| [`CustomTranslationObject`](../../sdk-ui/type-aliases/type-alias.CustomTranslationObject.md)[])[]

Additional translation resources to be loaded.

You can find the list of available translation keys in the translation folder of every package.

Translation keys that are not provided will default to the English translation.
If translation is provided for a package other than sdk-ui, please specify the namespace property.

Important: Do not translate parts in {{}} - these are placeholders for dynamic values and will be matched using provided variable names.

#### Example

```ts
customTranslations: [
  {
    language: 'fr',
    resources: {
      errors: {
       invalidFilterType: 'Type de filtre invalide',
      },
    },
  },
  {
    language: 'es',
    namespace: 'sdkData'
    resources: {
      errors: {
        measure: {
          unsupportedType: 'Tipo de medida no compatible',
        },
      },
    },
  },
]
```

***

### `language`

**language**?: `string`

Language code to be used for translations.


---

---
title: UniformDataColorOptions
---

# Type alias UniformDataColorOptions

> **UniformDataColorOptions**: `object`

Uniform color options for data similar to the Single Color option in the Sisense UI.

## Example

An example of specifying red as a uniform color for all data values.

```ts
{
  type: 'uniform',
  color: 'red',
}
```

## Type declaration

### `color`

**color**: `string`

Color name, e.g., `red`, or a hexadecimal value, e.g., `#ff0000`.

***

### `type`

**type**: `"uniform"`

Color options type


---

---
title: ValueToColorMap
---

# Type alias ValueToColorMap

> **ValueToColorMap**: `object`

Mapping of each of the chart value series to colors.

## Index signature

 \[`value`: `string`\]: `string`


---

---
title: WidgetDataOptions
---

# Type alias WidgetDataOptions

> **WidgetDataOptions**: [`ChartDataOptions`](type-alias.ChartDataOptions.md) \| `EmptyObject` \| [`PivotTableDataOptions`](../interfaces/interface.PivotTableDataOptions.md)

Widget data options.


---

---
title: WidgetDataPointClickEvent
---

# Type alias WidgetDataPointClickEvent

> **WidgetDataPointClickEvent**: [`ChartDataPointClickEvent`](type-alias.ChartDataPointClickEvent.md) \| [`PivotTableDataPointEvent`](type-alias.PivotTableDataPointEvent.md) \| [`TextWidgetDataPointEvent`](type-alias.TextWidgetDataPointEvent.md)


---

---
title: WidgetDataPointClickEventHandler
---

# Type alias WidgetDataPointClickEventHandler

> **WidgetDataPointClickEventHandler**: (`event`) => `void`

Click handler for when a data point on Widget is clicked.

## Parameters

| Parameter | Type |
| :------ | :------ |
| `event` | [`WidgetDataPointClickEvent`](type-alias.WidgetDataPointClickEvent.md) |

## Returns

`void`


---

---
title: WidgetDataPointContextMenuEvent
---

# Type alias WidgetDataPointContextMenuEvent

> **WidgetDataPointContextMenuEvent**: [`ChartDataPointContextMenuEvent`](type-alias.ChartDataPointContextMenuEvent.md) \| [`PivotTableDataPointEvent`](type-alias.PivotTableDataPointEvent.md)


---

---
title: WidgetDataPointContextMenuEventHandler
---

# Type alias WidgetDataPointContextMenuEventHandler

> **WidgetDataPointContextMenuEventHandler**: (`event`) => `void`

Context menu handler for when a data point on Widget is right-clicked.

## Parameters

| Parameter | Type |
| :------ | :------ |
| `event` | [`WidgetDataPointContextMenuEvent`](type-alias.WidgetDataPointContextMenuEvent.md) |

## Returns

`void`


---

---
title: WidgetId
---

# Type alias WidgetId

> **WidgetId**: `string`

Widget ID


---

---
title: WidgetProps
---

# Type alias WidgetProps

> **WidgetProps**: `SoftUnion`\< [`WithCommonWidgetProps`](type-alias.WithCommonWidgetProps.md)\< [`ChartWidgetProps`](../interfaces/interface.ChartWidgetProps.md), `"chart"` \> \| [`WithCommonWidgetProps`](type-alias.WithCommonWidgetProps.md)\< [`CustomWidgetProps`](../../sdk-ui/interfaces/interface.CustomWidgetProps.md), `"custom"` \> \| [`WithCommonWidgetProps`](type-alias.WithCommonWidgetProps.md)\< [`PivotTableWidgetProps`](../interfaces/interface.PivotTableWidgetProps.md), `"pivot"` \> \| [`WithCommonWidgetProps`](type-alias.WithCommonWidgetProps.md)\< [`TextWidgetProps`](../interfaces/interface.TextWidgetProps.md), `"text"` \> \> & \{
  `dataPointClick`: [`WidgetDataPointClickEventHandler`](type-alias.WidgetDataPointClickEventHandler.md);
  `dataPointContextMenu`: [`WidgetDataPointContextMenuEventHandler`](type-alias.WidgetDataPointContextMenuEventHandler.md);
  `dataPointsSelect`: [`ChartDataPointsEventHandler`](type-alias.ChartDataPointsEventHandler.md);
 }

Props of the [WidgetComponent](../dashboards/class.WidgetComponent.md).

> ## `WidgetProps.dataPointClick`
>
> **dataPointClick**?: [`WidgetDataPointClickEventHandler`](type-alias.WidgetDataPointClickEventHandler.md)
>
> ## `WidgetProps.dataPointContextMenu`
>
> **dataPointContextMenu**?: [`WidgetDataPointContextMenuEventHandler`](type-alias.WidgetDataPointContextMenuEventHandler.md)
>
> ## `WidgetProps.dataPointsSelect`
>
> **dataPointsSelect**?: [`ChartDataPointsEventHandler`](type-alias.ChartDataPointsEventHandler.md)
>
>


---

---
title: WidgetStyleOptions
---

# Type alias WidgetStyleOptions

> **WidgetStyleOptions**: [`ChartStyleOptions`](type-alias.ChartStyleOptions.md) \| [`CustomWidgetStyleOptions`](../../sdk-ui/type-aliases/type-alias.CustomWidgetStyleOptions.md) \| [`TableStyleOptions`](../interfaces/interface.TableStyleOptions.md) \| [`TextWidgetStyleOptions`](../../sdk-ui/type-aliases/type-alias.TextWidgetStyleOptions.md) & [`WidgetContainerStyleOptions`](../../sdk-ui/interfaces/interface.WidgetContainerStyleOptions.md)

Complete set of configuration options that define functional style of the various elements of the charts as well as the look and feel of widget itself and widget header.


---

---
title: WidgetType
---

# Type alias WidgetType

> **WidgetType**: `"chart"` \| `"custom"` \| `"pivot"` \| `"text"`

Type of the widget component.


---

---
title: WidgetsOptions
---

# Type alias WidgetsOptions

> **WidgetsOptions**: `Record`\< [`WidgetId`](type-alias.WidgetId.md), [`SpecificWidgetOptions`](../../sdk-ui/type-aliases/type-alias.SpecificWidgetOptions.md) \>

Options for widgets in a dashboard

For example, how common filters defined at the dashboard level should be applied to widgets.


---

---
title: WidgetsPanelLayout
---

# Type alias WidgetsPanelLayout

> **WidgetsPanelLayout**: [`WidgetsPanelColumnLayout`](../interfaces/interface.WidgetsPanelColumnLayout.md)

Layout of dashboard widgets panel, which is a union of different layout algorithms


---

---
title: WithCommonWidgetProps
---

# Type alias WithCommonWidgetProps`<BaseWidget, Type>`

> **WithCommonWidgetProps**: <`BaseWidget`, `Type`> `BaseWidget` & \{
  `id`: `string`;
  `widgetType`: `Type`;
 }

A utility type that combines widget-specific properties (`BaseWidget`)
with a common widget props including corresponding widget type (`Type`).

> ## `WithCommonWidgetProps.id`
>
> **`readonly`** **id**: `string`
>
> Unique identifier of the widget within the container component (dashboard)
>
> ## `WithCommonWidgetProps.widgetType`
>
> **widgetType**: `Type`
>
> Widget type
>
>

## Type parameters

| Parameter | Description |
| :------ | :------ |
| `BaseWidget` |  |
| `Type` |  |


---

---
title: X2Title
---

# Type alias X2Title

> **X2Title**: `object`

## Type declaration

### `enabled`

**enabled**: `boolean`

***

### `text`

**text**?: `string`

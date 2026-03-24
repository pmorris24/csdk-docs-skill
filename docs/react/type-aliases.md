---
title: AbstractDataPointWithEntries
---

# Type alias AbstractDataPointWithEntries

> **AbstractDataPointWithEntries**: `object`

A basic data point with entries.

## Type declaration

### `entries`

**entries**?: `Record`\< `string`, [`DataPointEntry`](type-alias.DataPointEntry.md) \| [`DataPointEntry`](type-alias.DataPointEntry.md)[] \>

A collection of data point entries that represents values for all related `dataOptions`.


---

---
title: AlignmentTypes
---

# Type alias AlignmentTypes

> **AlignmentTypes**: `"Center"` \| `"Left"` \| `"Right"`

Possible types of text alignment.


---

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

**loadingIndicatorConfig**?: [`LoadingIndicatorConfig`](type-alias.LoadingIndicatorConfig.md)

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
title: AreaRangeSubtype
---

# Type alias AreaRangeSubtype

> **AreaRangeSubtype**: `"arearange/basic"` \| `"arearange/spline"`

Property of [AreaRangeStyleOptions](../interfaces/interface.AreaRangeStyleOptions.md)

Subtype of AreaRangeChart

**Values**

- `arearange/spline` - curved line from point to point.
- `arearange/basic` - straight line from point to point.


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
title: AreamapDataPoint
---

# Type alias AreamapDataPoint

> **AreamapDataPoint**: [`GeoDataElement`](type-alias.GeoDataElement.md) & \{
  `entries`: \{
    `color`: [`DataPointEntry`](type-alias.DataPointEntry.md)[];
    `geo`: [`DataPointEntry`](type-alias.DataPointEntry.md)[];
  };
 }

Data point in an Areamap chart.

> ## `AreamapDataPoint.entries`
>
> **entries**?: `object`
>
> A collection of data point entries that represents values for all related `dataOptions`.
>
> > ### `entries.color`
> >
> > **color**: [`DataPointEntry`](type-alias.DataPointEntry.md)[]
> >
> > Data point entries for the `color` data options
> >
> > ### `entries.geo`
> >
> > **geo**: [`DataPointEntry`](type-alias.DataPointEntry.md)[]
> >
> > Data point entries for the `geo` data options
> >
> >
>
>


---

---
title: AreamapDataPointEventHandler
---

# Type alias AreamapDataPointEventHandler

> **AreamapDataPointEventHandler**: (`point`, `nativeEvent`) => `void`

Click handler for when a data point on Areamap is clicked.

## Parameters

| Parameter | Type |
| :------ | :------ |
| `point` | [`AreamapDataPoint`](type-alias.AreamapDataPoint.md) |
| `nativeEvent` | `MouseEvent` |

## Returns

`void`


---

---
title: AreamapType
---

# Type alias AreamapType

> **AreamapType**: `"usa"` \| `"world"`

Type of map to display on the AreamapChart component


---

---
title: AutoZoomNavigatorScrollerLocation
---

# Type alias AutoZoomNavigatorScrollerLocation

> **AutoZoomNavigatorScrollerLocation**: `object`

The scroll location of the navigator scroller / auto zoom feature

## Type declaration

### `max`

**max**: `number`

***

### `min`

**min**: `number`


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
> **category**: [`DataPointEntry`](type-alias.DataPointEntry.md)[]
>
> Data point entries for the `category` data options
>
> #### `entries.outliers`
>
> **outliers**: [`DataPointEntry`](type-alias.DataPointEntry.md)[]
>
> Data point entries for the `outliers` data options
>
> #### `entries.value`
>
> **value**: [`DataPointEntry`](type-alias.DataPointEntry.md)[]
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
title: BoxplotDataPointEventHandler
---

# Type alias BoxplotDataPointEventHandler

> **BoxplotDataPointEventHandler**: (`point`, `nativeEvent`) => `void`

Click handler for when a data point on Boxplot is clicked.

## Parameters

| Parameter | Type |
| :------ | :------ |
| `point` | [`BoxplotDataPoint`](type-alias.BoxplotDataPoint.md) |
| `nativeEvent` | `PointerEvent` |

## Returns

`void`


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
title: CalendarHeatmapCellLabels
---

# Type alias CalendarHeatmapCellLabels

> **CalendarHeatmapCellLabels**: `object`

Configuration for day numbers (1-31) labels in calendar-heatmap cells

## Type declaration

### `enabled`

**enabled**?: `boolean`

Boolean flag that defines if calendar day numbers should be shown in cells

#### Default

```ts
true
```

***

### `style`

**style**?: `Omit`\< [`TextStyle`](type-alias.TextStyle.md), `"color"` \> & \{
  `color`: `"contrast"` \| `string`;
 }

Style configuration for calendar day numbers in cells

::: warning Deprecated
Please use `textStyle` instead
:::

> #### `style.color`
>
> **color**?: `"contrast"` \| `string`
>
> Color of the labels text
>
> The "contrast" color applies the maximum contrast between the background and the text
>
>

***

### `textStyle`

**textStyle**?: `Omit`\< [`TextStyle`](type-alias.TextStyle.md), `"color"` \> & \{
  `color`: `"contrast"` \| `string`;
 }

Style configuration for calendar day numbers in cells

> #### `textStyle.color`
>
> **color**?: `"contrast"` \| `string`
>
> Color of the labels text
>
> The "contrast" color applies the maximum contrast between the background and the text
>
>


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
> **date**: [`DataPointEntry`](type-alias.DataPointEntry.md)
>
> Data point entry for the `date` data options
>
> #### `entries.value`
>
> **value**?: [`DataPointEntry`](type-alias.DataPointEntry.md)
>
> Data point entry for the `value` data options
>
>


---

---
title: CalendarHeatmapDataPointEventHandler
---

# Type alias CalendarHeatmapDataPointEventHandler

> **CalendarHeatmapDataPointEventHandler**: (`point`, `nativeEvent`) => `void`

Click handler for when a calendar-heatmap data point is clicked

## Parameters

| Parameter | Type |
| :------ | :------ |
| `point` | [`CalendarHeatmapDataPoint`](type-alias.CalendarHeatmapDataPoint.md) |
| `nativeEvent` | `PointerEvent` |

## Returns

`void`


---

---
title: CalendarHeatmapDataPointsEventHandler
---

# Type alias CalendarHeatmapDataPointsEventHandler

> **CalendarHeatmapDataPointsEventHandler**: (`points`, `nativeEvent`) => `void`

Click handler for when multiple calendar-heatmap data points are selected.

## Parameters

| Parameter | Type |
| :------ | :------ |
| `points` | [`CalendarHeatmapDataPoint`](type-alias.CalendarHeatmapDataPoint.md)[] |
| `nativeEvent` | `MouseEvent` |

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

> **ChartDataOptions**: [`RegularChartDataOptions`](type-alias.RegularChartDataOptions.md) \| [`TabularChartDataOptions`](type-alias.TabularChartDataOptions.md)

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
title: ChartDataPoint
---

# Type alias ChartDataPoint

> **ChartDataPoint**: [`AreamapDataPoint`](type-alias.AreamapDataPoint.md) \| [`BoxplotDataPoint`](type-alias.BoxplotDataPoint.md) \| [`CalendarHeatmapDataPoint`](type-alias.CalendarHeatmapDataPoint.md) \| [`DataPoint`](type-alias.DataPoint.md) \| [`ScatterDataPoint`](type-alias.ScatterDataPoint.md) \| [`ScattermapDataPoint`](type-alias.ScattermapDataPoint.md)

Abstract data point in a chart - union of all types of data points.


---

---
title: ChartDataPoints
---

# Type alias ChartDataPoints

> **ChartDataPoints**: [`AreamapDataPoint`](type-alias.AreamapDataPoint.md)[] \| [`BoxplotDataPoint`](type-alias.BoxplotDataPoint.md)[] \| [`CalendarHeatmapDataPoint`](type-alias.CalendarHeatmapDataPoint.md)[] \| [`DataPoint`](type-alias.DataPoint.md)[] \| [`ScatterDataPoint`](type-alias.ScatterDataPoint.md)[] \| [`ScattermapDataPoint`](type-alias.ScattermapDataPoint.md)[]

Data points in a chart. Array of data points of the same data point type.


---

---
title: ChartDataPointsEventHandler
---

# Type alias ChartDataPointsEventHandler

> **ChartDataPointsEventHandler**: (`points`, `nativeEvent`) => `void`

Click handler for when an abstract data point (data point of any chart) is clicked

## Parameters

| Parameter | Type |
| :------ | :------ |
| `points` | [`ChartDataPoints`](type-alias.ChartDataPoints.md) |
| `nativeEvent` | `MouseEvent` \| `PointerEvent` |

## Returns

`void`


---

---
title: ChartStyleOptions
---

# Type alias ChartStyleOptions

> **ChartStyleOptions**: [`RegularChartStyleOptions`](type-alias.RegularChartStyleOptions.md) \| [`TabularChartStyleOptions`](type-alias.TabularChartStyleOptions.md)

Configuration options that define functional style of the various elements of chart.


---

---
title: ChartType
---

# Type alias ChartType

> **ChartType**: [`AreamapChartType`](type-alias.AreamapChartType.md) \| [`BoxplotChartType`](type-alias.BoxplotChartType.md) \| [`CalendarHeatmapChartType`](type-alias.CalendarHeatmapChartType.md) \| [`CartesianChartType`](type-alias.CartesianChartType.md) \| [`CategoricalChartType`](type-alias.CategoricalChartType.md) \| [`IndicatorChartType`](type-alias.IndicatorChartType.md) \| [`RangeChartType`](type-alias.RangeChartType.md) \| [`ScatterChartType`](type-alias.ScatterChartType.md) \| [`ScattermapChartType`](type-alias.ScattermapChartType.md) \| [`TableChartType`](type-alias.TableChartType.md)

Chart type of one of the supported chart families


---

---
title: ChartWidgetStyleOptions
---

# Type alias ChartWidgetStyleOptions

> **ChartWidgetStyleOptions**: [`ChartStyleOptions`](type-alias.ChartStyleOptions.md) & [`WidgetContainerStyleOptions`](../interfaces/interface.WidgetContainerStyleOptions.md)

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
title: ColorValue
---

# Type alias ColorValue

> **ColorValue**: `string`

A color value that can be a CSS color string, hex value, or rgba/hsla string.


---

---
title: CommonFiltersOptions
---

# Type alias CommonFiltersOptions

> **CommonFiltersOptions**: `object`

Options for common filters defined at the dashboard level to be applied to certain widgets.

## Type declaration

### `applyMode`

**applyMode**?: \`$\{CommonFiltersApplyMode}\`

Apply mode for common filters: 'highlight' or 'filter'.

***

### `forceApplyBackgroundFilters`

**forceApplyBackgroundFilters**?: `boolean`

Boolean flag whether to apply all background filters as slice filters ignoring "disabled" state and "ignoreFilters" rules

If not specified, the default value is `true`.

***

### `ignoreFilters`

**ignoreFilters**?: [`FiltersIgnoringRules`](type-alias.FiltersIgnoringRules.md)

Filters to ignore when applying common filters.

***

### `shouldAffectFilters`

**shouldAffectFilters**?: `boolean`

Boolean flag whether widget interactions – for example, selection of bars on a bar chart –
should affect common filters.

If not specified, the default value is `true`.


---

---
title: ComposableDashboardProps
---

# Type alias ComposableDashboardProps

> **ComposableDashboardProps**: `Pick`\< [`DashboardProps`](../interfaces/interface.DashboardProps.md), `"config"` \| `"filters"` \| `"layoutOptions"` \| `"widgets"` \| `"widgetsOptions"` \>


---

---
title: ComposedDashboardResult
---

# Type alias ComposedDashboardResult`<D>`

> **ComposedDashboardResult**: <`D`> `object`

Result of the [useComposedDashboard](../dashboards/function.useComposedDashboard.md) hook.

## Type parameters

| Parameter |
| :------ |
| `D` *extends* [`ComposableDashboardProps`](type-alias.ComposableDashboardProps.md) \| [`DashboardProps`](../interfaces/interface.DashboardProps.md) |

## Type declaration

### `dashboard`

**dashboard**: `D`

The composable dashboard object containing the current state of the dashboard.

***

### `setFilters`

**setFilters**: (`filters`) => `void`

API to set filters on the dashboard.

#### Parameters

| Parameter | Type |
| :------ | :------ |
| `filters` | [`FilterRelations`](../../sdk-data/interfaces/interface.FilterRelations.md) \| [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[] |

#### Returns

`void`

***

### `setWidgetsLayout`

**setWidgetsLayout**: (`newLayout`) => `void`

API to set the layout of the widgets on the dashboard.

#### Parameters

| Parameter | Type |
| :------ | :------ |
| `newLayout` | [`WidgetsPanelLayout`](type-alias.WidgetsPanelLayout.md) |

#### Returns

`void`


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
title: Coordinates
---

# Type alias Coordinates

> **Coordinates**: `object`

## Type declaration

### `lat`

**lat**: `number`

***

### `lng`

**lng**: `number`


---

---
title: CsvQueryErrorState
---

# Type alias CsvQueryErrorState

> **CsvQueryErrorState**: `object`

State of a query execution that has failed.

## Type declaration

### `data`

**data**: `undefined`

The result data if the query has succeeded

***

### `error`

**error**: `Error`

The error if any occurred

***

### `isError`

**isError**: `true`

Whether the query has failed

***

### `isLoading`

**isLoading**: `false`

Whether the query is loading

***

### `isSuccess`

**isSuccess**: `false`

Whether the query has succeeded

***

### `status`

**status**: `"error"`

The status of the query execution


---

---
title: CsvQueryLoadingState
---

# Type alias CsvQueryLoadingState

> **CsvQueryLoadingState**: `object`

State of a query execution that is loading.

## Type declaration

### `data`

**data**: `Blob` \| `string` \| `undefined`

The result data if the query has succeeded

***

### `error`

**error**: `undefined`

The error if any occurred

***

### `isError`

**isError**: `false`

Whether the query has failed

***

### `isLoading`

**isLoading**: `true`

Whether the query is loading

***

### `isSuccess`

**isSuccess**: `false`

Whether the query has succeeded

***

### `status`

**status**: `"loading"`

The status of the query execution


---

---
title: CsvQueryState
---

# Type alias CsvQueryState

> **CsvQueryState**: [`CsvQueryErrorState`](type-alias.CsvQueryErrorState.md) \| [`CsvQueryLoadingState`](type-alias.CsvQueryLoadingState.md) \| [`CsvQuerySuccessState`](type-alias.CsvQuerySuccessState.md)

State of a query execution.


---

---
title: CsvQuerySuccessState
---

# Type alias CsvQuerySuccessState

> **CsvQuerySuccessState**: `object`

State of a query execution that has succeeded.

## Type declaration

### `data`

**data**: `Blob` \| `string`

The result data if the query has succeeded

***

### `error`

**error**: `undefined`

The error if any occurred

***

### `isError`

**isError**: `false`

Whether the query has failed

***

### `isLoading`

**isLoading**: `false`

Whether the query is loading

***

### `isSuccess`

**isSuccess**: `true`

Whether the query has succeeded

***

### `status`

**status**: `"success"`

The status of the query execution


---

---
title: CustomDrilldownResult
---

# Type alias CustomDrilldownResult

> **CustomDrilldownResult**: `object`

Result of custom drilldown execution

User provides selected points and desired category to drilldown to
and receives set of filters to apply and new category to display

## Type declaration

### `breadcrumbsComponent`

**breadcrumbsComponent**?: `JSX.Element`

Breadcrumbs that only allow for selection slicing, clearing, & navigation

***

### `drilldownDimension`

**drilldownDimension**: [`Attribute`](../../sdk-data/interfaces/interface.Attribute.md)

New dimension that should replace the current dimension

***

### `drilldownFilters`

**drilldownFilters**: `MembersFilter`[]

The drilldown filters that should be applied to the next drilldown

***

### `onContextMenu`

**onContextMenu**: (`menuPosition`) => `void`

Callback to open context menu

#### Parameters

| Parameter | Type |
| :------ | :------ |
| `menuPosition` | [`MenuPosition`](type-alias.MenuPosition.md) |

#### Returns

`void`

***

### `onDataPointsSelected`

**onDataPointsSelected**: [`DataPointsEventHandler`](type-alias.DataPointsEventHandler.md)

Callback to provide next points to drilldown to


---

---
title: CustomTranslationObject
---

# Type alias CustomTranslationObject

> **CustomTranslationObject**: `object`

Custom translation object.

## Type declaration

### `language`

**language**: `string`

The language code of the translations.

***

### `namespace`

**namespace**?: `string`

The translation namespace (usually a package name in camelCase). It identifies the specific context in which the translation is being registered.
If not specified, the default value is `sdkUi`.

***

### `resources`

**resources**: [`NestedTranslationResources`](type-alias.NestedTranslationResources.md)

The translation resources.


---

---
title: CustomWidgetComponent
---

# Type alias CustomWidgetComponent`<Props>`

> **CustomWidgetComponent**: <`Props`> (`props`) => `ReactNode`

A user-defined custom widget component. This is can be specified when registering a
custom widget with `registerCustomWidget` from the `useCustomWidgets` hook.

## Type parameters

| Parameter | Default | Description |
| :------ | :------ | :------ |
| `Props` | [`CustomWidgetComponentProps`](../interfaces/interface.CustomWidgetComponentProps.md) | The props type for the custom widget component |

## Parameters

| Parameter | Type |
| :------ | :------ |
| `props` | `Props` |

## Returns

`ReactNode`


---

---
title: CustomWidgetDataPoint
---

# Type alias CustomWidgetDataPoint`<T>`

> **CustomWidgetDataPoint**: <`T`> `T`

Represents a single data point in a custom widget.

This type is used to define the structure of a data point that is passed to event handlers
like `onDataPointClick`. It typically extends `AbstractDataPointWithEntries` to include
specific entries for categories, values, or other dimensions used in the widget.

## Example

```typescript
interface MyWidgetDataPoint extends CustomWidgetDataPoint {
  entries: {
    category: DataPointEntry[];
    value: DataPointEntry[];
  };
}

const onDataPointClick = (point: MyWidgetDataPoint) => {
  console.log('Clicked category:', point.entries.category[0].value);
};
```

## Type parameters

| Parameter | Default |
| :------ | :------ |
| `T` *extends* [`AbstractDataPointWithEntries`](type-alias.AbstractDataPointWithEntries.md) | [`AbstractDataPointWithEntries`](type-alias.AbstractDataPointWithEntries.md) |


---

---
title: CustomWidgetDataPointContextMenuHandler
---

# Type alias CustomWidgetDataPointContextMenuHandler`<T>`

> **CustomWidgetDataPointContextMenuHandler**: <`T`> (`point`, `nativeEvent`) => `void`

Generic event handler for custom widget data point context menu.

## Type parameters

| Parameter | Default | Description |
| :------ | :------ | :------ |
| `T` *extends* [`AbstractDataPointWithEntries`](type-alias.AbstractDataPointWithEntries.md) | [`AbstractDataPointWithEntries`](type-alias.AbstractDataPointWithEntries.md) | The shape of the data point |

## Parameters

| Parameter | Type |
| :------ | :------ |
| `point` | [`CustomWidgetDataPoint`](type-alias.CustomWidgetDataPoint.md)\< `T` \> |
| `nativeEvent` | `MouseEvent` |

## Returns

`void`


---

---
title: CustomWidgetDataPointEventHandler
---

# Type alias CustomWidgetDataPointEventHandler`<T>`

> **CustomWidgetDataPointEventHandler**: <`T`> (`point`, `nativeEvent`) => `void`

Generic event handler for custom widget data point click.

## Example

```ts
const handleClick: CustomWidgetDataPointEventHandler<MyDataPoint> = (point, event) => {
  console.log('Clicked:', point.label, point.value);
};
```

## Type parameters

| Parameter | Default | Description |
| :------ | :------ | :------ |
| `T` *extends* [`AbstractDataPointWithEntries`](type-alias.AbstractDataPointWithEntries.md) | [`AbstractDataPointWithEntries`](type-alias.AbstractDataPointWithEntries.md) | The shape of the data point |

## Parameters

| Parameter | Type |
| :------ | :------ |
| `point` | [`CustomWidgetDataPoint`](type-alias.CustomWidgetDataPoint.md)\< `T` \> |
| `nativeEvent` | `MouseEvent` \| `PointerEvent` |

## Returns

`void`


---

---
title: CustomWidgetDataPointsEventHandler
---

# Type alias CustomWidgetDataPointsEventHandler`<T>`

> **CustomWidgetDataPointsEventHandler**: <`T`> (`points`, `nativeEvent`) => `void`

Generic event handler for custom widget data points selection.

## Example

```ts
const handleSelect: CustomWidgetDataPointsEventHandler<MyDataPoint> = (points, event) => {
  console.log('Selected:', points.length, 'points');
};
```

## Type parameters

| Parameter | Default | Description |
| :------ | :------ | :------ |
| `T` *extends* [`AbstractDataPointWithEntries`](type-alias.AbstractDataPointWithEntries.md) | [`AbstractDataPointWithEntries`](type-alias.AbstractDataPointWithEntries.md) | The shape of the data point |

## Parameters

| Parameter | Type |
| :------ | :------ |
| `points` | [`CustomWidgetDataPoint`](type-alias.CustomWidgetDataPoint.md)\< `T` \>[] |
| `nativeEvent` | `MouseEvent` |

## Returns

`void`


---

---
title: CustomWidgetQueryState
---

# Type alias CustomWidgetQueryState

> **CustomWidgetQueryState**: [`QueryState`](type-alias.QueryState.md)

State of a query execution retrieving data of a custom widget.


---

---
title: CustomWidgetStyleOptions
---

# Type alias CustomWidgetStyleOptions

> **CustomWidgetStyleOptions**: [`WidgetContainerStyleOptions`](../interfaces/interface.WidgetContainerStyleOptions.md) & `Record`\< `string`, `unknown` \> & \{
  `height`: `number`;
  `width`: `number`;
 }

Style settings defining the look and feel of CustomWidget

> ## `CustomWidgetStyleOptions.height`
>
> **height**?: `number`
>
> The height of the custom widget component.
>
> ## `CustomWidgetStyleOptions.width`
>
> **width**?: `number`
>
> The width of the custom widget component.
>
>


---

---
title: DashStyle
---

# Type alias DashStyle

> **DashStyle**: `"Dash"` \| `"DashDot"` \| `"Dot"` \| `"LongDash"` \| `"LongDashDot"` \| `"LongDashDotDot"` \| `"ShortDash"` \| `"ShortDashDot"` \| `"ShortDashDotDot"` \| `"ShortDot"` \| `"Solid"`

Configuration that defines line dash type


---

---
title: DashboardChangeEvent
---

# Type alias DashboardChangeEvent

> **DashboardChangeEvent**: [`DashboardFiltersPanelCollapseChangedEvent`](../interfaces/interface.DashboardFiltersPanelCollapseChangedEvent.md) \| [`DashboardFiltersUpdatedEvent`](../interfaces/interface.DashboardFiltersUpdatedEvent.md) \| [`DashboardWidgetsDeletedEvent`](../interfaces/interface.DashboardWidgetsDeletedEvent.md) \| [`DashboardWidgetsPanelIsEditingChangedEvent`](../interfaces/interface.DashboardWidgetsPanelIsEditingChangedEvent.md) \| [`DashboardWidgetsPanelLayoutUpdatedEvent`](../interfaces/interface.DashboardWidgetsPanelLayoutUpdatedEvent.md)

Events that can be triggered by the Dashboard component

## Example

Example of a filters update event:

```ts
{ type: 'filters/updated', payload: filters }
```


---

---
title: DashboardModelErrorState
---

# Type alias DashboardModelErrorState

> **DashboardModelErrorState**: `object`

State of a dashboard model load that has failed.

## Type declaration

### `dashboard`

**dashboard**: `undefined`

The result dashboard model if the load has succeeded

***

### `error`

**error**: `Error`

The error if any occurred

***

### `isError`

**isError**: `true`

Whether the dashboard model load has failed

***

### `isLoading`

**isLoading**: `false`

Whether the dashboard model is loading

***

### `isSuccess`

**isSuccess**: `false`

Whether the dashboard model load has succeeded

***

### `status`

**status**: `"error"`

The status of the dashboard model load


---

---
title: DashboardModelLoadingState
---

# Type alias DashboardModelLoadingState

> **DashboardModelLoadingState**: `object`

State of a dashboard model loading.

## Type declaration

### `dashboard`

**dashboard**: [`DashboardModel`](../fusion-assets/interface.DashboardModel.md) \| `undefined`

The result dashboard model if the load has succeeded

***

### `error`

**error**: `undefined`

The error if any occurred

***

### `isError`

**isError**: `false`

Whether the dashboard model load has failed

***

### `isLoading`

**isLoading**: `true`

Whether the dashboard model is loading

***

### `isSuccess`

**isSuccess**: `false`

Whether the dashboard model load has succeeded

***

### `status`

**status**: `"loading"`

The status of the dashboard model load


---

---
title: DashboardModelState
---

# Type alias DashboardModelState

> **DashboardModelState**: [`DashboardModelErrorState`](type-alias.DashboardModelErrorState.md) \| [`DashboardModelLoadingState`](type-alias.DashboardModelLoadingState.md) \| [`DashboardModelSuccessState`](type-alias.DashboardModelSuccessState.md)

States of a dashboard model load.


---

---
title: DashboardModelSuccessState
---

# Type alias DashboardModelSuccessState

> **DashboardModelSuccessState**: `object`

State of a dashboard model load that has succeeded.

## Type declaration

### `dashboard`

**dashboard**: [`DashboardModel`](../fusion-assets/interface.DashboardModel.md)

The result dashboard model if the load has succeeded

***

### `error`

**error**: `undefined`

The error if any occurred

***

### `isError`

**isError**: `false`

Whether the dashboard model load has failed

***

### `isLoading`

**isLoading**: `false`

Whether the dashboard model is loading

***

### `isSuccess`

**isSuccess**: `true`

Whether the dashboard model load has succeeded

***

### `status`

**status**: `"success"`

The status of the dashboard model load


---

---
title: DashboardModelsErrorState
---

# Type alias DashboardModelsErrorState

> **DashboardModelsErrorState**: `object`

State of a dashboard models load that has failed.

## Type declaration

### `dashboards`

**dashboards**: `undefined`

The result dashboard models if the load has succeeded

***

### `error`

**error**: `Error`

The error if any occurred

***

### `isError`

**isError**: `true`

Whether the dashboard models load has failed

***

### `isLoading`

**isLoading**: `false`

Whether the dashboard models is loading

***

### `isSuccess`

**isSuccess**: `false`

Whether the dashboard models load has succeeded

***

### `status`

**status**: `"error"`

The status of the dashboard models load


---

---
title: DashboardModelsLoadingState
---

# Type alias DashboardModelsLoadingState

> **DashboardModelsLoadingState**: `object`

State of a dashboard models loading.

## Type declaration

### `dashboards`

**dashboards**: [`DashboardModel`](../fusion-assets/interface.DashboardModel.md)[] \| `undefined`

The result dashboard models if the load has succeeded

***

### `error`

**error**: `undefined`

The error if any occurred

***

### `isError`

**isError**: `false`

Whether the dashboard models load has failed

***

### `isLoading`

**isLoading**: `true`

Whether the dashboard models is loading

***

### `isSuccess`

**isSuccess**: `false`

Whether the dashboard models load has succeeded

***

### `status`

**status**: `"loading"`

The status of the dashboard models load


---

---
title: DashboardModelsState
---

# Type alias DashboardModelsState

> **DashboardModelsState**: [`DashboardModelsErrorState`](type-alias.DashboardModelsErrorState.md) \| [`DashboardModelsLoadingState`](type-alias.DashboardModelsLoadingState.md) \| [`DashboardModelsSuccessState`](type-alias.DashboardModelsSuccessState.md)

States of a dashboard models load.


---

---
title: DashboardModelsSuccessState
---

# Type alias DashboardModelsSuccessState

> **DashboardModelsSuccessState**: `object`

State of a dashboard models load that has succeeded.

## Type declaration

### `dashboards`

**dashboards**: [`DashboardModel`](../fusion-assets/interface.DashboardModel.md)[]

The result dashboard models if the load has succeeded

***

### `error`

**error**: `undefined`

The error if any occurred

***

### `isError`

**isError**: `false`

Whether the dashboard models load has failed

***

### `isLoading`

**isLoading**: `false`

Whether the dashboard models is loading

***

### `isSuccess`

**isSuccess**: `true`

Whether the dashboard models load has succeeded

***

### `status`

**status**: `"success"`

The status of the dashboard models load


---

---
title: DashboardStyleOptions
---

# Type alias DashboardStyleOptions

> **DashboardStyleOptions**: `object`

Style options for the dashboard.

## Type declaration

### `backgroundColor`

**backgroundColor**?: `string`

Background color

***

### `dividerLineColor`

**dividerLineColor**?: `string`

Divider line color

***

### `dividerLineWidth`

**dividerLineWidth**?: `number`

Width of the divider line between widgets

***

### `palette`

**palette**?: [`ColorPaletteTheme`](type-alias.ColorPaletteTheme.md)

Collection of colors used to color various elements


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
> **breakBy**?: [`DataPointEntry`](type-alias.DataPointEntry.md)[]
>
> Data point entries for the `breakBy` data options
>
> #### `entries.category`
>
> **category**: [`DataPointEntry`](type-alias.DataPointEntry.md)[]
>
> Data point entries for the `category` data options
>
> #### `entries.value`
>
> **value**: [`DataPointEntry`](type-alias.DataPointEntry.md)[]
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
title: DataPointEntry
---

# Type alias DataPointEntry

> **DataPointEntry**: [`AttributeDataPointEntry`](../interfaces/interface.AttributeDataPointEntry.md) \| [`BasicDataPointEntry`](../interfaces/interface.BasicDataPointEntry.md) \| [`MeasureDataPointEntry`](../interfaces/interface.MeasureDataPointEntry.md)

A data point entry that represents a single dimension within a multi-dimensional data point.


---

---
title: DataPointEventHandler
---

# Type alias DataPointEventHandler

> **DataPointEventHandler**: (`point`, `nativeEvent`) => `void`

A handler function that allows you to customize what happens when certain events occur to
a data point.

For an example of how the `DataPointEventHandler` function can be used, see the
[Compose SDK Charts Guide](/guides/sdk/guides/charts/guide-compose-sdk-charts.html#callbacks).

## Parameters

| Parameter | Type |
| :------ | :------ |
| `point` | [`DataPoint`](type-alias.DataPoint.md) |
| `nativeEvent` | `PointerEvent` |

## Returns

`void`


---

---
title: DataPointsEventHandler
---

# Type alias DataPointsEventHandler

> **DataPointsEventHandler**: (`points`, `nativeEvent`) => `void`

Click handler for when multiple data points are selected.

## Parameters

| Parameter | Type |
| :------ | :------ |
| `points` | [`DataPoint`](type-alias.DataPoint.md)[] |
| `nativeEvent` | `MouseEvent` |

## Returns

`void`


---

---
title: DataSourceDimensionsErrorState
---

# Type alias DataSourceDimensionsErrorState

> **DataSourceDimensionsErrorState**: `object`

State of a data source dimensions load that has failed.

## Type declaration

### `dimensions`

**dimensions**: `undefined`

Dimensions, if the load succeeded

***

### `error`

**error**: `Error`

Error, if one occurred

***

### `isError`

**isError**: `true`

Whether the dimensions load has failed

***

### `isLoading`

**isLoading**: `false`

Whether the dimensions are loading

***

### `isSuccess`

**isSuccess**: `false`

Whether the dimensions load has succeeded

***

### `status`

**status**: `"error"`

Loading status


---

---
title: DataSourceDimensionsLoadingState
---

# Type alias DataSourceDimensionsLoadingState

> **DataSourceDimensionsLoadingState**: `object`

State of data source dimensions that is loading.

## Type declaration

### `dimensions`

**dimensions**: `undefined`

Dimensions, if the load succeeded

***

### `error`

**error**: `undefined`

Error, if one occurred

***

### `isError`

**isError**: `false`

Whether the dimensions load has failed

***

### `isLoading`

**isLoading**: `true`

Whether the dimensions are loading

***

### `isSuccess`

**isSuccess**: `false`

Whether the dimensions load has succeeded

***

### `status`

**status**: `"loading"`

Loading status


---

---
title: DataSourceDimensionsState
---

# Type alias DataSourceDimensionsState

> **DataSourceDimensionsState**: [`DataSourceDimensionsErrorState`](type-alias.DataSourceDimensionsErrorState.md) \| [`DataSourceDimensionsLoadingState`](type-alias.DataSourceDimensionsLoadingState.md) \| [`DataSourceDimensionsSuccessState`](type-alias.DataSourceDimensionsSuccessState.md)

States of a data source dimensions load.


---

---
title: DataSourceDimensionsSuccessState
---

# Type alias DataSourceDimensionsSuccessState

> **DataSourceDimensionsSuccessState**: `object`

State of a data source dimensions load that has succeeded.

## Type declaration

### `dimensions`

**dimensions**: [`Dimension`](../../sdk-data/interfaces/interface.Dimension.md)[]

Dimensions, if the load succeeded

***

### `error`

**error**: `undefined`

Error, if one occurred

***

### `isError`

**isError**: `false`

Whether the dimensions load has failed

***

### `isLoading`

**isLoading**: `false`

Whether the dimensions are loading

***

### `isSuccess`

**isSuccess**: `true`

Whether the dimensions load has succeeded

***

### `status`

**status**: `"success"`

Loading status


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

**drilldownPaths**?: ([`Attribute`](../../sdk-data/interfaces/interface.Attribute.md) \| [`Hierarchy`](../interfaces/interface.Hierarchy.md) \| [`HierarchyId`](type-alias.HierarchyId.md))[]

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

**points**: [`ChartDataPoint`](type-alias.ChartDataPoint.md)[]

Points selected for drilldown


---

---
title: DrilldownWidgetConfig
---

# Type alias DrilldownWidgetConfig

> **DrilldownWidgetConfig**: `object`

An object that allows users to pass advanced configuration options as a prop for the [DrilldownWidget](../drilldown/function.DrilldownWidget.md) component

## Type declaration

### `breadcrumbsComponent`

**breadcrumbsComponent**?: `ComponentType`\< [`DrilldownBreadcrumbsProps`](../interfaces/interface.DrilldownBreadcrumbsProps.md) \>

React component to be rendered as breadcrumbs

[DrilldownBreadcrumbs](../drilldown/function.DrilldownBreadcrumbs.md) will be used if not provided

***

### `contextMenuComponent`

**contextMenuComponent**?: (`contextMenuProps`) => `JSX.Element`

React component to be rendered as context menu

[ContextMenu](../drilldown/function.ContextMenu.md) will be used if not provided

#### Parameters

| Parameter | Type |
| :------ | :------ |
| `contextMenuProps` | [`ContextMenuProps`](../interfaces/interface.ContextMenuProps.md) |

#### Returns

`JSX.Element`

***

### `isBreadcrumbsDetached`

**isBreadcrumbsDetached**?: `boolean`

Boolean to override default breadcrumbs location and instead only return them as a property of the 'children' function


---

---
title: EmptyObject
---

# Type alias EmptyObject

> **EmptyObject**: `Record`\< `string`, `never` \>

Empty object with no properties


---

---
title: EndCapType
---

# Type alias EndCapType

> **EndCapType**: `"Round"` \| `"Square"`

Configuration that defines line end cap type


---

---
title: ExecuteCSVQueryConfig
---

# Type alias ExecuteCSVQueryConfig

> **ExecuteCSVQueryConfig**: `object`

Configuration for [useExecuteCsvQuery](../queries/function.useExecuteCsvQuery.md) hook.

## Type declaration

### `asDataStream`

**asDataStream**?: `boolean`

If set to true, the data will be returned as a Blob.


---

---
title: ExecuteQueryResult
---

# Type alias ExecuteQueryResult

> **ExecuteQueryResult**: [`QueryState`](type-alias.QueryState.md) & \{
  `refetch`: () => `void`;
 }

Result of a query execution.

> ## `ExecuteQueryResult.refetch`
>
> **refetch**: () => `void`
>
> Function to refetch the query
>
> ### Returns
>
> `void`
>
>
>
>


---

---
title: FilterMembersState
---

# Type alias FilterMembersState

> **FilterMembersState**: [`FilterMembersErrorState`](../interfaces/interface.FilterMembersErrorState.md) \| [`FilterMembersLoadingState`](../interfaces/interface.FilterMembersLoadingState.md) \| [`FilterMembersSuccessState`](../interfaces/interface.FilterMembersSuccessState.md)

States of the [useGetFilterMembers](../filter-tiles/function.useGetFilterMembers.md) hook.


---

---
title: FilterThemeSettings
---

# Type alias FilterThemeSettings

> **FilterThemeSettings**: `object`

Filter theme settings

## Type declaration

### `panel`

**panel**: `object`

> #### `panel.backgroundColor`
>
> **backgroundColor**?: `string`
>
> Background color
>
> #### `panel.dividerLineColor`
>
> **dividerLineColor**?: `string`
>
> Divider line color for the filter panel
>
> #### `panel.dividerLineWidth`
>
> **dividerLineWidth**?: `number`
>
> Divider line width for the filter panel
>
> #### `panel.titleColor`
>
> **titleColor**?: `string`
>
> Title color
>
>


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
title: FiltersIgnoringRules
---

# Type alias FiltersIgnoringRules

> **FiltersIgnoringRules**: `object`

Filters ignoring rules.

## Type declaration

### `all`

**all**?: `boolean`

Boolean flag whether to ignore all filters.

If not specified, the default value is `false`.

***

### `ids`

**ids**?: `string`[]

Filter GUIDs to ignore.


---

---
title: GenericDataOptions
---

# Type alias GenericDataOptions

> **GenericDataOptions**: `Record`\< `string`, ([`StyledColumn`](../interfaces/interface.StyledColumn.md) \| [`StyledMeasureColumn`](../interfaces/interface.StyledMeasureColumn.md))[] \>

Data options with arbitrary keys. This is typically used in the context of a custom widget.


---

---
title: GeoDataElement
---

# Type alias GeoDataElement

> **GeoDataElement**: [`RawGeoDataElement`](type-alias.RawGeoDataElement.md) & \{
  `color`: [`Color`](type-alias.Color.md);
 }

GeoDataElement with color property, calculated from `originalValue`

> ## `GeoDataElement.color`
>
> **color**?: [`Color`](type-alias.Color.md)
>
> Calculated color for this geo-element
>
>


---

---
title: GetFilterMembersResult
---

# Type alias GetFilterMembersResult

> **GetFilterMembersResult**: [`FilterMembersState`](type-alias.FilterMembersState.md) & \{}

Result of the [useGetFilterMembers](../filter-tiles/function.useGetFilterMembers.md) hook.


---

---
title: GradientColor
---

# Type alias GradientColor

> **GradientColor**: [`LinearGradientColor`](../interfaces/interface.LinearGradientColor.md) \| [`RadialGradientColor`](../interfaces/interface.RadialGradientColor.md)

Enhanced gradient color options that provide better type safety and developer experience.

This is a discriminated union that allows for either linear or radial gradients,
with comprehensive type checking and better IntelliSense support.

## Example

```ts
// Linear gradient example
const linearGradient: GradientColor = {
  type: 'linear',
  direction: { x1: 0, y1: 0, x2: 0, y2: 1 },
  stops: [
    { position: 0, color: '#003399' },
    { position: 0.5, color: '#ffffff' },
    { position: 1, color: '#3366AA' }
  ]
};

// Radial gradient example
const radialGradient: GradientColor = {
  type: 'radial',
  center: { centerX: 0.5, centerY: 0.5, radius: 0.8 },
  stops: [
    { position: 0, color: '#ff0000' },
    { position: 1, color: '#0000ff' }
  ]
};
```


---

---
title: GradientPosition
---

# Type alias GradientPosition

> **GradientPosition**: `number`

A position value for gradient stops, ranging from 0 (start) to 1 (end).


---

---
title: HierarchyId
---

# Type alias HierarchyId

> **HierarchyId**: `string`

A unique identifier representing a hierarchy.


---

---
title: HierarchyModelsErrorState
---

# Type alias HierarchyModelsErrorState

> **HierarchyModelsErrorState**: `object`

State of a hierarchy models load that has failed.

## Type declaration

### `error`

**error**: `Error`

Error, if one occurred

***

### `hierarchies`

**hierarchies**: `undefined`

Hierarchy models, if the load succeeded

***

### `isError`

**isError**: `true`

Whether the hierarchy models load has failed

***

### `isLoading`

**isLoading**: `false`

Whether the hierarchy models is loading

***

### `isSuccess`

**isSuccess**: `false`

Whether the hierarchy models load has succeeded

***

### `status`

**status**: `"error"`

Loading status


---

---
title: HierarchyModelsLoadingState
---

# Type alias HierarchyModelsLoadingState

> **HierarchyModelsLoadingState**: `object`

State of hierarchy models that is loading.

## Type declaration

### `error`

**error**: `undefined`

Error, if one occurred

***

### `hierarchies`

**hierarchies**: [`HierarchyModel`](../interfaces/interface.HierarchyModel.md)[] \| `undefined`

Hierarchy models, if the load succeeded

***

### `isError`

**isError**: `false`

Whether the hierarchy models load has failed

***

### `isLoading`

**isLoading**: `true`

Whether the hierarchy models is loading

***

### `isSuccess`

**isSuccess**: `false`

Whether the hierarchy models load has succeeded

***

### `status`

**status**: `"loading"`

Loading status


---

---
title: HierarchyModelsState
---

# Type alias HierarchyModelsState

> **HierarchyModelsState**: [`HierarchyModelsErrorState`](type-alias.HierarchyModelsErrorState.md) \| [`HierarchyModelsLoadingState`](type-alias.HierarchyModelsLoadingState.md) \| [`HierarchyModelsSuccessState`](type-alias.HierarchyModelsSuccessState.md)

States of hierarchy models load.


---

---
title: HierarchyModelsSuccessState
---

# Type alias HierarchyModelsSuccessState

> **HierarchyModelsSuccessState**: `object`

State of a hierarchy models load that has succeeded.

## Type declaration

### `error`

**error**: `undefined`

Error, if one occurred

***

### `hierarchies`

**hierarchies**: [`HierarchyModel`](../interfaces/interface.HierarchyModel.md)[]

Hierarchy models, if the load succeeded

***

### `isError`

**isError**: `false`

Whether the hierarchy models load has failed

***

### `isLoading`

**isLoading**: `false`

Whether the hierarchy models is loading

***

### `isSuccess`

**isSuccess**: `true`

Whether the hierarchy models load has succeeded

***

### `status`

**status**: `"success"`

Loading status


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
> **max**?: [`DataPointEntry`](type-alias.DataPointEntry.md)
>
> Data point entry for the `max` data options
>
> #### `entries.min`
>
> **min**?: [`DataPointEntry`](type-alias.DataPointEntry.md)
>
> Data point entry for the `min` data options
>
> #### `entries.secondary`
>
> **secondary**?: [`DataPointEntry`](type-alias.DataPointEntry.md)
>
> Data point entry for the `secondary` data options
>
> #### `entries.value`
>
> **value**?: [`DataPointEntry`](type-alias.DataPointEntry.md)
>
> Data point entry for the `value` data options
>
>


---

---
title: IndicatorDataPointEventHandler
---

# Type alias IndicatorDataPointEventHandler

> **IndicatorDataPointEventHandler**: (`point`, `nativeEvent`) => `void`

Click handler for when an indicator chart is clicked.

## Parameters

| Parameter | Type |
| :------ | :------ |
| `point` | [`IndicatorDataPoint`](type-alias.IndicatorDataPoint.md) |
| `nativeEvent` | `MouseEvent` |

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
title: JtdTarget
---

# Type alias JtdTarget

> **JtdTarget**: \{
  `caption`: `string`;
  `id`: `string`;
 } \| \{
  `caption`: `string`;
  `dashboard`: [`DashboardProps`](../interfaces/interface.DashboardProps.md);
 }

Target dashboard for Jump To Dashboard functionality.
Supports both dashboard ID reference and in-code dashboard object.

## See

 - JumpToDashboardConfig
 - DashboardProps


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

> **Legend**: [`LegendOptions`](type-alias.LegendOptions.md)

Alias for LegendOptions for backward compatibility

::: warning Deprecated
Please use [LegendOptions](type-alias.LegendOptions.md) instead
:::


---

---
title: LegendOptions
---

# Type alias LegendOptions

> **LegendOptions**: `object`

Options that define legend - a key that provides information about the data series or colors used in chart.

## Type declaration

### `align`

**align**?: `"center"` \| `"left"` \| `"right"`

Horizontal alignment of the legend

***

### `backgroundColor`

**backgroundColor**?: [`GradientColor`](type-alias.GradientColor.md) \| `string`

Background color of the legend

***

### `borderColor`

**borderColor**?: [`GradientColor`](type-alias.GradientColor.md) \| `string`

Color of the legend border

***

### `borderRadius`

**borderRadius**?: `number`

Border radius in pixels applied to the legend border, if visible.

#### Default

```ts
0
```

***

### `borderWidth`

**borderWidth**?: `number`

Width of the legend border in pixels

***

### `enabled`

**enabled**: `boolean`

Boolean flag that defines if legend should be shown on the chart

***

### `floating`

**floating**?: `boolean`

If `true`, the legend can float over the chart.

#### Default

```ts
false
```

***

### `items`

**items**?: [`LegendItemsOptions`](../interfaces/interface.LegendItemsOptions.md)

Configuration for legend items

***

### `margin`

**margin**?: `number`

Margin in pixels between the legend and the axis labels or plot area

***

### `maxHeight`

**maxHeight**?: `number`

Maximum height of the legend in pixels.
When the maximum height is exceeded by the number of items in the legend, scroll navigation arrows will appear

***

### `padding`

**padding**?: `number`

Padding inside the legend, in pixels

***

### `position`

**position**?: [`LegendPosition`](type-alias.LegendPosition.md)

Position of the legend

::: warning Deprecated
Please use `align`, `verticalAlign` and `items.layout` properties instead
:::

***

### `reversed`

**reversed**?: `boolean`

If `true`, the order of legend items is reversed.

#### Default

```ts
false
```

***

### `rtl`

**rtl**?: `boolean`

If `true`, legend items are displayed right-to-left.

#### Default

```ts
false
```

***

### `shadow`

**shadow**?: `boolean`

Whether to show shadow on the legend

***

### `symbols`

**symbols**?: [`LegendSymbolsOptions`](../interfaces/interface.LegendSymbolsOptions.md)

Configuration for legend symbols in pixels

***

### `title`

**title**?: [`LegendTitleOptions`](../interfaces/interface.LegendTitleOptions.md)

Configuration for the legend title

***

### `verticalAlign`

**verticalAlign**?: `"bottom"` \| `"middle"` \| `"top"`

Vertical alignment of the legend

***

### `width`

**width**?: `number` \| `string`

Width of the legend, specified in pixels e.g. `200` or percentage of the chart width e.g. `'30%'`

***

### `xOffset`

**xOffset**?: `number`

Horizontal offset of the legend in pixels, relative to its horizontal alignment specified via `align`.

#### Default

```ts
0
```

***

### `yOffset`

**yOffset**?: `number`

Vertical offset of the legend in pixels, relative to its vertical alignment specified via `verticalAlign`.

#### Default

```ts
0
```


---

---
title: LegendPosition
---

# Type alias LegendPosition

> **LegendPosition**: `"bottom"` \| `"left"` \| `"right"` \| `"top"` \| `null`


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
title: LoadingIndicatorConfig
---

# Type alias LoadingIndicatorConfig

> **LoadingIndicatorConfig**: `object`

A config that defines the behavior of the loading indicator

## Type declaration

### `delay`

**delay**?: `number`

Delay in milliseconds before the loading indicator is shown

***

### `enabled`

**enabled**?: `boolean`

Boolean flag that defines if the loading indicator should be shown


---

---
title: LoadingOverlayProps
---

# Type alias LoadingOverlayProps

> **LoadingOverlayProps**: `object`

Loading overlay props.

## Type declaration

### `children`

**children**?: `ReactNode`

Child component to wrap in the overlay.

***

### `isVisible`

**isVisible**?: `boolean`

Visibility of the overlay (does not work if loading indicator is disabled in app config).


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
Used in [`ContextMenuProps`](../interfaces/interface.ContextMenuProps.md)

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
Used in [`ContextMenuProps`](../interfaces/interface.ContextMenuProps.md)

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
title: NestedTranslationResources
---

# Type alias NestedTranslationResources

> **NestedTranslationResources**: `object`

Translation resources with nested structure.

## Index signature

 \[`key`: `string`\]: [`NestedTranslationResources`](type-alias.NestedTranslationResources.md) \| `string`


---

---
title: NlqResult
---

# Type alias NlqResult

> **NlqResult**: `Omit`\< [`NlqResponseData`](../interfaces/interface.NlqResponseData.md), `"followupQuestions"` \>


---

---
title: NlqResultChartType
---

# Type alias NlqResultChartType

> **NlqResultChartType**: `"bar" | "column" | "indicator" | "line" | "pie" | "table"`

NLQ result chart types


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
title: PiePercentageLabels
---

# Type alias PiePercentageLabels

> **PiePercentageLabels**: `object`

Configuration for percentage labels
Percentage labels are shown on top of series slices

## Type declaration

### `enabled`

**enabled**: `boolean`

Boolean flag that defines if percentage label should be shown

***

### `showDecimals`

**showDecimals**?: `boolean`

Boolean flag that defines if percentage label should be shown with decimals


---

---
title: PieSeriesLabels
---

# Type alias PieSeriesLabels

> **PieSeriesLabels**: [`SeriesLabelsBase`](type-alias.SeriesLabelsBase.md) & \{
  `percentageLabels`: [`PiePercentageLabels`](type-alias.PiePercentageLabels.md);
  `showCategory`: `boolean`;
  `showValue`: `boolean`;
  `textStyle`: `Omit`\< [`TextStyle`](type-alias.TextStyle.md), `"pointerEvents"` \| `"textOverflow"` \>;
 }

> ## `PieSeriesLabels.percentageLabels`
>
> **percentageLabels**?: [`PiePercentageLabels`](type-alias.PiePercentageLabels.md)
>
> Configuration for percentage labels
> Percentage labels are shown on top of series slices
> Styling from series labels are not applied to percentage labels
>
> ## `PieSeriesLabels.showCategory`
>
> **showCategory**?: `boolean`
>
> Boolean flag that defines if the category should be shown
>
> ### Default
>
> `true`
>
> ## `PieSeriesLabels.showValue`
>
> **showValue**?: `boolean`
>
> Boolean flag that defines if value should be shown in series labels
> (if not specified, default is determined by chart type)
>
> ## `PieSeriesLabels.textStyle`
>
> **textStyle**?: `Omit`\< [`TextStyle`](type-alias.TextStyle.md), `"pointerEvents"` \| `"textOverflow"` \>
>
> Styling for labels text
>
>


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
title: PivotQueryErrorState
---

# Type alias PivotQueryErrorState

> **PivotQueryErrorState**: `object`

State of a query execution that has failed.

## Type declaration

### `data`

**data**: `undefined`

The result data if the query has succeeded

***

### `error`

**error**: `Error`

The error if any occurred

***

### `isError`

**isError**: `true`

Whether the query has failed

***

### `isLoading`

**isLoading**: `false`

Whether the query is loading

***

### `isSuccess`

**isSuccess**: `false`

Whether the query has succeeded

***

### `status`

**status**: `"error"`

The status of the query execution


---

---
title: PivotQueryLoadingState
---

# Type alias PivotQueryLoadingState

> **PivotQueryLoadingState**: `object`

State of a query execution that is loading.

## Type declaration

### `data`

**data**: [`PivotQueryResultData`](../../sdk-data/interfaces/interface.PivotQueryResultData.md) \| `undefined`

The result data if the query has succeeded

***

### `error`

**error**: `undefined`

The error if any occurred

***

### `isError`

**isError**: `false`

Whether the query has failed

***

### `isLoading`

**isLoading**: `true`

Whether the query is loading

***

### `isSuccess`

**isSuccess**: `false`

Whether the query has succeeded

***

### `status`

**status**: `"loading"`

The status of the query execution


---

---
title: PivotQueryState
---

# Type alias PivotQueryState

> **PivotQueryState**: [`PivotQueryErrorState`](type-alias.PivotQueryErrorState.md) \| [`PivotQueryLoadingState`](type-alias.PivotQueryLoadingState.md) \| [`PivotQuerySuccessState`](type-alias.PivotQuerySuccessState.md)

State of a pivot query execution.


---

---
title: PivotQuerySuccessState
---

# Type alias PivotQuerySuccessState

> **PivotQuerySuccessState**: `object`

State of a query execution that has succeeded.

## Type declaration

### `data`

**data**: [`PivotQueryResultData`](../../sdk-data/interfaces/interface.PivotQueryResultData.md)

The result data if the query has succeeded

***

### `error`

**error**: `undefined`

The error if any occurred

***

### `isError`

**isError**: `false`

Whether the query has failed

***

### `isLoading`

**isLoading**: `false`

Whether the query is loading

***

### `isSuccess`

**isSuccess**: `true`

Whether the query has succeeded

***

### `status`

**status**: `"success"`

The status of the query execution


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
title: PivotTableDataPoint
---

# Type alias PivotTableDataPoint

> **PivotTableDataPoint**: `object`

Data point in a PivotTable.

## Type declaration

### `entries`

**entries**: `object`

A collection of data point entries that represents values for all related `dataOptions`.

> #### `entries.columns`
>
> **columns**?: [`DataPointEntry`](type-alias.DataPointEntry.md)[]
>
> Data point entries for the `columns` data options
>
> #### `entries.rows`
>
> **rows**?: [`DataPointEntry`](type-alias.DataPointEntry.md)[]
>
> Data point entries for the `rows` data options
>
> #### `entries.values`
>
> **values**?: [`DataPointEntry`](type-alias.DataPointEntry.md)[]
>
> Data point entries for the `values` data options
>
>

***

### `isCaptionCell`

**isCaptionCell**: `boolean`

Boolean flag that defines if the data point is a caption cell

***

### `isDataCell`

**isDataCell**: `boolean`

Boolean flag that defines if the data point is a data cell

***

### `isTotalCell`

**isTotalCell**: `boolean`

Boolean flag that defines if the data point is a total cell (subtotal or grandtotal)


---

---
title: PivotTableDataPointEventHandler
---

# Type alias PivotTableDataPointEventHandler

> **PivotTableDataPointEventHandler**: (`point`, `nativeEvent`) => `void`

Click handler for when a pivot table cell is clicked.

## Parameters

| Parameter | Type |
| :------ | :------ |
| `point` | [`PivotTableDataPoint`](type-alias.PivotTableDataPoint.md) |
| `nativeEvent` | `MouseEvent` |

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

**drilldownPaths**?: ([`Attribute`](../../sdk-data/interfaces/interface.Attribute.md) \| [`Hierarchy`](../interfaces/interface.Hierarchy.md) \| [`HierarchyId`](type-alias.HierarchyId.md))[]

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

**drilldownPaths**?: ([`Attribute`](../../sdk-data/interfaces/interface.Attribute.md) \| [`Hierarchy`](../interfaces/interface.Hierarchy.md) \| [`HierarchyId`](type-alias.HierarchyId.md))[]

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

> **PivotTableWidgetStyleOptions**: [`PivotTableStyleOptions`](../interfaces/interface.PivotTableStyleOptions.md) & [`WidgetContainerStyleOptions`](../interfaces/interface.WidgetContainerStyleOptions.md)

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
title: QueryByWidgetIdQueryParams
---

# Type alias QueryByWidgetIdQueryParams

> **QueryByWidgetIdQueryParams**: `object`

Query parameters constructed over either a chart widget or pivot table widget. This is returned as part of the query state [QueryByWidgetIdState](type-alias.QueryByWidgetIdState.md).

## Type declaration

### `pivotQuery`

**pivotQuery**: [`ExecutePivotQueryParams`](../interfaces/interface.ExecutePivotQueryParams.md) \| `undefined`

Query parameters constructed over the pivot table widget

***

### `query`

**query**: [`ExecuteQueryParams`](../interfaces/interface.ExecuteQueryParams.md) \| `undefined`

Query parameters constructed over the chart widget


---

---
title: QueryByWidgetIdState
---

# Type alias QueryByWidgetIdState

> **QueryByWidgetIdState**: [`QueryState`](type-alias.QueryState.md) & [`QueryByWidgetIdQueryParams`](type-alias.QueryByWidgetIdQueryParams.md)

State of a query execution retrieving data of Fusion widget.


---

---
title: QueryErrorState
---

# Type alias QueryErrorState

> **QueryErrorState**: `object`

State of a query execution that has failed.

## Type declaration

### `data`

**data**: `undefined`

The result data if the query has succeeded

***

### `error`

**error**: `Error`

The error if any occurred

***

### `isError`

**isError**: `true`

Whether the query has failed

***

### `isLoading`

**isLoading**: `false`

Whether the query is loading

***

### `isSuccess`

**isSuccess**: `false`

Whether the query has succeeded

***

### `status`

**status**: `"error"`

The status of the query execution


---

---
title: QueryLoadingState
---

# Type alias QueryLoadingState

> **QueryLoadingState**: `object`

State of a query execution that is loading.

## Type declaration

### `data`

**data**: [`QueryResultData`](../../sdk-data/interfaces/interface.QueryResultData.md) \| `undefined`

The result data if the query has succeeded

***

### `error`

**error**: `undefined`

The error if any occurred

***

### `isError`

**isError**: `false`

Whether the query has failed

***

### `isLoading`

**isLoading**: `true`

Whether the query is loading

***

### `isSuccess`

**isSuccess**: `false`

Whether the query has succeeded

***

### `status`

**status**: `"loading"`

The status of the query execution


---

---
title: QueryRecommendationResponse
---

# Type alias QueryRecommendationResponse

> **QueryRecommendationResponse**: [`QueryRecommendation`](../interfaces/interface.QueryRecommendation.md)[]


---

---
title: QueryState
---

# Type alias QueryState

> **QueryState**: [`QueryErrorState`](type-alias.QueryErrorState.md) \| [`QueryLoadingState`](type-alias.QueryLoadingState.md) \| [`QuerySuccessState`](type-alias.QuerySuccessState.md)

State of a query execution.


---

---
title: QuerySuccessState
---

# Type alias QuerySuccessState

> **QuerySuccessState**: `object`

State of a query execution that has succeeded.

## Type declaration

### `data`

**data**: [`QueryResultData`](../../sdk-data/interfaces/interface.QueryResultData.md)

The result data if the query has succeeded

***

### `error`

**error**: `undefined`

The error if any occurred

***

### `isError`

**isError**: `false`

Whether the query has failed

***

### `isLoading`

**isLoading**: `false`

Whether the query is loading

***

### `isSuccess`

**isSuccess**: `true`

Whether the query has succeeded

***

### `status`

**status**: `"success"`

The status of the query execution


---

---
title: RadiusSizes
---

# Type alias RadiusSizes

> **RadiusSizes**: `"Large"` \| `"Medium"` \| `"None"` \| `"Small"`

Possible sizes for border radius.


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
title: RawGeoDataElement
---

# Type alias RawGeoDataElement

> **RawGeoDataElement**: `object`

Raw GeoDataElement from data

## Type declaration

### `formattedOriginalValue`

**formattedOriginalValue**: `string`

Formatted measure value for this geo-element to display

***

### `geoName`

**geoName**: `string`

Name of geo-element (country or state)

***

### `originalValue`

**originalValue**: `number`

Original numeric measure value for this geo-element


---

---
title: RegularChartDataOptions
---

# Type alias RegularChartDataOptions

> **RegularChartDataOptions**: [`AreamapChartDataOptions`](../interfaces/interface.AreamapChartDataOptions.md) \| [`BoxplotChartCustomDataOptions`](type-alias.BoxplotChartCustomDataOptions.md) \| [`BoxplotChartDataOptions`](type-alias.BoxplotChartDataOptions.md) \| [`CalendarHeatmapChartDataOptions`](../interfaces/interface.CalendarHeatmapChartDataOptions.md) \| [`CartesianChartDataOptions`](../interfaces/interface.CartesianChartDataOptions.md) \| [`CategoricalChartDataOptions`](../interfaces/interface.CategoricalChartDataOptions.md) \| [`IndicatorChartDataOptions`](../interfaces/interface.IndicatorChartDataOptions.md) \| [`RangeChartDataOptions`](../interfaces/interface.RangeChartDataOptions.md) \| [`ScatterChartDataOptions`](../interfaces/interface.ScatterChartDataOptions.md) \| [`ScattermapChartDataOptions`](../interfaces/interface.ScattermapChartDataOptions.md)

Configuration for how to query aggregate data and assigning data to chart encodings of regular charts.


---

---
title: RegularChartStyleOptions
---

# Type alias RegularChartStyleOptions

> **RegularChartStyleOptions**: [`AreaRangeStyleOptions`](../interfaces/interface.AreaRangeStyleOptions.md) \| [`AreaStyleOptions`](../interfaces/interface.AreaStyleOptions.md) \| [`AreamapStyleOptions`](../interfaces/interface.AreamapStyleOptions.md) \| [`BoxplotStyleOptions`](../interfaces/interface.BoxplotStyleOptions.md) \| [`CalendarHeatmapStyleOptions`](../interfaces/interface.CalendarHeatmapStyleOptions.md) \| [`FunnelStyleOptions`](../interfaces/interface.FunnelStyleOptions.md) \| [`IndicatorStyleOptions`](type-alias.IndicatorStyleOptions.md) \| [`LineStyleOptions`](../interfaces/interface.LineStyleOptions.md) \| [`PieStyleOptions`](../interfaces/interface.PieStyleOptions.md) \| [`PolarStyleOptions`](../interfaces/interface.PolarStyleOptions.md) \| [`ScatterStyleOptions`](../interfaces/interface.ScatterStyleOptions.md) \| [`ScattermapStyleOptions`](../interfaces/interface.ScattermapStyleOptions.md) \| [`StackableStyleOptions`](../interfaces/interface.StackableStyleOptions.md) \| [`StreamgraphStyleOptions`](../interfaces/interface.StreamgraphStyleOptions.md) \| [`SunburstStyleOptions`](../interfaces/interface.SunburstStyleOptions.md) \| [`TreemapStyleOptions`](../interfaces/interface.TreemapStyleOptions.md)

Style options for regular chart types


---

---
title: RegularChartType
---

# Type alias RegularChartType

> **RegularChartType**: `Exclude`\< [`ChartType`](type-alias.ChartType.md), [`TableChartType`](type-alias.TableChartType.md) \>

Chart type of the regular charts


---

---
title: RequestConfig
---

# Type alias RequestConfig

> **RequestConfig**: `object`

Additional request configuration options for the `useFetch` hook.

## Type declaration

### `nonJSONBody`

**nonJSONBody**?: `boolean`

Indicates that the request body is not a JSON object.

***

### `returnBlob`

**returnBlob**?: `boolean`

Indicates that the response should be treated as a Blob.


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
> **breakByColor**?: [`DataPointEntry`](type-alias.DataPointEntry.md)
>
> Data point entry for the `breakByColor` data options
>
> #### `entries.breakByPoint`
>
> **breakByPoint**?: [`DataPointEntry`](type-alias.DataPointEntry.md)
>
> Data point entry for the `breakByPoint` data options
>
> #### `entries.size`
>
> **size**?: [`DataPointEntry`](type-alias.DataPointEntry.md)
>
> Data point entry for the `size` data options
>
> #### `entries.x`
>
> **x**?: [`DataPointEntry`](type-alias.DataPointEntry.md)
>
> Data point entry for the `x` data options
>
> #### `entries.y`
>
> **y**?: [`DataPointEntry`](type-alias.DataPointEntry.md)
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
title: ScatterDataPointEventHandler
---

# Type alias ScatterDataPointEventHandler

> **ScatterDataPointEventHandler**: (`point`, `nativeEvent`) => `void`

Click handler for when a scatter data point is clicked

## Parameters

| Parameter | Type |
| :------ | :------ |
| `point` | [`ScatterDataPoint`](type-alias.ScatterDataPoint.md) |
| `nativeEvent` | `PointerEvent` |

## Returns

`void`


---

---
title: ScatterDataPointsEventHandler
---

# Type alias ScatterDataPointsEventHandler

> **ScatterDataPointsEventHandler**: (`points`, `nativeEvent`) => `void`

Click handler for when multiple scatter data points are selected.

## Parameters

| Parameter | Type |
| :------ | :------ |
| `points` | [`ScatterDataPoint`](type-alias.ScatterDataPoint.md)[] |
| `nativeEvent` | `MouseEvent` |

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
title: ScatterSeriesLabels
---

# Type alias ScatterSeriesLabels

> **ScatterSeriesLabels**: [`SeriesLabelsBase`](type-alias.SeriesLabelsBase.md) & [`SeriesLabelsAligning`](type-alias.SeriesLabelsAligning.md)


---

---
title: ScattermapChartType
---

# Type alias ScattermapChartType

> **ScattermapChartType**: `"scattermap"`

Scattermap chart types


---

---
title: ScattermapDataPoint
---

# Type alias ScattermapDataPoint

> **ScattermapDataPoint**: `object`

Data point in an Scattermap chart.

## Type declaration

### `categories`

**categories**: `string`[]

Array with categories strings used for location definition

***

### `coordinates`

**coordinates**: [`Coordinates`](type-alias.Coordinates.md)

Location coordinates

***

### `displayName`

**displayName**: `string`

Location name displayed on marker

***

### `entries`

**entries**?: `object`

A collection of data point entries that represents values for all related `dataOptions`.

> #### `entries.colorBy`
>
> **colorBy**?: [`DataPointEntry`](type-alias.DataPointEntry.md)
>
> Data point entry for the `colorBy` data options
>
> #### `entries.details`
>
> **details**?: [`DataPointEntry`](type-alias.DataPointEntry.md)
>
> Data point entry for the `details` data options
>
> #### `entries.geo`
>
> **geo**: [`DataPointEntry`](type-alias.DataPointEntry.md)[]
>
> Data point entries for the `geo` data options
>
> #### `entries.size`
>
> **size**?: [`DataPointEntry`](type-alias.DataPointEntry.md)
>
> Data point entry for the `size` data options
>
>

***

### `value`

**value**: `number`

Numeric measure value


---

---
title: ScattermapDataPointEventHandler
---

# Type alias ScattermapDataPointEventHandler

> **ScattermapDataPointEventHandler**: (`point`, `nativeEvent`) => `void`

Click handler for when a data point on Scattermap is clicked.

## Parameters

| Parameter | Type |
| :------ | :------ |
| `point` | [`ScattermapDataPoint`](type-alias.ScattermapDataPoint.md) |
| `nativeEvent` | `MouseEvent` |

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

> **SeriesLabels**: [`SeriesLabelsBase`](type-alias.SeriesLabelsBase.md) & [`SeriesLabelsAligning`](type-alias.SeriesLabelsAligning.md) & \{
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
title: SeriesLabelsAligning
---

# Type alias SeriesLabelsAligning

> **SeriesLabelsAligning**: `object`

## Type declaration

### `align`

**align**?: `"center"` \| `"left"` \| `"right"`

The horizontal alignment of the data label compared to the point

For some chart types, this will only apply when `alignInside` is `true`.

***

### `alignInside`

**alignInside**?: `boolean`

If `true`, series labels appear inside bars/columns instead of at the datapoints. Not applicable for some chart types e.g. line, area

***

### `verticalAlign`

**verticalAlign**?: `"bottom"` \| `"middle"` \| `"top"`

The vertical alignment of the data label

For some chart types, this will only apply when `alignInside` is `true`.


---

---
title: SeriesLabelsBase
---

# Type alias SeriesLabelsBase

> **SeriesLabelsBase**: `object`

## Type declaration

### `backgroundColor`

**backgroundColor**?: `"auto"` \| [`GradientColor`](type-alias.GradientColor.md) \| `string`

Background color of the labels. `auto` uses the same color as the data point

***

### `borderColor`

**borderColor**?: [`GradientColor`](type-alias.GradientColor.md) \| `string`

Color of the labels border

***

### `borderRadius`

**borderRadius**?: `number`

Border radius in pixels applied to the labels border, if visible

#### Default

```ts
0
```

***

### `borderWidth`

**borderWidth**?: `number`

Border width of the series labels, in pixels

***

### `enabled`

**enabled**: `boolean`

Boolean flag that defines if series labels should be shown on the chart

***

### `padding`

**padding**?: `number`

Padding of the series labels, in pixels

***

### `prefix`

**prefix**?: `string`

Text to be shown before the series labels

***

### `rotation`

**rotation**?: `number`

Rotation of series labels (in degrees)
Note that due to a more complex structure, backgrounds, borders and padding will be lost on a rotated data label

***

### `suffix`

**suffix**?: `string`

Text to be shown after the series labels

***

### `textStyle`

**textStyle**?: [`SeriesLabelsTextStyle`](type-alias.SeriesLabelsTextStyle.md)

Styling for labels text

***

### `xOffset`

**xOffset**?: `number`

Horizontal offset of the labels in pixels, relative to its horizontal alignment specified via `align`

#### Default

```ts
0
```

***

### `yOffset`

**yOffset**?: `number`

Vertical offset of the labels in pixels, relative to its vertical alignment specified via `verticalAlign`

#### Default

```ts
0
```


---

---
title: SeriesLabelsTextStyle
---

# Type alias SeriesLabelsTextStyle

> **SeriesLabelsTextStyle**: `Omit`\< [`TextStyle`](type-alias.TextStyle.md), `"color"` \| `"pointerEvents"` \| `"textOverflow"` \> & \{
  `color`: `"contrast"` \| `string`;
 }

> ## `SeriesLabelsTextStyle.color`
>
> **color**?: `"contrast"` \| `string`
>
> Color of the labels text
> The default color setting is "contrast", which applies the maximum contrast between the background and the text
>
> ### Default
>
> ```ts
> 'contrast'
> ```
>
>


---

---
title: SeriesStyleOptions
---

# Type alias SeriesStyleOptions

> **SeriesStyleOptions**: `object`

Specific style options to be applied to specific series in Chart.
Supported only for cartesian and polar charts.

## Type declaration

### `lineWidth`

**lineWidth**?: [`LineWidth`](type-alias.LineWidth.md)

#### Inherit Doc

***

### `markers`

**markers**?: [`Markers`](type-alias.Markers.md)

#### Inherit Doc


---

---
title: ShadowsTypes
---

# Type alias ShadowsTypes

> **ShadowsTypes**: `"Dark"` \| `"Light"` \| `"Medium"` \| `"None"`

Possible types of shadows.


---

---
title: SharedFormulaErrorState
---

# Type alias SharedFormulaErrorState

> **SharedFormulaErrorState**: `object`

State of a shared formula load that has failed.

## Type declaration

### `error`

**error**: `Error`

The error if any occurred

***

### `formula`

**formula**: `undefined`

The result shared formula if the load has succeeded

***

### `isError`

**isError**: `true`

Whether the shared formula load has failed

***

### `isLoading`

**isLoading**: `false`

Whether the shared formula is loading

***

### `isSuccess`

**isSuccess**: `false`

Whether the shared formula load has succeeded

***

### `status`

**status**: `"error"`

The status of the shared formula load


---

---
title: SharedFormulaLoadingState
---

# Type alias SharedFormulaLoadingState

> **SharedFormulaLoadingState**: `object`

State of a shared formula loading.

## Type declaration

### `error`

**error**: `undefined`

The error if any occurred

***

### `formula`

**formula**: [`CalculatedMeasure`](../../sdk-data/interfaces/interface.CalculatedMeasure.md) \| `null`

The result shared formula if the load has succeeded

***

### `isError`

**isError**: `false`

Whether the shared formula load has failed

***

### `isLoading`

**isLoading**: `true`

Whether the shared formula is loading

***

### `isSuccess`

**isSuccess**: `false`

Whether the shared formula load has succeeded

***

### `status`

**status**: `"loading"`

The status of the shared formula load


---

---
title: SharedFormulaState
---

# Type alias SharedFormulaState

> **SharedFormulaState**: [`SharedFormulaErrorState`](type-alias.SharedFormulaErrorState.md) \| [`SharedFormulaLoadingState`](type-alias.SharedFormulaLoadingState.md) \| [`SharedFormulaSuccessState`](type-alias.SharedFormulaSuccessState.md)

States of a shared formula load.


---

---
title: SharedFormulaSuccessState
---

# Type alias SharedFormulaSuccessState

> **SharedFormulaSuccessState**: `object`

State of a shared formula load that has succeeded.

## Type declaration

### `error`

**error**: `undefined`

The error if any occurred

***

### `formula`

**formula**: [`CalculatedMeasure`](../../sdk-data/interfaces/interface.CalculatedMeasure.md) \| `null`

The result shared formula if the load has succeeded

***

### `isError`

**isError**: `false`

Whether the shared formula load has failed

***

### `isLoading`

**isLoading**: `false`

Whether the shared formula is loading

***

### `isSuccess`

**isSuccess**: `true`

Whether the shared formula load has succeeded

***

### `status`

**status**: `"success"`

The status of the shared formula load


---

---
title: SortDirection
---

# Type alias SortDirection

> **SortDirection**: `"sortAsc"` \| `"sortDesc"` \| `"sortNone"`

Sorting direction, either in Ascending order, Descending order, or None


---

---
title: SpaceSizes
---

# Type alias SpaceSizes

> **SpaceSizes**: `"Large"` \| `"Medium"` \| `"None"` \| `"Small"`

Possible sizes for spacing.


---

---
title: SpecificWidgetOptions
---

# Type alias SpecificWidgetOptions

> **SpecificWidgetOptions**: `object`

Options for a specific widget

## Type declaration

### `filtersOptions`

**filtersOptions**?: [`CommonFiltersOptions`](type-alias.CommonFiltersOptions.md)

Options for common filters defined at the dashboard level to be applied to certain widgets.

***

### `jtdConfig`

**jtdConfig**?: [`JumpToDashboardConfig`](../interfaces/interface.JumpToDashboardConfig.md) \| [`JumpToDashboardConfigForPivot`](../interfaces/interface.JumpToDashboardConfigForPivot.md)

Jump To Dashboard config for widgets.


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
title: SunburstSeriesLabels
---

# Type alias SunburstSeriesLabels

> **SunburstSeriesLabels**: [`SunburstSeriesLabelsBase`](type-alias.SunburstSeriesLabelsBase.md) \| [`SunburstSeriesLabelsBase`](type-alias.SunburstSeriesLabelsBase.md)[]


---

---
title: SunburstSeriesLabelsBase
---

# Type alias SunburstSeriesLabelsBase

> **SunburstSeriesLabelsBase**: [`SeriesLabelsBase`](type-alias.SeriesLabelsBase.md) & \{
  `backgroundColor`: `string`;
  `borderColor`: `string`;
 }

> ## `SunburstSeriesLabelsBase.backgroundColor`
>
> **backgroundColor**?: `string`
>
> Background color of the labels.
>
> ## `SunburstSeriesLabelsBase.borderColor`
>
> **borderColor**?: `string`
>
> Color of the labels border
>
>


---

---
title: TabberButtonsWidgetCustomOptions
---

# Type alias TabberButtonsWidgetCustomOptions

> **TabberButtonsWidgetCustomOptions**: `object`

Custom options for the tabber buttons widget

## Type declaration

### `activeTab`

**activeTab**?: `number`

Index of the currently active tab (zero-based)

#### Default Value

```ts
0
```

***

### `tabNames`

**tabNames**: `string`[]

Array of tab names to display in the tabber buttons widget


---

---
title: TabberButtonsWidgetStyleOptions
---

# Type alias TabberButtonsWidgetStyleOptions

> **TabberButtonsWidgetStyleOptions**: `object`

Configuration options that define style of the various elements of the tabbers buttons widget.

## Type declaration

### `descriptionColor`

**descriptionColor**?: `string`

Color of the widget description text

***

### `selectedBackgroundColor`

**selectedBackgroundColor**?: `string`

Background color of the selected tab

***

### `selectedColor`

**selectedColor**?: `string`

Text color of the selected tab

***

### `showDescription`

**showDescription**?: `boolean`

Whether to display the widget description

#### Default Value

```ts
true
```

***

### `showSeparators`

**showSeparators**?: `boolean`

Whether to show visual separators between tabs

#### Default Value

```ts
true
```

***

### `tabCornerRadius`

**tabCornerRadius**?: `"large"` \| `"medium"` \| `"none"` \| `"small"`

Corner radius style for tabs

***

### `tabsAlignment`

**tabsAlignment**?: `"center"` \| `"left"` \| `"right"`

Horizontal alignment of tabs within the widget

***

### `tabsInterval`

**tabsInterval**?: `"large"` \| `"medium"` \| `"small"` \| `number`

Spacing interval between tabs.
Can be a predefined size ('small', 'medium', 'large') or a number (treated as pixels).

#### Default

```ts
'medium'
```

#### Example

```typescript
tabsInterval: 'small'
tabsInterval: 16  // treated as 16px
```

***

### `tabsSize`

**tabsSize**?: `"large"` \| `"medium"` \| `"small"` \| `number`

Size of the tabs.
Can be a predefined size ('small', 'medium', 'large') or a number (treated as pixels).

#### Default

```ts
'medium'
```

#### Example

```typescript
tabsSize: 'medium'
tabsSize: 14  // treated as 14px
```

***

### `unselectedBackgroundColor`

**unselectedBackgroundColor**?: `string`

Background color of unselected tabs

***

### `unselectedColor`

**unselectedColor**?: `string`

Text color of unselected tabs


---

---
title: TabberConfig
---

# Type alias TabberConfig

> **TabberConfig**: `object`

Configuration for a tabber widget.

## Type declaration

### `tabs`

**tabs**: [`TabberTabConfig`](type-alias.TabberTabConfig.md)[]

Tabs configuration for the tabber widget.


---

---
title: TabberTabConfig
---

# Type alias TabberTabConfig

> **TabberTabConfig**: `object`

Configuration for a single tab in a tabber widget.

## Type declaration

### `displayWidgetIds`

**displayWidgetIds**: `string`[]

Widget IDs from the dashboard to display in the tab.


---

---
title: TabbersConfig
---

# Type alias TabbersConfig

> **TabbersConfig**: `Record`\< [`WidgetId`](type-alias.WidgetId.md), [`TabberConfig`](type-alias.TabberConfig.md) \>

Configuration for tabbers in a dashboard.
It includes separate configuration for each tabber.


---

---
title: TableChartType
---

# Type alias TableChartType

> **TableChartType**: `"table"`

Table chart types


---

---
title: TableColorOptions
---

# Type alias TableColorOptions

> **TableColorOptions**: `object`

Configuration for Table color options

## Type declaration

### `backgroundColor`

**backgroundColor**?: `string`

Color used for background fill

***

### `enabled`

**enabled**: `boolean`

Boolean flag whether to fill with color

***

### `textColor`

**textColor**?: `string`

Color used for text


---

---
title: TableType
---

# Type alias TableType

> **TableType**: `"table"`

Table chart types


---

---
title: TabularChartDataOptions
---

# Type alias TabularChartDataOptions

> **TabularChartDataOptions**: [`TableDataOptions`](../interfaces/interface.TableDataOptions.md)

Configuration for how to query data and assign data to tabular charts.


---

---
title: TabularChartStyleOptions
---

# Type alias TabularChartStyleOptions

> **TabularChartStyleOptions**: [`TableStyleOptions`](../interfaces/interface.TableStyleOptions.md)

Configuration options that define functional style of the various elements of the tabular charts.


---

---
title: TabularWidgetType
---

# Type alias TabularWidgetType

> **TabularWidgetType**: `"pivot"` \| `"pivot2"` \| `"tablewidget"` \| `"tablewidgetagg"`

The type of a widget on a dashboard that is a variant of tabular widget.


---

---
title: TextStyle
---

# Type alias TextStyle

> **TextStyle**: `object`

Style configuration for text elements in charts and UI components.
Defines the visual appearance and behavior of text rendering.

## Type declaration

### `color`

**color**?: `string`

Text color in any valid CSS color format.
Examples: '#FF0000', 'rgb(255, 0, 0)', 'red', 'rgba(255, 0, 0, 0.5)'

***

### `fontFamily`

**fontFamily**?: `string`

Font family name for the text.
Examples: 'Arial', 'Helvetica', 'Times New Roman', 'sans-serif'

***

### `fontSize`

**fontSize**?: `string`

Font size in CSS units (px, em, rem, pt, etc.).
Examples: '12px', '1.2em', '16pt'

***

### `fontStyle`

**fontStyle**?: `string`

Font style for text rendering.
Examples: 'normal', 'italic', 'oblique'

***

### `fontWeight`

**fontWeight**?: `string`

Font weight for text rendering.
Examples: 'normal', 'bold', '100', '200', '300', '400', '500', '600', '700', '800', '900'

***

### `pointerEvents`

**pointerEvents**?: `string`

CSS pointer-events property for text interaction.
Controls how the text responds to mouse events.
Examples: 'auto', 'none', 'visible', 'visibleFill', 'visibleStroke'

***

### `textOutline`

**textOutline**?: `string`

Text outline/stroke configuration.
Defines the outline color and width for text rendering.
Examples: '1px solid black', '2px #333'

***

### `textOverflow`

**textOverflow**?: `string`

Text overflow handling behavior.
Controls how text is displayed when it exceeds its container.
Examples: 'clip', 'ellipsis', 'visible', 'hidden'


---

---
title: TextWidgetStyleOptions
---

# Type alias TextWidgetStyleOptions

> **TextWidgetStyleOptions**: `object`

Style settings defining the look and feel of TextWidget

## Type declaration

### `bgColor`

**bgColor**: `string`

***

### `html`

**html**: `string`

***

### `vAlign`

**vAlign**: \`valign-$\{"middle" \| "top" \| "bottom"}\`


---

---
title: TextWidgetType
---

# Type alias TextWidgetType

> **TextWidgetType**: `"richtexteditor"`

The type of a widget on a dashboard that is a variant of text widget.


---

---
title: ThemeOid
---

# Type alias ThemeOid

> **ThemeOid**: `string`

Identifier of a theme as defined in the Sisense instance.


---

---
title: ThemeProviderProps
---

# Type alias ThemeProviderProps

> **ThemeProviderProps**: `PropsWithChildren`\< \{
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
title: ThemeSettingsFontSource
---

# Type alias ThemeSettingsFontSource

> **ThemeSettingsFontSource**: \{
  `local`: `string`;
 } \| \{
  `url`: `string`;
 } \| \{
  `format`: `string`;
  `url`: `string`;
 }


---

---
title: TotalLabels
---

# Type alias TotalLabels

> **TotalLabels**: `object`

Configuration options for total labels in stacked charts.

Total labels display the sum of all series values at each data point in stacked charts.
This configuration allows you to customize the appearance and positioning of these labels.

## Type declaration

### `align`

**align**?: `"center"` \| `"left"` \| `"right"`

The horizontal alignment of the total label compared to the point

***

### `backgroundColor`

**backgroundColor**?: `"auto"` \| [`GradientColor`](type-alias.GradientColor.md) \| `string`

Background color of the labels. `auto` uses the same color as the data point

***

### `borderColor`

**borderColor**?: [`GradientColor`](type-alias.GradientColor.md) \| `string`

Color of the labels border

***

### `borderRadius`

**borderRadius**?: `number`

Border radius in pixels applied to the labels border, if visible

#### Default

```ts
0
```

***

### `borderWidth`

**borderWidth**?: `number`

Border width of the series labels, in pixels

***

### `delay`

**delay**?: `number`

The animation delay time in milliseconds. Set to 0 to render the data labels immediately

***

### `enabled`

**enabled**: `boolean`

Boolean flag that defines if total labels should be shown on the chart
Total labels are only supported for stacked chart subtypes (Column, Bar, Area)

***

### `prefix`

**prefix**?: `string`

Text to be shown before the total label

***

### `rotation`

**rotation**?: `number`

Rotation of total labels (in degrees)

***

### `suffix`

**suffix**?: `string`

Text to be shown after the total label

***

### `textStyle`

**textStyle**?: [`TotalLabelsTextStyle`](type-alias.TotalLabelsTextStyle.md)

Styling for labels text

***

### `verticalAlign`

**verticalAlign**?: `"bottom"` \| `"middle"` \| `"top"`

The vertical alignment of the total label compared to the point

***

### `xOffset`

**xOffset**?: `number`

Horizontal offset of the total label in pixels, relative to its horizontal alignment specified via `align`

***

### `yOffset`

**yOffset**?: `number`

Vertical offset of the total label in pixels, relative to its vertical alignment specified via `verticalAlign`


---

---
title: TotalLabelsTextStyle
---

# Type alias TotalLabelsTextStyle

> **TotalLabelsTextStyle**: `Omit`\< [`TextStyle`](type-alias.TextStyle.md), `"pointerEvents"` \| `"textOverflow"` \> & \{
  `align`: `"center"` \| `"left"` \| `"right"`;
 }

Text styling options for total labels.

Extends the base TextStyle with additional alignment options specific to total labels.

> ## `TotalLabelsTextStyle.align`
>
> **align**?: `"center"` \| `"left"` \| `"right"`
>
> Horizontal alignment of the total label text
>
>


---

---
title: TranslationConfig
---

# Type alias TranslationConfig

> **TranslationConfig**: `object`

Translation Configuration

## Type declaration

### `customTranslations`

**customTranslations**?: ([`CustomTranslationObject`](type-alias.CustomTranslationObject.md) \| [`CustomTranslationObject`](type-alias.CustomTranslationObject.md)[])[]

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
title: TreemapSeriesLabels
---

# Type alias TreemapSeriesLabels

> **TreemapSeriesLabels**: [`SeriesLabelsBase`](type-alias.SeriesLabelsBase.md) & [`SeriesLabelsAligning`](type-alias.SeriesLabelsAligning.md)[] \| [`SeriesLabelsBase`](type-alias.SeriesLabelsBase.md) & [`SeriesLabelsAligning`](type-alias.SeriesLabelsAligning.md)


---

---
title: TriggerMethod
---

# Type alias TriggerMethod

> **TriggerMethod**: `"click"` \| `"rightclick"`

Jump To Dashboard action trigger method type
click - when user clicks on the widget
rightclick - when user right clicks on the widget, opening the context menu

## See

[JumpToDashboardConfig](../interfaces/interface.JumpToDashboardConfig.md)


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
title: UseComposedDashboardOptions
---

# Type alias UseComposedDashboardOptions

> **UseComposedDashboardOptions**: `object`


---

---
title: UseQueryResult
---

# Type alias UseQueryResult`<TData, TError>`

> **UseQueryResult**: <`TData`, `TError`> `TanstackUseQueryResult`\< `TData`, `TError` \>

The result of the `useFetch` hook.
Return value of the `useQuery` hook from `@tanstack/react-query`.

## See

https://tanstack.com/query/v4/docs/framework/react/reference/useQuery

## Type parameters

| Parameter | Description |
| :------ | :------ |
| `TData` | The type of the data returned by the fetch request |
| `TError` | The type of the error returned by the fetch request |


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
title: WidgetId
---

# Type alias WidgetId

> **WidgetId**: `string`

Widget ID


---

---
title: WidgetModelErrorState
---

# Type alias WidgetModelErrorState

> **WidgetModelErrorState**: `object`

State of a widget model load that has failed.

## Type declaration

### `error`

**error**: `Error`

Error, if one occurred

***

### `isError`

**isError**: `true`

Whether the widget model load has failed

***

### `isLoading`

**isLoading**: `false`

Whether the widget model is loading

***

### `isSuccess`

**isSuccess**: `false`

Whether the widget model load has succeeded

***

### `status`

**status**: `"error"`

Loading status

***

### `widget`

**widget**: `undefined`

Widget model, if the load succeeded


---

---
title: WidgetModelLoadingState
---

# Type alias WidgetModelLoadingState

> **WidgetModelLoadingState**: `object`

State of a widget model that is loading.

## Type declaration

### `error`

**error**: `undefined`

Error, if one occurred

***

### `isError`

**isError**: `false`

Whether the widget model load has failed

***

### `isLoading`

**isLoading**: `true`

Whether the widget model is loading

***

### `isSuccess`

**isSuccess**: `false`

Whether the widget model load has succeeded

***

### `status`

**status**: `"loading"`

Loading status

***

### `widget`

**widget**: [`WidgetModel`](../fusion-assets/interface.WidgetModel.md) \| `undefined`

Widget model, if the load succeeded


---

---
title: WidgetModelState
---

# Type alias WidgetModelState

> **WidgetModelState**: [`WidgetModelErrorState`](type-alias.WidgetModelErrorState.md) \| [`WidgetModelLoadingState`](type-alias.WidgetModelLoadingState.md) \| [`WidgetModelSuccessState`](type-alias.WidgetModelSuccessState.md)

States of a widget model load.


---

---
title: WidgetModelSuccessState
---

# Type alias WidgetModelSuccessState

> **WidgetModelSuccessState**: `object`

State of a widget model load that has succeeded.

## Type declaration

### `error`

**error**: `undefined`

Error, if one occurred

***

### `isError`

**isError**: `false`

Whether the widget model load has failed

***

### `isLoading`

**isLoading**: `false`

Whether the widget model is loading

***

### `isSuccess`

**isSuccess**: `true`

Whether the widget model load has succeeded

***

### `status`

**status**: `"success"`

Loading status

***

### `widget`

**widget**: [`WidgetModel`](../fusion-assets/interface.WidgetModel.md)

Widget model, if the load succeeded


---

---
title: WidgetProps
---

# Type alias WidgetProps

> **WidgetProps**: [`WithCommonWidgetProps`](type-alias.WithCommonWidgetProps.md)\< [`ChartWidgetProps`](../interfaces/interface.ChartWidgetProps.md), `"chart"` \> \| [`WithCommonWidgetProps`](type-alias.WithCommonWidgetProps.md)\< [`CustomWidgetProps`](../interfaces/interface.CustomWidgetProps.md), `"custom"` \> \| [`WithCommonWidgetProps`](type-alias.WithCommonWidgetProps.md)\< [`PivotTableWidgetProps`](../interfaces/interface.PivotTableWidgetProps.md), `"pivot"` \> \| [`WithCommonWidgetProps`](type-alias.WithCommonWidgetProps.md)\< [`TextWidgetProps`](../interfaces/interface.TextWidgetProps.md), `"text"` \>

Props for the widget component within a container component like dashboard.


---

---
title: WidgetStyleOptions
---

# Type alias WidgetStyleOptions

> **WidgetStyleOptions**: [`ChartStyleOptions`](type-alias.ChartStyleOptions.md) \| [`CustomWidgetStyleOptions`](type-alias.CustomWidgetStyleOptions.md) \| [`TableStyleOptions`](../interfaces/interface.TableStyleOptions.md) \| [`TextWidgetStyleOptions`](type-alias.TextWidgetStyleOptions.md) & [`WidgetContainerStyleOptions`](../interfaces/interface.WidgetContainerStyleOptions.md)

Complete set of configuration options that define functional style of the various elements of the charts as well as the look and feel of widget itself and widget header.


---

---
title: WidgetThemeSettings
---

# Type alias WidgetThemeSettings

> **WidgetThemeSettings**: `object`

Widget theme settings

## Type declaration

### `border`

**border**?: `boolean`

Widget container border toggle

***

### `borderColor`

**borderColor**?: `string`

Widget container border color

***

### `cornerRadius`

**cornerRadius**?: [`RadiusSizes`](type-alias.RadiusSizes.md)

Corner radius of the widget container

***

### `header`

**header**?: `object`

Widget header styles

> #### `header.backgroundColor`
>
> **backgroundColor**?: `string`
>
> Header background color
>
> #### `header.dividerLine`
>
> **dividerLine**?: `boolean`
>
> Toggle of the divider line between widget header and chart
>
> #### `header.dividerLineColor`
>
> **dividerLineColor**?: `string`
>
> Divider line color
>
> #### `header.titleAlignment`
>
> **titleAlignment**?: [`AlignmentTypes`](type-alias.AlignmentTypes.md)
>
> Header title alignment
>
> #### `header.titleFontSize`
>
> **titleFontSize**?: `number`
>
> Header title font size
>
> #### `header.titleTextColor`
>
> **titleTextColor**?: `string`
>
> Header title text color
>
>

***

### `shadow`

**shadow**?: [`ShadowsTypes`](type-alias.ShadowsTypes.md)

Shadow level of the widget container

Effective only when spaceAround is defined

***

### `spaceAround`

**spaceAround**?: [`SpaceSizes`](type-alias.SpaceSizes.md)

Space between widget container edge and the chart


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

> **WidgetsOptions**: `Record`\< [`WidgetId`](type-alias.WidgetId.md), [`SpecificWidgetOptions`](type-alias.SpecificWidgetOptions.md) \>

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

| Parameter |
| :------ |
| `BaseWidget` |
| `Type` *extends* [`WidgetType`](type-alias.WidgetType.md) |


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

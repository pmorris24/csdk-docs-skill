---
title: AiContextProviderProps
---

# Interface AiContextProviderProps

## Properties

### children

> **children**: `ReactNode`

***

### volatile

> **volatile**?: `boolean`

Boolean flag to indicate whether the chat session should be volatile.

When `false` the chat session history will be stored per user per datamodel. The retention period is configurable in Sisense Fusion.

When the `Chatbot` component renders, if a previous chat history exists for the current user and datamodel, it will be restored. The user may continue the conversation or clear the history.

When `true` a new chat session (with no history) will be created each time the `Chatbot` comoponent initializes.

#### Default

```ts
false
```


---

---
title: ContextMenuProps
---

# Interface ContextMenuProps

Props of the [ContextMenu](../drilldown/function.ContextMenu.md) component.

## Properties

### Widget

#### children

> **children**?: `ReactNode`

React nodes to be rendered at the bottom of the context menu

***

#### closeContextMenu

> **closeContextMenu**: () => `void`

Callback function that is evaluated when the context menu is closed

##### Returns

`void`

***

#### itemSections

> **itemSections**?: [`MenuItemSection`](../type-aliases/type-alias.MenuItemSection.md)[]

Menu item sections

***

#### position

> **position**?: [`MenuPosition`](../type-aliases/type-alias.MenuPosition.md) \| `null`

Context menu position


---

---
title: CustomWidgetComponentProps
---

# Interface CustomWidgetComponentProps`<DataOptions, StyleOptions, DataPoint>`

Props passed to a user-defined custom widget component.

## Example

```ts
import { CustomWidgetComponent, CustomWidgetComponentProps, CustomWidgetDataPoint, StyledColumn, StyledMeasureColumn, DataPointEntry, GenericDataOptions} from '@sisense/sdk-ui';

interface MyDataOptions extends GenericDataOptions {
  category: StyledColumn[];
  value: StyledMeasureColumn[];
}

interface MyDataPoint extends CustomWidgetDataPoint {
  entries: {
    category: DataPointEntry[];
    value: DataPointEntry[];
  };
}

type MyWidgetProps = CustomWidgetComponentProps<MyDataOptions, {}, MyDataPoint>;

const MyWidget: CustomWidgetComponent<MyWidgetProps> = (props) => {
  const { dataOptions, onDataPointClick } = props;
  // ... implementation based on props
  return <div>My Custom Widget</div>;
};
```

## Type parameters

| Parameter | Default | Description |
| :------ | :------ | :------ |
| `DataOptions` | [`GenericDataOptions`](../type-aliases/type-alias.GenericDataOptions.md) | The shape of data options for this custom widget |
| `StyleOptions` | [`CustomWidgetStyleOptions`](../type-aliases/type-alias.CustomWidgetStyleOptions.md) | The shape of style options for this custom widget |
| `DataPoint` *extends* [`AbstractDataPointWithEntries`](../type-aliases/type-alias.AbstractDataPointWithEntries.md) | [`AbstractDataPointWithEntries`](../type-aliases/type-alias.AbstractDataPointWithEntries.md) | The shape of data points for event handlers |

## Properties

### Callbacks

#### onDataPointClick

> **onDataPointClick**?: [`CustomWidgetDataPointEventHandler`](../type-aliases/type-alias.CustomWidgetDataPointEventHandler.md)\< `DataPoint` \>

Click handler callback for a data point

***

#### onDataPointContextMenu

> **onDataPointContextMenu**?: [`CustomWidgetDataPointContextMenuHandler`](../type-aliases/type-alias.CustomWidgetDataPointContextMenuHandler.md)\< `DataPoint` \>

Context menu handler callback for a data point

***

#### onDataPointsSelected

> **onDataPointsSelected**?: [`CustomWidgetDataPointsEventHandler`](../type-aliases/type-alias.CustomWidgetDataPointsEventHandler.md)\< `DataPoint` \>

Handler callback for selection of multiple data points

### Other

#### dataOptions

> **dataOptions**: `DataOptions`

Data options defining what data to display

***

#### dataSource

> **dataSource**?: [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md)

Data source for the custom widget

***

#### description

> **description**?: `string`

Description of the widget

***

#### filters

> **filters**?: [`FilterRelations`](../../sdk-data/interfaces/interface.FilterRelations.md) \| [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Filters to apply to the data

***

#### highlights

> **highlights**?: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Highlight filters for interactive highlighting

***

#### styleOptions

> **styleOptions**?: `StyleOptions`

Style options for customizing appearance


---

---
title: CustomWidgetEventProps
---

# Interface CustomWidgetEventProps`<DataPoint>`

Event props for custom widgets with generic data point type.

## Type parameters

| Parameter | Default | Description |
| :------ | :------ | :------ |
| `DataPoint` *extends* [`AbstractDataPointWithEntries`](../type-aliases/type-alias.AbstractDataPointWithEntries.md) | [`AbstractDataPointWithEntries`](../type-aliases/type-alias.AbstractDataPointWithEntries.md) | The shape of data points for this custom widget |

## Properties

### Callbacks

#### onDataPointClick

> **onDataPointClick**?: [`CustomWidgetDataPointEventHandler`](../type-aliases/type-alias.CustomWidgetDataPointEventHandler.md)\< `DataPoint` \>

Click handler callback for a data point

***

#### onDataPointContextMenu

> **onDataPointContextMenu**?: [`CustomWidgetDataPointContextMenuHandler`](../type-aliases/type-alias.CustomWidgetDataPointContextMenuHandler.md)\< `DataPoint` \>

Context menu handler callback for a data point

***

#### onDataPointsSelected

> **onDataPointsSelected**?: [`CustomWidgetDataPointsEventHandler`](../type-aliases/type-alias.CustomWidgetDataPointsEventHandler.md)\< `DataPoint` \>

Handler callback for selection of multiple data points


---

---
title: CustomWidgetProps
---

# Interface CustomWidgetProps

Props for the Custom Widget component

## Properties

### Data

#### dataSource

> **dataSource**?: [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md)

Data source the query is run against - e.g. `Sample ECommerce`

If not specified, the query will use the `defaultDataSource` specified in the parent Sisense Context.

***

#### filters

> **filters**?: [`FilterRelations`](../../sdk-data/interfaces/interface.FilterRelations.md) \| [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Filters that will slice query results

***

#### highlights

> **highlights**?: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Filters that will highlight query results

### Chart

#### dataOptions

> **dataOptions**: [`GenericDataOptions`](../type-aliases/type-alias.GenericDataOptions.md)

Configurations for how to interpret and present the data passed to the table

### Widget

#### customOptions

> **customOptions**?: `Record`\< `string`, `any` \>

Specific options for the custom widget.

***

#### customWidgetType

> **customWidgetType**: `string`

Custom widget type. This is typically the name/ID of the custom widget.

***

#### description

> **description**?: `string`

Description of the widget

***

#### styleOptions

> **styleOptions**?: [`CustomWidgetStyleOptions`](../type-aliases/type-alias.CustomWidgetStyleOptions.md)

Style options for the custom widget.

***

#### title

> **title**?: `string`

Title of the widget

### Callbacks

#### onDataPointClick

> **onDataPointClick**?: [`CustomWidgetDataPointEventHandler`](../type-aliases/type-alias.CustomWidgetDataPointEventHandler.md)\< [`AbstractDataPointWithEntries`](../type-aliases/type-alias.AbstractDataPointWithEntries.md) \>

Click handler callback for a data point

***

#### onDataPointContextMenu

> **onDataPointContextMenu**?: [`CustomWidgetDataPointContextMenuHandler`](../type-aliases/type-alias.CustomWidgetDataPointContextMenuHandler.md)\< [`AbstractDataPointWithEntries`](../type-aliases/type-alias.AbstractDataPointWithEntries.md) \>

Context menu handler callback for a data point

***

#### onDataPointsSelected

> **onDataPointsSelected**?: [`CustomWidgetDataPointsEventHandler`](../type-aliases/type-alias.CustomWidgetDataPointsEventHandler.md)\< [`AbstractDataPointWithEntries`](../type-aliases/type-alias.AbstractDataPointWithEntries.md) \>

Handler callback for selection of multiple data points


---

---
title: DashboardByIdConfig
---

# Interface DashboardByIdConfig

Dashboard configuration

## Properties

### filtersPanel

> **filtersPanel**?: [`DashboardFiltersPanelConfig`](interface.DashboardFiltersPanelConfig.md)

Configuration for the filters panel

***

### persist

> **persist**?: `boolean`

Boolean flag indicating whether changes to the embedded dashboard should be saved to the dashboard in Fusion.

If not specified, the default value is `false`.

Limitations:
- WAT authentication does not support persistence.
- Currently only changes to dashboard filters are persisted.

***

### tabbers

> **tabbers**?: [`TabbersConfig`](../type-aliases/type-alias.TabbersConfig.md)

Configuration for tabber widgets in the dashboard

***

### toolbar

> **toolbar**?: `object`

Configuration for the toolbar

#### Type declaration

> ##### `toolbar.visible`
>
> **visible**: `boolean`
>
> Determines whether the toolbar is visible.
>
> If not specified, the default value is `true`.
>
>

***

### widgetsPanel

> **widgetsPanel**?: [`WidgetsPanelConfig`](interface.WidgetsPanelConfig.md)

Configuration for the widgets panel


---

---
title: DashboardByIdProps
---

# Interface DashboardByIdProps

Props of the [DashboardById](../fusion-assets/function.DashboardById.md) component.

## Properties

### config

> **config**?: [`DashboardByIdConfig`](interface.DashboardByIdConfig.md)

The configuration for the dashboard

***

### dashboardOid

> **dashboardOid**: `string`

The OID of the dashboard to render.


---

---
title: DashboardConfig
---

# Interface DashboardConfig

Dashboard configuration

## Properties

### filtersPanel

> **filtersPanel**?: [`DashboardFiltersPanelConfig`](interface.DashboardFiltersPanelConfig.md)

Configuration for the filters panel

***

### tabbers

> **tabbers**?: [`TabbersConfig`](../type-aliases/type-alias.TabbersConfig.md)

Configuration for tabber widgets in the dashboard

***

### toolbar

> **toolbar**?: `object`

Configuration for the toolbar

#### Type declaration

> ##### `toolbar.visible`
>
> **visible**: `boolean`
>
> Determines whether the toolbar is visible.
>
> If not specified, the default value is `true`.
>
>

***

### widgetsPanel

> **widgetsPanel**?: [`WidgetsPanelConfig`](interface.WidgetsPanelConfig.md)

Configuration for the widgets panel


---

---
title: DashboardFiltersPanelCollapseChangedEvent
---

# Interface DashboardFiltersPanelCollapseChangedEvent

Event triggered when the filters panel collapsed state changes.

## Properties

### payload

> **payload**: `boolean`

Is the filters panel collapsed?

***

### type

> **type**: `"filtersPanel/collapse/changed"`

Event type


---

---
title: DashboardFiltersPanelConfig
---

# Interface DashboardFiltersPanelConfig

Dashboard filters panel configuration

## Properties

### actions

> **actions**?: `object`

Configures the available actions within the filters panel.

#### Type declaration

> ##### `actions.addFilter`
>
> **addFilter**?: `object`
>
> Configuration for adding a new filter.
>
> > ###### `addFilter.enabled`
> >
> > **enabled**?: `boolean`
> >
> > Determines whether the possibility to create a new filter is enabled.
> >
> > If not specified, the default value is `false`.
> >
> >
>
> ##### `actions.deleteFilter`
>
> **deleteFilter**?: `object`
>
> Configuration for deleting a filter.
>
> > ###### `deleteFilter.enabled`
> >
> > **enabled**?: `boolean`
> >
> > Determines whether the possibility to delete a filter is enabled.
> >
> > If not specified, the default value is `false`.
> >
> >
>
> ##### `actions.editFilter`
>
> **editFilter**?: `object`
>
> Configuration for editing an existing filter.
>
> > ###### `editFilter.enabled`
> >
> > **enabled**?: `boolean`
> >
> > Determines whether the possibility to edit an existing filter is enabled.
> >
> > If not specified, the default value is `false`.
> >
> >
>
>

***

### collapsedInitially

> **collapsedInitially**?: `boolean`

Boolean flag that controls the initial "collapsed" state of the filters panel.

If not specified, the default value is `false`.

***

### persistCollapsedStateToLocalStorage

> **persistCollapsedStateToLocalStorage**?: `boolean`

Setting this to `true` will use the isCollapsed state from local storage, if available, and store any changes to local storage.
This state is shared across all dashboards.
This state has a higher priority than `collapsedInitially` when enabled.

***

### showFilterIconInToolbar

> **showFilterIconInToolbar**?: `boolean`

If enabled, the expand/collapse arrow on the divider between the filters panel and the dashboard content will be replaced with a filter toggle icon on the dashboard toolbar.

If the dashboard toolbar is configured to be not visible, this setting will be ignored.

If not specified, the default value is `false`.

***

### visible

> **visible**?: `boolean`

Determines whether the filters panel is visible.

If not specified, the default value is `true`.


---

---
title: DashboardFiltersUpdatedEvent
---

# Interface DashboardFiltersUpdatedEvent

Event triggered when dashboard filters are updated.

## Properties

### payload

> **payload**: [`FilterRelations`](../../sdk-data/interfaces/interface.FilterRelations.md) \| [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

New filters or filter relations after the update

***

### type

> **type**: `"filters/updated"`

Event type


---

---
title: DashboardLayoutOptions
---

# Interface DashboardLayoutOptions

Dashboard layout options

## Properties

### widgetsPanel

> **widgetsPanel**?: [`WidgetsPanelColumnLayout`](interface.WidgetsPanelColumnLayout.md)

The layout of the dashboard widgets panel
If not provided, the widgets will be laid out in one column vertically by default


---

---
title: DashboardProps
---

# Interface DashboardProps

Props for the Dashboard component

## Properties

### config

> **config**?: [`DashboardConfig`](interface.DashboardConfig.md)

The configuration for the dashboard

***

### defaultDataSource

> **defaultDataSource**?: [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md)

The default data source to use for the dashboard

***

### filters

> **filters**?: [`FilterRelations`](../../sdk-data/interfaces/interface.FilterRelations.md) \| [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

The dashboard filters to be applied to each of the widgets based on the widget filter options

***

### layoutOptions

> **layoutOptions**?: [`DashboardLayoutOptions`](interface.DashboardLayoutOptions.md)

Dashboard layout options

***

### onChange

> **onChange**?: (`event`) => `void`

Callback to receive changes

This callback is invoked when the dashboard state changes, such as filter updates,
layout changes, or widget deletions. See [DashboardChangeEvent](../type-aliases/type-alias.DashboardChangeEvent.md) for all possible event types.

#### Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `event` | [`DashboardChangeEvent`](../type-aliases/type-alias.DashboardChangeEvent.md) | The event that occurred |

#### Returns

`void`

***

### styleOptions

> **styleOptions**?: [`DashboardStyleOptions`](../type-aliases/type-alias.DashboardStyleOptions.md)

The style options for the dashboard

***

### title

> **title**?: `string`

The title of the dashboard

***

### widgets

> **widgets**: [`WidgetProps`](../type-aliases/type-alias.WidgetProps.md)[]

The widgets to render in the dashboard

***

### widgetsOptions

> **widgetsOptions**?: [`WidgetsOptions`](../type-aliases/type-alias.WidgetsOptions.md)

The options for each of the widgets


---

---
title: DashboardWidgetsDeletedEvent
---

# Interface DashboardWidgetsDeletedEvent

Event triggered when widgets are deleted from the dashboard.

## Remarks

When `config.widgetsPanel.editMode.applyChangesAsBatch.enabled` is `true` (default),
this event is only triggered when the user applies changes (clicks "Apply"),
not during the editing process. When `false`, this event is triggered immediately
after widgets are deleted.

## Properties

### payload

> **payload**: `string`[]

The oids of the widgets deleted

***

### type

> **type**: `"widgets/deleted"`

Event type


---

---
title: DashboardWidgetsPanelIsEditingChangedEvent
---

# Interface DashboardWidgetsPanelIsEditingChangedEvent

Event triggered when the edit mode state changes.

## Properties

### payload

> **payload**: `boolean`

Is the widgets panel layout in editing state?

***

### type

> **type**: `"widgetsPanel/editMode/isEditing/changed"`

Event type


---

---
title: DashboardWidgetsPanelLayoutUpdatedEvent
---

# Interface DashboardWidgetsPanelLayoutUpdatedEvent

Event triggered when the widgets panel layout is updated.

## Remarks

When `config.widgetsPanel.editMode.applyChangesAsBatch.enabled` is `true` (default),
this event is only triggered when the user applies changes (clicks "Apply"),
not during the editing process. When `false`, this event is triggered immediately
after each layout change.

## Properties

### payload

> **payload**: [`WidgetsPanelColumnLayout`](interface.WidgetsPanelColumnLayout.md)

The new widgets panel layout

***

### type

> **type**: `"widgetsPanel/layout/updated"`

Event type


---

---
title: DrilldownWidgetProps
---

# Interface DrilldownWidgetProps

Props for the [DrilldownWidget](../drilldown/function.DrilldownWidget.md) component

## Properties

### Widget

#### children

> **children**: (`customDrilldownResult`) => `ReactNode`

React component to be rendered as context menu

[ContextMenu](../drilldown/function.ContextMenu.md) will be used if not provided

##### Parameters

| Parameter | Type |
| :------ | :------ |
| `customDrilldownResult` | [`CustomDrilldownResult`](../type-aliases/type-alias.CustomDrilldownResult.md) |

##### Returns

`ReactNode`

***

#### config

> **config**?: [`DrilldownWidgetConfig`](../type-aliases/type-alias.DrilldownWidgetConfig.md)

An object that allows users to pass advanced configuration options as a prop for the `DrilldownWidget` component

***

#### drilldownPaths

> **drilldownPaths**?: ([`Attribute`](../../sdk-data/interfaces/interface.Attribute.md) \| [`Hierarchy`](interface.Hierarchy.md))[]

Dimensions and hierarchies available for drilldown on.

***

#### initialDimension

> **initialDimension**: [`Attribute`](../../sdk-data/interfaces/interface.Attribute.md)

Initial dimension to apply first set of filters to


---

---
title: ExecuteCustomWidgetQueryParams
---

# Interface ExecuteCustomWidgetQueryParams

Parameters for executing a query for a custom widget.
Contains only data-related properties needed for query execution,
excluding event handlers and other non-query props.

## Properties

### count

> **count**?: `number`

Number of rows to return in the query result

If not specified, the default value is `20000`

***

### dataOptions

> **dataOptions**: [`GenericDataOptions`](../type-aliases/type-alias.GenericDataOptions.md)

Data options defining dimensions and measures

***

### dataSource

> **dataSource**?: [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md)

Data source for the query

***

### enabled

> **enabled**?: `boolean`

Boolean flag to control if the hook is executed

If not specified, the default value is `true`

***

### filters

> **filters**?: [`FilterRelations`](../../sdk-data/interfaces/interface.FilterRelations.md) \| [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Filters to apply to the query

***

### highlights

> **highlights**?: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Highlight filters

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
title: ExecutePivotQueryParams
---

# Interface ExecutePivotQueryParams

Parameters for [useExecutePivotQuery](../queries/function.useExecutePivotQuery.md) hook.

## Properties

### Control

#### enabled

> **enabled**?: `boolean`

Boolean flag to control if query is executed

If not specified, the default value is `true`

### Data Options

#### columns

> **columns**?: ([`Attribute`](../../sdk-data/interfaces/interface.Attribute.md) \| [`PivotAttribute`](../../sdk-data/interfaces/interface.PivotAttribute.md))[]

Dimensions for the columns of the pivot table

***

#### dataSource

> **dataSource**?: [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md)

Data source the query is run against - e.g. `Sample ECommerce`

If not specified, the query will use the `defaultDataSource` specified in the parent Sisense Context.

***

#### grandTotals

> **grandTotals**?: [`PivotGrandTotals`](../../sdk-data/type-aliases/type-alias.PivotGrandTotals.md)

Options for grand totals

***

#### rows

> **rows**?: ([`Attribute`](../../sdk-data/interfaces/interface.Attribute.md) \| [`PivotAttribute`](../../sdk-data/interfaces/interface.PivotAttribute.md))[]

Dimensions for the rows of the pivot table

***

#### values

> **values**?: ([`Measure`](../../sdk-data/interfaces/interface.Measure.md) \| [`PivotMeasure`](../../sdk-data/interfaces/interface.PivotMeasure.md))[]

Measures for the values of the pivot table

### Filtering

#### filters

> **filters**?: [`FilterRelations`](../../sdk-data/interfaces/interface.FilterRelations.md) \| [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Filters that will slice query results

***

#### highlights

> **highlights**?: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Filters that will highlight query results

### Other

#### onBeforeQuery

> **onBeforeQuery**?: (`jaql`) => `any`

Sync or async callback that allows to modify the JAQL payload before it is sent to the server.

**Note:** In React, wrap this function in `useCallback` hook to avoid triggering query execution on each render.
```ts
const onBeforeQuery = useCallback((jaql) => {
  // modify jaql here
  return jaql;
}, []);
```

##### Parameters

| Parameter | Type |
| :------ | :------ |
| `jaql` | `any` |

##### Returns

`any`


---

---
title: ExecuteQueryByWidgetIdParams
---

# Interface ExecuteQueryByWidgetIdParams

Parameters for [useExecuteQueryByWidgetId](../fusion-assets/function.useExecuteQueryByWidgetId.md) hook.

## Properties

### count

> **count**?: `number`

Number of rows to return in the query result

If not specified, the default value is `20000`

***

### dashboardOid

> **dashboardOid**: `string`

Identifier of the dashboard that contains the widget

***

### enabled

> **enabled**?: `boolean`

Boolean flag to control if query is executed

If not specified, the default value is `true`

***

### filters

> **filters**?: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Filters that will slice query results.

The provided filters will be merged with the existing widget filters based on `filtersMergeStrategy`

***

### filtersMergeStrategy

> **filtersMergeStrategy**?: `"codeFirst"` \| `"codeOnly"` \| `"widgetFirst"`

Strategy for merging the existing widget filters (including highlights) with the filters provided via the `filters` and `highlights` props:

- `widgetFirst` - prioritizes the widget filters over the provided filters in case of filter conflicts by certain attributes.
- `codeFirst` - prioritizes the provided filters over the widget filters in case of filter conflicts by certain attributes.
- `codeOnly` - applies only the provided filters and completely ignores the widget filters.

If not specified, the default strategy is `codeFirst`.

***

### highlights

> **highlights**?: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Highlight filters that will highlight results that pass filter criteria

***

### includeDashboardFilters

> **includeDashboardFilters**?: `boolean`

Boolean flag whether to include dashboard filters in the widget's `filters` and `highlights`

If not specified, the default value is `false`.

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

### widgetOid

> **widgetOid**: `string`

Identifier of the widget


---

---
title: ExecuteQueryByWidgetIdProps
---

# Interface ExecuteQueryByWidgetIdProps

Props for [ExecuteQueryByWidgetId](../fusion-assets/function.ExecuteQueryByWidgetId.md) component.

## Properties

### children

> **children**?: (`queryState`) => `ReactNode`

Function as child component that is called to render the query results

#### Parameters

| Parameter | Type |
| :------ | :------ |
| `queryState` | [`QueryByWidgetIdState`](../type-aliases/type-alias.QueryByWidgetIdState.md) |

#### Returns

`ReactNode`

***

### count

> **count**?: `number`

Number of rows to return in the query result

If not specified, the default value is `20000`

***

### dashboardOid

> **dashboardOid**: `string`

Identifier of the dashboard that contains the widget

***

### filters

> **filters**?: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Filters that will slice query results.

The provided filters will be merged with the existing widget filters based on `filtersMergeStrategy`

***

### filtersMergeStrategy

> **filtersMergeStrategy**?: `"codeFirst"` \| `"codeOnly"` \| `"widgetFirst"`

Strategy for merging the existing widget filters (including highlights) with the filters provided via the `filters` and `highlights` props:

- `widgetFirst` - prioritizes the widget filters over the provided filters in case of filter conflicts by certain attributes.
- `codeFirst` - prioritizes the provided filters over the widget filters in case of filter conflicts by certain attributes.
- `codeOnly` - applies only the provided filters and completely ignores the widget filters.

If not specified, the default strategy is `codeFirst`.

***

### highlights

> **highlights**?: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Highlight filters that will highlight results that pass filter criteria

***

### includeDashboardFilters

> **includeDashboardFilters**?: `boolean`

Boolean flag whether to include dashboard filters in the widget's `filters` and `highlights`

If not specified, the default value is `false`.

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

> **onDataChanged**?: (`data`, `queryParams`) => `void`

Callback function that is evaluated when query results are ready

#### Parameters

| Parameter | Type |
| :------ | :------ |
| `data` | [`QueryResultData`](../../sdk-data/interfaces/interface.QueryResultData.md) |
| `queryParams` | [`ExecuteQueryParams`](interface.ExecuteQueryParams.md) |

#### Returns

`void`

***

### widgetOid

> **widgetOid**: `string`

Identifier of the widget


---

---
title: GetDashboardModelOptions
---

# Interface GetDashboardModelOptions

## Properties

### includeFilters

> **includeFilters**?: `boolean`

Boolean flag whether to include filters in the dashboard model

If not specified, the default value is `false`

***

### includeWidgets

> **includeWidgets**?: `boolean`

Boolean flag whether to include widgets in the dashboard model

If not specified, the default value is `false`


---

---
title: GetDashboardModelParams
---

# Interface GetDashboardModelParams

Parameters for [useGetDashboardModel](../fusion-assets/function.useGetDashboardModel.md) hook.

## Properties

### dashboardOid

> **dashboardOid**: `string`

Dashboard identifier

***

### enabled

> **enabled**?: `boolean`

Boolean flag to control if the hook is executed

If not specified, the default value is `true`

***

### includeFilters

> **includeFilters**?: `boolean`

Boolean flag whether to include filters in the dashboard model

If not specified, the default value is `false`

***

### includeWidgets

> **includeWidgets**?: `boolean`

Boolean flag whether to include widgets in the dashboard model

If not specified, the default value is `false`


---

---
title: GetDashboardModelsOptions
---

# Interface GetDashboardModelsOptions

## Properties

### includeWidgets

> **includeWidgets**?: `boolean`

Boolean flag whether to include widgets in the dashboard model

If not specified, the default value is `false`

***

### searchByTitle

> **searchByTitle**?: `string`

Dashboard title to search by

Dashboard titles are not necessarily unique, so the result may contain multiple dashboards.


---

---
title: GetDashboardModelsParams
---

# Interface GetDashboardModelsParams

Parameters for [useGetDashboardModels](../fusion-assets/function.useGetDashboardModels.md) hook.

## Properties

### enabled

> **enabled**?: `boolean`

Boolean flag to control if the hook is executed

If not specified, the default value is `true`

***

### includeWidgets

> **includeWidgets**?: `boolean`

Boolean flag whether to include widgets in the dashboard model

If not specified, the default value is `false`

***

### searchByTitle

> **searchByTitle**?: `string`

Dashboard title to search by

Dashboard titles are not necessarily unique, so the result may contain multiple dashboards.


---

---
title: GetWidgetModelParams
---

# Interface GetWidgetModelParams

Parameters for [useGetWidgetModel](../fusion-assets/function.useGetWidgetModel.md) hook.

## Properties

### dashboardOid

> **dashboardOid**: `string`

Identifier of the dashboard that contains the widget

***

### enabled

> **enabled**?: `boolean`

Boolean flag to control if the hook is executed

If not specified, the default value is `true`

***

### widgetOid

> **widgetOid**: `string`

Identifier of the widget to be retrieved


---

---
title: JumpToDashboardConfig
---

# Interface JumpToDashboardConfig

Configuration for Jump To Dashboard functionality.
Allows users to navigate from a widget to another dashboard with contextual filtering.

## Properties

### enabled

> **enabled**?: `boolean`

Whether Jump To Dashboard functionality is enabled

#### Default

```ts
true
```

***

### filtering

> **filtering**?: `object`

Configuration for filter handling between source and target dashboards

#### Type declaration

> ##### `filtering.extraFilters`
>
> **extraFilters**?: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]
>
> Additional filters to apply to the target dashboard
>
> ###### Example
>
> ```ts
> const extraFilters = [dashboardProps.filters[0], dashboardProps.widgets[0].filters[0]]
> ```
>
> ###### Default
>
> ```ts
> []
> ```
>
> ##### `filtering.includeDashboardFilters`
>
> **includeDashboardFilters**?: `string`[]
>
> Dashboard-level filter dimensions to pass through
>
> undefined - include all
> [] - include nothing
> [string] - include specific dimensions
>
> example: ["[ER.Date (Calendar)]", "[Doctors.Specialty]"]
>
> ###### Default
>
> ```ts
> undefined
> ```
>
> ##### `filtering.includeWidgetFilters`
>
> **includeWidgetFilters**?: `string`[]
>
> Widget-level filter dimensions to pass through
>
> undefined - include all
> [] - include nothing
> [string] - include specific dimensions
>
> example: ["[ER.Date (Calendar)]", "[Doctors.Specialty]"]
>
> ###### Default
>
> ```ts
> undefined
> ```
>
> ##### `filtering.mergeWithTargetFilters`
>
> **mergeWithTargetFilters**?: `boolean`
>
> Whether to merge filters with existing target dashboard filters or replace them
>
> ###### Default
>
> ```ts
> false
> ```
>
>

***

### interaction

> **interaction**?: `object`

Configuration for user interaction behavior

#### Type declaration

> ##### `interaction.captionPrefix`
>
> **captionPrefix**?: `string`
>
> Caption prefix for jumping action (i.e in context menu)
>
> ###### Default
>
> ```ts
> 'Jump to'
> ```
>
> ##### `interaction.showIcon`
>
> **showIcon**?: `boolean`
>
> Whether to show the Jump To Dashboard icon in the toolbar of the source widget
>
> ###### Default
>
> ```ts
> true
> ```
>
> ##### `interaction.triggerMethod`
>
> **triggerMethod**?: [`TriggerMethod`](../type-aliases/type-alias.TriggerMethod.md)
>
> How users trigger the jump action
> Note that not all widgets support both trigger methods
>
> ###### Default
>
> ```ts
> 'rightclick'
> ```
>
>

***

### modal

> **modal**?: `object`

Configuration for the modal window that will display the target dashboard

#### Type declaration

> ##### `modal.height`
>
> **height**?: `number`
>
> Height of the modal window
>
> ###### Default
>
> ```ts
> 85 (when measurementUnit is '%') or 800 (when measurementUnit is 'px')
> ```
>
> ##### `modal.measurementUnit`
>
> **measurementUnit**?: `"%"` \| `"px"`
>
> Unit of measurement for width/height
>
> ###### Default
>
> ```ts
> 'px'
> ```
>
> ##### `modal.width`
>
> **width**?: `number`
>
> Width of the modal window
>
> ###### Default
>
> ```ts
> 85 (when measurementUnit is '%') or 1200 (when measurementUnit is 'px')
> ```
>
>

***

### targetDashboardConfig

> **targetDashboardConfig**?: [`DashboardConfig`](interface.DashboardConfig.md)

Configuration for the target dashboard display.
This configuration will be merged with target dashboard config, having higher priority

#### Default

```ts
{}
```

***

### targets

> **targets**: [`JtdTarget`](../type-aliases/type-alias.JtdTarget.md)[]

List of target dashboards that can be navigated to


---

---
title: JumpToDashboardConfigForPivot
---

# Interface JumpToDashboardConfigForPivot

Configuration for Jump To Dashboard functionality for pivot widgets.
Used for pivot widgets, allowing to configure jumping to different dashboard from different dimensions

## See

[JumpToDashboardConfig](interface.JumpToDashboardConfig.md)

## Properties

### enabled

> **enabled**?: `boolean`

Whether Jump To Dashboard functionality is enabled

#### Default

```ts
true
```

***

### filtering

> **filtering**?: `object`

Configuration for filter handling between source and target dashboards

#### Type declaration

> ##### `filtering.extraFilters`
>
> **extraFilters**?: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]
>
> Additional filters to apply to the target dashboard
>
> ###### Example
>
> ```ts
> const extraFilters = [dashboardProps.filters[0], dashboardProps.widgets[0].filters[0]]
> ```
>
> ###### Default
>
> ```ts
> []
> ```
>
> ##### `filtering.includeDashboardFilters`
>
> **includeDashboardFilters**?: `string`[]
>
> Dashboard-level filter dimensions to pass through
>
> undefined - include all
> [] - include nothing
> [string] - include specific dimensions
>
> example: ["[ER.Date (Calendar)]", "[Doctors.Specialty]"]
>
> ###### Default
>
> ```ts
> undefined
> ```
>
> ##### `filtering.includeWidgetFilters`
>
> **includeWidgetFilters**?: `string`[]
>
> Widget-level filter dimensions to pass through
>
> undefined - include all
> [] - include nothing
> [string] - include specific dimensions
>
> example: ["[ER.Date (Calendar)]", "[Doctors.Specialty]"]
>
> ###### Default
>
> ```ts
> undefined
> ```
>
> ##### `filtering.mergeWithTargetFilters`
>
> **mergeWithTargetFilters**?: `boolean`
>
> Whether to merge filters with existing target dashboard filters or replace them
>
> ###### Default
>
> ```ts
> false
> ```
>
>

***

### interaction

> **interaction**?: `object`

Configuration for user interaction behavior

#### Type declaration

> ##### `interaction.captionPrefix`
>
> **captionPrefix**?: `string`
>
> Caption prefix for jumping action (i.e in context menu)
>
> ###### Default
>
> ```ts
> 'Jump to'
> ```
>
> ##### `interaction.showIcon`
>
> **showIcon**?: `boolean`
>
> Whether to show the Jump To Dashboard icon in the toolbar of the source widget
>
> ###### Default
>
> ```ts
> true
> ```
>
> ##### `interaction.triggerMethod`
>
> **triggerMethod**?: [`TriggerMethod`](../type-aliases/type-alias.TriggerMethod.md)
>
> How users trigger the jump action
> Note that not all widgets support both trigger methods
>
> ###### Default
>
> ```ts
> 'rightclick'
> ```
>
>

***

### modal

> **modal**?: `object`

Configuration for the modal window that will display the target dashboard

#### Type declaration

> ##### `modal.height`
>
> **height**?: `number`
>
> Height of the modal window
>
> ###### Default
>
> ```ts
> 85 (when measurementUnit is '%') or 800 (when measurementUnit is 'px')
> ```
>
> ##### `modal.measurementUnit`
>
> **measurementUnit**?: `"%"` \| `"px"`
>
> Unit of measurement for width/height
>
> ###### Default
>
> ```ts
> 'px'
> ```
>
> ##### `modal.width`
>
> **width**?: `number`
>
> Width of the modal window
>
> ###### Default
>
> ```ts
> 85 (when measurementUnit is '%') or 1200 (when measurementUnit is 'px')
> ```
>
>

***

### targetDashboardConfig

> **targetDashboardConfig**?: [`DashboardConfig`](interface.DashboardConfig.md)

Configuration for the target dashboard display.
This configuration will be merged with target dashboard config, having higher priority

#### Default

```ts
{}
```

***

### targets <Badge type="beta" text="Beta" />

> **targets**: `Map`\< [`Attribute`](../../sdk-data/interfaces/interface.Attribute.md) \| [`Measure`](../../sdk-data/interfaces/interface.Measure.md) \| \{
  `dimension`: [`Attribute`](../../sdk-data/interfaces/interface.Attribute.md);
  `location`: `"column"` \| `"row"` \| `"value"`;
 }, [`JtdTarget`](../type-aliases/type-alias.JtdTarget.md)[] \>

Map of target dashboards for different dimensions/measures

#### Example

```ts
const FormulaMeasure = dashboardProps.widgets[0].dataOptions.values[0];
const ageRangeAttribute = dashboardProps.widgets[0].dataOptions.rows[1];

const targets = new Map([
   [ageRangeAttribute, [target, target2]],
   [FormulaMeasure, [target3]],
]);
```


---

---
title: PivotTableDataOptions
---

# Interface PivotTableDataOptions

Configuration for how to query data and assign data to PivotTable.

## Properties

### Data Options

#### columns

> **columns**?: ([`Column`](../../sdk-data/interfaces/interface.Column.md) \| [`StyledColumn`](interface.StyledColumn.md))[]

Dimensions for the columns of the pivot table

***

#### grandTotals

> **grandTotals**?: [`PivotGrandTotals`](../../sdk-data/type-aliases/type-alias.PivotGrandTotals.md)

Options for grand totals

***

#### rows

> **rows**?: ([`Column`](../../sdk-data/interfaces/interface.Column.md) \| [`StyledColumn`](interface.StyledColumn.md))[]

Dimensions for the rows of the pivot table

***

#### values

> **values**?: ([`CalculatedMeasureColumn`](../../sdk-data/interfaces/interface.CalculatedMeasureColumn.md) \| [`MeasureColumn`](../../sdk-data/interfaces/interface.MeasureColumn.md) \| [`StyledMeasureColumn`](interface.StyledMeasureColumn.md))[]

Measures for the values of the pivot table


---

---
title: PivotTableProps
---

# Interface PivotTableProps

Props of the [PivotTable](../data-grids/function.PivotTable.md) component.

## Properties

### Data

#### dataSet

> **dataSet**?: [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md)

Data source name (as a `string`) - e.g. `Sample ECommerce`.

If not specified, the component will use the `defaultDataSource` specified in the parent Sisense Context.

***

#### filters

> **filters**?: [`FilterRelations`](../../sdk-data/interfaces/interface.FilterRelations.md) \| [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Filters that will slice query results

***

#### highlights

> **highlights**?: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Filters that will highlight query results

### Callbacks

#### onDataPointClick

> **onDataPointClick**?: [`PivotTableDataPointEventHandler`](../type-aliases/type-alias.PivotTableDataPointEventHandler.md)

Callback function that is called when the pivot table cell is clicked

***

#### onDataPointContextMenu

> **onDataPointContextMenu**?: [`PivotTableDataPointEventHandler`](../type-aliases/type-alias.PivotTableDataPointEventHandler.md)

Callback function that is called when the pivot table cell is right-clicked

### Representation

#### dataOptions

> **dataOptions**: [`PivotTableDataOptions`](interface.PivotTableDataOptions.md)

Configurations for how to interpret and present the data passed to the component

***

#### styleOptions

> **styleOptions**?: [`PivotTableStyleOptions`](interface.PivotTableStyleOptions.md)

Configurations for how to style and present a pivot table's data.


---

---
title: PivotTableStyleOptions
---

# Interface PivotTableStyleOptions

Configuration options that define functional style of the various elements of the PivotTable component.

## Properties

### alternatingColumnsColor

> **alternatingColumnsColor**?: `boolean`

Boolean flag whether to apply background color to alternate columns

***

### alternatingRowsColor

> **alternatingRowsColor**?: `boolean`

Boolean flag whether to apply background color to alternate rows.

***

### alwaysShowResultsPerPage

> **alwaysShowResultsPerPage**?: `boolean`

Boolean flag whether to always show the results per page select

If `true`, the results per page select will be shown even if there is only one page of results.

#### Default

```ts
false
```

***

### headersColor

> **headersColor**?: `boolean`

Boolean flag whether to fill header cells with background color

***

### height

> **height**?: `number`

Total height of the component, which is considered in the following order of priority:

1. Value passed to this property (in pixels).
2. Height of the container wrapping this component
3. Default value of 500px (for component without header) or 525px (for component with header).

***

### highlightColor

> **highlightColor**?: `string`

Color of highlighted cells. If not specified, default value is light yellow (`#ffff9c`).

***

### isAutoContentWidth

> **isAutoContentWidth**?: `boolean`

Boolean flag whether the widths of each vertical column of table cells should be automatically calculated
to fit the width of the component, which defaults to '100%' if `width` is not specified.

If `true`, all vertical columns of table cells will be resized to fit within the component width without requiring horizontal scroll.
If a width is also specified in the `dataOptions` item, this will be used to calculate the width in proportion to the total width of the component.
Using `isAutoContentWidth: true` with a large number of columns displayed may result in very narrow columns, and is not recommended.

If `false`, each vertical column of table cells will be calculated to fit the contents, or if specified, the width provided in the corresponding `dataOptions` item.
Horizontal scroll will be shown automatically if required.

#### Default

```ts
false
```

***

### isAutoHeight

> **isAutoHeight**?: `boolean`

Boolean flag whether the height of the component should be automatically adjusted to fit the content

***

### membersColor

> **membersColor**?: `boolean`

Boolean flag whether to fill row members cells with background color

***

### rowHeight

> **rowHeight**?: `number`

Manual height of each row (default is 25px)

***

### rowsPerPage

> **rowsPerPage**?: `number`

Number of rows per page

Default value is 25

***

### totalsColor

> **totalsColor**?: `boolean`

Boolean flag whether to fill totals and subtotals cells with background color

***

### width

> **width**?: `number`

Total width of the component, which is considered in the following order of priority:

1. Value passed to this property (in pixels)
2. Width of the container wrapping this component
3. Default value of 400px


---

---
title: PivotTableWidgetProps
---

# Interface PivotTableWidgetProps

Props for the [PivotTableWidget](../dashboards/function.PivotTableWidget.md) component

## Properties

### Data

#### dataSource

> **dataSource**?: [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md)

Data source the query is run against - e.g. `Sample ECommerce`

If not specified, the query will use the `defaultDataSource` specified in the parent Sisense Context.

***

#### filters

> **filters**?: [`FilterRelations`](../../sdk-data/interfaces/interface.FilterRelations.md) \| [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Filters that will slice query results

***

#### highlights

> **highlights**?: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Filters that will highlight query results

### Chart

#### dataOptions

> **dataOptions**: [`PivotTableDataOptions`](interface.PivotTableDataOptions.md)

Configurations for how to interpret and present the data passed to the table

### Widget

#### description

> **description**?: `string`

Description of the widget

***

#### drilldownOptions

> **drilldownOptions**?: [`PivotTableDrilldownOptions`](../type-aliases/type-alias.PivotTableDrilldownOptions.md)

Configuration for the pivot table drilldown

***

#### styleOptions

> **styleOptions**?: [`PivotTableWidgetStyleOptions`](../type-aliases/type-alias.PivotTableWidgetStyleOptions.md)

Style options for both the table and widget including the widget header

***

#### title

> **title**?: `string`

Title of the widget

### Callbacks

#### onDataPointClick

> **onDataPointClick**?: [`PivotTableDataPointEventHandler`](../type-aliases/type-alias.PivotTableDataPointEventHandler.md)

Callback function that is called when the pivot table cell is clicked

***

#### onDataPointContextMenu

> **onDataPointContextMenu**?: [`PivotTableDataPointEventHandler`](../type-aliases/type-alias.PivotTableDataPointEventHandler.md)

Callback function that is called when the pivot table cell is right-clicked


---

---
title: SisenseContextProviderProps
---

# Interface SisenseContextProviderProps

Configurations and authentication for Sisense Context.

Use one of the following to authenticate:

- [ssoEnabled](interface.SisenseContextProviderProps.md#ssoenabled)
- [token](interface.SisenseContextProviderProps.md#token)
- [wat](interface.SisenseContextProviderProps.md#wat)

## Properties

### Sisense App

#### appConfig

> **appConfig**?: [`AppConfig`](../type-aliases/type-alias.AppConfig.md)

Application specific configurations such as locale and date formats.

***

#### defaultDataSource

> **defaultDataSource**?: [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md)

Default data source explicitly set to be used by child components that are not defined with a data source.

***

#### url

> **url**: `string`

URL of the Sisense environment the app connects to

### Sisense App Error Handling

#### onError

> **onError**?: (`error`, `errorDetails`?) => `ReactNode` \| `void`

Callback function that is triggered when an error occurs within the Sisense context.

Return React node to render a custom error UI.
Return `undefined` to use the default error UI.

This callback is useful for handling errors that happen during the initialization or runtime of the Sisense context,
such as incorrect configuration, invalid authentication, or network-related issues.

##### Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `error` | `Error` | The error object containing details about the issue. |
| `errorDetails`? | `object` | Additional details about the error, such as the component name and props that caused this error. |
| `errorDetails.componentName`? | `string` | The name of the component that caused the error. |
| `errorDetails.componentProps`? | `unknown` | The props of the component that caused the error. |

##### Returns

`ReactNode` \| `void`

***

#### showRuntimeErrors

> **showRuntimeErrors**?: `boolean`

Boolean flag to show or hide run-time errors that involve Sisense context in the UI.
Example errors include incorrect Sisense URL or invalid authentication.
Note that this flag does not hide run-time errors in the console.
If disabled - it's recommended to specify an [onError](interface.SisenseContextProviderProps.md#onerror) callback to handle errors.

If not specified, the default value is `true`.

### Sisense Authentication

#### enableSilentPreAuth

> **enableSilentPreAuth**?: `boolean`

Boolean flag to enable sending silent pre-authentication requests to the Sisense instance.
Used to check if user is already authenticated, check is performed in an ivisible iframe.
Used only with SSO authentication.
If not specified, the default value is `false`.

***

#### ssoEnabled

> **ssoEnabled**?: `boolean`

[Single Sign-On](https://docs.sisense.com/main/SisenseLinux/using-single-sign-on-to-access-sisense.htm) toggle.

Set to `true` to use SSO authentication. When `true`, this overrides any other authentication methods. Defaults to `false`.

***

#### token

> **token**?: `null` \| `string`

Token for [bearer authentication](https://developer.sisense.com/guides/restApi/using-rest-api.html).

To signify that the token is pending (e.g., being generated), set the value to `null`. This is supported for React and Vue only.

***

#### useFusionAuth

> **useFusionAuth**?: `boolean`

Flag to delegate authentication to Fusion.

Defaults to `false`.

***

#### wat

> **wat**?: `null` \| `string`

[Web Access Token](https://docs.sisense.com/main/SisenseLinux/using-web-access-token.htm).

To signify that the token is pending (e.g., being generated), set the value to `null`. This is supported for React and Vue only.


---

---
title: TabberButtonsWidgetProps
---

# Interface TabberButtonsWidgetProps

Props for tabbers buttons widget in a dashboard.

## Properties

### Data

#### dataSource

> **dataSource**?: [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md)

Data source the query is run against - e.g. `Sample ECommerce`

If not specified, the query will use the `defaultDataSource` specified in the parent Sisense Context.

***

#### filters

> **filters**?: [`FilterRelations`](../../sdk-data/interfaces/interface.FilterRelations.md) \| [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Filters that will slice query results

***

#### highlights

> **highlights**?: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Filters that will highlight query results

### Widget

#### title

> **title**?: `string`

Title of the widget

### Callbacks

#### onDataPointClick

> **onDataPointClick**?: [`CustomWidgetDataPointEventHandler`](../type-aliases/type-alias.CustomWidgetDataPointEventHandler.md)\< [`AbstractDataPointWithEntries`](../type-aliases/type-alias.AbstractDataPointWithEntries.md) \>

Click handler callback for a data point

***

#### onDataPointContextMenu

> **onDataPointContextMenu**?: [`CustomWidgetDataPointContextMenuHandler`](../type-aliases/type-alias.CustomWidgetDataPointContextMenuHandler.md)\< [`AbstractDataPointWithEntries`](../type-aliases/type-alias.AbstractDataPointWithEntries.md) \>

Context menu handler callback for a data point

***

#### onDataPointsSelected

> **onDataPointsSelected**?: [`CustomWidgetDataPointsEventHandler`](../type-aliases/type-alias.CustomWidgetDataPointsEventHandler.md)\< [`AbstractDataPointWithEntries`](../type-aliases/type-alias.AbstractDataPointWithEntries.md) \>

Handler callback for selection of multiple data points

### Other

#### customOptions

> **customOptions**: [`TabberButtonsWidgetCustomOptions`](../type-aliases/type-alias.TabberButtonsWidgetCustomOptions.md)

Configuration for tabs including names and active tab index

***

#### customWidgetType

> **customWidgetType**: `"tabber-buttons"`

Custom widget type identifier, always 'tabber-buttons' for tabber widget

***

#### dataOptions

> **dataOptions**: `Record`\< `string`, `never` \>

Data options configuration (empty object for tabber widget as it doesn't require data)

***

#### description

> **description**?: `string`

Description text displayed in the widget

***

#### id

> **id**: `string`

Unique identifier for the widget

***

#### styleOptions

> **styleOptions**?: [`TabberButtonsWidgetStyleOptions`](../type-aliases/type-alias.TabberButtonsWidgetStyleOptions.md)

Style configuration options for the tabber buttons widget

***

#### widgetType

> **widgetType**: `"custom"`

Widget type identifier, always 'custom' for tabber widget


---

---
title: TextWidgetProps
---

# Interface TextWidgetProps

Props for the `TextWidget` component.

## Properties

### Widget

#### styleOptions

> **styleOptions**: [`TextWidgetStyleOptions`](../type-aliases/type-alias.TextWidgetStyleOptions.md)

Style options for the text widget.


---

---
title: WidgetByIdProps
---

# Interface WidgetByIdProps

Props for the [WidgetById](../fusion-assets/function.WidgetById.md) component

## Properties

### Data

#### filters

> **filters**?: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Filters that will slice query results

Provided filters will be merged with the existing filters from the widget configuration.

***

#### filtersMergeStrategy

> **filtersMergeStrategy**?: `"codeFirst"` \| `"codeOnly"` \| `"widgetFirst"`

Strategy for merging the existing widget filters (including highlights) with the filters provided via the `filters` and `highlights` props:

- `widgetFirst` - prioritizes the widget filters over the provided filters in case of filter conflicts by certain attributes.
- `codeFirst` - prioritizes the provided filters over the widget filters in case of filter conflicts by certain attributes.
- `codeOnly` - applies only the provided filters and completely ignores the widget filters.

If not specified, the default strategy is `codeFirst`.

***

#### highlights

> **highlights**?: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Highlight filters that will highlight results that pass filter criteria

***

#### includeDashboardFilters

> **includeDashboardFilters**?: `boolean`

Boolean flag whether to include dashboard filters in the widget's `filters` and `highlights`

If not specified, the default value is `false`.

### Widget

#### dashboardOid

> **dashboardOid**: `string`

Identifier of the dashboard that contains the widget

***

#### description

> **description**?: `string`

Description of the widget

If not specified, it takes the existing value from the widget configuration.

***

#### highlightSelectionDisabled

> **highlightSelectionDisabled**?: `boolean`

Boolean flag whether selecting data points triggers highlight filter of the selected data

Recommended to turn on when the Chart Widget component is enhanced with data drilldown by the Drilldown Widget component

If not specified, the default value is `false`

***

#### styleOptions

> **styleOptions**?: [`WidgetByIdStyleOptions`](interface.WidgetByIdStyleOptions.md)

Style options for the widget including the widget container and the chart or table inside.

***

#### title

> **title**?: `string`

Title of the widget

If not specified, it takes the existing value from the widget configuration.

***

#### widgetOid

> **widgetOid**: `string`

Identifier of the widget

### Callbacks

#### onBeforeRender

> **onBeforeRender**?: [`BeforeRenderHandler`](../type-aliases/type-alias.BeforeRenderHandler.md) \| [`IndicatorBeforeRenderHandler`](../type-aliases/type-alias.IndicatorBeforeRenderHandler.md)

A callback that allows you to customize the underlying chart element before it is rendered. The returned options are then used when rendering the chart.

This callback is not supported for Areamap Chart, Scattermap Chart, Table, and PivotTable.

***

#### onDataPointClick

> **onDataPointClick**?: [`AreamapDataPointEventHandler`](../type-aliases/type-alias.AreamapDataPointEventHandler.md) \| [`BoxplotDataPointEventHandler`](../type-aliases/type-alias.BoxplotDataPointEventHandler.md) \| [`CalendarHeatmapDataPointEventHandler`](../type-aliases/type-alias.CalendarHeatmapDataPointEventHandler.md) \| [`DataPointEventHandler`](../type-aliases/type-alias.DataPointEventHandler.md) \| [`IndicatorDataPointEventHandler`](../type-aliases/type-alias.IndicatorDataPointEventHandler.md) \| [`ScatterDataPointEventHandler`](../type-aliases/type-alias.ScatterDataPointEventHandler.md) \| [`ScattermapDataPointEventHandler`](../type-aliases/type-alias.ScattermapDataPointEventHandler.md)

Click handler callback for a data point

***

#### onDataPointContextMenu

> **onDataPointContextMenu**?: [`BoxplotDataPointEventHandler`](../type-aliases/type-alias.BoxplotDataPointEventHandler.md) \| [`CalendarHeatmapDataPointEventHandler`](../type-aliases/type-alias.CalendarHeatmapDataPointEventHandler.md) \| [`DataPointEventHandler`](../type-aliases/type-alias.DataPointEventHandler.md) \| [`ScatterDataPointEventHandler`](../type-aliases/type-alias.ScatterDataPointEventHandler.md)

Context menu handler callback for a data point

***

#### onDataPointsSelected

> **onDataPointsSelected**?: [`CalendarHeatmapDataPointsEventHandler`](../type-aliases/type-alias.CalendarHeatmapDataPointsEventHandler.md) \| [`DataPointsEventHandler`](../type-aliases/type-alias.DataPointsEventHandler.md) \| [`ScatterDataPointsEventHandler`](../type-aliases/type-alias.ScatterDataPointsEventHandler.md)

Handler callback for selection of multiple data points

***

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


---

---
title: WidgetByIdStyleOptions
---

# Interface WidgetByIdStyleOptions

Style settings defining the look and feel of the widget created in Fusion

## Properties

### backgroundColor

> **backgroundColor**?: `string`

Widget background color

Affects chart background color as well

***

### border

> **border**?: `boolean`

Widget container border toggle

***

### borderColor

> **borderColor**?: `string`

Widget container border color

***

### cornerRadius

> **cornerRadius**?: [`RadiusSizes`](../type-aliases/type-alias.RadiusSizes.md)

Corner radius of the widget container

***

### header

> **header**?: `object`

Widget header styles

#### Type declaration

> ##### `header.backgroundColor`
>
> **backgroundColor**?: `string`
>
> Header background color
>
> ##### `header.dividerLine`
>
> **dividerLine**?: `boolean`
>
> Toggle of the divider line between widget header and chart
>
> ##### `header.dividerLineColor`
>
> **dividerLineColor**?: `string`
>
> Divider line color
>
> ##### `header.hidden`
>
> **hidden**?: `boolean`
>
> Header visibility toggle
>
> ##### `header.titleAlignment`
>
> **titleAlignment**?: [`AlignmentTypes`](../type-aliases/type-alias.AlignmentTypes.md)
>
> Header title alignment
>
> ##### `header.titleTextColor`
>
> **titleTextColor**?: `string`
>
> Header title text color
>
>

***

### height

> **height**?: `number`

Total height of the component, which is considered in the following order of priority:

1. Value passed to this property (in pixels).
2. Height of the container wrapping this component
3. Default value as specified per chart type

***

### shadow

> **shadow**?: [`ShadowsTypes`](../type-aliases/type-alias.ShadowsTypes.md)

Shadow level of the widget container

Effective only when spaceAround is defined

***

### spaceAround

> **spaceAround**?: [`SpaceSizes`](../type-aliases/type-alias.SpaceSizes.md)

Space between widget container edge and the chart

***

### width

> **width**?: `number`

Total width of the component, which is considered in the following order of priority:

1. Value passed to this property (in pixels)
2. Width of the container wrapping this component
3. Default value as specified per chart type


---

---
title: WidgetContainerStyleOptions
---

# Interface WidgetContainerStyleOptions

Style settings defining the look and feel of widget itself and widget header

## Properties

### backgroundColor

> **backgroundColor**?: `string`

Widget background color

Affects chart background color as well

***

### border

> **border**?: `boolean`

Widget container border toggle

***

### borderColor

> **borderColor**?: `string`

Widget container border color

***

### cornerRadius

> **cornerRadius**?: [`RadiusSizes`](../type-aliases/type-alias.RadiusSizes.md)

Corner radius of the widget container

***

### header

> **header**?: `object`

Widget header styles

#### Type declaration

> ##### `header.backgroundColor`
>
> **backgroundColor**?: `string`
>
> Header background color
>
> ##### `header.dividerLine`
>
> **dividerLine**?: `boolean`
>
> Toggle of the divider line between widget header and chart
>
> ##### `header.dividerLineColor`
>
> **dividerLineColor**?: `string`
>
> Divider line color
>
> ##### `header.hidden`
>
> **hidden**?: `boolean`
>
> Header visibility toggle
>
> ##### `header.titleAlignment`
>
> **titleAlignment**?: [`AlignmentTypes`](../type-aliases/type-alias.AlignmentTypes.md)
>
> Header title alignment
>
> ##### `header.titleTextColor`
>
> **titleTextColor**?: `string`
>
> Header title text color
>
>

***

### shadow

> **shadow**?: [`ShadowsTypes`](../type-aliases/type-alias.ShadowsTypes.md)

Shadow level of the widget container

Effective only when spaceAround is defined

***

### spaceAround

> **spaceAround**?: [`SpaceSizes`](../type-aliases/type-alias.SpaceSizes.md)

Space between widget container edge and the chart


---

---
title: WidgetsPanelCell
---

# Interface WidgetsPanelCell

Part of Dashboard layout, which describes how widgets are arranged in a cell

## Properties

### widgetId

> **widgetId**: `string`

***

### widthPercentage

> **widthPercentage**: `number`


---

---
title: WidgetsPanelConfig
---

# Interface WidgetsPanelConfig

Widgets panel configuration

## Properties

### editMode

> **editMode**?: [`EditModeConfig`](interface.EditModeConfig.md)

Edit mode configuration.

***

### responsive

> **responsive**?: `boolean`

If `true`, adjust layout based on available width of widgets panel.

If not specified, the default value is `false`.


---

---
title: WidgetsPanelRow
---

# Interface WidgetsPanelRow

Part of Dashboard layout, which describes how widgets are arranged in a row

## Properties

### cells

> **cells**: [`WidgetsPanelCell`](interface.WidgetsPanelCell.md)[]

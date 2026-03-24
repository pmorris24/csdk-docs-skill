---
title: ContextMenu
---

# Class ContextMenu

`ContextMenu` component from the `@sisense/sdk-ui-vue` package.
This component provides a context menu that can be customized with different items and sections.
It allows for flexible positioning and can be easily integrated into Vue applications.

## Example

Here's how to use the `ContextMenu` component:
```vue
<template>
  <ContextMenu :closeContextMenu="closeMenu" :itemSections="sections" :position="menuPosition">
  </ContextMenu>
</template>

<script>
import { ref } from 'vue';
import ContextMenu from './ContextMenu.vue';

export default {
  components: { ContextMenu },
  setup() {
    const sections = ref([...]);
    const menuPosition = ref({ top: 0, left: 0 });
    const closeMenu = () => {};
   }
};
</script>
```

## Properties

### closeContextMenu

> **`readonly`** **closeContextMenu**: () => `void`

Function to close the context menu. It should be a function that sets the visibility of the context menu to false.

#### Returns

`void`

***

### itemSections

> **`readonly`** **itemSections**?: [`MenuItemSection`](../type-aliases/type-alias.MenuItemSection.md)[]

An array of sections, each containing an array of items to be rendered in the context menu. Each item can be a string or an object specifying the item's properties.

***

### position

> **`readonly`** **position**?: [`MenuPosition`](../type-aliases/type-alias.MenuPosition.md) \| `null`

An object specifying the position of the context menu. It should contain `top` and `left` properties to position the menu on the screen.


---

---
title: DrilldownBreadcrumbs
---

# Class DrilldownBreadcrumbs

`DrilldownBreadcrumbs` component from the `@sisense/sdk-ui-vue` package.
This component provides a way to display and interact with the drilldown path in data visualization components,
allowing users to navigate through different levels of data drilldowns. It includes functionalities to clear selections
or slice through the drilldown selections for a more intuitive data exploration experience.

## Example

Here's how to use the `DrilldownBreadcrumbs` component:
```vue
<template>
  <DrilldownBreadcrumbs
    :clearDrilldownSelections="clearSelections"
    :currentDimension="currentDimension"
    :sliceDrilldownSelections="sliceSelections"
    :filtersDisplayValues="filtersDisplayValues"
  />
</template>

<script>
import { ref } from 'vue';
import DrilldownBreadcrumbs from './DrilldownBreadcrumbs.vue';

export default {
  components: { DrilldownBreadcrumbs },
  setup() {
    const clearSelections = () => {};
    const currentDimension = ref({<current dimension object>});
    const sliceSelections = (index) => { <logic to slice selections up to index> };
    const filtersDisplayValues = ref({<object mapping filter values to display values>});

    return { clearSelections, currentDimension, sliceSelections, filtersDisplayValues };
  }
};
</script>
```

## Properties

### Widget

#### clearDrilldownSelections

> **`readonly`** **clearDrilldownSelections**: () => `void`

Callback function that is evaluated when the close (X) button is clicked

##### Returns

`void`

***

#### currentDimension

> **`readonly`** **currentDimension**: [`Attribute`](../../sdk-data/interfaces/interface.Attribute.md)

Currently selected drilldown dimension

***

#### filtersDisplayValues

> **`readonly`** **filtersDisplayValues**: `string`[][]

List of drilldown filters formatted to be displayed as breadcrumbs

***

#### sliceDrilldownSelections

> **`readonly`** **sliceDrilldownSelections**: (`i`) => `void`

Callback function that is evaluated when a breadcrumb is clicked

##### Parameters

| Parameter | Type |
| :------ | :------ |
| `i` | `number` |

##### Returns

`void`


---

---
title: DrilldownWidget
---

# Class DrilldownWidget

Vue component designed to add drilldown functionality to any type of chart

It acts as a wrapper around a given chart component, enhancing it with drilldown capabilities

The widget offers several features including:
- A context menu for initiating drilldown actions (can be provided as a custom component)
- Breadcrumbs that not only allow for drilldown selection slicing but also
provide an option to clear the selection (can be provided as a custom component)
- Filters specifically created for drilldown operation
- An option to navigate to the next drilldown dimension

When an `initialDimension` is specified, the `drilldownDimension` will automatically inherit its value,
even before any points on the chart are selected.
This allows for complete control over the chart's dimensions to be handed over to the DrilldownWidget

## Example

Here's how to use the `DrilldownWidget` component:
```vue
<template>
   <DrilldownWidget
     :drilldownPaths="drilldownPaths"
     :initialDimension="dimProductName"
   >
     <template
       #chart="{ drilldownFilters, drilldownDimension, onDataPointsSelected, onContextMenu }"
     >
       <ChartWidget
         chart-type="bar"
         v-bind:filters="drilldownFilters"
         :dataOptions="{
           ...chartProps.dataOptions,
           category: [drilldownDimension],
         }"
         :highlight-selection-disabled="true"
         :dataSet="chartProps.dataSet"
         :style="chartProps.styleOptions"
         :on-data-points-selected="(dataPoints: any, event: any) => {
           onDataPointsSelected(dataPoints);
           onContextMenu({ left: event.clientX, top: event.clientY });
         }"
         :on-data-point-click="(dataPoint: any, event: any) => {
           onDataPointsSelected([dataPoint]);
           onContextMenu({ left: event.clientX, top: event.clientY });
         }"
         :on-data-point-context-menu="(dataPoint: any, event: any) => {
           onDataPointsSelected([dataPoint]);
           onContextMenu({ left: event.clientX, top: event.clientY });
         }"
       />
     </template>
   </DrilldownWidget>
</template>

<script>
import { ref } from 'vue';
import { DrilldownWidget } from '@sisense/sdk-ui-vue';

const chartProps = ref<ChartProps>({
 chartType: 'bar',
 dataSet: DM.DataSource,
 dataOptions: {
   category: [dimProductName],
   value: [{ column: measureTotalRevenue, sortType: 'sortDesc' }],
   breakBy: [],
 },
 filters: [filterFactory.topRanking(dimProductName, measureTotalRevenue, 10)],
 styleOptions: {
   xAxis: {
     title: {
       text: 'Product Name',
       enabled: true,
     },
   },
   yAxis: {
     title: {
       text: 'Total Revenue',
       enabled: true,
     },
   },
 },
});
const drilldownPaths = [DM.DimCountries.CountryName, DM.DimProducts.ProductName];
const dimProductName = DM.DimProducts.ProductName;
</script>
```
<img src="../../../img/vue-drilldown-widget-example.png" width="800px" />

## Param

DrilldownWidget properties

## Properties

### Widget

#### config

> **`readonly`** **config**: [`DrilldownWidgetConfig`](../type-aliases/type-alias.DrilldownWidgetConfig.md)

An object that allows users to pass advanced configuration options as a prop for the `DrilldownWidget` component

***

#### drilldownPaths

> **`readonly`** **drilldownPaths**: ([`Attribute`](../../sdk-data/interfaces/interface.Attribute.md) \| [`Hierarchy`](../../sdk-ui/interfaces/interface.Hierarchy.md))[] \| `undefined`

Dimensions and hierarchies available for drilldown on.

***

#### initialDimension

> **`readonly`** **initialDimension**: [`Attribute`](../../sdk-data/interfaces/interface.Attribute.md)

Initial dimension to apply first set of filters to

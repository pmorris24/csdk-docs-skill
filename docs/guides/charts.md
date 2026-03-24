---
title: Compose SDK Charts
---

# Compose SDK Charts

The chart components found in the `sdk-ui` modules of Compose SDK are a great way to display analytics data with minimal effort. They can be used out of the box with data retrieved from a Sisense instance, or with the correct structure, data retrieved from anywhere else.

The charts allow you to customize the data that is presented, how that data is styled, and how your users can interact with that data. The components provide properties for the most common customization options and also allow you to manipulate the underlying chart configuration before rendering if necessary.

Compose SDK charts are currently available as React and Angular components.

There are several different types of components you can use to display charts.

- Specific chart components - Each chart type has a component specifically for that chart type. For example, to display a pie chart, you can use the `<PieChart />` component. These components offer the most granular customization levels since their properties are tailored to the specific type of chart you’re working with.
- Chart - A universal `<Chart />` component that can be used to display charts of different types. You specify which type of chart you want to display using the component’s `chartType` property. This component can be used to easily switch between chart types or to show a series of charts that are all different types.
- ChartWidget - A universal `<Chart />` wrapped in a widget container. You can use the widget wrapping to add a title, widget styling, and more.

Although there are some differences between the different chart types, their basic usage is mostly similar. Each chart has the same base properties for working with a chart’s data, chart options, and callbacks. In addition to these base properties, some charts will have additional properties specific to their chart types.

The examples in this guide will use the generic `<Chart />` component, but you can apply the code found in the examples to other chart types as well. The examples will also mostly use data from a Sisense instance, but the code in the examples can be adapted to work with data from other sources as well.

## Data Properties

Charts contain the following data properties for working with the data the chart displays:

- `dataSet` - Data or reference to the data the chart displays
- `filters` - Filters to apply to the chart data
- `highlights` - Highlights that highlight data that pass certain criteria

### dataSet

The `dataSet` property defines a chart’s data. The data you use for your chart can either be data queried from a data source in a Sisense instance or any explicit data.

If no data is specified, the chart uses data from the `defaultDataSource` (specified in the `<SisenseContextProvider />` for React projects and in the `SisenseContextConfig` object for Angular projects).

The way the data is applied to a chart is defined by the chart’s `dataOptions` as explained below.

#### Sisense data

When using data from a Sisense instance, set the `dataSet` property’s value to the name of the Sisense data source. Typically, you retrieve the data source name from a data model you create using the `get-data-model` command of the Compose SDK CLI.

Under the hood, a chart executes a query to connect to the data source and load the data as specified in the `dataOptions`, `filters`, and `highlights` as described below. You can also perform the query explicitly (using the `<ExecuteQuery />` component or the `useExecuteQuery()` hook in React or the `QueryService` in Angular) and use the returned data as a chart’s `dataSet` value. Running a query explicitly allows you to use the query results for a number of purposes, to populate multiple charts for example, instead of tying the query to a single chart.

For example, the following code snippets set a chart’s dataset using data from the Sample ECommerce data model:

##### React

<iframe
 src='https://csdk-playground.sisense.com/?example=charts-guide%2Fsimple-chart&mode=docs'
 width=800
 height=870
 style='border:none;'
/>

##### Angular

```ts
// Component behavior in .component.ts

import { measureFactory } from '@sisense/sdk-data';
import * as DM from '../../sample-ecommerce';

//...

chart = {
  chartType: 'column' as const,
  dataSet: DM.DataSource,
  dataOptions: {
    category: [DM.Commerce.AgeRange],
    value: [measureFactory.sum(DM.Commerce.Revenue)],
  },
},
```

```html
<!--Component HTML template in .component.html-->
<csdk-chart [chartType]="chart.chartType" [dataSet]="chart.dataSet" [dataOptions]="chart.dataOptions" />
```

#### Explicit data

In addition to data from Sisense, you can use any other data with Compose SDK charts. This can be static data that you provide or data from a 3rd party.

The Compose SDK charts expect data in a specific tabular format. The data must be an object containing an array of `Column` objects and a two-dimensional array of row data. The `Column` objects have `name` and `type` properties. The row data can be made up of strings and numbers for raw data or `Cell` objects for data that includes some formatting information in addition to the raw data.

Once you have your data formatted properly, you can use that data by setting the data object as the value of the `dataSet` property.

For example, the following code snippets set a chart’s dataset using static data:

##### Sample data

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

##### React

<iframe
 src='https://csdk-playground.sisense.com/?example=charts-guide%2Fexplicit-data&mode=docs'
 width=800
 height=870
 style='border:none;'
/>

##### Angular

```ts
// Component behavior in .component.ts

chart = {
  chartType: 'column' as const,
  dataSet: sampleData,
  dataOptions: {
    category: [{ name: 'Years', type: 'date' }],
    value: [{ name: 'Quantity', type: 'number' }],
  },
},
```

```html
<!--Component HTML template in .component.html-->

<csdk-chart [chartType]="chart.chartType" [dataSet]="chart.dataSet" [dataOptions]="chart.dataOptions" />
```

### filters

The `filters` property defines filters to apply to a chart’s data. You can create filters using filtering functions or connect your filtering to filter UI components.

You can use filters on a single chart or use the same filter to filter multiple charts at once.

#### Filter functions

The `sdk-data` module contains factory functions to create text, number, and date filters on specified attributes.
Call one or more of these functions to create filters that you then use to set the value of a chart's `filter` property.

Use this filtering option when you know what you want to filter on when writing your code or you want to create a dynamic filter without using Compose SDK filtering UI components.

For example, the following code snippets filter a chart’s dataset to only include data where the cost is greater than 1000.

##### React

<iframe
 src='https://csdk-playground.sisense.com/?example=charts-guide%2Ffilter-function&mode=docs'
 width=800
 height=870
 style='border:none;'
/>

##### Angular

```ts
// Component behavior in .component.ts

import { filterFactory, measureFactory } from '@sisense/sdk-data';
import * as DM from '../../sample-ecommerce';

//...

chart = {
  chartType: 'column' as const,
  dataSet: DM.DataSource,
  dataOptions: {
    category: [DM.Commerce.AgeRange],
    value: [measureFactory.sum(DM.Commerce.Revenue)],
  },
  filters: [filterFactory.lessThan(DM.Commerce.Cost, 1000)],
};
```

```html
<!--Component HTML template in .component.html-->

<csdk-chart
  [chartType]="chart.chartType"
  [dataSet]="chart.dataSet"
  [dataOptions]="chart.dataOptions"
  [filters]="chart.filters"
/>
```

#### Filter components

The `sdk-ui` modules contain UI components for creating user-defined filters. You can use the filters created by these components to filter one of more charts.

Add one or more of these components to create filters that you then use to set the value of a chart's `filter` property.

Use this filtering option when you want to use pre-built components to allow your users to set filters.

For example, the following code snippets filter a chart’s dataset based on the condition dimension.

##### React

<iframe
 src='https://csdk-playground.sisense.com/?example=charts-guide%2Ffilter-component&mode=docs'
 width=800
 height=985
 style='border:none;'
/>

##### Angular

```ts
// Component behavior in .component.ts

import { Filter, filterFactory, measureFactory } from '@sisense/sdk-data';
import * as DM from '../../sample-ecommerce';

//...

DM = DM;

conditionFilter = filterFactory.members(DM.Commerce.Condition, []);

onMembersFilterChange({ filter }: { filter: Filter | null }) {
  if (!filter) return void console.log(filter);
  this.conditionFilter = filter;
}

chart = {
  chartType: 'column' as const,
  dataSet: DM.DataSource,
  dataOptions: {
    category: [DM.Commerce.AgeRange],
    value: [measureFactory.sum(DM.Commerce.Revenue)],
  },
  filters: [this.conditionFilter],
};
```

```html
<!--Component HTML template in .component.html-->

<csdk-chart
  [chartType]="chart.chartType"
  [dataSet]="chart.dataSet"
  [dataOptions]="chart.dataOptions"
  [filters]="[conditionFilter]"
/>
<csdk-member-filter-tile
  title="Condition"
  [dataSource]="DM.DataSource"
  [attribute]="DM.Commerce.Condition"
  [filter]="conditionFilter"
  (filterChange)="onMembersFilterChange($event)"
/>
```

### highlights

Highlights work in a similar fashion to filters. But, whereas filters filter the data to only show the subset of the data that matches the filter, highlights show all the data, but call attention to the data that matches the filter. Not all filters will work as highlights though. The filter dimension must match those defined in the `dataOptions` of the chart (see the [Chart Properties](#chart-properties) section below).

Just like filters, you can create highlights using filtering functions or connect your filtering to filter components.

You can also use filters and highlights together to first filter the data that is displayed in a chart and then highlight some of that data.

#### Filter functions for highlighting

See above to learn about filtering functions. Use the filters returned by those functions to set a chart’s `highlights` property.

For example, the following code snippets highlight certain age ranges in a chart.

##### React

<iframe
 src='https://csdk-playground.sisense.com/?example=charts-guide%2Fhighlight-function&mode=docs'
 width=800
 height=870
 style='border:none;'
/>

##### Angular

```ts
// Component behavior in .component.ts

import { filterFactory, measureFactory } from '@sisense/sdk-data';
import * as DM from '../../sample-ecommerce';

//...

chart = {
  chartType: 'column' as const,
  dataSet: DM.DataSource,
  dataOptions: {
    category: [DM.Commerce.AgeRange],
    value: [measureFactory.sum(DM.Commerce.Revenue)],
  },
  highlights: [
    filterFactory.members(DM.Commerce.AgeRange, ['25-34', '35-44', '45-54']),
  ],
},
```

```html
<!--Component HTML template in .component.html-->

<csdk-chart
  [chartType]="chart.chartType"
  [dataSet]="chart.dataSet"
  [dataOptions]="chart.dataOptions"
  [highlights]="chart.highlights"
/>
```

#### Filter components for highlighting

See above to learn about filter components. Use the filters created by those components to set a chart’s `highlights` property.

For example, the following code snippets highlight a chart’s data based on age range, with some default highlighting already set when the chart is loaded.

##### React

<iframe
 src='https://csdk-playground.sisense.com/?example=charts-guide%2Fhighlight-component&mode=docs'
 width=800
 height=985
 style='border:none;'
/>

##### Angular

```ts
// Component behavior in .component.ts

import { Filter, filterFactory, measureFactory } from '@sisense/sdk-data';
import * as DM from '../../sample-ecommerce';

//...

DM = DM;

ageRangeFilter = filterFactory.members(DM.Commerce.AgeRange, []);

onMembersFilterChange({ filter }: { filter: Filter | null }) {
  if (!filter) return void;
  this.ageRangeFilter = filter;
}

chart = {
  chartType: 'column' as const,
  dataSet: DM.DataSource,
  dataOptions: {
    category: [DM.Commerce.AgeRange],
    value: [measureFactory.sum(DM.Commerce.Revenue)],
  },
  highlights: [this.ageRangeFilter],
};
```

```html
<!--Component HTML template in .component.html-->

<csdk-chart
  [chartType]="chart.chartType"
  [dataSet]="chart.dataSet"
  [dataOptions]="chart.dataOptions"
  [highlights]="[ageRangeFilter]"
/>
<csdk-member-filter-tile
  title="Age Range"
  [dataSource]="DM.DataSource"
  [attribute]="DM.Commerce.AgeRange"
  [filter]="ageRangeFilter"
  (filterChange)="onMembersFilterChange($event)"
/>
```

## Chart Properties

Charts contain the following chart properties for working with the data and style options:

- `dataOptions` - Configuration for querying aggregate data and assigning data to a chart
- `styleOptions` - Configuration options that define the style of chart elements.

### dataOptions

A chart’s data options configure how the data in a chart is aggregated and how the data is applied to a chart.

There are different configurations for different types of charts. Some types of configurations are:

- Cartesian
- Categorical
- Scatter
- Indicator

Let’s take a look at the data options for Cartesian charts. After understanding how those work, you should have no problem using the other types of data options as well.

Cartesian charts can include multiple values on both the X and Y axes, as well as a break-down by categories.
The cartesian data options contain the following properties:

- `category`
- `value`
- `breakBy`
- `seriesToColorMap`

In the examples below, we’ll show the data options that replace the placeholder in the following chart code.

##### React

```ts
import { Chart } from '@sisense/sdk-ui';
import * as DM from '../sample-ecommerce';
import { measureFactory } from '@sisense/sdk-data';

//...

<Chart
  chartType={'bar'}
  dataSet={DM.DataSource}
  dataOptions={{
    /* data options go here */
  }}
/>;
```

##### Angular

```ts
// Component behavior in .component.ts

import { measureFactory } from '@sisense/sdk-data';
import * as DM from '../../sample-ecommerce';

chart = {
    chartType: 'column' as const,
    dataSet: DM.DataSource,
    dataOptions: {
        /* data options go here */
    },
};
```

```html
<!--Component HTML template in .component.html-->

<csdk-chart [chartType]="chart.chartType" [dataSet]="chart.dataSet" [dataOptions]="chart.dataOptions" />
```

#### category and value

The `category` and `value` properties determine how the axes of a chart are set up.

Typically, a `category` is a dimension in your data model. These are entities such as dates, people, or location. This information doesn’t change that often.

Typically, a `value` is a fact in your data model. These contain quantitative and numerical data such as transactions, inventory, or performance data. This information changes often and is generally the data you want to analyze using a chart. Often, you will run some sort of aggregation or other measure function to aggregate, summarize, and accumulate values.

Let’s take a look at some examples of charts using the `category` and `value` properties.

This is the simplest example where we have a single `category` and a single `value`. This chart shows the sum of revenue for a number of age ranges.

##### React

<iframe
 src='https://csdk-playground.sisense.com/?example=charts-guide%2Fone-category-one-value&mode=docs'
 width=800
 height=870
 style='border:none;'
/>

##### Angular

```ts
dataOptions: {
  category: [DM.Commerce.AgeRange],
  value: [measureFactory.sum(DM.Commerce.Revenue, 'Sum of Revenue')],
},
```

---

This example adds an additional `value` to the chart . This chart shows the sum of cost alongside the sum of revenue for a number of age ranges.

##### React

<iframe
 src='https://csdk-playground.sisense.com/?example=charts-guide%2Fone-category-two-values&mode=docs'
 width=800
 height=870
 style='border:none;'
/>

##### Angular

```ts
dataOptions: {
  category: [DM.Commerce.AgeRange],
  value: [
    measureFactory.sum(DM.Commerce.Revenue, 'Sum of Revenue'),
    measureFactory.sum(DM.Commerce.Cost, 'Sum of Cost'),
  ],
},
```

---

This example is similar to the one above in that it uses two `value` measures, but it changes the type of chart used in the second `value` and adds a right-side axis. This chart shows the sum of revenue and quantity for a number of age ranges.

##### React

<iframe
 src='https://csdk-playground.sisense.com/?example=charts-guide/one-category-two-values&mode=docs'
 width=800
 height=870
 style='border:none;'
/>

###### Angular

```ts
dataOptions: {
  category: [DM.Commerce.AgeRange],
  value: [
    measureFactory.sum(DM.Commerce.Revenue, 'Sum of Revenue'),
    {
      column: measureFactory.sum(DM.Commerce.Quantity, 'Sum of Quantity'),
      chartType: 'line',
      showOnRightAxis: true,
    },
  ],
},
```

---

This example adds an additional `category` to a chart instead of an additional `value`. Notice how there are now labels across both the bottom and top of the Y-axis. This chart shows the sum of revenue for a number of condition types and age ranges. In this case it is probably preferable to use a `breakBy` instead of adding a second category, as explained below.

##### React

<iframe
 src='https://csdk-playground.sisense.com/?example=charts-guide/two-categories-one-value&mode=docs'
 width=800
 height=870
 style='border:none;'
/>

##### Angular

```ts
dataOptions: {
  category: [DM.Commerce.AgeRange, DM.Commerce.Condition],
  value: [measureFactory.sum(DM.Commerce.Revenue, 'Sum of Revenue')],
},
```

---

This example has two `category` attributes and two `value` measures. This chart shows the sum of revenue alongside the sum of cost for a number of condition types and age ranges.

##### React

<iframe
 src='https://csdk-playground.sisense.com/?example=charts-guide/two-categories-one-value&mode=docs'
 width=800
 height=870
 style='border:none;'
/>

##### Angular

```ts
dataOptions: {
  category: [DM.Commerce.AgeRange, DM.Commerce.Condition],
  value: [
    measureFactory.sum(DM.Commerce.Revenue, 'Sum of Revenue'),
    measureFactory.sum(DM.Commerce.Cost, 'Sum of Cost'),
  ],
},
```

#### breakBy and seriesToColorMap

The `breakBy` property, optionally determines how categories are broken down into subcategories. You can also use the `seriesToColorMap` property to customize the color of the broken down subcategories.

Let’s take a look at some examples of charts using the `breakBy` and `seriesToColorMap` properties.

This example has a single `category` and a single `value`, but the categories are broken down by an additional attribute. This chart shows the sum of revenue for a number of condition types and age ranges.

##### React

<iframe
 src='https://csdk-playground.sisense.com/?example=charts-guide/break-by&mode=docs'
 width=800
 height=870
 style='border:none;'
/>

##### Angular

```ts
dataOptions: {
  category: [DM.Commerce.AgeRange],
  value: [measureFactory.sum(DM.Commerce.Revenue, 'Sum of Revenue')],
  breakBy: [DM.Commerce.Condition],
},
```

---

This example shows the same data as the previous example, but the subcategories are colored using the colors defined in the series color map.

##### React

<iframe
 src='https://csdk-playground.sisense.com/?example=charts-guide/series-to-color-map&mode=docs'
 width=800
 height=870
 style='border:none;'
/>

##### Angular

```ts
dataOptions: {
  category: [DM.Commerce.AgeRange],
  value: [measureFactory.sum(DM.Commerce.Revenue, 'Sum of Revenue')],
  breakBy: [DM.Commerce.Condition],
  seriesToColorMap: {
    New: '#7CB518',
    Refurbished: '#F3DE2C',
    Used: '#FB6107',
    Unspecified: '#FBB02D',
  },
},
```

### styleOptions

A chart’s style options configure the styling of the chart’s elements.

There are many different types of style configurations. The type of configuration you use for a specific chart depends on the chart type. Each of the configuration types has a different set of properties that are tailored to the types of charts they apply to.

Note that you can achieve additional styling of your charts using the `<ThemeProvider />`.

For example, the following code snippets limit the number of slices in the pie chart and remove some of the labeling using style options.

##### React

<iframe
 src='https://csdk-playground.sisense.com/?example=charts-guide/style-options&mode=docs'
 width=800
 height=1275
 style='border:none;'
/>

##### Angular

```ts
// Component behavior in .component.ts

import { filterFactory, measureFactory } from '@sisense/sdk-data';
import * as DM from '../../sample-ecommerce';

//...

chart = {
  chartType: 'pie' as const,
  dataSet: DM.DataSource,
  dataOptions: {
    category: [DM.Commerce.AgeRange],
    value: [measureFactory.sum(DM.Commerce.Revenue)],
  },
  styleOptions: {
    convolution: {
      enabled: true,
      independentSlicesCount: 4,
      selectedConvolutionType: 'bySlicesCount',
    },
    labels: {
      categories: false,
    },
    width: 550,
    height: 400,
  },
};
```

```html
<!--Component HTML template in .component.html-->

<csdk-chart
  [chartType]="chart.chartType"
  [dataSet]="chart.dataSet"
  [dataOptions]="chart.dataOptions"
  [styleOptions]="chart.styleOptions"
/>
```

## Callbacks

Charts contain callback properties for defining functions that are called when certain events occur. Most charts have the following callback properties:

- `onBeforeRender`
- `onDataPointClick`
- `onDataPointContextMenu`
- `onDataPointsSelected`

These callbacks allow you to perform actions to change a chart’s behavior or to react in some way to events that happen on a chart.

The `onBeforeRender` callback allows you to customize the underlying chart element before it is rendered to your users. The callback receives an object representing the Highcharts options of the underlying chart element. Use the options object to change options values and then return the modified options object. The returned options are then used when rendering your chart.

The `onData*` callbacks allow you to react to user interactions with your chart. The callbacks receive information about the data point the user is interacting with as well as an event object for the native event that occurred. You can use that information to respond to the event in any way you want.

For example, the following code snippets remove the tooltip that shows by default when you hover over data points in the chart and replace it with an element that shows the data point information when the data point is clicked.

##### React

<iframe
 src='https://csdk-playground.sisense.com/?example=charts-guide/callbacks&mode=docs'
 width=800
 height=870
 style='border:none;'
/>

##### Angular

```ts
// Component behavior in .component.ts

import { Component } from '@angular/core';
import { measureFactory } from '@sisense/sdk-data';
import { DataPoint, HighchartsOptions } from '@sisense/sdk-ui';
import * as DM from '../../sample-ecommerce';

type PointInfo = { range: string; value: string } | null;

//...

pointInfo: PointInfo;

chart = {
  chartType: 'column' as const,
  dataSet: DM.DataSource,
  dataOptions: {
    category: [DM.Commerce.AgeRange],
    value: [measureFactory.sum(DM.Commerce.Revenue)],
  },
};

onBeforeRender(options: HighchartsOptions) {
  if (options.tooltip) options.tooltip.enabled = false;
  return options;
}

onDataPointClick(...args: any[]) {
  const clickedPoint: DataPoint = args[0].point;

  this.pointInfo = {
    range: clickedPoint.categoryDisplayValue!,
    value: this.formatNumber(clickedPoint.value),
  };
}
```

```html
<!--Component HTML template in .component.html-->

<div class="pointInfo" *ngIf="pointInfo">Range: {{ pointInfo.range }} | Value {{ pointInfo.value }}</div>
<csdk-chart
  [chartType]="chart.chartType"
  [dataSet]="chart.dataSet"
  [dataOptions]="chart.dataOptions"
  [beforeRender]="onBeforeRender"
  (dataPointClick)="onDataPointClick($event)"
/>
```


---

---
title: External Charts
---

# External Charts

You can use the data you retrieve from your Sisense instance with just about any JavaScript charting library. Use Compose SDK to query your Sisense instance for the data you need for your charts. Then use that data to populate charts from a 3rd party charting library.

In this guide we’ll use [Plotly.js](https://plotly.com/javascript/) charts, but the same principles apply to using any other charting library.

In order to display your Sisense data in a 3rd party chart, you need to:

- Query you Sisense instance for the data you want
- Transform the data you receive from Sisense to the format required by the charting library you’re using
- Apply the formatted data to the 3rd party chart.

Let’s see how you would perform these steps to create this chart that shows the total cost and total revenue for a number of age ranges.

![Plotly chart](../../img/chart-guides/plotly.png 'Plotly chart')

## Query

The first step you need to perform to use Sisense data in a 3rd party chart is to query the data.

There are a number of ways you can do this with Compose SDK. The two main ways are:

- Use `executeQuery()` (as a hook in React or as the `QueryService` method in Angular)
- Use the `<ExecuteQuery />` component (React only)

In this guide, we’ll take the first approach of using `executeQuery()`. So we simply call `executeQuery()` and pass it the information we want to query from our data model.

In this snippet, we’re querying the Sample ECommerce model to get total cost and total revenue categorized by age range.

##### React

<iframe
 src='https://csdk-playground.sisense.com/?example=charts-guide/external-chart&mode=docs'
 width=800
 height=875
 style='border:none;'
/>

##### Angular

```ts
import * as DM from '../../sample-ecommerce';
import { measureFactory } from '@sisense/sdk-data';
import { QueryService } from '@sisense/sdk-ui-angular';

//...

constructor(private queryService: QueryService) {}

async ngOnInit(): Promise<void> {
  const { data } = await this.queryService.executeQuery({
    dataSource: DM.DataSource,
    dimensions: [DM.Commerce.AgeRange],
    measures: [
      measureFactory.sum(DM.Commerce.Cost, 'Total Cost'),
      measureFactory.sum(DM.Commerce.Revenue, 'Total Revenue'),
    ],
  });
  //..
}
```

## Transform

Now that we have the data from Sisense, we need to transform it to the format required by our 3rd party charting library. The code you need to write in this step will differ depending on what charting library you use.

For our Plotly chart, we need to take the data retrieved from Sisense, which is represented as a two-dimensional array of row data, and transpose it to an object containing 3 arrays, one for each column of our data.

We need to take this data from Sisense, organized as a two-dimensional array of row data, where each row is an object containing an age range and the corresponding cost and revenue totals:

```ts
data = [
  [
    { data: '0-18', text: '0-18', blur: false },
    { data: 4319951.642637288, text: '4319951.64263729', blur: false },
    { data: 1527753.0939548016, text: '1527753.0939548', blur: false },
  ],
  [
    { data: '19-24', text: '19-24', blur: false },
    { data: 8656480.951007009, text: '8656480.95100701', blur: false },
    { data: 3859902.864543805, text: '3859902.8645438', blur: false },
  ],
  [
    { data: '25-34', text: '25-34', blur: false },
    { data: 21185350.45013156, text: '21185350.4501316', blur: false },
    { data: 4877853.600113869, text: '4877853.60011387', blur: false },
  ],
  //...
];
```

And turn in into this data, organized as three arrays, one for the age ranges, one for the corresponding total cost values, and one for the corresponding total revenue values:

```ts
x1 = ['0-18', '19-24', '25-34', '35-44', '45-54', '55-64', '65+'];
x2 = [
  4319951.642637288, 8656480.951007009, 21185350.45013156,
  //...
];
x3 = [
  1527753.0939548016, 3859902.864543805, 4877853.600113869,
  //...
];
```

We can do that fairly easily with this code:

```ts
const x1: number[] = [];
const y1: number[] = [];
const y2: number[] = [];

data?.rows.forEach((row) => {
  x1.push(row[0].data);
  y1.push(row[1].data);
  y2.push(row[2].data);
});
```

Next, we need to take that data and create two “traces”, one for the total cost and another for the total revenue.

```ts
const trace1: Plotly.Data = {
  x: x1,
  y: y1,
  type: 'bar',
  name: 'Total Cost',
};

const trace2: Plotly.Data = {
  x: x1,
  y: y2,
  type: 'bar',
  name: 'Total Revenue',
};
```

Then, we can configure the layout of the chart.

```ts
const layout = {
  title: 'Total Cost and Revenue by Age Ranges',
  xaxis: { title: 'Age Range' },
  yaxis: { title: 'Cost and Revenue ($)' },
  width: 900,
  height: 500,
};
```

That concludes our data transformation. We just need to package it up in a variable that we’ll use to set the Plotly chart’s data in the next step.

```ts
const plotData = [trace1, trace2];
```

## Apply

Finally, we can apply our transformed data to our 3rd party chart.

In our case, we simply add a Plotly `<Plot />` component with the data we transformed and the layout configuration we created.

##### React

```ts
//...

import Plot from 'react-plotly.js';

//..

return <Plot data={plotData} layout={layout} />;

//...
```

##### Angular

```ts
// Component behavior in .component.ts

//..

this.graph = {
  data: plotData,
  layout: layout,
};

//...
```

```html
<!--Component HTML template in .component.html-->
<plotly-plot [data]="graph.data" [layout]="graph.layout"></plotly-plot>
```

## Full Code

When we put the steps together, the code for populating our 3rd party chart with data from Sisense looks like this:

##### React

```ts
import { useExecuteQuery } from '@sisense/sdk-ui';
import * as DM from '../sample-ecommerce';
import { measureFactory } from '@sisense/sdk-data';

import Plot from 'react-plotly.js';

function MyPlotlyChart() {
  // Query
  const { data, isLoading, isError } = useExecuteQuery({
    dataSource: DM.DataSource,
    dimensions: [DM.Commerce.AgeRange],
    measures: [measureFactory.sum(DM.Commerce.Cost, 'Total Cost'), measureFactory.sum(DM.Commerce.Revenue, 'Total Revenue')],
  });

  if (isLoading) {
    return <div>Loading...</div>;
  }

  if (isError) {
    return <div>Error</div>;
  }

  // Transform
  const x1: number[] = [];
  const y1: number[] = [];
  const y2: number[] = [];

  data?.rows.forEach((row) => {
    x1.push(row[0].data);
    y1.push(row[1].data);
    y2.push(row[2].data);
  });

  const trace1: Plotly.Data = {
    x: x1,
    y: y1,
    type: 'bar',
    name: 'Total Cost',
  };

  const trace2: Plotly.Data = {
    x: x1,
    y: y2,
    type: 'bar',
    name: 'Total Revenue',
  };

  const layout = {
    title: 'Total Cost and Revenue by Age Ranges',
    xaxis: { title: 'Age Range' },
    yaxis: { title: 'Cost and Revenue ($)' },
    width: 900,
    height: 500,
  };

  const plotData = [trace1, trace2];

  // Apply
  return <Plot data={plotData} layout={layout} />;
}

export default MyPlotlyChart;
```

##### Angular

```ts
import { Component } from '@angular/core';
import * as DM from '../../sample-ecommerce';
import { measureFactory } from '@sisense/sdk-data';
import { QueryService } from '@sisense/sdk-ui-angular';

import { PlotData } from 'plotly.js-dist-min';

@Component({
  selector: 'app-analytics',
  templateUrl: './analytics.component.html',
  styleUrls: ['./analytics.component.css'],
})
export class AnalyticsComponent {
  graph: { data: Partial<PlotData>[]; layout: {} } = { data: [], layout: {} };

  constructor(private queryService: QueryService) {}

  async ngOnInit(): Promise<void> {
    const { data } = await this.queryService.executeQuery({
      dataSource: DM.DataSource,
      dimensions: [DM.Commerce.AgeRange],
      measures: [
        measureFactory.sum(DM.Commerce.Cost, 'Total Cost'),
        measureFactory.sum(DM.Commerce.Revenue, 'Total Revenue'),
      ],
    });

    const x1: number[] = [];
    const y1: number[] = [];
    const y2: number[] = [];

    data?.rows.forEach((row) => {
      x1.push(row[0].data);
      y1.push(row[1].data);
      y2.push(row[2].data);
    });

    const trace1: Plotly.Data = {
      x: x1,
      y: y1,
      type: 'bar',
      name: 'Total Cost',
    };

    const trace2: Plotly.Data = {
      x: x1,
      y: y2,
      type: 'bar',
      name: 'Total Revenue',
    };

    const layout = {
      title: 'Total Cost and Revenue by Age Ranges',
      xaxis: { title: 'Age Range' },
      yaxis: { title: 'Cost and Revenue ($)' },
      width: 900,
      height: 500,
    };

    const plotData = [trace1, trace2];

    this.graph = {
      data: plotData,
      layout: layout,
    };
  }
}
```

## Learn More

To learn more about using 3rd party chats with Compose SDK, including using [Material UI](https://mui.com/x/react-charts/) with React, see [Take control of your data visualizations: Connecting to third-party libraries with Compose SDK](https://www.sisense.com/blog/take-control-of-your-data-visualizations/).


---

---
title: Sisense Fusion Widgets
---

# Sisense Fusion Widgets

Sisense Fusion widgets are charts from dashboard widgets that already exist in your Sisense instance. You can reuse the charts you already have and customize them using Compose SDK.

You display charts from your existing Sisense instance using the `<WidgetById />` component in React/Vue projects or `WidgetByIdComponent` in Angular projects.

Note that you can also get the data from a dashboard widget and use it in a Compose SDK chart using the `useExecuteQueryByWidgetId()` hook in React/Vue projects or the `executeQueryByWidgetId()` query service method in Angular projects.

## WidgetById Properties

Many of the properties of dashboard widget component’s properties are the same as the properties for other Compose SDK charts. To learn more about those properties, see [Compose SDK charts](./guide-compose-sdk-charts.md).

There are also some properties which are specific to `WidgetById` components.

### dashboardOid and widgetOid

In addition to any other chart properties you want to use with a `WidgetById`, you need to specify the `dashboardOid` and `widgetOid`, which identify which widget from your Sisense instance is displayed in the `WidgetById`.

You can get the `dashboardOid` and `widgetOid` from the widget’s embed code in Sisense instance or using the Sisense REST API. You can also use the the `useGetDashboardModel` and `useGetDashboardModels` hooks in React/Vue or the `DashboardService` functions with the same names in Angular, to get `dashboardOid` and `widgetOid` values for a dashboard and its widgets.

For example, the following code snippets get a chart or charts from a Sisense dashboard:

##### React

Hardcoded dashboard and widget IDs

<iframe
 src='https://csdk-playground.sisense.com/?example=charts-guide/widget-component&mode=docs'
 width=800
 height=900
 style='border:none;'
/>

Retrieve widget IDs using hook

<iframe
 src='https://csdk-playground.sisense.com/?example=charts-guide/widget-hook&mode=docs'
 width=800
 height=975
 style='border:none;'
/>

##### Angular

```ts
// Hardcoded dashboard and widget IDs
// Component behavior in .component.ts

chart = {
  dashboardOid: '65536353a90176002a68e5aa',
  widgetOid: '6553637ea90176002a68e5ac',
};
```

```html
<!--Hardcoded dashboard and widget IDs-->
<!--Component HTML template in .component.html-->

<csdk-dashboard-widget [dashboardOid]="chart.dashboardOid" [widgetOid]="chart.widgetOid" />
```

### Widget Properties

Since the WidgetById component includes the widget wrapper over a chart, it has properties for customizing the widget, including:

- `title` - Widget title
- `description` - Widget description
- `styleOptions` - Configuration options that define the style of the widget

#### Additional Properties

In addition to the standard chart properties, widget properties, and properties to identify which widget to display, `WidgetById` also has properties that allow you to define the interplay between the widget as it is set up in your Sisense instance and customizations you apply in code.

These properties include:

- `includeDashboardFilters` - Whether to include dashboard filters and highlights that apply to the original widget in your Sisense instance
- `filtersMergeStrategy` - How to reconcile dashboard filters and highlights that apply to the original widget in your Sisense instance and filters and highlights set in code

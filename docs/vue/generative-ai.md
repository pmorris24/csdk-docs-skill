---
title: AiContextProvider
---

# Class AiContextProvider

A Vue component that wraps all generative AI components and hooks.

## Example

```vue
<script setup lang="ts">
import { SisenseContextProvider } from '@sisense/sdk-ui-vue';
import { AiContextProvider, Chatbot } from '@sisense/sdk-ui-vue/ai';
</script>

<template>
 <SisenseContextProvider v-bind="sisenseContextProps">
   <AiContextProvider>
     <Chatbot />
   </AiContextProvider>
 </SisenseContextProvider>
</template>
```

## Param

[AiContextProviderProps](../interfaces/interface.AiContextProviderProps.md)

## Properties

### volatile

> **`readonly`** **volatile**?: `boolean`

Boolean flag to indicate whether the chat session should be volatile.

When `false` the chat session history will be stored per user per datamodel. The retention period is configurable in Sisense Fusion.

When the `Chatbot` component renders, if a previous chat history exists for the current user and datamodel, it will be restored. The user may continue the conversation or clear the history.

When `true` a new chat session (with no history) will be created each time the `Chatbot` comoponent initializes.


---

---
title: Chatbot
---

# Class Chatbot

An Vue component that renders a chatbot with data topic selection.

## Example

Here's how you can use the Chatbot component in a Vue application:
```vue
<script setup lang="ts">
import { Chatbot, type ChatbotProps } from '@sisense/sdk-ui-vue/ai';

const chatbotProps: ChatbotProps = {
 width: 500,
 height: 700,
 config: {
   numOfRecommendations: 5,
 },
};
</script>

<template>
 <Chatbot
   :width="chatbotProps.width"
   :height="chatbotProps.height"
   :config="chatbotProps.config"
 />
</template>
```

<img src="../../../img/vue-chatbot-example.png" width="500px" />

## Param

[ChatbotProps](../interfaces/interface.ChatbotProps.md)

## Properties

### config

> **`readonly`** **config**?: `Partial`\< [`ChatConfig`](../interfaces/interface.ChatConfig.md) \>

Various configuration options for the chatbot

***

### height

> **`readonly`** **height**?: `Height`\< `number` \| `string` \>

Total height of the chatbot

If not specified, a default height of `900px` will be used.

***

### width

> **`readonly`** **width**?: `Width`\< `number` \| `string` \>

Total width of the chatbot

If not specified, a default width of `500px` will be used.


---

---
title: GetNlgInsights
---

# Class GetNlgInsights

A Vue component that fetches and displays a collapsible analysis of the provided query using natural language generation (NLG).
Specifying a query is similar to providing parameters to a [`useExecuteQuery`](../queries/function.useExecuteQuery.md) composable, using dimensions, measures, and filters.

## Example

Here's how you can use the GetNlgInsights component in a Vue application:
```vue
<script setup lang="ts">
import { GetNlgInsights, type GetNlgInsightsProps } from '@sisense/sdk-ui-vue/ai';
import { measureFactory } from '@sisense/sdk-data';
import * as DM from '../assets/sample-retail-model';

const props: GetNlgInsightsProps = {
 dataSource: DM.DataSource.title,
 dimensions: [DM.DimProducts.CategoryName],
 measures: [measureFactory.sum(DM.DimProducts.Price)],
};
</script>

<template>
 <GetNlgInsights
   :dataSource="props.dataSource"
   :dimensions="props.dimensions"
   :measures="props.measures"
 />
</template>
```
<img src="../../../img/vue-get-nlg-insights-example.png" width="700"/>

## Param

[GetNlgInsightsProps](../interfaces/interface.GetNlgInsightsProps.md)

## Properties

### dataSource

> **`readonly`** **dataSource**: [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md)

The data source that the query targets - e.g. `Sample ECommerce`

***

### dimensions

> **`readonly`** **dimensions**?: [`Attribute`](../../sdk-data/interfaces/interface.Attribute.md)[]

Dimensions of the query

***

### filters

> **`readonly`** **filters**?: [`FilterRelations`](../../sdk-data/interfaces/interface.FilterRelations.md) \| [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Filters of the query

***

### measures

> **`readonly`** **measures**?: [`Measure`](../../sdk-data/interfaces/interface.Measure.md)[]

Measures of the query

***

### verbosity

> **`readonly`** **verbosity**?: `"High"` \| `"Low"`

The verbosity of the NLG summarization


---

---
title: useGetNlgInsights
---

# Function useGetNlgInsights

> **useGetNlgInsights**(`params`): [`UseGetNlgInsightsState`](../interfaces/interface.UseGetNlgInsightsState.md)

A Vue composable that fetches an analysis of the provided query using natural language generation (NLG).
Specifying a query is similar to providing parameters to a [`useExecuteQuery`](../queries/function.useExecuteQuery.md) composable, using dimensions, measures, and filters.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `params` | [`MaybeRefOrWithRefs`](../type-aliases/type-alias.MaybeRefOrWithRefs.md)\< [`UseGetNlgInsightsParams`](../interfaces/interface.UseGetNlgInsightsParams.md) \> | [UseGetNlgInsightsParams](../interfaces/interface.UseGetNlgInsightsParams.md) |

## Returns

[`UseGetNlgInsightsState`](../interfaces/interface.UseGetNlgInsightsState.md)

The composable load state that contains the status of the execution and a text summary result (data)

## Example

```vue
<script setup lang="ts">
import { useGetNlgInsights, type GetNlgInsightsProps } from '@sisense/sdk-ui-vue/ai';
import { measureFactory } from '@sisense/sdk-data';
import * as DM from '../assets/sample-retail-model';

const props: GetNlgInsightsProps = {
 dataSource: DM.DataSource.title,
 dimensions: [DM.DimProducts.CategoryName],
 measures: [measureFactory.sum(DM.DimProducts.Price)],
};
const { data: nlgInsights } = useGetNlgInsights(props);
</script>

<template>
 {{ nlgInsights }}
</template>
```


---

---
title: useGetNlqResult
---

# Function useGetNlqResult <Badge type="beta" text="Beta" />

> **useGetNlqResult**(`params`): [`UseGetNlqResultState`](../interfaces/interface.UseGetNlqResultState.md)

A Vue composable that enables natural language query (NLQ) against a data model or perspective.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `params` | [`MaybeRefOrWithRefs`](../type-aliases/type-alias.MaybeRefOrWithRefs.md)\< [`UseGetNlqResultParams`](../interfaces/interface.UseGetNlqResultParams.md) \> | [UseGetNlqResultParams](../interfaces/interface.UseGetNlqResultParams.md) |

## Returns

[`UseGetNlqResultState`](../interfaces/interface.UseGetNlqResultState.md)

The composable NLQ load state that contains the status of the execution, the result (data) as WidgetProps

## Example

```vue
<script setup lang="ts">
import { ChartWidget } from '@sisense/sdk-ui-vue';
import { useGetNlqResult, type UseGetNlqResultParams } from '@sisense/sdk-ui-vue/ai';

const params: UseGetNlqResultParams = {
 dataSource: 'Sample Retail',
 query: 'Show me the lowest product prices by country'
};
const { data: nlqResult } = useGetNlqResult(params);
</script>

<template>
 <ChartWidget v-bind="nlqResult" />
</template>
```


---

---
title: useGetQueryRecommendations
---

# Function useGetQueryRecommendations <Badge type="beta" text="Beta" />

> **useGetQueryRecommendations**(`params`): [`UseGetQueryRecommendationsState`](../interfaces/interface.UseGetQueryRecommendationsState.md)

A Vue composable that fetches recommended questions for a data model or perspective.

This composable includes the same code that fetches the initial suggested questions in the chatbot.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `params` | [`MaybeRefOrWithRefs`](../type-aliases/type-alias.MaybeRefOrWithRefs.md)\< [`UseGetQueryRecommendationsParams`](../interfaces/interface.UseGetQueryRecommendationsParams.md) \> | [UseGetQueryRecommendationsParams](../interfaces/interface.UseGetQueryRecommendationsParams.md) |

## Returns

[`UseGetQueryRecommendationsState`](../interfaces/interface.UseGetQueryRecommendationsState.md)

The composable load state that contains the status of the execution and recommendations result (data) with recommended question text and its corresponding `widgetProps`

## Example

```vue
<script setup lang="ts">
import {
 useGetQueryRecommendations,
 type UseGetQueryRecommendationsParams,
} from '@sisense/sdk-ui-vue/ai';

const params: UseGetQueryRecommendationsParams = {
 contextTitle: 'Sample Retail',
 count: 3,
};
const { data: recommendations = [] } = useGetQueryRecommendations(params);
</script>

<template>
 <ul>
   <li v-for="r in recommendations" :key="r.nlqPrompt">
     {{ r.nlqPrompt }}
   </li>
 </ul>
</template>
```

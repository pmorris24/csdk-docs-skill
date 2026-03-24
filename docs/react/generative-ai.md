---
title: AiContextProvider
---

# Function AiContextProvider

> **AiContextProvider**(`props`): `Element`

React component that wraps all generative AI components and hooks.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `props` | [`AiContextProviderProps`](../interfaces/interface.AiContextProviderProps.md) | AI Context Provider Props |

## Returns

`Element`

An AI Context Provider Component

## Example

```ts
import { SisenseContextProvider } from '@sisense/sdk-ui';
import { AiContextProvider, Chatbot } from '@sisense/sdk-ui/ai';

function App() {
  return (
    <SisenseContextProvider {...sisenseContextProps}>
      <AiContextProvider>
        <Chatbot />
      </AiContextProvider>
    </SisenseContextProvider>
  );
}
```


---

---
title: Chatbot
---

# Function Chatbot

> **Chatbot**(`props`): `ReactElement`\< `any`, `any` \> \| `null`

React component that displays a chatbot with data topic selection.
You can optionally configure size, config e.g. data topics, recommendations, UI text.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `props` | [`ChatbotProps`](../interfaces/interface.ChatbotProps.md) | [ChatbotProps](../interfaces/interface.ChatbotProps.md) |

## Returns

`ReactElement`\< `any`, `any` \> \| `null`

## Example

```ts
import { SisenseContextProvider } from '@sisense/sdk-ui';
import { AiContextProvider, Chatbot } from '@sisense/sdk-ui/ai';

function App() {
  return (
    <SisenseContextProvider {...sisenseContextProps}>
      <AiContextProvider>
        <Chatbot
           width={1000}
           height={800}
           config={{
              enableFollowupQuestions: true,
              numOfRecommendations: 2,
              dataTopicsList: [
                 'Sample ECommerce',
                  'Sample Healthcare'
              ],
              inputPromptText: 'What do you want to explore?',
              welcomeText: 'Welcome to Acme AI, powered by Sisense',
              suggestionsWelcomeText: 'Would you like to know:',
           }}
        />
      </AiContextProvider>
    </SisenseContextProvider>
  );
}
```


---

---
title: GetNlgInsights
---

# Function GetNlgInsights

> **GetNlgInsights**(`props`): `ReactElement`\< `any`, `any` \> \| `null`

React component that fetches and displays a collapsible analysis of the provided query using natural language generation (NLG).
Specifying a query is similar to providing parameters to a [useExecuteQuery](../queries/function.useExecuteQuery.md) hook, using dimensions, measures, and filters.

## Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `props` | [`GetNlgInsightsProps`](../interfaces/interface.GetNlgInsightsProps.md) | [GetNlgInsightsProps](../interfaces/interface.GetNlgInsightsProps.md) |

## Returns

`ReactElement`\< `any`, `any` \> \| `null`

Collapsible container wrapping a text summary

## Example

```ts
<GetNlgInsights
  dataSource="Sample ECommerce"
  dimensions={[DM.Commerce.Date.Years]}
  measures={[measureFactory.sum(DM.Commerce.Revenue)]}
/>
```


---

---
title: useGetNlgInsights
---

# Function useGetNlgInsights

> **useGetNlgInsights**(...`args`): [`UseGetNlgInsightsState`](../interfaces/interface.UseGetNlgInsightsState.md)

React hook that fetches an analysis of the provided query using natural language generation (NLG).
Specifying a query is similar to providing parameters to a [useExecuteQuery](../queries/function.useExecuteQuery.md) hook, using dimensions, measures, and filters.

## Parameters

| Parameter | Type |
| :------ | :------ |
| ...`args` | [[`UseGetNlgInsightsParams`](../interfaces/interface.UseGetNlgInsightsParams.md)] |

## Returns

[`UseGetNlgInsightsState`](../interfaces/interface.UseGetNlgInsightsState.md)

Response object containing a text summary

## Example

```ts
const { data, isLoading } = useGetNlgInsights({
  dataSource: 'Sample ECommerce',
  dimensions: [DM.Commerce.Date.Years],
  measures: [measureFactory.sum(DM.Commerce.Revenue)],
});

if (isLoading) {
  return <div>Loading...</div>;
}

return <p>{data}</p>;
```


---

---
title: useGetNlqResult
---

# Function useGetNlqResult <Badge type="beta" text="Beta" />

> **useGetNlqResult**(...`args`): [`UseGetNlqResultState`](../interfaces/interface.UseGetNlqResultState.md)

React hook that enables natural language query (NLQ) against a data model or perspective.

## Parameters

| Parameter | Type |
| :------ | :------ |
| ...`args` | [[`UseGetNlqResultParams`](../interfaces/interface.UseGetNlqResultParams.md)] |

## Returns

[`UseGetNlqResultState`](../interfaces/interface.UseGetNlqResultState.md)

NLQ load state that contains the status of the execution, the result (data) as WidgetProps

## Example

```ts
const { data, isLoading } = useGetNlqResult({
   dataSource: 'Sample ECommerce',
   query: 'Show me total revenue by age range'
});

if (isLoading) {
  return <div>Loading...</div>;
}

return (
  {
     data &&
     <Widget {...data} />
  }
);
```


---

---
title: useGetQueryRecommendations
---

# Function useGetQueryRecommendations <Badge type="beta" text="Beta" />

> **useGetQueryRecommendations**(...`args`): [`UseGetQueryRecommendationsState`](../interfaces/interface.UseGetQueryRecommendationsState.md)

React hook that fetches recommended questions for a data model or perspective.

This hook includes the same code that fetches the initial suggested questions in the chatbot.

## Parameters

| Parameter | Type |
| :------ | :------ |
| ...`args` | [[`UseGetQueryRecommendationsParams`](../interfaces/interface.UseGetQueryRecommendationsParams.md)] |

## Returns

[`UseGetQueryRecommendationsState`](../interfaces/interface.UseGetQueryRecommendationsState.md)

An array of objects, each containing recommended question text and its corresponding `widgetProps`

## Example

```ts
const { data, isLoading } = useGetQueryRecommendations({
  contextTitle: 'Sample ECommerce',
});

if (isLoading) {
  return <div>Loading recommendations</div>;
}

return (
  <ul>
    {data.map((item, index) => (
      <li key={index}>{item.nlqPrompt}</li>
    ))}
  </ul>
);
```

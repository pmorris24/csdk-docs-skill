---
title: ChatConfig
---

# Interface ChatConfig

## Properties

### customPrompt

> **customPrompt**?: `string`

Pass a custom prompt to AI when generating query recommendations

e.g. "Focus on age range"

***

### dataTopicsList

> **dataTopicsList**?: `string`[]

List of titles representing allowed contexts (data models or perspectives) for a chat session.

Each context will be validated and checked for availability.
If only one context is specified, the data topic selector screen will not be shown.

***

### enableFollowupQuestions

> **enableFollowupQuestions**: `boolean`

Boolean flag to show or hide suggested questions following a chat response. Currently
follow-up questions are still under development and are not validated. Therefore, follow-up
questions are disabled by default.

***

### hideHistory

> **hideHistory**?: `boolean`

Boolean flag to hide chat history on every load.

Note: When the flag is `true`, chat history will be preserved and stored for the session but will not be displayed. Changing this setting back to `false` will make the entire history visible again, even if it was previously hidden. Use the "Clear History" button to completely erase the history.

#### Default

```ts
false
```

::: warning Deprecated
This flag is deprecated and will be removed in a future version. Use [@sisense/sdk-ui!AiContextProviderProps.volatile](../../sdk-ui/interfaces/interface.AiContextProviderProps.md#volatile) instead.
:::

***

### inputPromptText

> **inputPromptText**?: `string`

The input prompt text to show in the chat input box

***

### numOfRecentPrompts

> **numOfRecentPrompts**: `number`

Number of recent prompts that should be shown in a chat session

If not specified, the default value is `5`

***

### numOfRecommendations

> **numOfRecommendations**: `number`

Number of recommended queries that should initially be shown in a chat session

If not specified, the default value is `4`.

Set to `0` to disable initial recommendations.

***

### suggestionsWelcomeText

> **suggestionsWelcomeText**?: `false` \| `string`

The message text to show above the initial suggested questions in a chat session.

A value of `false` will hide the text.

If not specified, a default message will be displayed.

***

### welcomeText

> **welcomeText**?: `false` \| `string`

The welcome text to show at the top of a chat session.

A value of `false` will hide the welcome text.

If not specified, a default message will be displayed.


---

---
title: ChatbotProps
---

# Interface ChatbotProps

Props of the [ChatbotComponent](../generative-ai/class.ChatbotComponent.md).

## Properties

### config

> **config**?: `Partial`\< [`ChatConfig`](interface.ChatConfig.md) \>

Various configuration options for the chatbot

***

### height

> **height**?: `Height`\< `number` \| `string` \>

Total height of the chatbot

If not specified, a default height of `900px` will be used.

***

### width

> **width**?: `Width`\< `number` \| `string` \>

Total width of the chatbot

If not specified, a default width of `500px` will be used.


---

---
title: GetNlgInsightsParams
---

# Interface GetNlgInsightsParams

## Properties

### dataSource

> **dataSource**: [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md)

The data source that the query targets - e.g. `Sample ECommerce`

***

### dimensions

> **dimensions**?: [`Attribute`](../../sdk-data/interfaces/interface.Attribute.md)[]

Dimensions of the query

***

### filters

> **filters**?: [`FilterRelations`](../../sdk-data/interfaces/interface.FilterRelations.md) \| [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Filters of the query

***

### measures

> **measures**?: [`Measure`](../../sdk-data/interfaces/interface.Measure.md)[]

Measures of the query

***

### verbosity

> **verbosity**?: `"High"` \| `"Low"`

The verbosity of the NLG summarization


---

---
title: GetNlgInsightsProps
---

# Interface GetNlgInsightsProps

Props of the [GetNlgInsightsComponent](../generative-ai/class.GetNlgInsightsComponent.md).

## Properties

### dataSource

> **dataSource**: [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md)

The data source that the query targets - e.g. `Sample ECommerce`

***

### dimensions

> **dimensions**?: [`Attribute`](../../sdk-data/interfaces/interface.Attribute.md)[]

Dimensions of the query

***

### filters

> **filters**?: [`FilterRelations`](../../sdk-data/interfaces/interface.FilterRelations.md) \| [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Filters of the query

***

### measures

> **measures**?: [`Measure`](../../sdk-data/interfaces/interface.Measure.md)[]

Measures of the query

***

### verbosity

> **verbosity**?: `"High"` \| `"Low"`

The verbosity of the NLG summarization


---

---
title: GetNlqResultParams
---

# Interface GetNlqResultParams

## Properties

### chartTypes

> **chartTypes**?: (`"bar"` \| `"column"` \| `"indicator"` \| `"line"` \| `"pie"` \| `"table"`)[]

Possible chart types to be used in NLQ results

***

### dataSource

> **dataSource**: [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md)

Data source for queries to run against

***

### query

> **query**: `string`

Text containing the natural language query

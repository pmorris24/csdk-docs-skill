---
title: AiService
---

# Class AiService

Service for working with Sisense Fusion Generative AI.

## Constructors

### constructor

> **new AiService**(`sisenseContextService`, `aiContextConfig`?): [`AiService`](class.AiService.md)

#### Parameters

| Parameter | Type |
| :------ | :------ |
| `sisenseContextService` | [`SisenseContextService`](../contexts/class.SisenseContextService.md) |
| `aiContextConfig`? | [`AiContextConfig`](../interfaces/interface.AiContextConfig.md) |

#### Returns

[`AiService`](class.AiService.md)

## Methods

### getNlgInsights

> **getNlgInsights**(`params`): `Promise`\< `string` \| `undefined` \>

Fetches an analysis of the provided query using natural language generation (NLG).
Specifying NLG parameters is similar to providing parameters to the [QueryService.executeQuery](../queries/class.QueryService.md#executequery) service method, using dimensions, measures, and filters.

#### Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `params` | [`GetNlgInsightsParams`](../interfaces/interface.GetNlgInsightsParams.md) | Parameters for getting NLG insights |

#### Returns

`Promise`\< `string` \| `undefined` \>

NLG insights text summary

***

### getNlqResult <Badge type="beta" text="Beta" />

> **getNlqResult**(`params`): `Promise`\< [`WidgetProps`](../type-aliases/type-alias.WidgetProps.md) \| `undefined` \>

Executes a natural language query (NLQ) against a data model or perspective

#### Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `params` | [`GetNlqResultParams`](../interfaces/interface.GetNlqResultParams.md) | NLQ query parameters |

#### Returns

`Promise`\< [`WidgetProps`](../type-aliases/type-alias.WidgetProps.md) \| `undefined` \>

The result as WidgetProps

***

### getQueryRecommendations <Badge type="beta" text="Beta" />

> **getQueryRecommendations**(`params`): `Promise`\< [`QueryRecommendation`](../interfaces/interface.QueryRecommendation.md)[] \>

Fetches recommended questions for a data model or perspective.

#### Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `params` | [`GetQueryRecommendationsParams`](../interfaces/interface.GetQueryRecommendationsParams.md) | Parameters for recommendations |

#### Returns

`Promise`\< [`QueryRecommendation`](../interfaces/interface.QueryRecommendation.md)[] \>

An array of objects, each containing recommended question text and its corresponding `widgetProps`


---

---
title: ChatbotComponent
---

# Class ChatbotComponent

An Angular component that renders a chatbot with data topic selection.

## Example

An example of using the `ChatbotComponent`:

```html
<!--Component HTML template in example.component.html-->
<csdk-chatbot
 [width]="chatbot.width"
 [height]="chatbot.height"
 [config]="chatbot.config"
/>
```

```ts
// Component behavior in example.component.ts
import { Component } from '@angular/core';

@Component({
 selector: 'example',
 templateUrl: './example.component.html',
 styleUrls: ['./example.component.scss'],
})
export class ExampleComponent {
 chatbot = {
   width: '500px',
   height: '700px',
   config: {
     numOfRecommendations: 5,
   },
 };
}
```

<img src="../../../img/angular-chatbot-example.png" width="500px" />

## Implements

- `AfterViewInit`
- `OnChanges`
- `OnDestroy`

## Constructors

### constructor

> **new ChatbotComponent**(
  `sisenseContextService`,
  `themeService`,
  `aiService`): [`ChatbotComponent`](class.ChatbotComponent.md)

Constructor for the `ChatbotComponent`.

#### Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `sisenseContextService` | [`SisenseContextService`](../contexts/class.SisenseContextService.md) | Sisense context service |
| `themeService` | [`ThemeService`](../contexts/class.ThemeService.md) | Theme service |
| `aiService` | [`AiService`](class.AiService.md) | AI service |

#### Returns

[`ChatbotComponent`](class.ChatbotComponent.md)

## Properties

### Constructor

#### aiService

> **aiService**: [`AiService`](class.AiService.md)

AI service

***

#### sisenseContextService

> **sisenseContextService**: [`SisenseContextService`](../contexts/class.SisenseContextService.md)

Sisense context service

***

#### themeService

> **themeService**: [`ThemeService`](../contexts/class.ThemeService.md)

Theme service

### Other

#### config

> **config**: `Partial`\< [`ChatConfig`](../interfaces/interface.ChatConfig.md) \> \| `undefined`

Various configuration options for the chatbot

***

#### height

> **height**: `Height`\< `number` \| `string` \> \| `undefined`

Total height of the chatbot

If not specified, a default height of `900px` will be used.

***

#### width

> **width**: `Width`\< `number` \| `string` \> \| `undefined`

Total width of the chatbot

If not specified, a default width of `500px` will be used.


---

---
title: GetNlgInsightsComponent
---

# Class GetNlgInsightsComponent

An Angular component that fetches and displays a collapsible analysis of the provided query using natural language generation (NLG).
Specifying NLG parameters is similar to providing parameters to the [QueryService.executeQuery](../queries/class.QueryService.md#executequery) service method, using dimensions, measures, and filters.

## Example

An example of using the `GetNlgInsightsComponent`:

```html
<!--Component HTML template in example.component.html-->
<csdk-get-nlg-insights
 [dataSource]="nlgParams.dataSource"
 [dimensions]="nlgParams.dimensions"
 [measures]="nlgParams.measures"
/>
```

```ts
// Component behavior in example.component.ts
import { Component } from '@angular/core';
import { measureFactory } from '@sisense/sdk-data';
import * as DM from '../../assets/sample-healthcare-model';

@Component({
 selector: 'example',
 templateUrl: './example.component.html',
 styleUrls: ['./example.component.scss'],
})
export class ExampleComponent {
 nlgParams = {
   dataSource: DM.DataSource.title,
   dimensions: [DM.Divisions.Divison_name],
   measures: [measureFactory.sum(DM.Admissions.Cost_of_admission)],
 };
}
```

<img src="../../../img/angular-get-nlg-insights-example.png" width="700px" />

## Implements

- `AfterViewInit`
- `OnChanges`
- `OnDestroy`

## Constructors

### constructor

> **new GetNlgInsightsComponent**(
  `sisenseContextService`,
  `themeService`,
  `aiService`): [`GetNlgInsightsComponent`](class.GetNlgInsightsComponent.md)

Constructor for the `GetNlgInsightsProps`.

#### Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `sisenseContextService` | [`SisenseContextService`](../contexts/class.SisenseContextService.md) | Sisense context service |
| `themeService` | [`ThemeService`](../contexts/class.ThemeService.md) | Theme service |
| `aiService` | [`AiService`](class.AiService.md) | AI service |

#### Returns

[`GetNlgInsightsComponent`](class.GetNlgInsightsComponent.md)

## Properties

### Constructor

#### aiService

> **aiService**: [`AiService`](class.AiService.md)

AI service

***

#### sisenseContextService

> **sisenseContextService**: [`SisenseContextService`](../contexts/class.SisenseContextService.md)

Sisense context service

***

#### themeService

> **themeService**: [`ThemeService`](../contexts/class.ThemeService.md)

Theme service

### Other

#### dataSource

> **dataSource**: [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md)

The data source that the query targets - e.g. `Sample ECommerce`

***

#### dimensions

> **dimensions**: [`Attribute`](../../sdk-data/interfaces/interface.Attribute.md)[] \| `undefined`

Dimensions of the query

***

#### filters

> **filters**: [`FilterRelations`](../../sdk-data/interfaces/interface.FilterRelations.md) \| [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[] \| `undefined`

Filters of the query

***

#### measures

> **measures**: [`Measure`](../../sdk-data/interfaces/interface.Measure.md)[] \| `undefined`

Measures of the query

***

#### verbosity

> **verbosity**: `"High"` \| `"Low"` \| `undefined`

The verbosity of the NLG summarization


---

---
title: SdkAiModule
---

# Class SdkAiModule

SDK AI Module, which is a container for generative AI components and services.

## Example

Example of importing [SdkAiModule](class.SdkAiModule.md) and injecting [AiContextConfig](../interfaces/interface.AiContextConfig.md) into your application,
along with importing dependency [SdkUiModule](../contexts/class.SdkUiModule.md) and injecting [SisenseContextConfig](../interfaces/interface.SisenseContextConfig.md) to connect to a Sisense instance:

```ts
import { SdkUiModule, SisenseContextConfig } from '@sisense/sdk-ui-angular';
import { SdkAiModule, AI_CONTEXT_CONFIG_TOKEN, AiContextConfig } from '@sisense/sdk-ui-angular/ai';

const AI_CONTEXT_CONFIG: AiContextConfig = {
  volatile: true,
};
const SISENSE_CONTEXT_CONFIG: SisenseContextConfig = {
  url: "<instance url>", // replace with the URL of your Sisense instance
  token: "<api token>", // replace with the API token of your user account
  defaultDataSource: DM.DataSource,
};

@NgModule({
  imports: [
    BrowserModule,
    SdkUiModule,
    SdkAiModule,
  ],
  declarations: [AppComponent],
  providers: [
    { provide: AI_CONTEXT_CONFIG_TOKEN, useValue: AI_CONTEXT_CONFIG },
    { provide: SISENSE_CONTEXT_CONFIG_TOKEN, useValue: SISENSE_CONTEXT_CONFIG },
  ],
  bootstrap: [AppComponent],
})
```

## Constructors

### constructor

> **new SdkAiModule**(): [`SdkAiModule`](class.SdkAiModule.md)

#### Returns

[`SdkAiModule`](class.SdkAiModule.md)


---

---
title: AI_CONTEXT_CONFIG_TOKEN
---

# Variable AI\_CONTEXT\_CONFIG\_TOKEN

> **`const`** **AI\_CONTEXT\_CONFIG\_TOKEN**: `InjectionToken`\< [`AiContextConfig`](../interfaces/interface.AiContextConfig.md) \>

Token used to inject [AiContextConfig](../interfaces/interface.AiContextConfig.md) into your application.

## Example

Example of importing [SdkAiModule](class.SdkAiModule.md) and injecting [AiContextConfig](../interfaces/interface.AiContextConfig.md) into your application,
along with importing dependency [SdkUiModule](../contexts/class.SdkUiModule.md) and injecting [SisenseContextConfig](../interfaces/interface.SisenseContextConfig.md) to connect to a Sisense instance:

```ts
import { SdkUiModule, SisenseContextConfig } from '@sisense/sdk-ui-angular';
import { SdkAiModule, AI_CONTEXT_CONFIG_TOKEN, AiContextConfig } from '@sisense/sdk-ui-angular/ai';

const AI_CONTEXT_CONFIG: AiContextConfig = {
  volatile: true,
};
const SISENSE_CONTEXT_CONFIG: SisenseContextConfig = {
  url: "<instance url>", // replace with the URL of your Sisense instance
  token: "<api token>", // replace with the API token of your user account
  defaultDataSource: DM.DataSource,
};

@NgModule({
  imports: [
    BrowserModule,
    SdkUiModule,
    SdkAiModule,
  ],
  declarations: [AppComponent],
  providers: [
    { provide: AI_CONTEXT_CONFIG_TOKEN, useValue: AI_CONTEXT_CONFIG },
    { provide: SISENSE_CONTEXT_CONFIG_TOKEN, useValue: SISENSE_CONTEXT_CONFIG },
  ],
  bootstrap: [AppComponent],
})
```

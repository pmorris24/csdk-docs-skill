# Sisense Compose SDK - Documentation Knowledge Base

This document contains the complete guides, tutorials, and troubleshooting
documentation for the Sisense Compose SDK (Compose SDK / CSDK).

Packages: @sisense/sdk-ui, @sisense/sdk-data, @sisense/sdk-cli
Frameworks: React, Angular, Vue + TypeScript


================================================================================
# Getting Started

Setup, authentication, quickstart guides for React/Angular/Vue
================================================================================


<!-- Source: getting-started/index.md -->
# Getting Started

Here you'll find guides that will help get started with Compose SDK.

<SectionIndex />


<!-- Source: getting-started/authentication-security.md -->
# Authentication & Security

There are some authentication and security concerns you need to address in order to start using Compose SDK in an application.

## Authentication

To retrieve data using Compose SDK you need to authenticate your application against a Sisense instance.

There are several ways you can authenticate your application:

- [Single Sign On (SSO)](#single-sign-on)
- [Web Access Token (WAT)](#web-access-token)
- [API Token](#api-token)

a Sisense instance.

There are several ways you can authenticate your application:

- [Single Sign On (SSO)](#single-sign-on)
- [Web Access Token (WAT)](#web-access-token)
- [API Token](#api-token)

### Single Sign On

Single Sign On (SSO) allows the users of your application to authenticate with Sisense using an external identity provider.

#### Set up SSO

Set up your Sisense instance to authenticate users with SSO using one of the following:

- [JSON Web Token (JWT)](https://docs.sisense.com/main/SisenseLinux/single-sign-on-using-json-web-token.htm?tocpath=Security%7CImplementing%20Single%20Sign-On%7C_____3)
- [Security Assertion Markup Language 2.0 (SAML)](https://docs.sisense.com/main/SisenseLinux/single-sign-on-using-security-assertion-markup-language-20.htm?tocpath=Security%7CImplementing%20Single%20Sign-On%7C_____2)
- [OpenID Connect](https://docs.sisense.com/main/SisenseLinux/single-sign-on-using-openid-connect.htm?tocpath=Security%7CImplementing%20Single%20Sign-On%7C_____4)

##### Using the SSO Router Addon with JWT
If your Sisense instance is configured to use the [SSO Router addon](https://www.sisense.com/marketplace/add-on/sso-router/) in order to support dynamic routing to various JWT endpoints, please use Compose SDK 2.6.0 or later.

For more information on configuring SSO Router check [this knowledge base article](https://community.sisense.com/kb/add-ons_and_plug-ins/sso-router-plugin-usage-with-examples/4805), or contact Sisense support.

::: tip Note
If you're experiencing difficulties or unexpected behavior when using SSO, the cause may be a hidden feature configuration. To resolve the issue, you can:

- Contact [support](https://www.sisense.com/support/) to validate you Fusion configuration settings
- See this [community post](https://community.sisense.com/discussions/help_and_how_to/issue-with-sisense-compose-sdk-and-sso-authentication/18580/replies/18601#M40) to try to resolve the issue yourself
:::

#### Authenticate with SSO

Once you’ve set up SSO access, you can use it to authenticate within your application:

- For React apps use the `ssoEnabled` property of the `<SisenseContextProvider />` component:

```ts
<SisenseContextProvider
  url="https://sisense-instance-url"
  ssoEnabled=true
>
```

- For Angular apps use the `ssoEnabled` property of the `SisenseContextConfig` object:

```ts
export const SISENSE_CONTEXT_CONFIG: SisenseContextConfig = {
  url="https://sisense-instance-url"
  ssoEnabled=true
};
```

- For Vue apps use the `ssoEnabled` property of the `<SisenseContextProvider />` component:

```ts
<SisenseContextProvider
  :url="https://sisense-instance-url"
  :ssoEnabled="true"
>
```

ue
};
```

- For Vue apps use the `ssoEnabled` property of the `<SisenseContextProvider />` component:

```ts
<SisenseContextProvider
  :url="https://sisense-instance-url"
  :ssoEnabled="true"
>
```

### Web Access Token

Sisense Web Access Tokens (WATs) impersonate specific Sisense users. Typically, in a production environment you create a Sisense user specifically for using Compose SDK. You grant that user the permissions you want to expose in your application and use a WAT that impersonates that user.

::: tip Note
When using a Structured Token (By Value) you can enforce row level security using an `acl` claim. All other claims are not supported.
:::

#### Create a WAT

Before creating a WAT, you need to [create a token configuration](https://docs.sisense.com/main/SisenseLinux/using-web-access-token.htm?tocpath=Security%7CSecuring%20Users%7C_____4#CreatingaTokenConfiguration) to generate a token secret and key ID.

Once you have a token secret and key ID, you can generate a WAT to use in your application in one of the following ways:

- [Go to Web Access Tokens in the Sisense UI](https://docs.sisense.com/main/SisenseLinux/using-web-access-token.htm?tocpath=Security%7CSecuring%20Users%7C_____4#OptionsforCreatingWebAccessTokens)
- Send a request to the [wat/generate](https://developer.sisense.com/guides/restApi/v1/?platform=linux&spec=L2025.2#/web-access-tokens/generateWebAccessToken) endpoint of the Sisense REST API
- [Use self-hosted token generation](https://docs.sisense.com/main/SisenseLinux/using-web-access-token.htm?tocpath=Security%7CSecuring%20Users%7C_____4#OptionsforCreatingWebAccessTokens)

#### Authenticate with a WAT

Once you’ve created a WAT, you can use it to authenticate within your application:

- For React apps use the `wat` property of the `<SisenseContextProvider />` component:

```ts
<SisenseContextProvider
  url="http://sisense-instance-url"
  wat="eykZjkFhMGYzYmJl…"
>
```

- For Angular apps use the `wat` property of the `SisenseContextConfig` object:

```ts
export const SISENSE_CONTEXT_CONFIG: SisenseContextConfig = {
  url="http://sisense-instance-url"
  wat="eykZjkFhMGYzYmJl…"
};
```

- For Vue apps use the `wat` property of the `<SisenseContextProvider />` component:

```ts
<SisenseContextProvider
  :url="http://sisense-instance-url"
  :wat="eykZjkFhMGYzYmJl…"
>
```

Jl…"
};
```

- For Vue apps use the `wat` property of the `<SisenseContextProvider />` component:

```ts
<SisenseContextProvider
  :url="http://sisense-instance-url"
  :wat="eykZjkFhMGYzYmJl…"
>
```

### API Token

Sisense API Tokens are issued per user. Typically, you create a Sisense user specifically for using Compose SDK. You grant that user the permissions you want to expose in your application and use that user's API Token.

:::warning
Be sure to use API tokens in a secure manner. Typically, API tokens are not a good choice for production environments.
:::

#### Create an API Token

You can get an API Token to use in your application in one of the following ways:

- [Go to a user profile in the Sisense UI](https://developer.sisense.com/guides/restApi/using-rest-api.html#getting-the-api-token-from-user-profiles)
- Send a request to the [authentication/login](https://developer.sisense.com/guides/restApi/v1/?platform=linux&spec=L2025.2#/authentication/login) endpoint of the Sisense REST API
- Run the following command using the Compose SDK CLI tool:

```sh
npx @sisense/sdk-cli@latest get-api-token --url <your_instance_url> --username <username>
```

Notes:

- Be sure to replace `<your_instance_url>` with the URL to your Sisense instance and `<username>` with the username of the user you want to create the API token for.
- For Windows, use double quotes around the URL and username arguments. For Mac/Linux, only use double quotes for arguments that contain white space.

#### Authenticate with an API token

Once you’ve obtained an API token, you can use it to authenticate within your application:

- For React apps use the `token` property of the `<SisenseContextProvider />` component:

```ts
<SisenseContextProvider
  url="http://sisense-instance-url"
  token="eRykZjVxkFdhMaGYzYmqJl..."
>
```

- For Angular apps use the `token` property of the `SisenseContextConfig` object:

```ts
export const SISENSE_CONTEXT_CONFIG: SisenseContextConfig = {
  url="http://sisense-instance-url"
  token="eRykZjVxkFdhMaGYzYmqJl..."
};
```

- For Vue apps use the `token` property of the `<SisenseContextProvider />` component:

```ts
<SisenseContextProvider
  :url="http://sisense-instance-url"
  :token="eRykZjVxkFdhMaGYzYmqJl..."
>
```

- For Vue apps use the `token` property of the `<SisenseContextProvider />` component:

```ts
<SisenseContextProvider
  :url="http://sisense-instance-url"
  :token="eRykZjVxkFdhMaGYzYmqJl..."
>
```

## Cross-Origin Resource Sharing (CORS)

By default, browser same-origin policy prevents client-side web applications located in one domain from obtaining data from a different domain. That means an application you build with Compose SDK can't get data from your Sisense instance without some initial setup.

To get around this problem, you enable [CORS](https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS) for specific origins for which you want to allow resource sharing. Doing so instructs the Sisense server to respond to requests from your application with a header that tells the browser your application can use the data returned from Sisense even though it comes from a different domain.

#### Set up CORS

Set up CORS on your Sisense instance using one of the following:

- [Add your application's domain to the **CORS Allowed Origins** in the Sisense UI](https://docs.sisense.com/main/SisenseLinux/cross-origin-resource-sharing.htm?Highlight=cors#EnablingCORS)
- Send a request to the [settings/system](https://developer.sisense.com/guides/restApi/v1/?platform=linux&spec=L2025.2#/settings/setSystemSettings) endpoint of the Sisense REST API and include your application's domain in the `allowedOrigins` array:

```json
"cors": {
  "enabled": true,
  "allowedOrigins": [
    "https://your-application-url"
  ]
}
```

::: tip Notes

- **Do not** include the trailing slash (`/`) when adding a domain to the **CORS Allowed Origins**
- Save your settings changes after adding your domain.

:::

lication-url"
  ]
}
```

::: tip Notes

- **Do not** include the trailing slash (`/`) when adding a domain to the **CORS Allowed Origins**
- Save your settings changes after adding your domain.

:::

## Third-Party Cookies

Most modern browsers block third-party cookies. This affects cookie-based authentications such as SSO.

Therefore, the best practice is either to:

- Use the same domain for the different apps and put it behind a specific path. This prevents Sisense cookies from being third-party cookies. For example: `companyA.com/analytics`.
- Leverage the Web Access Tokens (WAT) feature for authentication. Note that WAT requires special licensing.
- Allow third-party cookies via your browser settings. See this [doc](https://docs.sisense.com/main/SisenseLinux/3rd-party-cookies.htm) for detailed instructions.

:::warning
The Cookies Having Independent Partitioned State ([CHIPS](https://developers.google.com/privacy-sandbox/cookies/chips)) solution is not compatible with Compose SDK.
:::


<!-- Source: getting-started/quickstart.md -->

Independent Partitioned State ([CHIPS](https://developers.google.com/privacy-sandbox/cookies/chips)) solution is not compatible with Compose SDK.
:::


<!-- Source: getting-started/quickstart.md -->
# Compose SDK with React: Quickstart Guide

Follow this guide to get started developing applications with Compose SDK.

> **Note**:
> This guide is for [<img src="../img/react-logo.png" height="18px" style="vertical-align: text-bottom; padding-bottom: 3px" /> React](./quickstart.md). We also have a Quickstart Guide for [<img src="../img/angular-logo.png" height="18px" style="vertical-align: text-bottom; padding-bottom: 2px" /> Angular](./quickstart-angular.md)
> and [<img src="../img/vue-logo.png" height="14px" /> Vue](./quickstart-vue.md).

ogo.png" height="18px" style="vertical-align: text-bottom; padding-bottom: 2px" /> Angular](./quickstart-angular.md)
> and [<img src="../img/vue-logo.png" height="14px" /> Vue](./quickstart-vue.md).

## Prerequisites

Compose SDK contains a set of React components needed to interface with your Sisense instance. The following prerequisites are needed in order to use the SDK:

1. Familiarity with [front-end web development](https://developer.mozilla.org/en-US/docs/Learn/Front-end_web_developer), including Node.js, JavaScript/TypeScript, and React.
2. [Node.js](https://nodejs.org/en) version **16** or higher.
3. [React](https://react.dev) version **17**, **18** or **19**.
4. A Node package manager such as [npm](https://docs.npmjs.com/downloading-and-installing-node-js-and-npm) or [Yarn](https://yarnpkg.com/getting-started/install).
5. Access to a [Sisense](https://sisense.com) instance with a queryable data source (for example, Sample ECommerce).
6. React application **with TypeScript**. You can use your existing application, or if you do not have one, you can follow the [Vite tutorial](https://vitejs.dev/guide/#scaffolding-your-first-vite-project) to create one.

*with TypeScript**. You can use your existing application, or if you do not have one, you can follow the [Vite tutorial](https://vitejs.dev/guide/#scaffolding-your-first-vite-project) to create one.

## Quickstart Application Setup

For this quickstart guide we will use the `Vite` project.

If you want to use your own application, skip to [Installing the SDK packages](#installing-the-sdk-packages).

> **Note:**
>
> When creating your Vite project, select the React framework and TypeScript.

Follow the instructions on the [Scaffolding Your First Vite Project](https://vitejs.dev/guide/#scaffolding-your-first-vite-project) page.

Navigate to your project and install the dependencies.

<div style="display: flex; margin-right: 10px;">
  <div style="flex: 1; overflow-x: auto; max-width: calc(50% - 5px);">

For npm:

```sh
npm install
```

  </div>
  <div style="flex: 1; margin-left: 10px; overflow-x: auto; max-width: calc(50% - 5px);">

For Yarn:

```sh
yarn
```

  </div>
</div>

To run the Vite application, use:

<div style="display: flex; margin-right: 10px;">
  <div style="flex: 1; overflow-x: auto; max-width: calc(50% - 5px);">

For npm:

```sh
npm run dev
```

  </div>
  <div style="flex: 1; margin-left: 10px; overflow-x: auto; max-width: calc(50% - 5px);">

For Yarn:

```sh
yarn dev
```

  </div>
</div>

alc(50% - 5px);">

For npm:

```sh
npm run dev
```

  </div>
  <div style="flex: 1; margin-left: 10px; overflow-x: auto; max-width: calc(50% - 5px);">

For Yarn:

```sh
yarn dev
```

  </div>
</div>

## Installing the SDK Packages

Compose SDK contains three packages for public use:

-   [@sisense/sdk-ui](https://www.npmjs.com/package/@sisense/sdk-ui): React components and hooks for rendering charts and executing queries against a Sisense instance.
-   [@sisense/sdk-data](https://www.npmjs.com/package/@sisense/sdk-data): Implementations of dimensional modeling elements including dimensions, attributes, measures, and filters.
-   [@sisense/sdk-cli](https://www.npmjs.com/package/@sisense/sdk-cli): A command-line tool for generating TypeScript representation of a Sisense data model.

The Compose SDK packages are deployed via public NPM Registry. To install `@sisense/sdk-ui` and `@sisense/sdk-data` for your app:

<div style="display: flex; margin-right: 10px;">
  <div style="flex: 1; overflow-x: auto; max-width: calc(50% - 5px);">

For npm:

```sh
npm i @sisense/sdk-ui @sisense/sdk-data
```

  </div>
  <div style="flex: 1; margin-left: 10px; overflow-x: auto; max-width: calc(50% - 5px);">

For Yarn:

```sh
yarn add @sisense/sdk-ui @sisense/sdk-data
```

  </div>
</div>

Package `@sisense/sdk-cli` is not needed to run your app. It will be installed on the fly as you execute CLI commands using [npx](https://docs.npmjs.com/cli/v10/commands/npx).

```

  </div>
</div>

Package `@sisense/sdk-cli` is not needed to run your app. It will be installed on the fly as you execute CLI commands using [npx](https://docs.npmjs.com/cli/v10/commands/npx).

## Sisense Authentication and Security

In order to retrieve data, you need to authenticate your application with your Sisense instance and set up CORS.

### Authentication

There are a number different ways you can authenticate your application. To learn more, see [Authentication and Security](./authentication-security.md#authentication).

Here, we'll use an API Token that we retrieve using the Compose SDK tool. To do so, run the `get-api-token` command:

```sh
npx @sisense/sdk-cli@latest get-api-token --url <your_instance_url> --username <username>
```

Hold on to the API Token. You'll need it later when adding Compose SDK code to your application.

### CORS Settings

There are also a number of different ways you can set up CORS. To learn more, see [Authentication and Security](./authentication-security.md#cross-origin-resource-sharing-cors).

Here we'll use the Sisense UI. To do so, in your Sisense instance, go to **Admin > Security & Access > Security Settings > General** and add your application's domain to the **CORS Allowed Origins** list.

## Adding Sisense to Your Application

This section describes how to add Compose SDK to your application to render charts from data in your Sisense instance.

n to the **CORS Allowed Origins** list.

## Adding Sisense to Your Application

This section describes how to add Compose SDK to your application to render charts from data in your Sisense instance.

### Generating a Data Model Representation

To visualize data in your application using Compose SDK, first make sure you have a data model in your Sisense instance. Then, create a TypeScript representation of it in your project. This is done using the CLI command which automatically generates it, or you can create it manually using the same syntax.

Once you have a TypeScript representation of your data model, you define measures, dimensions and filters and easily create sophisticated queries. There is no need to specify complex `JOINS` relationships or `GROUP BYS` that you do when using SQL and other query languages because the Sisense semantic query engine will do that for you.

Run the following command to create a `sample-ecommerce.ts` file in directory `src/` of the application. The file contains a TypeScript representation of the Sample ECommerce data model.

```sh
npx @sisense/sdk-cli@latest get-data-model --username "<username>" --output src/sample-ecommerce.ts --dataSource "Sample ECommerce" --url <your_instance_url>
```

Enter your password to complete the command and generate the data model representation.

> **Note:**
> You can use other authentication methods such as WAT (`--wat "<your_token>"`), or API token (`--token "<your_API_token>"`) when generating the data model representation.

The resulting file, which is created in the `src/` directory, should look something like below:

```ts
import type { Dimension, DateDimension, Attribute } from '@sisense/sdk-data';
import { createAttribute, createDateDimension, createDimension } from '@sisense/sdk-data';

export const DataSource = 'Sample ECommerce';

interface BrandDimension extends Dimension {
    Brand: Attribute;
    BrandID: Attribute;
}
export const Brand = createDimension({
    name: 'Brand',
    Brand: createAttribute({
        name: 'Brand',
        type: 'text-attribute',
        expression: '[Brand.Brand]',
    }),
    BrandID: createAttribute({
        name: 'BrandID',
        type: 'numeric-attribute',
        expression: '[Brand.Brand ID]',
    }),
}) as BrandDimension;
```

This works for any data model, including models you create. Just replace `"Sample ECommerce"` with the name of your data model.

expression: '[Brand.Brand ID]',
    }),
}) as BrandDimension;
```

This works for any data model, including models you create. Just replace `"Sample ECommerce"` with the name of your data model.

## Embedding a Chart in your Application

In this section, you will modify the main `app` component to embed a chart visualizing data from the Sample ECommerce data source.

Use the two components, `SisenseContextProvider` and `Chart`, from `@sisense/sdk-ui` along with the `measureFactory` and `filterFactory` utilities from `@sisense/sdk-data`.

> **Note:**
> The following assumptions are made about your application:
>
> -   The `src/App.tsx` file is the main React component.
> -   The `sample-ecommerce.ts` file generated earlier resides in `src/`.
> -   The URL to your application (e.g. http://localhost:5173) is already added as an entry to CORS Allowed Origins section on your Sisense instance. If not, you can do so on your Sisense instance by going to _Admin_, then _Security Settings_.

//localhost:5173) is already added as an entry to CORS Allowed Origins section on your Sisense instance. If not, you can do so on your Sisense instance by going to _Admin_, then _Security Settings_.

### Connecting to a Sisense Instance

The `SisenseContextProvider` component contains all relevant information about the Sisense instance and ensures it is available to all nested Compose SDK components. In other words, this is a wrapper for your application so that all the components are able to access the data. The authentication method used to access your Sisense instance is also defined in this component.

The following examples shows how to add `SisenseContextProvider` to `src/App.tsx`. Make sure that all the other SDK components you want to use are nested inside the `SisenseContextProvider` component.

```ts
// src/App.tsx

import { SisenseContextProvider } from '@sisense/sdk-ui';

function App() {
    return (
        <>
            <SisenseContextProvider
                url="<instance url>" // replace with the URL of your Sisense instance
                token="<api token>" // replace with the API token of your user account
            ></SisenseContextProvider>
        </>
    );
}
export default App;
```

> **Note:**
> The above example uses the API token (also called _bearer authentication_) to connect to a Sisense instance. To generate an API token for your Sisense user account, see the Sisense Instance Authentication section above. The `SisenseContextProvider` also supports other authentication mechanisms including WAT and SSO.

e an API token for your Sisense user account, see the Sisense Instance Authentication section above. The `SisenseContextProvider` also supports other authentication mechanisms including WAT and SSO.

### Adding a chart

To render a chart in your application that queries your data model, use the `Chart` component, the `measureFactory` and `filterFactory` utilities, and your previously generated data model file.

Use the `dataOptions` property (`ChartProps` interface) to assign table columns or attributes from your data model to the categories and values of a chart. This is similar to the **Data** panel in the **Sisense Widget Editor**, where you can drag and drop columns to the **Categories**, **Values**, and **Break By** fields. For example, if you wanted to render a line chart with `Age Range` on the X-axis and a sum aggregation of `Revenue` on the Y-axis, your `dataOptions` object would look like:

```ts
// chartType={'line'}
{
  category: [DM.Commerce.AgeRange],
  value: [measureFactory.sum(DM.Commerce.Revenue)],
  breakBy: [],
}
```

> **Note**
> Use `measureFactory.sum()` from the example above to specify the `sum` type aggregation on the `Revenue` category. This `measureFactory` utility is exported from the `@sisense/sdk-data` library and supports other aggregation types. See the [`measureFactory`](../modules/sdk-data/factories/namespace.measureFactory/index.md) documentation for more information.

The following is a complete example of a rendered chart in an application.

```ts
// src/App.tsx

import { Chart, SisenseContextProvider } from '@sisense/sdk-ui';
import * as DM from './sample-ecommerce';
import { measureFactory } from '@sisense/sdk-data';

function App() {
    return (
        <>
            <SisenseContextProvider
                url="<instance url>" // replace with the URL of your Sisense instance
                token="<api token>" // replace with the API token of your user account
            >
                <Chart
                    dataSet={DM.DataSource}
                    chartType={'line'}
                    dataOptions={{
                        category: [DM.Commerce.AgeRange],
                        value: [measureFactory.sum(DM.Commerce.Revenue)],
                        breakBy: [],
                    }}
                    styleOptions={{
                        legend: {
                            enabled: true,
                            position: 'bottom',
                        },
                    }}
                    onDataPointClick={(point, nativeEvent) => {
                        console.log('clicked', point, nativeEvent);
                    }}
                />
            </SisenseContextProvider>
        </>
    );
}

export default App;
```

Your chart should look like this:

![Line chart rendered by the Chart component](../img/chart-data-source-example-2.png)

See the [SisenseContextProvider](../modules/sdk-ui/contexts/function.SisenseContextProvider.md) and [Chart](../modules/sdk-ui/charts/function.Chart.md) docs for more details on supported props.

ng)

See the [SisenseContextProvider](../modules/sdk-ui/contexts/function.SisenseContextProvider.md) and [Chart](../modules/sdk-ui/charts/function.Chart.md) docs for more details on supported props.

## Next Steps

The sample application in this quickstart guide is designed to give you a basis for what you can do with Compose SDK. Build on the code sample by using other components from Compose SDK to add Sisense analytical experiences to your applications.

For some ideas and examples, check out:

-   [Compose SDK Playground](https://www.sisense.com/developers/playground/)
-   [Demo application for Compose SDK with React](https://csdk-react.sisense.com)
-   [Chart Tutorial](../tutorials/tutorial-charts/index.md)


<!-- Source: getting-started/quickstart-angular.md -->
# Compose SDK with Angular: Quickstart Guide

Follow this guide to get started developing applications with Compose SDK.

> **Note**:
> This guide is for [<img src="../img/angular-logo.png" height="18px" style="vertical-align: text-bottom; padding-bottom: 2px" /> Angular](./quickstart-angular.md). We also have a Quickstart Guide for [<img src="../img/react-logo.png" height="18px" style="vertical-align: text-bottom; padding-bottom: 3px" /> React](./quickstart.md) and [<img src="../img/vue-logo.png" height="14px" /> Vue](./quickstart-vue.md).

/img/react-logo.png" height="18px" style="vertical-align: text-bottom; padding-bottom: 3px" /> React](./quickstart.md) and [<img src="../img/vue-logo.png" height="14px" /> Vue](./quickstart-vue.md).

## Prerequisites

Compose SDK contains a set of components needed to interface with your Sisense instance. The following prerequisites are needed in order to use the SDK:

1. Familiarity with [front-end web development](https://developer.mozilla.org/en-US/docs/Learn/Front-end_web_developer), including Node.js, JavaScript/TypeScript, and Angular.
2. [Node.js](https://nodejs.org/en) version **16.0.0** or higher.
3. [Angular](https://angular.io) version **17** or higher.
4. A Node package manager such as [npm](https://docs.npmjs.com/downloading-and-installing-node-js-and-npm) or [Yarn](https://yarnpkg.com/getting-started/install).
5. Access to a [Sisense](https://sisense.com) instance with a queryable data source (for example, Sample Healthcare).
6. Angular application **with TypeScript**. You can use an existing application, or if you don't have one, you can follow the [tutorial](https://angular.io/start) to create one.

> **Package manager**:
> In Angular `npm` is the default choice and this guide will also adopt `npm`.
>
> You can opt to switch to `Yarn` by following the instructions in a [blog post](https://blog.angular-university.io/getting-started-with-angular-setup-a-development-environment-with-yarn-the-angular-cli-setup-an-ide/) from Angular University.

ng the instructions in a [blog post](https://blog.angular-university.io/getting-started-with-angular-setup-a-development-environment-with-yarn-the-angular-cli-setup-an-ide/) from Angular University.

## Quickstart Application Setup

For this quickstart guide we'll create a new Angular project using [comand line tool](https://angular.io/quick-start#create-a-new-angular-app-from-the-command-line).

If you're using an existing project, skip to [Installing the SDK packages](#installing-the-sdk-packages).

1. Create or navigate to the directory in which you want to create your Angular app.
2. Run this command to create your new Angular app.

```sh
npm init @angular compose-sdk-app
```

3. When prompted, choose to add Angular routing, then press Enter to accept the default option.
   This creates a new Angular app in the `compose-sdk-app` directory.
4. Run this command to navigate to the newly created directory.

```sh
cd compose-sdk-app
```

5. Install the dependencies.

```sh
npm install
```

6. To run the application, use:

```sh
npm start
```

Run this command to navigate to the newly created directory.

```sh
cd compose-sdk-app
```

5. Install the dependencies.

```sh
npm install
```

6. To run the application, use:

```sh
npm start
```

## Installing the SDK Packages

Compose SDK for Angular contains three packages for public use:

-   [@sisense/sdk-ui-angular](https://www.npmjs.com/package/@sisense/sdk-ui-angular): Angular components and services for rendering charts and executing queries against a Sisense instance.
-   [@sisense/sdk-data](https://www.npmjs.com/package/@sisense/sdk-data): Implementations of dimensional modeling elements including dimensions, attributes, measures, and filters.
-   [@sisense/sdk-cli](https://www.npmjs.com/package/@sisense/sdk-cli): A command-line tool for generating a TypeScript representation of a Sisense data model.

The Compose SDK packages are deployed via public NPM Registry. To install `@sisense/sdk-ui-angular` and `@sisense/sdk-data` for your app:

```sh
npm i @sisense/sdk-ui-angular @sisense/sdk-data
```

Package `@sisense/sdk-cli` is not needed to run your app. It will be installed on the fly as you execute CLI commands using [npx](https://docs.npmjs.com/cli/v10/commands/npx).

## Sisense Authentication and Security

In order to retrieve data, you need to authenticate your application with your Sisense instance and set up CORS.

ttps://docs.npmjs.com/cli/v10/commands/npx).

## Sisense Authentication and Security

In order to retrieve data, you need to authenticate your application with your Sisense instance and set up CORS.

### Authentication

There are a number of different ways you can authenticate your application. To learn more, see [Authentication and Security](./authentication-security.md#authentication).

Here, we'll use an API Token that we retrieve using the Compose SDK tool. To do so, run the `get-api-token` command:

```sh
npx @sisense/sdk-cli@latest get-api-token --url <your_instance_url> --username <username>
```

Hold on to the API Token. You'll need it later when adding Compose SDK code to your application.

### CORS Settings

There are also a number of different ways you can set up CORS. To learn more, see [Authentication and Security](./authentication-security.md#cross-origin-resource-sharing-cors).

Here we'll use the Sisense UI. To do so, in your Sisense instance, go to **Admin > Security & Access > Security Settings > General** and add your application's domain to the **CORS Allowed Origins** list.

## Adding Sisense to Your Application

This section describes how to add Compose SDK to your application to render charts from data in your Sisense instance.

n to the **CORS Allowed Origins** list.

## Adding Sisense to Your Application

This section describes how to add Compose SDK to your application to render charts from data in your Sisense instance.

### Generating a Data Model Representation

To visualize data in your application using Compose SDK, first make sure you have a data model in your Sisense instance. Then, create a TypeScript representation of it in your project. This is done using the CLI command which automatically generates it, or you can create it manually using the same syntax.

Once you have a TypeScript representation of your data model, you define measures, dimensions and filters and easily create sophisticated queries. There is no need to specify complex `JOINS` relationships or `GROUP BYS` that you do when using SQL and other query languages because the Sisense semantic query engine will do that for you.

Run the following command to create a `sample-healthcare.ts` file in directory `src/` of the application. The file contains a TypeScript representation of the Sample Healthcare data model.

```sh
npx @sisense/sdk-cli@latest get-data-model --username "<username>" --output src/sample-healthcare.ts --dataSource "Sample Healthcare" --url <your_instance_url>
```

Enter your password to complete the command and generate the data model representation.

> **Note:**
> You can use other authentication methods such as WAT (`--wat "<your_token>"`), or API token (`--token "<your_API_token>"`) when generating the data model representation.

The resulting file, which is created in the `src/` directory, should look something like below:

```ts
import type { Dimension, DateDimension, Attribute } from '@sisense/sdk-data';
import { createAttribute, createDateDimension, createDimension } from '@sisense/sdk-data';

export const DataSource = 'Sample Healthcare';

interface AdmissionsDimension extends Dimension {
  Cost_of_admission: Attribute;
  Death: Attribute;
  Diagnosis_ID: Attribute;
  Doctor_ID: Attribute;
  HAI: Attribute;
  ID: Attribute;
  Patient_ID: Attribute;
  Room_ID: Attribute;
  SSI: Attribute;
  Surgical_Procedure: Attribute;
  TimeofStay: Attribute;
  Admission_Time: DateDimension;
  Discharge_Time: DateDimension;
}
export const Admissions = createDimension({
  name: 'Admissions',
  Cost_of_admission: createAttribute({
    name: 'Cost_of_admission',
    type: 'numeric-attribute',
    expression: '[Admissions.Cost_of_admission]',
  }),
...
```

This works for any data model, including models you create. Just replace `"Sample Healthcare"` with the name of your data model.

te',
    expression: '[Admissions.Cost_of_admission]',
  }),
...
```

This works for any data model, including models you create. Just replace `"Sample Healthcare"` with the name of your data model.

## Embedding a Chart in your Application

In this section, you will add a new component and modify the main app module to embed a chart visualizing data from the Sample Healthcare data source.

> **Note:**
> The following assumptions are made about your application:
>
> -   The `sample-healthcare.ts` file generated earlier resides in `src/`.
> -   The URL to your application (e.g. http://localhost:4200) is already added as an entry to CORS Allowed Origins section on your Sisense instance

are.ts` file generated earlier resides in `src/`.
> -   The URL to your application (e.g. http://localhost:4200) is already added as an entry to CORS Allowed Origins section on your Sisense instance

### Connecting to a Sisense Instance

Add a Sisense provider that contains all relevant information about the Sisense instance and ensures it is available to all Compose SDK components. The authentication method used to access your Sisense instance is defined in this provider.

The following examples shows how to add a provider to `src/app/app.config.ts`.

```typescript
import { ApplicationConfig, provideZoneChangeDetection } from '@angular/core';
import { provideRouter } from '@angular/router';
import { SISENSE_CONTEXT_CONFIG_TOKEN, SisenseContextConfig } from '@sisense/sdk-ui-angular';

import { routes } from './app.routes';

export const SISENSE_CONTEXT_CONFIG: SisenseContextConfig = {
    url: '<instance url>', // replace with the URL of your Sisense instance
    token: '<api token>', // replace with the API token of your user account
};

export const appConfig: ApplicationConfig = {
  providers: [
    { provide: SISENSE_CONTEXT_CONFIG_TOKEN, useValue: SISENSE_CONTEXT_CONFIG },
    provideZoneChangeDetection({ eventCoalescing: true }),
    provideRouter(routes)]
};
```

> **Note:**
> The above example uses the API token (also called _bearer authentication_) to connect to a Sisense instance. To generate an API token for your Sisense user account, see the Sisense Instance Authentication section above. The provider also supports other authentication mechanisms including WAT and SSO.

ance. To generate an API token for your Sisense user account, see the Sisense Instance Authentication section above. The provider also supports other authentication mechanisms including WAT and SSO.

### Adding a component and routing

To render a chart in your application that queries your data model, you need to create a new component that uses the data utilities along with your previously generated data model file.

Here, we'll add a new **Analytics** component with the help of the `ng` CLI tool. You can do it manually. For more information, see the [guide](https://angular.io/guide/component-overview) from Angular.

Run following in your terminal from the project directory:

```sh
npx ng generate component analytics
```

This should result in a new folder with three files inside:

<img src='../img/angular-component-folders.png' height='200px' />

Next, configure the routing and point the main page to the `Analytics` component.

The `app.routes.ts` file should look like this now:

```typescript
import { AnalyticsComponent } from './analytics/analytics.component';
import { Routes } from '@angular/router';

export const routes: Routes = [
    {path: '', component: AnalyticsComponent}
];
```

Replace the contents of the `app.component.html` file with:

```typescript
<router-outlet></router-outlet>
```

export const routes: Routes = [
    {path: '', component: AnalyticsComponent}
];
```

Replace the contents of the `app.component.html` file with:

```typescript
<router-outlet></router-outlet>
```

### Adding a chart

Use the `dataOptions` property (`ChartProps` interface) to assign table columns or attributes from your data model to the categories and values of a chart. This is similar to the **Data** panel in the **Sisense Widget Editor**, where you can drag and drop columns to the **Categories**, **Values**, and **Break By** fields. For example, if you wanted to render a line chart with `Doctors' Specialty` on the X-axis and an average aggregation of `Time of Stay` on the Y-axis, your `dataOptions` object would look like:

```ts
// chartType={'line'}
{
  category: [DM.Doctors.Specialty],
  value: [measureFactory.average(DM.Admissions.TimeofStay)],
  breakBy: [],
}
```

> **Note:**
> Use `measureFactory.average()` from the example above to specify the `average` type aggregation on the `TimeofStay` category. This `measureFactory` utility is exported from the `@sisense/sdk-data` library and supports other aggregation types. See the [`measureFactory`](../modules/sdk-data/factories/namespace.measureFactory/index.md) documentation for more information.

The following is a complete example of a rendered chart in an application.

```ts
// src/app/analytics/analytics.component.ts

import { Component } from '@angular/core';
import { measureFactory } from '@sisense/sdk-data';
import * as DM from '../../sample-healthcare';
import { SdkUiModule } from '@sisense/sdk-ui-angular';

@Component({
  selector: 'app-analytics',
  standalone: true,
  imports: [SdkUiModule],
  templateUrl: './analytics.component.html',
  styleUrl: './analytics.component.scss'
})
export class AnalyticsComponent {
  chart = {
    chartType: 'line' as const,
    dataSet: DM.DataSource,
    dataOptions: {
      category: [DM.Doctors.Specialty],
      value: [measureFactory.average(DM.Admissions.TimeofStay, 'Average time of stay')],
      breakBy: [],
    },
    styleOptions: {
      legend: {
        enabled: true,
        position: 'bottom',
      },
    },
  };

  logArguments(...args: any[]) {
    console.log(args);
  }
}
```

```ts
// src/app/analytics/analytics.component.html

<h3 [align]="'center'">My Sisense Compose SDK Chart</h3>
<csdk-chart
    [chartType]="chart.chartType"
    [dataSet]="chart.dataSet"
    [dataOptions]="chart.dataOptions"
    [styleOptions]="chart.styleOptions"
    (dataPointClick)="logArguments($event)"
  />
```

At this point, check your application in the browser if it's already running or run `npm start` to run your application and view it in a browser.

Your first Compose SDK chart with Angular should look something like this:

![Line chart rendered by the Angular component](../img/angular-quickstart-chart-example.png)

See the [SISENSE_CONTEXT_CONFIG_TOKEN](../modules/sdk-ui-angular/contexts/variable.SISENSE_CONTEXT_CONFIG_TOKEN.md) and [ChartComponent](../modules/sdk-ui-angular/charts/class.ChartComponent.md) docs for more details on supported props.

(../modules/sdk-ui-angular/contexts/variable.SISENSE_CONTEXT_CONFIG_TOKEN.md) and [ChartComponent](../modules/sdk-ui-angular/charts/class.ChartComponent.md) docs for more details on supported props.

## Next Steps

The sample application in this quickstart guide is designed to give you a basis for what you can do with Compose SDK. Build on the code sample by using other components from Compose SDK to add Sisense analytical experiences to your applications.

Check out our demo application for Compose SDK with [Angular](https://csdk-angular.sisense.com).


<!-- Source: getting-started/quickstart-vue.md -->
# Compose SDK with Vue: Quickstart Guide

Follow this guide to get started developing applications with Compose SDK.

> **Note**:
> This guide is for [<img src="../img/vue-logo.png" height="14px" /> Vue](./quickstart-vue.md). We also have a Quickstart Guide for [<img src="../img/react-logo.png" height="18px" style="vertical-align: text-bottom; padding-bottom: 3px" /> React](./quickstart.md) and [<img src="../img/angular-logo.png" height="18px" style="vertical-align: text-bottom; padding-bottom: 2px" /> Angular](./quickstart-angular.md).

; padding-bottom: 3px" /> React](./quickstart.md) and [<img src="../img/angular-logo.png" height="18px" style="vertical-align: text-bottom; padding-bottom: 2px" /> Angular](./quickstart-angular.md).

## Prerequisites

Compose SDK contains a set of components needed to interface with your Sisense instance. The following prerequisites are needed in order to use the SDK:

1. Familiarity with [front-end web development](https://developer.mozilla.org/en-US/docs/Learn/Front-end_web_developer), including Node.js, JavaScript/TypeScript, and Angular.
2. [Node.js](https://nodejs.org/en) version **18.0.0** or higher.
3. [Vue](https://vuejs.org) version **3.3.0** or higher.
4. A Node package manager such as [npm](https://docs.npmjs.com/downloading-and-installing-node-js-and-npm) or [Yarn](https://yarnpkg.com/getting-started/install).
5. Access to a [Sisense](https://sisense.com) instance with a queryable data source (for example, Sample Retail).
6. Vue application **with TypeScript**. You can use an existing application, or if you don't have one, you can follow the [tutorial](https://vuejs.org/guide/quick-start) to create one.

mple Retail).
6. Vue application **with TypeScript**. You can use an existing application, or if you don't have one, you can follow the [tutorial](https://vuejs.org/guide/quick-start) to create one.

## Quickstart Application Setup

For this quickstart guide we'll create a new Vue project using [comand line tool](https://vuejs.org/guide/quick-start#creating-a-vue-application).

If you're using an existing project, skip to [Installing the SDK packages](#installing-the-sdk-packages).

1. Create or navigate to the directory in which you want to create your Vue app.

2. Run this command to create your new Vue app.

<div style="display: flex; margin-right: 10px;">
  <div style="flex: 1; overflow-x: auto; max-width: calc(50% - 5px);">

For npm:

```sh
npm create vue@latest
```

  </div>
  <div style="flex: 1; margin-left: 10px; overflow-x: auto; max-width: calc(50% - 5px);">

For Yarn:

```sh
yarn create vue@latest
```

  </div>
</div>

3. When prompted, choose to add Typescript, JSX support and Vue routing.

<img src="../img/vue-create-new-project.png" height="200px"/>

This creates a new Vue app in the `compose-sdk-app` directory.

4. Run this command to navigate to the newly created directory.

```sh
cd compose-sdk-app
```

5. Install the dependencies.

<div style="display: flex; margin-right: 10px;">
  <div style="flex: 1; overflow-x: auto; max-width: calc(50% - 5px);">

For npm:

```sh
npm install
```

  </div>
  <div style="flex: 1; margin-left: 10px; overflow-x: auto; max-width: calc(50% - 5px);">

For Yarn:

```sh
yarn
```

  </div>
</div>

6. To run the application, use:

<div style="display: flex; margin-right: 10px;">
  <div style="flex: 1; overflow-x: auto; max-width: calc(50% - 5px);">

For npm:

```sh
npm run dev
```

  </div>
  <div style="flex: 1; margin-left: 10px; overflow-x: auto; max-width: calc(50% - 5px);">

For Yarn:

```sh
yarn dev
```

  </div>
</div>

alc(50% - 5px);">

For npm:

```sh
npm run dev
```

  </div>
  <div style="flex: 1; margin-left: 10px; overflow-x: auto; max-width: calc(50% - 5px);">

For Yarn:

```sh
yarn dev
```

  </div>
</div>

## Installing the SDK Packages

Compose SDK for Vue contains three packages for public use:

-   [@sisense/sdk-ui-vue](https://www.npmjs.com/package/@sisense/sdk-ui-vue): Vue components and hooks for rendering charts and executing queries against a Sisense instance.
-   [@sisense/sdk-data](https://www.npmjs.com/package/@sisense/sdk-data): Implementations of dimensional modeling elements including dimensions, attributes, measures, and filters.
-   [@sisense/sdk-cli](https://www.npmjs.com/package/@sisense/sdk-cli): A command-line tool for generating a TypeScript representation of a Sisense data model.

The Compose SDK packages are deployed via public NPM Registry. To install `@sisense/sdk-ui-vue` and `@sisense/sdk-data` for your app:

<div style="display: flex; margin-right: 10px;">
  <div style="flex: 1; overflow-x: auto; max-width: calc(50% - 5px);">

For npm:

```sh
npm i @sisense/sdk-ui-vue @sisense/sdk-data
```

  </div>
  <div style="flex: 1; margin-left: 10px; overflow-x: auto; max-width: calc(50% - 5px);">

For Yarn:

```sh
yarn add @sisense/sdk-ui-vue @sisense/sdk-data
```

  </div>
</div>

Package `@sisense/sdk-cli` is not needed to run your app. It will be installed on the fly as you execute CLI commands using [npx](https://docs.npmjs.com/cli/v10/commands/npx).

```

  </div>
</div>

Package `@sisense/sdk-cli` is not needed to run your app. It will be installed on the fly as you execute CLI commands using [npx](https://docs.npmjs.com/cli/v10/commands/npx).

## Sisense Authentication and Security

In order to retrieve data, you need to authenticate your application with your Sisense instance and set up CORS.

### Authentication

There are a number of different ways you can authenticate your application. To learn more, see [Authentication and Security](./authentication-security.md#authentication).

Here, we'll use an API Token that we retrieve using the Compose SDK tool. To do so, run the `get-api-token` command:

```sh
npx @sisense/sdk-cli@latest get-api-token --url <your_instance_url> --username <username>
```

Hold on to the API Token. You'll need it later when adding Compose SDK code to your application.

### CORS Settings

There are also a number of different ways you can set up CORS. To learn more, see [Authentication and Security](./authentication-security.md#cross-origin-resource-sharing-cors).

Here we'll use the Sisense UI. To do so, in your Sisense instance, go to **Admin > Security & Access > Security Settings > General** and add your application's domain to the **CORS Allowed Origins** list.

## Adding Sisense to Your Application

This section describes how to add Compose SDK to your application to render charts from data in your Sisense instance.

n to the **CORS Allowed Origins** list.

## Adding Sisense to Your Application

This section describes how to add Compose SDK to your application to render charts from data in your Sisense instance.

### Generating a Data Model Representation

To visualize data in your application using Compose SDK, first make sure you have a data model in your Sisense instance. Then, create a TypeScript representation of it in your project. This is done using the CLI command which automatically generates it, or you can create it manually using the same syntax.

Once you have a TypeScript representation of your data model, you define measures, dimensions and filters and easily create sophisticated queries. There is no need to specify complex `JOINS` relationships or `GROUP BYS` that you do when using SQL and other query languages because the Sisense semantic query engine will do that for you.

Run the following command to create a `sample-retail.ts` file in directory `src/` of the application. The file contains a TypeScript representation of the Sample Retail data model.

```sh
npx @sisense/sdk-cli@latest get-data-model --username "<username>" --output src/sample-retail.ts --dataSource "Sample Retail" --url <your_instance_url>
```

Enter your password to complete the command and generate the data model representation.

> **Note:**
> You can use other authentication methods such as WAT (`--wat "<your_token>"`), or API token (`--token "<your_API_token>"`) when generating the data model representation.

The resulting file, which is created in the `src/` directory, should look something like below:

```ts
import type { Dimension, DateDimension, Attribute } from '@sisense/sdk-data';
import { createAttribute, createDateDimension, createDimension } from '@sisense/sdk-data';

export const DataSource = 'Sample Retail';

interface DimCountriesDimension extends Dimension {
  CountryName: Attribute;
  Region: Attribute;
}
export const DimCountries = createDimension({
  name: 'DimCountries',
  CountryName: createAttribute({
    name: 'CountryName',
    type: 'text-attribute',
    expression: '[DimCountries.CountryName]',
  }),
  Region: createAttribute({
    name: 'Region',
    type: 'text-attribute',
    expression: '[DimCountries.Region]',
  }),
}) as DimCountriesDimension;
...
```

This works for any data model, including models you create. Just replace `"Sample Retail"` with the name of your data model.

ion: '[DimCountries.Region]',
  }),
}) as DimCountriesDimension;
...
```

This works for any data model, including models you create. Just replace `"Sample Retail"` with the name of your data model.

## Embedding a Chart in your Application

In this section, you will add a new component and modify the main app to embed a chart visualizing data from the Sample Retail data source.

> **Note:**
> The following assumptions are made about your application:
>
> -   The `src/App.vue` file is the main Vue component.
> -   The `sample-retail.ts` file generated earlier resides in `src/`.
> -   The URL to your application (e.g. http://localhost:5173) is already added as an entry to CORS Allowed Origins section on your Sisense instance

ail.ts` file generated earlier resides in `src/`.
> -   The URL to your application (e.g. http://localhost:5173) is already added as an entry to CORS Allowed Origins section on your Sisense instance

### Connecting to a Sisense Instance

The `SisenseContextProvider` component contains all relevant information about the Sisense instance and ensures it is available to all nested Compose SDK components. In other words, this is a wrapper for your application so that all the components are able to access the data. The authentication method used to access your Sisense instance is also defined in this component.

The following examples shows how to add `SisenseContextProvider` to `src/App.vue`. Make sure that all the other SDK components you want to use are nested inside the `SisenseContextProvider` component.

```ts
// src/App.vue

<script setup lang="ts">
import { SisenseContextProvider } from '@sisense/sdk-ui-vue';
</script>

<template>
  <SisenseContextProvider
    url="<instance url>"
    token="<api token>"
  >
  </SisenseContextProvider>
</template>
```

> **Note:**
> The above example uses the API token (also called _bearer authentication_) to connect to a Sisense instance. To generate an API token for your Sisense user account, see the Sisense Instance Authentication section above. The `SisenseContextProvider` also supports other authentication mechanisms including WAT and SSO.

e an API token for your Sisense user account, see the Sisense Instance Authentication section above. The `SisenseContextProvider` also supports other authentication mechanisms including WAT and SSO.

### Adding a chart

To render a chart in your application that queries your data model, use the `Chart` component, the `measureFactory` and `filterFactory` utilities, and your previously generated data model file.

Use the `dataOptions` property (`ChartProps` interface) to assign table columns or attributes from your data model to the categories and values of a chart. This is similar to the **Data** panel in the **Sisense Widget Editor**, where you can drag and drop columns to the **Categories**, **Values**, and **Break By** fields. For example, if you wanted to render a column chart with `Category Name` on the X-axis and an average aggregation of `Unit Price Discount` on the Y-axis, your `dataOptions` object would look like:

```ts
// chartType={'column'}
{
    category: [DM.DimProducts.CategoryName],
    value: [measureFactory.average(DM.Fact_Sale_orders.UnitPriceDiscount)],
    breakBy: [],
  }
```

> **Note:**
> Use `measureFactory.average()` from the example above to specify the `average` type aggregation on the `UnitPriceDiscount` category. This `measureFactory` utility is exported from the `@sisense/sdk-data` library and supports other aggregation types. See the [`measureFactory`](../modules/sdk-data/factories/namespace.measureFactory/index.md) documentation for more information.

The following is a complete example of a rendered chart in an application.

```ts
// src/App.vue

<script setup lang="ts">
import { SisenseContextProvider } from '@sisense/sdk-ui-vue';
import { Chart } from '@sisense/sdk-ui-vue';
import { measureFactory } from '@sisense/sdk-data';

import * as DM from './sample-retail';
</script>

<template>
  <SisenseContextProvider
    url="<instance url>"
    token="<api token>"
  >
    <Chart
      chartType="column"
      :dataSet="DM.DataSource"
      :dataOptions="{
        category: [DM.DimProducts.CategoryName],
        value: [measureFactory.average(DM.Fact_Sale_orders.UnitPriceDiscount, 'Average Discount')],
      }"
    />
  </SisenseContextProvider>
</template>
```

At this point, check your application in the browser if it's already running or run your application as described in [Quickstart Application Setup](#quickstart-application-setup).

Your first Compose SDK chart with Vue should look something like this:

![Line chart rendered by the Vue component](../img/vue-quickstart-chart-example.png)

See the [SisenseContextProvider](../modules/sdk-ui-vue/contexts/class.SisenseContextProvider.md) and [Chart](../modules/sdk-ui-vue/charts/class.Chart.md) docs for more details on supported props.

)

See the [SisenseContextProvider](../modules/sdk-ui-vue/contexts/class.SisenseContextProvider.md) and [Chart](../modules/sdk-ui-vue/charts/class.Chart.md) docs for more details on supported props.

## Next Steps

The sample application in this quickstart guide is designed to give you a basis for what you can do with Compose SDK. Build on the code sample by using other components from Compose SDK to add Sisense analytical experiences to your applications.


================================================================================
# Guides

In-depth guides for charts, dashboards, drilldown, styling, AI features, etc.
================================================================================


<!-- Source: guides/index.md -->
# Guides

Here you'll find guides that will help you learn and work with Compose SDK.

<SectionIndex />


<!-- Source: guides/cli.md -->
# CLI

Use the Compose SDK CLI to work with your Compose SDK project.

The CLI has the following commands:

- [`get-data-model`](#get-data-model): Creates a [TypeScript representation of a data model](./data-model.md)
- [`get-api-token`](#get-api-token): Gets an [API token for authentication](../getting-started/authentication-security.md#api-token)

## get-data-model

The `get-data-model` command creates a [TypeScript representation of a data model](./data-model.md). Use either a username/password, API token, or WAT token to authenticate when running this command.

he `get-data-model` command creates a [TypeScript representation of a data model](./data-model.md). Use either a username/password, API token, or WAT token to authenticate when running this command.

### Options

- `dataSource` - (`string`): The name of the data model to create a TypeScript representation of
- `output` - (`string` | `undefined`): The `*.ts` file to write the data model file to
- `password` - (`string` | `undefined`): Password when using username/password authentication (if omitted when using a username/password to authenticate, the CLI will prompt you to enter your password)
- `token` - (`string` | `undefined`): API token when using API token authentication
- `url` - (`string`): URL of the Sisense instance that contains your data model
- `username` - (`string` | `undefined`): Username when using username/password authentication
- `wat` -  (`string` | `undefined`): WAT token when using WAT authentication

### Example

This example command creates a data model file for the Sample ECommerce data model using username/password authentication. After running this command, the CLI will prompt you for your password. (Be sure to replace `<username>` and `<your_instance_url>` with your actual username and Sisense instance URL).

```sh
npx @sisense/sdk-cli@latest get-data-model --dataSource "Sample ECommerce" --url <your_instance_url> --output src/sample-ecommerce.ts --username <username>
```

name and Sisense instance URL).

```sh
npx @sisense/sdk-cli@latest get-data-model --dataSource "Sample ECommerce" --url <your_instance_url> --output src/sample-ecommerce.ts --username <username>
```

## get-api-token

The `get-api-token` command gets an [API token for authentication](../getting-started/authentication-security.md#api-token). Use a username/password to authenticate when running this command.

### Options

- `password` - (`string` | `undefined`): Password for authentication (if omitted, the CLI will prompt you to enter your password)
- `url` - (`string`): URL of the Sisense instance that your user exists in
- `username` - (`string`): Username for authentication

### Example

This example gets an API Token using username/password authentication. After running this command, the CLI will prompt you for your password. (Be sure to replace `<username>` and `<your_instance_url>` with your actual username and Sisense instance URL).

```sh
npx @sisense/sdk-cli@latest get-api-token --username <username> --url <your_instance_url>
```



<!-- Source: guides/client-query-caching.md -->
# Client Query Caching (Alpha)

Compose SDK provides a client-side caching mechanism that enhances chart rendering performance and reduces network requests for data queries.

If the results of an identical query already exist in the client-side cache, those results will be used automatically instead of making the same query request again to the Fusion API.

data queries.

If the results of an identical query already exist in the client-side cache, those results will be used automatically instead of making the same query request again to the Fusion API.

## Enabling Client Caching

To enable client-side caching, set the `AppConfig.queryCacheConfig.enabled` property to `true` in your `SisenseContextProvider`.

```tsx
<SisenseContextProvider
  appConfig={{
    queryCacheConfig: {
      enabled: true,
    },
  }}
>
```

This setting enables the caching mechanism globally for all JAQL queries made through the SDK.
The cache can store up to 250 distinct JAQL queries. Once this limit is reached, the oldest entries are purged to make room for new ones.
You can manually clear the cache by obtaining a `CacheClient` instance and calling its `clear` method, which removes all cached queries:

```tsx
const cacheClient = useQueryCache();
cacheClient.clear();
```

**Note:** While `queryCacheConfig` is supported in all frameworks (React, Angular, Vue), the ability to clear the cache via `code` is currently only supported in React. This current limitation is the reason the feature is currently in `alpha` status.

Refreshing the page in the browser also refreshes the cache (see below).

de` is currently only supported in React. This current limitation is the reason the feature is currently in `alpha` status.

Refreshing the page in the browser also refreshes the cache (see below).


## Query Caching Clarifications

This client-side caching mechanism is distinct from Sisense Fusion's server-side caching.
- It does not influence how JAQL requests are handled by Fusion
- It does not affect the server side caching within Fusion
- It cannot affect the response times for any JAQL requests sent to Fusion

Instead, it stores the results of JAQL queries in memory for quicker access without repeated server requests from the browser.

- It does not store data permanently. Reloading the page will clear the cache.
- It does not share cache across different browser tabs, or between different users.
- It is designed to improve performance and user experience for data that is accessed frequently or multiple times in the UI.

**Example:** A user frequently switches between tabs or sections of a UI which contain Compose SDK dashboards, widgets or other components that query data. Client-side caching will help avoid reloading the same data over the network each time a dashboard or widget is rendered, providing a more responsive user experience.



<!-- Source: guides/data-model.md -->

ide caching will help avoid reloading the same data over the network each time a dashboard or widget is rendered, providing a more responsive user experience.



<!-- Source: guides/data-model.md -->
# Data Model

When using Compose SDK with data from a Sisense instance, you can use a TypeScript representation of your data model to easily reference the entities in your model. Although it’s not strictly necessary to use a TypeScript data model representation, using one will save you time and help minimize errors in your code.

TypeScript representations of Sisense data models are built using functionality provided in the `sdk-data` module of Compose SDK.

Typically, these data model representations are built using the Compose SDK CLI tool. The CLI tool reads a specified data model from your Sisense instance and uses the functionality of the `sdk-data` module to build your data model using TypeScript. The end result is a TypeScript file that exports your data model’s structure. You can then import the data model from that file and use it in your code.

Theoretically, you can manually create a TypeScript representation of a Sisense data model using the functions exposed in `sdk-data`, but the need to do so is exceptionally rare. You may, however, want to edit the generated model to add sort on an attribute for example.

Sisense data model using the functions exposed in `sdk-data`, but the need to do so is exceptionally rare. You may, however, want to edit the generated model to add sort on an attribute for example.

## Generating a Data Model

To generate a TypeScript representation of a Sisense data model use the Compose SDK CLI tool’s `get-data-model` command.

The command takes the following parameters:

+ `--output`: Relative path in which to create the data model TypeScript file
+ `--dataSource`: Name of the data model in the Sisense instance
+ `--url`: URL of the Sisense instance
+ `--username`: (Optional) A username in the Sisense instance
+ `--wat`: (Optional) Web access token to use for authentication
+ `--token`: (Optional) An API token to use for authentication

For example, you can create a TypeScript representation of the Sample ECommerce data model like this:

```sh
npx @sisense/sdk-cli@latest get-data-model --username <username> --output src/sample-ecommerce.ts --dataSource "Sample ECommerce" --url https://myinstanceurl.com
```

If prompted, enter your password to authenticate and generate the data model representation.

me> --output src/sample-ecommerce.ts --dataSource "Sample ECommerce" --url https://myinstanceurl.com
```

If prompted, enter your password to authenticate and generate the data model representation.

## Data Model Contents

A TypeScript representation of a Sisense data model includes a data source name, type information and information about the dimensions and attributes of your data model.

Each table in your data model is represented by an exported dimension, which itself is made up of multiple attributes, representing the fields in the table.

For example, consider the Sample Ecommerce data model:

![Ecommerce data model](../img/data-model/ecommerce-model.png "Ecommerce data model")

This model generates the following TypeScript representation. Note that the `Brand` dimension represents the Brand table and the `Brand` and `BrandID` attributes represent fields in the Brand table with those names. Each attribute is created using `name`, `type`, and `expression` values.

```ts
import {
  Dimension,
  DateDimension,
  Attribute,
  createAttribute,
  createDateDimension,
  createDimension,
} from '@sisense/sdk-data';

export const DataSource = 'Sample ECommerce';

interface BrandDimension extends Dimension {
  Brand: Attribute;
  BrandID: Attribute;
}
export const Brand = createDimension({
  name: 'Brand',
  Brand: createAttribute({
    name: 'Brand',
    type: 'text-attribute',
    expression: '[Brand.Brand]',
  }),
  BrandID: createAttribute({
    name: 'BrandID',
    type: 'numeric-attribute',
    expression: '[Brand.Brand ID]',
  }),
}) as BrandDimension;

// Additional interface definitions and dimensions with attributes
// for the Category, Commerce, and Country tables
```

-attribute',
    expression: '[Brand.Brand ID]',
  }),
}) as BrandDimension;

// Additional interface definitions and dimensions with attributes
// for the Category, Commerce, and Country tables
```

## Using a Data Model

Once you’ve created a TypeScript data model representation, you can import and use it in code that refers to that data model. You can use it when creating visualizations, such as charts and tables, or when performing queries.

For example here is a chart that uses an imported data model representation to define its `dataset` and `dataOptions`.

```ts
import * as DM from '../sample-ecommerce';
import { measureFactory } from '@sisense/sdk-data';

//...

<Chart
  chartType={'column'}
  dataSet={DM.DataSource}
  dataOptions={{
    category: [DM.Commerce.AgeRange],
    value: [measureFactory.sum(DM.Commerce.Revenue)],
  }}
  styleOptions={{ width: 800, height: 400 }}
/>
```

And here is an example of performing a query using a data model representation, including sorting one of the attributes:

```ts
import * as DM from '../sample-ecommerce';
import { Sort, measureFactory } from '@sisense/sdk-data';

//...

const { data, isLoading, isError } = useExecuteQuery({
  dataSource: DM.DataSource,
  dimensions: [DM.Commerce.AgeRange.sort(Sort.Descending)],
  measures: [measureFactory.sum(DM.Commerce.Revenue)],
});
```


<!-- Source: guides/formatting.md -->

Query({
  dataSource: DM.DataSource,
  dimensions: [DM.Commerce.AgeRange.sort(Sort.Descending)],
  measures: [measureFactory.sum(DM.Commerce.Revenue)],
});
```


<!-- Source: guides/formatting.md -->
# Number & Date Formatting

This guide demonstrates how to customize the formatting of numbers and dates in your [Compose SDK charts](./charts/guide-compose-sdk-charts.md).

## Number Formatting

You can format numbers in your chart using the `numberFormatConfig` property of `StyledColumn` or `StyledMeasureColumn` objects.

There are 3 main ways to format numbers. Specify the type of formatting using the `name` property with one of the following values:

- `'Numbers'`: Format as regular numbers that are not currency or percentages
- `'Currency'`: Format as currency
- `'Percent'`: Format as a percentage

For each of these format types, you can customize the formatting using the following properties:

- `thousandsSeparator` (boolean): Whether to show a thousands separator. Defaults to `true`.
- `decimalScale` (number): Number of decimal places to show.

Depending on which type of formatting you use, you can also customize the formatting using the properties described below.

ts to `true`.
- `decimalScale` (number): Number of decimal places to show.

Depending on which type of formatting you use, you can also customize the formatting using the properties described below.

### Numbers

Use the following properties to customize the formatting of regular numbers:

- `trillion` (boolean): Whether to abbreviate numbers greater than or equal one trillion. Defaults to `true`.
- `billion` (boolean): Whether to abbreviate numbers greater than or equal one billion. Defaults to `true`.
- `million` (boolean): Whether to abbreviate numbers greater than or equal one million. Defaults to `true`.
- `kilo` (boolean): Whether to abbreviate numbers greater than or equal one thousand. Defaults to `true`.

#### Numbers Example

![Chart with Numbers formatting](../img/chart-guides/formatting-numbers.png 'Chart with Numbers formatting')

```tsx
<Chart
  chartType={'column'}
  dataSet={DM.DataSource}
  dataOptions={{
    category: [DM.Commerce.AgeRange],
    value: [
      {
        column: measureFactory.sum(DM.Commerce.Revenue),
        numberFormatConfig: {
          name: 'Numbers',
          million: false,
          decimalScale: 2,
        },
      },
    ],
  }}
/>
```

column: measureFactory.sum(DM.Commerce.Revenue),
        numberFormatConfig: {
          name: 'Numbers',
          million: false,
          decimalScale: 2,
        },
      },
    ],
  }}
/>
```

### Currency

Use the following properties to customize the formatting of numbers representing currency:

- `prefix` (boolean): Whether to show the `symbol` before the number (`true`) or after the number (`false`). Defaults to `true`.
- `symbol` (string): Symbol to show before or after the number, depending on the `prefix` value. Defaults to `'$'`.
- `trillion` (boolean): Whether to abbreviate numbers greater than or equal one trillion. Defaults to `true`.
- `billion` (boolean): Whether to abbreviate numbers greater than or equal one billion. Defaults to `true`.
- `million` (boolean): Whether to abbreviate numbers greater than or equal one million. Defaults to `true`.
- `kilo` (boolean): Whether to abbreviate numbers greater than or equal one thousand. Defaults to `true`.

#### Currency Example

![Chart with currency formatting](../img/chart-guides/formatting-currency.png 'Chart with currency formatting')

```tsx
<Chart
  chartType={'column'}
  dataSet={DM.DataSource}
  dataOptions={{
    category: [DM.Commerce.AgeRange],
    value: [
      {
        column: measureFactory.sum(DM.Commerce.Revenue),
        numberFormatConfig: {
          name: 'Currency',
          million: false,
          kilo: false,
          prefix: false,
          symbol: '¥',
        },
      },
    ],
  }}
/>
```

ue),
        numberFormatConfig: {
          name: 'Currency',
          million: false,
          kilo: false,
          prefix: false,
          symbol: '¥',
        },
      },
    ],
  }}
/>
```

### Percent

The percent type doesn't have any additional properties for further customization.

#### Percent Example

![Chart with percent formatting](../img/chart-guides/formatting-percent.png 'Chart with percent formatting')

```tsx
<Chart
  chartType={'column'}
  dataSet={DM.DataSource}
  dataOptions={{
    category: [DM.Commerce.AgeRange],
    value: [
      {
        column: measureFactory.divide(
          measureFactory.sum(DM.Commerce.Revenue),
          measureFactory.sum(DM.Commerce.Cost)
        ),
        numberFormatConfig: {
          name: 'Percent',
        },
      },
    ],
  }}
/>
```

## Date Formatting

You can format dates in your chart categories using the `dateFormat` property of a `StyledColumn` or `StyledMeasureColumn` object. Provide the function with a format string using a [ECMAScript Date Time String Format](https://tc39.es/ecma262/multipage/numbers-and-dates.html#sec-date-time-string-format) string.

reColumn` object. Provide the function with a format string using a [ECMAScript Date Time String Format](https://tc39.es/ecma262/multipage/numbers-and-dates.html#sec-date-time-string-format) string.

### Date Example

![Chart with date formatting](../img/chart-guides/formatting-dates.png 'Chart with date formatting')

```tsx
<Chart
  chartType={'column'}
  dataSet={DM.DataSource}
  dataOptions={{
    category: [{column: DM.Commerce.Date.Quarters, dateFormat: 'qqq - yyyy'}],
    value: [
      {
        column: measureFactory.sum(DM.Commerce.Revenue),
      },
    ],
  }}
/>
```


<!-- Source: guides/internationalization.md -->
# Internationalization with Compose SDK
The Compose SDK utilizes the [i18next](https://www.i18next.com/) internationalization framework, making it straightforward to load your own translations.

## Changing the language
To facilitate language changes, the `AppConfig` of `SisenseContextProvider` includes a `translationConfig` property where you can easily set your desired language. For example, to set the language to **French**, use the following code:
```
<SisenseContextProvider appConfig={{ translationConfig: { language: 'fr-FR' }}}>
```
## Loading Additional Translations
By default, the Compose SDK offers a limited number of translation resources. You can utilize `translationConfig` to load additional translation resources into the internationalization framework.

ns
By default, the Compose SDK offers a limited number of translation resources. You can utilize `translationConfig` to load additional translation resources into the internationalization framework.

### Pre-built translation submodules (`@sisense/sdk-ui/translations/*`)
The `@sisense/sdk-ui` package exposes pre-built translation bundles as subpath exports. Each submodule exports an array of translation objects (language, namespace, resources) ready to use in `customTranslations`.

| Submodule | Code | Language |
|-----------|------|----------|
| `@sisense/sdk-ui/translations/en-us` | `en-US` | English (US) |
| `@sisense/sdk-ui/translations/de-de` | `de-DE` | German |
| `@sisense/sdk-ui/translations/es-ar` | `es-AR` | Spanish (Argentina) |
| `@sisense/sdk-ui/translations/es-es` | `es-ES` | Spanish (Spain) |
| `@sisense/sdk-ui/translations/fr-fr` | `fr-FR` | French |
| `@sisense/sdk-ui/translations/it-it` | `it-IT` | Italian |
| `@sisense/sdk-ui/translations/ja-jp` | `ja-JP` | Japanese |
| `@sisense/sdk-ui/translations/ko-kr` | `ko-KR` | Korean |
| `@sisense/sdk-ui/translations/nl-nl` | `nl-NL` | Dutch |
| `@sisense/sdk-ui/translations/pt-br` | `pt-BR` | Portuguese (Brazil) |
| `@sisense/sdk-ui/translations/ru-ru` | `ru-RU` | Russian |
| `@sisense/sdk-ui/translations/tr-tr` | `tr-TR` | Turkish |
| `@sisense/sdk-ui/translations/zh-cn` | `zh-CN` | Chinese (Simplified) |

**Example: using a pre-built translation**

```tsx
import { SisenseContextProvider } from '@sisense/sdk-ui';
import sdkUiFrench from '@sisense/sdk-ui/translations/fr-fr';

<SisenseContextProvider
  appConfig={{
    translationConfig: {
      language: 'fr-FR',
      customTranslations: [sdkUiFrench],
    },
  }}
>
  {/* Your app */}
</SisenseContextProvider>
```

**Example: combining pre-built translations with custom overrides**

```tsx
import { SisenseContextProvider, TranslationDictionary } from '@sisense/sdk-ui';
import sdkUiGerman from '@sisense/sdk-ui/translations/de-de';

const myOverrides: Partial<TranslationDictionary> = {
  chartNoData: 'Keine Daten in dieser Ansicht',
};

<SisenseContextProvider
  appConfig={{
    translationConfig: {
      language: 'de-DE',
      customTranslations: [
        sdkUiGerman,
        {
          language: 'de-DE',
          namespace: 'sdkUi',
          resources: myOverrides,
        },
      ],
    },
  }}
>
  {/* Your app */}
</SisenseContextProvider>
```

Later bundles for the same language and namespace extend or override earlier ones, so custom keys will take precedence when registered after the pre-built bundle.

*/}
</SisenseContextProvider>
```

Later bundles for the same language and namespace extend or override earlier ones, so custom keys will take precedence when registered after the pre-built bundle.

### Preparing Translation Resources
A translation resource consists of translation keys paired with their corresponding string values. This resource is typically structured as a nested object, making it easier to manage different translations. You can register multiple languages by creating separate translation resources for each language and then adding them to your configuration.

**IMPORTANT:** Do not translate parts within double curly brackets (i.e., `{{chartType}}`), as these are placeholders for dynamic values that will be matched using the provided variable names.

#### TranslationDictionary type
Each package with translations provides a `TranslationDictionary` type listing all keys used within that package. Use this type to ensure your custom translation includes all relevant keys.

**Example: complete translation for the `sdk-ui` package**
```
import { TranslationDictionary } from '@sisense/sdk-ui';

const customTranslationResources: TranslationDictionary = {
  ...
};
```

Note that specifying all translation keys is not required; any keys you do not provide will default to English. Using the `TranslationDictionary` type as a Partial can help prevent typos in your custom translation.

#### Example: Translation Resources
Let’s create translation resources for some fields in `sdk-ui` in **French**, and one error message in `sdk-data` in **Spanish**:
```
import { TranslationDictionary } from '@sisense/sdk-ui';

const frenchTranslationResources: Partial<TranslationDictionary> = {
  errors: {
    invalidFilterType: 'Type de filtre invalide',
  },
  chartNoData: 'Aucun résultat'
};
```
```
import { TranslationDictionary } from '@sisense/sdk-data';

const spanishTranslationResources: Partial<TranslationDictionary> = {
  errors: {
    measure: {
      unsupportedType: 'Tipo de medida no compatible',
    },
  },
};
```

As these files may grow larger, consider storing translations in separate files and loading them as needed. JSON format is a suitable option for nested objects like these.

ible',
    },
  },
};
```

As these files may grow larger, consider storing translations in separate files and loading them as needed. JSON format is a suitable option for nested objects like these.

###  Configuring Custom Translations
Similar to how we set the language, we can now provide additional translation resources through the `translationConfig`

Below is an example of loading both translations while setting the default language to **French**:
```
import { translationNamespace as sdkDataNamespace } from '@sisense/sdk-data';

<SisenseContextProvider
  appConfig={{
    translationConfig: {
      language: 'fr-FR',
      customTranslations: [{
        language: 'fr-FR',
        resources: frenchTranslationResources,
      },
      {
        language: 'es-ES',
        namespace: sdkDataNamespace, // 'sdkData'
        resources: spanishTranslationResources,
      }]
    }
  }}
 >
```
Note that we specified the namespace for **Spanish**, as this translation is meant to be loaded for the `sdk-data` package.

Translation namespace values can be found in `translationNamespace` constant exported from every package that has translations.
If `namespace` is not specified, the translation resource will be registered for `sdkUi` namespace that corresponds to the `sdk-ui` package.

nstant exported from every package that has translations.
If `namespace` is not specified, the translation resource will be registered for `sdkUi` namespace that corresponds to the `sdk-ui` package.

## Advanced Configuration
For more advanced internationalization configurations, the `i18n` instance is accessible through the [`useTranslation` hook](https://react.i18next.com/latest/usetranslation-hook) from the `react-i18next` package.

**Note:** The `i18n` instance is initialized within the `SisenseContextProvider`. Therefore, it is important to use the `useTranslation` hook either within the `SisenseContextProvider` or in its child components. Attempting to access `i18n` outside of this context will not yield the instance utilized by the Compose SDK.

#### Example: Checking Loaded Resources
To verify if the **French** resource bundle is loaded for the `sdk-ui` package, you can use the following code:
```
import { useTranslation } from 'react-i18next';
import { useEffect } from 'react';

const MyComponent = () => {
  const { i18n } = useTranslation();

  useEffect(() => {
	const frenchTranslationResourse = i18n.getResourceBundle('fr-FR', 'sdkUi');
	console.log(`Loaded French translation ${JSON.stringify(frenchTranslationResourse)}`)
  }, [i18n]);

  return <></>;
}
```

For further details, please refer to the [i18next API documentation](https://www.i18next.com/overview/api).


<!-- Source: guides/jest-compatibility.md -->
# Setting Up Jest for Compatibility with Compose SDK

r details, please refer to the [i18next API documentation](https://www.i18next.com/overview/api).


<!-- Source: guides/jest-compatibility.md -->
# Setting Up Jest for Compatibility with Compose SDK

## Overview

The Compose SDK packages are built with ECMAScript Modules (ESM), while Jest, by default, expects CommonJS (CJS) modules. This difference creates compatibility challenges when using Jest for testing with Compose SDK. You can learn more about the differences between ESM and CJS in the [Node.js official documentation](https://nodejs.org/api/esm.html#esm_differences_between_es_modules_and_commonjs). While Jest does provide [experimental ESM support](https://jestjs.io/docs/ecmascript-modules), it remains unstable and not recommended for production use.

## Including CommonJS packages

Starting with version 1.22.0, Compose SDK packages include a CommonJS build alongside the ESM build. This allows you to configure Jest to use the CJS version of Compose SDK in tests, while the main application can continue using the ESM version.

### File Structure for CJS in Compose SDK

-   *Primary Package* (`sdk-ui`): Includes `.cjs` files alongside `.js` files within the `dist` folder.
-   *Other Packages* (`sdk-common`, `sdk-data`, `sdk-modeling`, `sdk-query-client`, `sdk-rest-client`, `sdk-tracking`): Contain a `cjs` folder within the `dist` directory, which houses the CJS build files.

her Packages* (`sdk-common`, `sdk-data`, `sdk-modeling`, `sdk-query-client`, `sdk-rest-client`, `sdk-tracking`): Contain a `cjs` folder within the `dist` directory, which houses the CJS build files.

## Configuring Jest to Use CJS Packages
To direct Jest to the appropriate CJS files, you’ll use the [`moduleNameMapper`](https://jestjs.io/docs/tutorial-react-native#modulenamemapper) configuration in your Jest config. This maps the ESM package paths to the CJS equivalents.

**Note**: Compose SDK uses the ESM version of [lodash](https://lodash.com/), so it’s also necessary to map lodash explicitly to its CJS version.

Here are suggested configurations for common frameworks:

te**: Compose SDK uses the ESM version of [lodash](https://lodash.com/), so it’s also necessary to map lodash explicitly to its CJS version.

Here are suggested configurations for common frameworks:

### Jest `moduleNameMapper` Configuration

**React**
```
"moduleNameMapper": {
  "^@sisense/sdk-(common|data|modeling|query-client|rest-client|tracking)(.*)$": "<rootDir>/node_modules/@sisense/sdk-$1/dist/cjs$2",
  "^@sisense/sdk-ui(.*)$": "<rootDir>/node_modules/@sisense/sdk-ui/dist$1",
  "^lodash-es(.*)$": "<rootDir>/node_modules/lodash$1"
}
```
**Angular**
```
"moduleNameMapper": {
  "^@sisense/sdk-(common|data|modeling|query-client|rest-client|tracking)(.*)$": "<rootDir>/node_modules/@sisense/sdk-$1/dist/cjs$2",
  "^@sisense/sdk-ui-angular(.*)$": "<rootDir>/node_modules/@sisense/sdk-ui-angular/dist/fesm2020/sisense-sdk-ui-angular.mjs",
  "^lodash-es(.*)$": "<rootDir>/node_modules/lodash$1"
}
```
**Vue**:
```
"moduleNameMapper": {
  "^@sisense/sdk-(common|data|modeling|query-client|rest-client|tracking)(.*)$": "<rootDir>/node_modules/@sisense/sdk-$1/dist/cjs$2",
  "^@sisense/sdk-ui-vue(.*)$": "<rootDir>/node_modules/@sisense/sdk-ui-vue/dist$1",
  "^lodash-es(.*)$": "<rootDir>/node_modules/lodash$1"
}
```

: "<rootDir>/node_modules/@sisense/sdk-$1/dist/cjs$2",
  "^@sisense/sdk-ui-vue(.*)$": "<rootDir>/node_modules/@sisense/sdk-ui-vue/dist$1",
  "^lodash-es(.*)$": "<rootDir>/node_modules/lodash$1"
}
```
## Conclusion

By mapping the necessary Compose SDK packages to their CJS builds, Jest can effectively work with Compose SDK. This setup ensures that testing compatibility is maintained without impacting the main application’s use of ESM.


<!-- Source: guides/migration-guide-1.0.0.md -->
# Migrating Compose SDK from 0.x.x to 1.0.0

Released in December 2023, Compose SDK (C-SDK) major version `1.0.0` introduces a number of breaking changes.
If your application is still using C-SDK version less than `1.0.0`, follow this guide to migrate.

>**Note**:
>This guide is for <img src="./../img/react-logo.png" height="18px" style="vertical-align: text-bottom; padding-bottom: 3px" /> React.
>As of December 2023, C-SDK for other frameworks including Angular and Vue are still under internal testing.

ogo.png" height="18px" style="vertical-align: text-bottom; padding-bottom: 3px" /> React.
>As of December 2023, C-SDK for other frameworks including Angular and Vue are still under internal testing.

## Renamed

(1) For chart components in `@sisense/sdk-ui`,
   type alias `StyleOptions` has been renamed to `ChartStyleOptions`.
   If your app uses this type alias explicitly, do a simple search and replace in the code.

(2) For indicator chart in `@sisense/sdk-ui`,
    interface `IndicatorDataOptions` has been renamed to `IndicatorChartDataOptions`.
    If your app uses this interface explicitly, do a simple search and replace in the code.

(3) In `@sisense/sdk-data`, namespaces `measures` and `filters` have been renamed to
    `measureFactory` and `filterFactory`, respectively.
    Here is a code example to demonstrate the usage of `measureFactory` and `filterFactory`

BEFORE

```
  import { filters, measures } from '@sisense/sdk-data';
  import * as DM from './sample-ecommerce';
  const { data, isLoading, isError } = useExecuteQuery({
    dataSource: DM.DataSource,
    dimensions: [DM.Commerce.AgeRange],
    measures: [measures.sum(DM.Commerce.Revenue)],
    filters: [filters.greaterThan(DM.Commerce.Revenue, 1000)],
  });
  if (isLoading) {
    return <div>Loading...</div>;
  }
  if (isError) {
    return <div>Error</div>;
  }
  if (data) {
    return <div>{`Total Rows: ${data.rows.length}`}</div>;
  }
  return null;
```

AFTER
```
  import { filterFactory, measureFactory } from '@sisense/sdk-data';
  import * as DM from './sample-ecommerce';
  const { data, isLoading, isError } = useExecuteQuery({
    dataSource: DM.DataSource,
    dimensions: [DM.Commerce.AgeRange],
    measures: [measureFactory.sum(DM.Commerce.Revenue)],
    filters: [filterFactory.greaterThan(DM.Commerce.Revenue, 1000)],
  });
  if (isLoading) {
    return <div>Loading...</div>;
  }
  if (isError) {
    return <div>Error</div>;
  }
  if (data) {
    return <div>{`Total Rows: ${data.rows.length}`}</div>;
  }
  return null;
```

(isLoading) {
    return <div>Loading...</div>;
  }
  if (isError) {
    return <div>Error</div>;
  }
  if (data) {
    return <div>{`Total Rows: ${data.rows.length}`}</div>;
  }
  return null;
```

## Removed

(1) Parameter `widgetStyleOptions` has been removed from `ChartWidgetProps`, `TableWidgetProps`, and `DashboardWidgetProps`.
    Its options are now merged into the `styleOptions` prop to streamline the above mentioned props.
    This means that only `styleOptions` is needed to customize the look and feel of `*Chart`, `ChartWidget`, and `DashboardWidget` components.

Here is an example of `ChartWidget` with both `widgetStyleOptions` and `styleOptions` defined before and after the change:

Notice that `widgetStyleOptions` has been merged to `styleOptions`.

BEFORE
```
<ChartWidget
  title={'REVENUE vs.UNITS SOLD'}
  dataSource={DM.DataSource}
  chartType={'line'}
  dataOptions={{
    category: [
      {
        column: DM.Commerce.Date.Months,
        dateFormat: 'yy-MM',
      },
    ],
    value: [
      DM.Measures.SumRevenue,
      {
        column: DM.Measures.Quantity,
        showOnRightAxis: true,
        chartType: 'column',
      },
    ],
    breakBy: [],
  }}
  styleOptions={{
    subtype: 'line/spline',
    lineWidth: { width: 'bold' },
    yAxis: {
      title: { enabled: true, text: 'SALES' },
    },
    y2Axis: {
      title: { enabled: true, text: 'QUANTITY' },
    },
    markers: {
      enabled: true,
      fill: 'hollow',
    },
  }}
  widgetStyleOptions={{
    border: true,
    borderColor: 'lightgray',
    header: {
      dividerLine: true,
      dividerLineColor: 'lightgray',
    }
  }}
/>
```

AFTER

```
<ChartWidget
  title={'REVENUE vs.UNITS SOLD'}
  dataSource={DM.DataSource}
  chartType={'line'}
  dataOptions={{
    category: [
      {
        column: DM.Commerce.Date.Months,
        dateFormat: 'yy-MM',
      },
    ],
    value: [
      DM.Measures.SumRevenue,
      {
        column: DM.Measures.Quantity,
        showOnRightAxis: true,
        chartType: 'column',
      },
    ],
    breakBy: [],
  }}
  styleOptions={{
    subtype: 'line/spline',
    lineWidth: { width: 'bold' },
    yAxis: {
      title: { enabled: true, text: 'SALES' },
    },
    y2Axis: {
      title: { enabled: true, text: 'QUANTITY' },
    },
    markers: {
      enabled: true,
      fill: 'hollow',
    },
    border: true,
    borderColor: 'lightgray',
    header: {
      dividerLine: true,
      dividerLineColor: 'lightgray',
    },
  }}
/>
```

rs: {
      enabled: true,
      fill: 'hollow',
    },
    border: true,
    borderColor: 'lightgray',
    header: {
      dividerLine: true,
      dividerLineColor: 'lightgray',
    },
  }}
/>
```

## Updated

(1) The return value of the `ExecuteQuery` component is now consistent with that of the `useExecuteQuery` hook.
    Specifically, `ExecuteQuery` returns `QueryState` instead of just `data`.

Here is a code example to demonstrate the usage of `ExecuteQuery` before and after the change:


BEFORE
```tsx
<ExecuteQuery
  dataSource={DM.DataSource}
  dimensions={[DM.Commerce.AgeRange]}
  measures={[measures.sum(DM.Commerce.Revenue)]}
  filters={[filters.greaterThan(DM.Commerce.Revenue, 1000)]}
>
  {
    (data) => {
      if (data) {
        console.log(data);
        return <div>{`Total Rows: ${data.rows.length}`}</div>;
      }
    }
  }
</ExecuteQuery>
```

AFTER
```tsx
<ExecuteQuery
  dataSource={DM.DataSource}
  dimensions={[DM.Commerce.AgeRange]}
  measures={[measureFactory.sum(DM.Commerce.Revenue)]}
  filters={[filterFactory.greaterThan(DM.Commerce.Revenue, 1000)]}
>
  {
    ( { data, isLoading, isError } ) => {
      if (isLoading) {
        return <div>Loading...</div>;
      }
      if (isError) {
        return <div>Error</div>;
      }
      if (data) {
        return <div>{`Total Rows: ${data.rows.length}`}</div>;
      }
      return null;
    }
  }
</ExecuteQuery>
```

(2) Similarly, the return value of the `ExecuteQueryByWidgetId` component is now consistent with that of the `useExecuteQueryByWidgetId` hook.
    Specifically, `ExecuteQueryByWidgetId` returns `QueryByWidgetIdState` instead of just `data` and `query`.

Here is a code example to demonstrate the usage of `ExecuteQueryByWidgetId` before and after the change:


BEFORE

```tsx
 <ExecuteQueryByWidgetId
   widgetOid={'64473e07dac1920034bce77f'}
   dashboardOid={'6441e728dac1920034bce737'}
 >
 {
   (data, query) => {
     if (data) {
       return <div>{`Total Rows: ${data.rows.length}`}</div>;
     }
   }
 }
 </ExecuteQueryByWidgetId>
 ```

AFTER

 ```tsx
<ExecuteQueryByWidgetId
  widgetOid={'64473e07dac1920034bce77f'}
  dashboardOid={'6441e728dac1920034bce737'}
>
{
  ({data, isLoading, isError}) => {
    if (isLoading) {
      return <div>Loading...</div>;
    }
    if (isError) {
      return <div>Error</div>;
    }
    if (data) {
      console.log(data);
      return <div>{`Total Rows: ${data.rows.length}`}</div>;
    }
    return null;
  }
}
</ExecuteQueryByWidgetId>
```


<!-- Source: guides/migration-guide-2.0.0.md -->

) {
      console.log(data);
      return <div>{`Total Rows: ${data.rows.length}`}</div>;
    }
    return null;
  }
}
</ExecuteQueryByWidgetId>
```


<!-- Source: guides/migration-guide-2.0.0.md -->
# Migrating Compose SDK from 1.x.x to 2.0.0

Released in April 2025, the major version `2.0.0` of the Compose SDK introduces several breaking changes.
If your application is still using a Compose SDK version earlier than `2.0.0`, follow this guide to migrate.

## Minimum React Version

The minimum supported version of <img src="./../img/react-logo.png" height="14px" style="vertical-align: text-bottom; padding-bottom: 3px" /> **React** is now v17.0.0.

## Minimum Angular Version

The minimum supported version of <img src="./../img/angular-logo.png" height="14px" style="vertical-align: text-bottom; padding-bottom: 3px" /> **Angular** is now v17.

.

## Minimum Angular Version

The minimum supported version of <img src="./../img/angular-logo.png" height="14px" style="vertical-align: text-bottom; padding-bottom: 3px" /> **Angular** is now v17.

## Removed Deprecated Entities

1. ### `DashboardWidget` Component

   If your app uses `DashboardWidget` (React/Vue) or `\<csdk-dashboard-widget\>` (Angular) explicitly, replace them with the equivalent as described in the list below.

   The `DashboardWidget` component was renamed to `WidgetById` and deprecated in version `1.23.0`.
   It has now been removed in version `2.0.0`.

   <img src="./../img/react-logo.png" height="14px" style="vertical-align: text-bottom; padding-bottom: 3px" /> **React**, <img src="./../img/vue-logo.png" height="14px" style="vertical-align: text-bottom; padding-bottom: 3px" /> **Vue**
   - The `DashboardWidget` component has been removed. Use the `WidgetById` component instead.
   - The `DashboardWidgetProps` interface has been removed. Use the `WidgetByIdProps` interface instead.
   - The `DashboardWidgetStyleOptions` interface has been removed. Use the `WidgetByIdStyleOptions` interface instead.

   <img src="./../img/angular-logo.png" height="14px" style="vertical-align: text-bottom; padding-bottom: 3px" /> **Angular**
   - The `<csdk-dashboard-widget>` component has been removed. Use the `<csdk-widget-by-id>` component instead.
   - The `DashboardWidgetProps` interface has been removed. Use the `WidgetByIdProps` interface instead.
   - The `DashboardWidgetStyleOptions` interface has been removed. Use the `WidgetByIdStyleOptions` interface instead.

2. ### `WidgetModel` Interface

   In previous versions, `WidgetModel` was a class instance that included methods to convert its data into component props.
   In version `1.20.0`, these methods were moved into separate `widgetModelTranslator` utility functions and deprecated on the `WidgetModel` interface.
   In version `2.0.0`, these methods have been removed, and `WidgetModel` is now a plain object.

   Removed deprecated `WidgetModel` methods:
   - `getExecuteQueryParams` – use `widgetModelTranslator.toExecuteQueryParams` instead.
   - `getExecutePivotQueryParams` – use `widgetModelTranslator.toExecutePivotQueryParams` instead.
   - `getChartProps` – use `widgetModelTranslator.toChartProps` instead.
   - `getTableProps` – use `widgetModelTranslator.toTableProps` instead.
   - `getPivotTableProps` – use `widgetModelTranslator.toPivotTableProps` instead.
   - `getPivotTableWidgetProps` – use `widgetModelTranslator.toPivotTableWidgetProps` instead.
   - `getChartWidgetProps` – use `widgetModelTranslator.toChartWidgetProps` instead.
   - `getTableWidgetProps` – use `widgetModelTranslator.toTableWidgetProps` instead.
   - `getTextWidgetProps` – use `widgetModelTranslator.toTextWidgetProps` instead.

   Example:
   ```tsx
   // Before
   const chartProps = widgetModel.getChartProps();

   // After
   const chartProps = widgetModelTranslator.toChartProps(widgetModel);
   ```

3. ### Widget type
    Previously, the `WidgetModel` relied on the `Fusion` list of widget types. To improve consistency, the `WidgetModel` now uses the Compose SDK's own simplified list of widget types compatible with `Widget` component and `WidgetProps`.
    If you create/modify `WidgetModel` objects directly, you need to update the `widgetType` property to use the new type.
    ```ts
    type WidgetType = 'chart' | 'pivot' | 'text' | 'plugin';
    ```
    Example:
    ```tsx
    // Before
    const widgetModel: WidgetModel = {
        widgetType: 'chart/scatter',
        chartType: 'scatter',
        // ... other properties
    };

    // After
    const widgetModel: WidgetModel = {
        widgetType: 'chart',
        chartType: 'scatter',
        // ... other properties
    };
    ```

4. ### `TableStyleOptions` Interface

   - Removed deprecated `TableStyleOptions.headersColor` – use `TableStyleOptions.header.color.enabled` instead.
   - Removed deprecated `TableStyleOptions.alternatingRowsColor` – use `TableStyleOptions.rows.alternatingColor.enabled` instead.
   - Removed deprecated `TableStyleOptions.alternatingColumnsColor` – use `TableStyleOptions.columns.alternatingColor.enabled` instead.

   ```ts
   // Before
   const styleOptions: TableStyleOptions = {
     headersColor: true,
     alternatingColumnsColor: true,
     alternatingRowsColor: true,
   };

   // After
   const styleOptions: TableStyleOptions = {
     header: {
       color: {
         enabled: true,
       },
     },
     columns: {
       alternatingColor: {
         enabled: true,
       },
     },
     rows: {
       alternatingColor: {
         enabled: true,
       },
     },
   };
   ```

5. ### `PivotGrandTotals.title`

   The deprecated `PivotGrandTotals.title` property has been removed.
   To customize the title of grand totals, use the translation mechanism (see [Translation Guide](./internationalization.md) for details).

   Example:
   ```tsx
   const frenchTranslationResources: Partial<TranslationDictionary> = {
     pivotTable: {
       grandTotal: 'Total général',
       subTotal: '{{value}} total',
     },
   };
   ```

6. ### Widget drilldown

   - `DrilldownWidgetProps.drilldownDimensions` and `DrilldownOptions.drilldownDimensions` were deprecated in version `1.20.0` and have now been removed. Use `DrilldownWidgetProps.drilldownPaths` and `DrilldownOptions.drilldownPaths` instead.

   ```ts
   // Before
   const drilldownOptions = {
     drilldownDimensions: [DM.Commerce.AgeRange, DM.Commerce.Gender, DM.Commerce.Condition],
   };

   // After
   const drilldownOptions = {
     drilldownPaths: [DM.Commerce.AgeRange, DM.Commerce.Gender, DM.Commerce.Condition],
   };
   ```

7. ### Dashboard Helpers

   - The deprecated `modifyFilter` utility has been removed. Rename usages to `replaceFilter` instead.

8. ### `ThemeSettings`

   - The deprecated `themeSettings.chart.panelBackgroundColor` property has been removed. Use `themeSettings.filter.panel.backgroundColor` instead for theming filter panel.

9. ### Query Params

   <img src="./../img/angular-logo.png" height="14px" style="vertical-align: text-bottom; padding-bottom: 3px" /> **Angular**:
   - The deprecated `onBeforeQuery` property in `ExecuteQueryParams` has been removed. Use the `beforeQuery` parameter instead.

---

vertical-align: text-bottom; padding-bottom: 3px" /> **Angular**:
   - The deprecated `onBeforeQuery` property in `ExecuteQueryParams` has been removed. Use the `beforeQuery` parameter instead.

---

## Type Fixes

   <img src="./../img/react-logo.png" height="14px" style="vertical-align: text-bottom; padding-bottom: 3px" /> <img src="./../img/vue-logo.png" height="14px" style="vertical-align: text-bottom; padding-bottom: 3px" /> <img src="./../img/angular-logo.png" height="14px" style="vertical-align: text-bottom; padding-bottom: 3px" /> **All frameworks**:
   - The deprecated `CriteriaFilterType` type has been removed. Use the regular `Filter` type instead.

   <img src="./../img/vue-logo.png" height="14px" style="vertical-align: text-bottom; padding-bottom: 3px" /> **Vue**:

   In version `2.0.0` prop types were aligned across frameworks, with the following changes:
   - The `dataOptions` and `chartType` props for all charts and `ChartWidget` are now required.
   - The `dataOptions` prop for `Table` and `PivotTable` is now required.
   - The `url` prop for `SisenseContextProvider` is now required.
   - The `widgets` prop for `Dashboard` is now required.
   - The `closeContextMenu` prop for `ContextMenu` is now required.
   - The `clearDrilldownSelections`, `currentDimension`, `filtersDisplayValues`, and `sliceDrilldownSelections` props for `DrilldownBreadcrumbs` are now required.
   - The `filter`, `onUpdate`, and `title` props for `CriteriaFilterTile` and `RelativeDateFilterTile` are now required.
   - The `attribute`, `filter`, `onChange`, and `title` props for `DateRangeFilterTile` and `MemberFilterTile` are now required.
   - The `onChange` prop for `FilterTile` is now required.
   - The `dashboardOid` prop for `DashboardById` is now required.
   - The `dashboardOid` and `widgetOid` props for `WidgetById` are now required.
   - The `dataSource` prop for `GetNlgInsights` is now required.

   <img src="./../img/angular-logo.png" height="14px" style="vertical-align: text-bottom; padding-bottom: 3px" /> **Angular**:

   - The `dataPointsSelect` prop for multiple charts has been renamed to `dataPointsSelected`.
   - The callbacks `dataPointClick`, `dataPointContextMenu`, `dataPointsSelect`, and `beforeRender` for specific charts are now strictly typed, referencing the values specific to each chart.


<!-- Source: guides/styling.md -->

tClick`, `dataPointContextMenu`, `dataPointsSelect`, and `beforeRender` for specific charts are now strictly typed, referencing the values specific to each chart.


<!-- Source: guides/styling.md -->
# Theming & Styling

This guide demonstrates the various ways you can use themes and styles to customize the look and feel of [Compose SDK charts](./charts/guide-compose-sdk-charts.md).

To customize the way charts look, use one of the following, depending on what type of customization you want:

- [`ThemeProvider` / `ThemeService`](#themeprovider--themeservice)
- [`StyleOptions`](#chart-styleoptions)
- [`HighchartsOptions`](#highcharts-options)

#### Example Charts

In this guide, we refer to the following charts to demonstrate the usage of theme and style options.

![Unstyled Chart](../img/styling-guide/unstyled-chart.png 'Unstyled Chart')

```ts
import { AreaChart, PieChart } from '@sisense/sdk-ui';
import * as DM from './sample-ecommerce';
import { measureFactory } from '@sisense/sdk-data';

function App() {
  return (
    <div style={{ display: 'flex' }}>
      <AreaChart
        dataSet={DM.DataSource}
        dataOptions={{
          category: [{ column: DM.Commerce.Date.Years }],
          value: [measureFactory.sum(DM.Commerce.Revenue, 'Total Revenue')],
          breakBy: [DM.Commerce.Condition],
        }}
      />
      <PieChart
        dataSet={DM.DataSource}
        dataOptions={{
          category: [DM.Commerce.Condition],
          value: [measureFactory.sum(DM.Commerce.Revenue, 'Total Revenue')],
        }}
      />
    </div>
  );
}

export default App;
```

ataOptions={{
          category: [DM.Commerce.Condition],
          value: [measureFactory.sum(DM.Commerce.Revenue, 'Total Revenue')],
        }}
      />
    </div>
  );
}

export default App;
```

## ThemeProvider / ThemeService

Use a `ThemeProvider` (React and Vue) or `ThemeService` (Angular) to apply a consistent look and feel to multiple charts at once. All charts nested under the `ThemeProvider` or `ThemeService` inherit its theme settings.

A theme contains properties for setting styling, such as:

- Chart background and text colors
- General background and button colors
- Color palettes
- Fonts
- AI Chatbot look and feel

You can set the theme using a `ThemeSettings` object or you can use an [existing theme from your Fusion instance](https://docs.sisense.com/main/SisenseLinux/customizing-the-sisense-user-interface.htm) by providing a `ThemeOid`. If you don't include a `ThemeProvider` or `ThemeService` in your code, the default theme from your Fusion instance is used.

Note that style settings you set on the theme level may be overridden by other settings that you set on the chart level.

#### Theme Example

As an example, let's change the look and feel of our charts using the following `ThemeSettings` to change chart colors, fonts, and color palette:

```ts
<ThemeProvider
  theme={{
    chart: {
      backgroundColor: 'black',
      textColor: 'white',
    },
    typography: {
      fontFamily: 'American Typewriter',
    },
    palette: {
      variantColors: ['#FF0000', '#0000FF', '#006400', '#A020F0'],
    },
  }}
>
  {/* Chart code nested in here */}
</ThemeProvider>
```

![Theme Settings](../img/styling-guide/theme-settings.png 'Theme Settings')

ors: ['#FF0000', '#0000FF', '#006400', '#A020F0'],
    },
  }}
>
  {/* Chart code nested in here */}
</ThemeProvider>
```

![Theme Settings](../img/styling-guide/theme-settings.png 'Theme Settings')

## Chart StyleOptions

Use the `StyleOptions` property of a chart to set styling on particular charts.

The exact style options you can set for a chart depend on the type of chart you are styling, but in general, the kinds of styling you can do with chart style options include:

- Chart size
- Legend location
- Axes options
- Subtype (for example, whether a column chart is stacked)

#### StyleOptions Example

As an example, let's change the look and feel of our charts using the following `StyleOptions` to change the chart sizes, chart legends, and chart labels:

```ts
// AreaChart

styleOptions={{
  width: 600,
  height: 400,
  legend: { enabled: true, position: 'right' },
}}
```

```ts
// PieChart

styleOptions={{
  width: 400,
  height: 400,
  labels: { enabled: true, categories: false, value: false },
  legend: { enabled: false },
}}
```

![Style Options](../img/styling-guide/style-options.png 'Style Options')

idth: 400,
  height: 400,
  labels: { enabled: true, categories: false, value: false },
  legend: { enabled: false },
}}
```

![Style Options](../img/styling-guide/style-options.png 'Style Options')

## Highcharts Options

Use the `HighChartsOptions` parameter of the `onBeforeRender()` callback to set [styling (and other) options of the underlying Highcharts chart](https://api.highcharts.com/highcharts/). With the `onBeforeRender()` callback function, you can read, modify, and return the options that will be used when rendering your chart.

Use `HighChartsOptions` when the style settings you want to use are not available as part of a theme or the chart style options. You can also use `HighChartsOptions` to override styles you already set as part of a theme or the chart style options.

#### Highcharts Options Example

As an example, let's change the look and feel of our charts using the following `HighchartsOptions` to add a gradient to the area chart and to hollow out the center of the pie chart:

```ts
// AreaChart

onBeforeRender={(options: HighchartsOptions) => {
  options.series!.forEach((s: any) => {
    s.lineWidth = 4;
    s.fillColor = {
      linearGradient: { x1: 0, x2: 0, y1: 0, y2: 1 },
      stops: [
        [0, s.color + 90],
        [1, 'rgba(255, 255, 255, 0.1)'],
      ],
    };
  });
  return options;
}}
```

```ts
// PieChart

onBeforeRender={(options: HighchartsOptions) => {
  options.plotOptions!.pie!.innerSize = '65%';
  return options;
}}
```

![Highcharts Options](../img/styling-guide/highcharts-options.png 'Highcharts Options')



<!-- Source: guides/ai-features/index.md -->

.plotOptions!.pie!.innerSize = '65%';
  return options;
}}
```

![Highcharts Options](../img/styling-guide/highcharts-options.png 'Highcharts Options')



<!-- Source: guides/ai-features/index.md -->
# Generative AI powered by Sisense Intelligence

Compose SDK contains generative AI (GenAI) components and hooks/services that enable the following possibilities:

- **Deliver in-app analytics chat**: Enable business users to uncover data insights easily, by asking questions in a conversational interface using the `<Chatbot />` component. See how to [get started using the chatbot](./quickstart.md#chatbot) in your code.
- **Suggest recommedend questions**: Encourage exploration of the data landscape with AI-generated recommended queries, either directly within the chatbot or as a standlone feature using the `useGetQueryRecommendations()` hook in React and Vue, or the `AiService.getQueryRecommendations` in Angular. See how to [get started using query recommendations](./quickstart.md#query-recommendations) in your code.
- **Bring insights to life with data storytelling**: Enhance collaboration and add context to your data with auto-generated, natural language insights using the `<GetNlgInsights />` component (`GetNlgInsightsComponent` in Angular) or the `useGetNlgInsights()` hook (`AiService.getQueryRecommendations` in Angular). See how to [get started using natural language insights](./quickstart.md#natural-language-generation-nlg-insights) in your code.

<SectionIndex />

Visit the following API References to learn more about usage and examples:

- Generative for [React](../../modules/sdk-ui/generative-ai/)
- Generative for [Angular](../../modules/sdk-ui-angular/generative-ai/)
- Generative for [Vue](../../modules/sdk-ui-vue/generative-ai/)


<!-- Source: guides/ai-features/quickstart.md -->

rative-ai/)
- Generative for [Angular](../../modules/sdk-ui-angular/generative-ai/)
- Generative for [Vue](../../modules/sdk-ui-vue/generative-ai/)


<!-- Source: guides/ai-features/quickstart.md -->
# Generative AI with React: Quickstart Guide

This guide offers examples for getting started with:

- [AI Chatbot](#chatbot)
- [Natural language generation (NLG) for Insights](#natural-language-generation-nlg)
- [Natural language query (NLQ)](#natural-language-query-nlq)
- [Query recommendations](#query-recommendations)

## Prerequisites

This guide assumes you already have a React project working with Compose SDK. If you don't already have a working project, follow the [Compose SDK Quickstart](../../getting-started) before continuing here. The additional prerequsities for Generative AI are listed below:

- `@sisense/sdk-ui` version `2.0.0` or higher
- Sisense Fusion version L2025.2 or higher, with Generative AI and LLM enabled per the [Sisense Documentation](https://docs.sisense.com/main/SisenseLinux/genai.htm)

sdk-ui` version `2.0.0` or higher
- Sisense Fusion version L2025.2 or higher, with Generative AI and LLM enabled per the [Sisense Documentation](https://docs.sisense.com/main/SisenseLinux/genai.htm)

## Project Setup

To use AI features in Compose SDK, all AI related components or hooks imported from `@sisense/sdk-ui/ai` must be wrapped with an `AiContextProvider` component within your application code. For example:

```ts
import App from './App.tsx';
import { SisenseContextProvider } from '@sisense/sdk-ui';
import { AiContextProvider } from '@sisense/sdk-ui/ai';

const sisenseContextProps = { /* Sisense configuration */ };

// ...

<SisenseContextProvider {...sisenseContextProps}>
  <AiContextProvider>
    <App />
  </AiContextProvider>
</SisenseContextProvider>
```
<br />

## Chatbot

Here are some examples of how to work with the [`<Chatbot>`](../../modules/sdk-ui/generative-ai/function.Chatbot.md) component.

### Default Chatbot

To display a chatbot with the default settings, simply add the [`<Chatbot />`](../../modules/sdk-ui/generative-ai/function.Chatbot.md) component to your code without specifying any props.

```ts
import { Chatbot } from '@sisense/sdk-ui/ai';

// ...

<Chatbot />
```

hatbot />`](../../modules/sdk-ui/generative-ai/function.Chatbot.md) component to your code without specifying any props.

```ts
import { Chatbot } from '@sisense/sdk-ui/ai';

// ...

<Chatbot />
```

### Custom Configuration

You can also configure the Chatbot with custom options, including size, behavior and look and feel.

#### Change Size

To change the size of the displayed Chatbot, provide values for the `width` and `height` properties (props).
For more information refer to [ChatbotProps](../../modules/sdk-ui/interfaces/interface.ChatbotProps.md)

```ts
<Chatbot
  width="700px"
  height="1000px"
/>
```

#### Change Behavior

To change the Chatbot's default behavior or text content, provide an object to the `config` property.
For more information refer to [ChatConfig](../../modules/sdk-ui/interfaces/interface.ChatConfig.md)

```ts
<Chatbot
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
```

#### Change Look and Feel

To change the look and feel of the chatbot, wrap the component in a [`<ThemeProvider>`](../../modules/sdk-ui/contexts/function.ThemeProvider.md) and specify properties under the `aiChat` field.
For more information refer to [AiChatThemeSettings](../../modules/sdk-ui/interfaces/interface.AiChatThemeSettings.md)

```ts
<ThemeProvider
  theme={{
    aiChat: {
      backgroundColor: '#222222',
      primaryTextColor: 'rgba(255, 255, 255, 0.7)',
      secondaryTextColor: 'rgba(255, 255, 255, 0.7)',
      primaryFontSize: ['14px', '16px'],
    }
  }}
>
  <Chatbot />
</ThemeProvider>
```
<br />

primaryTextColor: 'rgba(255, 255, 255, 0.7)',
      secondaryTextColor: 'rgba(255, 255, 255, 0.7)',
      primaryFontSize: ['14px', '16px'],
    }
  }}
>
  <Chatbot />
</ThemeProvider>
```
<br />

## Natural Language Generation (NLG Insights)

Natural language textual insights generated from the data results of the provided query parameters.

There are different options for generating NLG insights using a Compose SDK query:

- Use the [`useGetNlgInsights()`](../../modules/sdk-ui/generative-ai/function.useGetNlgInsights.md) hook as an API to return a plain text response, and render it how you like using your own code / component.
- Use the [`<GetNlgInsights />`](../../modules/sdk-ui/generative-ai/function.GetNlgInsights.md) component to get display the generated text response in a styled container.

### useNlgInsights Hook

To use the [`useGetNlgInsights()`](../../modules/sdk-ui/generative-ai/function.useGetNlgInsights.md) hook, call the hook with the query information and handle the returned result.

```ts
import { useGetNlgInsights } from '@sisense/sdk-ui/ai';

// ...

const { data, isLoading } = useGetNlgInsights({
  dataSource: DM.DataSource,
  dimensions: [DM.Commerce.Date.Years],
  measures: [measureFactory.sum(DM.Commerce.Revenue)],
  verbosity: 'Low'
});

if (isLoading) {
  return <div>Loading...</div>;
}

return <p>{data}</p>;
```

,
  dimensions: [DM.Commerce.Date.Years],
  measures: [measureFactory.sum(DM.Commerce.Revenue)],
  verbosity: 'Low'
});

if (isLoading) {
  return <div>Loading...</div>;
}

return <p>{data}</p>;
```

### GetNlgInsights Component

To use the [`<GetNlgInsights />`](../../modules/sdk-ui/generative-ai/function.GetNlgInsights.md) component, add it to your code with the query information.

```ts
import { GetNlgInsights } from '@sisense/sdk-ui/ai';

// ...

<GetNlgInsights
  dataSource={DM.DataSource}
  dimensions={[DM.Commerce.Date.Years]}
  measures={[measureFactory.sum(DM.Commerce.Revenue)]}
  verbosity: 'High'
/>
```
<br />

## Natural Language Query (NLQ)

Generate properties for a [`<Widget>`](../../modules/sdk-ui/dashboards/function.Widget.md) by asking a question in natural language, with the `useGetNlqResult` hook.

Provide the question and datamodel name, and receive [`WidgetProps`](../../modules/sdk-ui/type-aliases/type-alias.WidgetProps.md) as a response, then render the result in a [`<Widget>`](../../modules/sdk-ui/dashboards/function.Widget.md) component.

```ts
import { useGetNlqResult } from '@sisense/sdk-ui/ai';

// ...

const { data, isLoading} = useGetNlqResult({
  dataSource: 'Sample ECommerce',
  query: 'total sales by month',
});

if (isLoading) {
  return <div>Loading result</div>;
}

return (
  <>
    {data && <Widget {...data} /> }
  </>
);
```
<br />

dataSource: 'Sample ECommerce',
  query: 'total sales by month',
});

if (isLoading) {
  return <div>Loading result</div>;
}

return (
  <>
    {data && <Widget {...data} /> }
  </>
);
```
<br />

## Query Recommendations

Query recommendations are AI-generated queries that you can run on your data model. The provides query recommendations as a standlone capability outside of the conversational analytics flow provided by the [`<Chatbot>`](../../modules/sdk-ui/generative-ai/function.Chatbot.md) component. This enables query recommendation functionality to be delivered in a customized user experience.

To do so, use the [`useGetQueryRecommendations()`](../../modules/sdk-ui/generative-ai/function.useGetQueryRecommendations.md) hook by providing a data model title for the query recommendations and, optionally, the number of recommendations you want to generate.

The hook returns `data` as an array of [`QueryRecommendation`](../../modules/sdk-ui/interfaces/interface.QueryRecommendation.md) entities. These include properties such as:
- The `nlqPrompt` which is the textual representation of the question to ask, to show to the end user
- `widgetProps` that can be passed to a [`<Widget>`](../../modules/sdk-ui/dashboards/function.Widget.md) component to render the results of the generated question.
- other properties e.g `detailedDescription`

In this example, we simply show the list of suggested questions. In practice, the other propeties are then useful if/when a user selects one of the generated questions.

```ts
import { useGetQueryRecommendations, QueryRecommendation } from '@sisense/sdk-ui/ai';

// ...

const { data, isLoading } = useGetQueryRecommendations({
  contextTitle: DM.DataSource.title,
  count: 5
});

if (isLoading) {
  return <div>Loading recommendations..</div>;
}

return (
  <ul>
    {data.map((item: QueryRecommendation, index) => (
      <li key={index}>{item.nlqPrompt}</li>
    ))}
  </ul>
);
```

In this example, both the generated question and the answer (widget) are shown at the same time.

```ts
import { useGetQueryRecommendations, QueryRecommendation } from '@sisense/sdk-ui/ai';

// ...

const { data, isLoading } = useGetQueryRecommendations({
  contextTitle: DM.DataSource.title,
  count: 5
});

if (isLoading) {
  return <div>Loading recommendations..</div>;
}

return (
  <ul>
    {data.map((item: QueryRecommendation, index) => (
      item.widgetProps &&
      <li key={index}>
        <div key={'title-' + index}>{item.nlqPrompt}</div>
        <div key={'chart-' + index}>
          <Widget
            key={'widget-' + index}
            {...item.widgetProps}
          />
        </div>
      </li>
    ))}
  </ul>
);
```


<!-- Source: guides/charts/index.md -->

ndex}>
          <Widget
            key={'widget-' + index}
            {...item.widgetProps}
          />
        </div>
      </li>
    ))}
  </ul>
);
```


<!-- Source: guides/charts/index.md -->
# Chart Types

When working with Compose SDK, there are several different ways you can visualize data using charts:

-   Compose SDK Charts - Charts found in the `sdk-ui*` modules built specifically for Compose SDK
-   Sisense Fusion Widgets - Charts that are already defined as widgets within a Sisense Fusion dashboard
-   External Charts - Charts from 3rd party charting libraries, such as [D3](https://d3js.org/),
    [Material UI](https://mui.com/x/react-charts/), [nivo](https://nivo.rocks/), and others

You can choose to use one type of chart or mix and match to fit your specific needs.

<SectionIndex />

),
    [Material UI](https://mui.com/x/react-charts/), [nivo](https://nivo.rocks/), and others

You can choose to use one type of chart or mix and match to fit your specific needs.

<SectionIndex />

## Compose SDK Charts

Compose SDK charts are the components found in the `sdk-ui` modules of Compose SDK. These charts can be used with data from a Sisense instance or 3rd party data.

These components provide an easy way to build data visualizations directly against a Sisense data model or other data source. They also allow for customizing the data that is presented, how that data is styled, and how your users can interact with that data.

Compose charts are currently available as React, Angular, and Vue components.

Compose SDK charts should be your default choice for any project where you’ll be creating new charts, especially with data from a Sisense instance.

To learn more about Compose SDK charts, see [Compose SDK Charts](./guide-compose-sdk-charts.md).

e for any project where you’ll be creating new charts, especially with data from a Sisense instance.

To learn more about Compose SDK charts, see [Compose SDK Charts](./guide-compose-sdk-charts.md).

## Sisense Fusion Widgets

Sisense Fusion widgets are charts rendered from dashboard widgets that already exist in your Sisense Fusion environment. You can reuse most charts you already defined using Sisense Fusion and optionally customize them using Compose SDK.

Note: Sisense Fusion widgets can also be used to update existing projects that embed Sisense Fusion widgets using Sisense.JS. Using Compose SDK instead of Sisense.JS usually leads to improved performance, lower latency, and simpler code.

Use Fusion charts when you already have the charts you need in your Sisense instance.

To learn more about Fusion charts, see [Sisense Fusion Widgets](./guide-fusion-widgets.md).

and simpler code.

Use Fusion charts when you already have the charts you need in your Sisense instance.

To learn more about Fusion charts, see [Sisense Fusion Widgets](./guide-fusion-widgets.md).

## External Charts

Using the query APIs of Compose SDK, you can use the data you retrieve from your Sisense environment with just about any JavaScript charting library. Use Compose SDK to query Sisense for the data you need for your charts. Then use that data to populate charts from a 3rd party charting library.

Use external charting libraries if you are already familiar with them and want to continue using them or if they offer functionality not currently available in Compose SDK charts.

To learn more about External Charts, see [External Charts](./guide-external-charts.md).


<!-- Source: guides/charts/guide-compose-sdk-charts.md -->

ty not currently available in Compose SDK charts.

To learn more about External Charts, see [External Charts](./guide-external-charts.md).


<!-- Source: guides/charts/guide-compose-sdk-charts.md -->
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

n the examples to other chart types as well. The examples will also mostly use data from a Sisense instance, but the code in the examples can be adapted to work with data from other sources as well.

## Data Properties

Charts contain the following data properties for working with the data the chart displays:

- `dataSet` - Data or reference to the data the chart displays
- `filters` - Filters to apply to the chart data
- `highlights` - Highlights that highlight data that pass certain criteria

displays:

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

ype: 'number' }],
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

>
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

e data and style options:

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

ce.Revenue, 'Sum of Revenue')],
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

omponent HTML template in .component.html-->

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


<!-- Source: guides/charts/guide-external-charts.md -->

t]="chart.dataSet"
  [dataOptions]="chart.dataOptions"
  [beforeRender]="onBeforeRender"
  (dataPointClick)="onDataPointClick($event)"
/>
```


<!-- Source: guides/charts/guide-external-charts.md -->
# External Charts

You can use the data you retrieve from your Sisense instance with just about any JavaScript charting library. Use Compose SDK to query your Sisense instance for the data you need for your charts. Then use that data to populate charts from a 3rd party charting library.

In this guide we’ll use [Plotly.js](https://plotly.com/javascript/) charts, but the same principles apply to using any other charting library.

In order to display your Sisense data in a 3rd party chart, you need to:

- Query you Sisense instance for the data you want
- Transform the data you receive from Sisense to the format required by the charting library you’re using
- Apply the formatted data to the 3rd party chart.

Let’s see how you would perform these steps to create this chart that shows the total cost and total revenue for a number of age ranges.

![Plotly chart](../../img/chart-guides/plotly.png 'Plotly chart')

see how you would perform these steps to create this chart that shows the total cost and total revenue for a number of age ranges.

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

imensions: [DM.Commerce.AgeRange],
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

his.graph = {
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

title: 'Cost and Revenue ($)' },
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


<!-- Source: guides/charts/guide-fusion-widgets.md -->
# Sisense Fusion Widgets

Sisense Fusion widgets are charts from dashboard widgets that already exist in your Sisense instance. You can reuse the charts you already have and customize them using Compose SDK.

You display charts from your existing Sisense instance using the `<WidgetById />` component in React/Vue projects or `WidgetByIdComponent` in Angular projects.

Note that you can also get the data from a dashboard widget and use it in a Compose SDK chart using the `useExecuteQueryByWidgetId()` hook in React/Vue projects or the `executeQueryByWidgetId()` query service method in Angular projects.

om a dashboard widget and use it in a Compose SDK chart using the `useExecuteQueryByWidgetId()` hook in React/Vue projects or the `executeQueryByWidgetId()` query service method in Angular projects.

## WidgetById Properties

Many of the properties of dashboard widget component’s properties are the same as the properties for other Compose SDK charts. To learn more about those properties, see [Compose SDK charts](./guide-compose-sdk-charts.md).

There are also some properties which are specific to `WidgetById` components.

ther Compose SDK charts. To learn more about those properties, see [Compose SDK charts](./guide-compose-sdk-charts.md).

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


<!-- Source: guides/custom-widgets/index.md -->
# Custom Widgets

Here you'll find guides that will help get started with the custom widgets in Compose SDK.

<SectionIndex />


<!-- Source: guides/custom-widgets/custom-widgets-angular.md -->

d -->
# Custom Widgets

Here you'll find guides that will help get started with the custom widgets in Compose SDK.

<SectionIndex />


<!-- Source: guides/custom-widgets/custom-widgets-angular.md -->
# Custom Widgets

> **Note**:
> This guide is for [<img src="../../img/angular-logo.png" height="18px" style="vertical-align: text-bottom; padding-bottom: 2px" /> Angular](../../getting-started/quickstart-angular.md). For other frameworks, see the [<img src="../../img/react-logo.png" height="18px" style="vertical-align: text-bottom; padding-bottom: 3px" /> React](custom-widgets-react.md) and [<img src="../../img/vue-logo.png" height="14px" /> Vue](custom-widgets-vue.md) guides.

This guide explains how to define your own custom widget component and register it in your application code, so that it will be automatically rendered (based on the corresponding widget type) when using the `DashboardById` component. Custom widgets in Compose SDK can be used to replace Fusion plugins when displaying dashboards.

**Note:** It is assumed that the application is [already configured correctly](../../getting-started/quickstart-angular.md) for use with Compose SDK.

lace Fusion plugins when displaying dashboards.

**Note:** It is assumed that the application is [already configured correctly](../../getting-started/quickstart-angular.md) for use with Compose SDK.

## Sample dashboard

The `histogramwidget` plugin is included with Sisense Fusion, so we'll be using it as our example. We'll start by creating a dashboard in Fusion, containing a single `histogramwidget` widget with `Sample ECommerce` as its data source.

![Dashboard in Fusion](../../img/plugins-guide/dashboard-in-fusion.png 'Dashboard in Fusion')

ard in Fusion, containing a single `histogramwidget` widget with `Sample ECommerce` as its data source.

![Dashboard in Fusion](../../img/plugins-guide/dashboard-in-fusion.png 'Dashboard in Fusion')

## Displaying the dashboard in your application

To display a dashboard using Compose SDK, we need the `oid` for the relevant dashboard. The simplest way to find this, is to copy the value from the end of the URL when viewing the dashboard in Fusion, e.g. `/app/main/dashboards/{dashboardOid}`.

The dashboard can be easily displayed using the `csdk-dashboard-by-id` component, passing this value into the `dashboardOid` input.

```html
<csdk-dashboard-by-id [dashboardOid]="'66f23d1b202c89002abd64ac'" />
```

Since Compose SDK does not support the `histogramwidget` plugin out of the box, it is expected that Compose SDK will display an error in place of the histogram widget.

![Dashboard in Compose SDK (no registered custom widget)](../../img/plugins-guide/dashboard-in-csdk-unregistered.png 'Dashboard in Compose SDK (no registered custom widget)')

In order to resolve this, we will explore how to define a custom widget component and register it with Compose SDK, so that it knows what to do when it encounters a `histogramwidget` plugin from Fusion.

rder to resolve this, we will explore how to define a custom widget component and register it with Compose SDK, so that it knows what to do when it encounters a `histogramwidget` plugin from Fusion.

## Defining a custom widget using Compose SDK

Before registering our custom widget, we first need to define a custom widget component that will replace the Fusion plugin. This component will:
1. Receive the props that Compose SDK will pass to our custom widget when rendering the `csdk-dashboard-by-id` component
2. Run a data query using those props
3. Render a visualization with the results

Purely for the **simplicity** of this guide, we have chosen to define a custom widget component which renders a table of the query results. In reality, you would more likely define an Angular implementation of a histogram chart, or however else you wish to represent the Fusion plugin in your Compose SDK dashboard.

This guide also aims to demonstrate the flexibility of the `registerCustomWidget` interface - as long as you provide a component that matches the shape of [`CustomWidgetComponent`](../../modules/sdk-ui-angular/type-aliases/type-alias.CustomWidgetComponent.md), Compose SDK will render that component as a replacement for the designated Fusion plugin.

A note on the `dataOptions` input that is passed to our component: For those familiar with the Fusion plugin / add-on architecture, `dataOptions` is the Compose SDK equivalent of `panels` on the [WidgetMetadata](https://developer.sisense.com/guides/customJs/jsApiRef/widgetClass/widget-metadata.html) object.

Compose SDK translates all widget metadata and filters to Compose SDK data structures (e.g. values inside [`dataOptions`](../../modules/sdk-ui-angular/type-aliases/type-alias.ChartDataOptions.md) are of type [`StyledColumn`](../../modules/sdk-ui-angular/interfaces/interface.StyledColumn.md) and [`StyledMeasureColumn`](../../modules/sdk-ui-angular/interfaces/interface.StyledMeasureColumn.md), the same types you'd expect for [`dataOptions`](../../modules/sdk-ui-angular/type-aliases/type-alias.ChartDataOptions.md) into the [`csdk-chart`](../../modules/sdk-ui-angular/charts/class.ChartComponent.md) component).

In the custom widget component, we can use the inputs directly with the `executeCustomWidgetQuery` method from the `QueryService` which runs a data query and applies some formatting on the results (defined by the `StyledColumn` information in `dataOptions`).

```typescript
import { Component, Input, OnInit } from '@angular/core';
import { QueryService } from '@sisense/sdk-ui-angular';
import type {
  CustomWidgetComponentProps,
  QueryResultData
} from '@sisense/sdk-ui-angular';
import { Observable } from 'rxjs';

@Component({
  selector: 'app-results-table',
  template: `
    <table style="margin: 20px;" *ngIf="data$ | async as data">
      <thead>
        <tr>
          <th *ngFor="let column of data.columns; trackBy: trackByIndex">
            {{ column.name }}
          </th>
        </tr>
      </thead>
      <tbody>
        <tr *ngFor="let row of data.rows; trackBy: trackByIndex">
          <td *ngFor="let cell of row; trackBy: trackByIndex">
            {{ cell.text }}
          </td>
        </tr>
      </tbody>
    </table>
  `
})
export class ResultsTableComponent implements OnInit, CustomWidgetComponentProps {
  @Input() title!: string;
  @Input() dataOptions!: any;
  @Input() filters!: any[];

  data$!: Observable<QueryResultData | null>;

  constructor(private queryService: QueryService) {}

  ngOnInit() {
    this.data$ = this.queryService.executeCustomWidgetQuery({
      title: this.title,
      dataOptions: this.dataOptions,
      filters: this.filters
    });
  }

  trackByIndex(index: number): number {
    return index;
  }
}
```
**Note:** Don't forget to declare your custom widget component in your Angular module

If you prefer to work with the raw data without any formatting applied, you can use `extractDimensionsAndMeasures` with `executeQuery` instead.

```typescript
import { extractDimensionsAndMeasures } from '@sisense/sdk-ui-angular';

ngOnInit() {
  const { dimensions, measures } = extractDimensionsAndMeasures(this.dataOptions);
  this.data$ = this.queryService.executeQuery({
    dimensions,
    measures,
    filters: this.filters,
  });
}
```

const { dimensions, measures } = extractDimensionsAndMeasures(this.dataOptions);
  this.data$ = this.queryService.executeQuery({
    dimensions,
    measures,
    filters: this.filters,
  });
}
```

## Registering the custom widget with Compose SDK

To register the custom widget, we need to inject the `CustomWidgetsService` and call `registerCustomWidget`.

```typescript
import { Component, OnInit } from '@angular/core';
import { CustomWidgetsService } from '@sisense/sdk-ui-angular';
import { ResultsTableComponent } from './results-table.component';

@Component({
  selector: 'app-root',
  template: `
    <csdk-dashboard-by-id [dashboardOid]="'66f4d4dd384428002ae0a21d'" />
  `
})
export class AppComponent implements OnInit {
  constructor(private customWidgetsService: CustomWidgetsService) {}

  ngOnInit() {
    this.customWidgetsService.registerCustomWidget('histogramwidget', ResultsTableComponent);
  }
}
```

If we refresh our application, instead of seeing the error in place of the widget as before, we should now see something like this:

![Dashboard in Compose SDK (registered custom widget)](../../img/plugins-guide/dashboard-in-csdk-registered.png 'Dashboard in Compose SDK (registered custom widget)')

d now see something like this:

![Dashboard in Compose SDK (registered custom widget)](../../img/plugins-guide/dashboard-in-csdk-registered.png 'Dashboard in Compose SDK (registered custom widget)')

## Summary

Here's what we accomplished:
- Displayed an existing Fusion dashboard in our application by rendering a `csdk-dashboard-by-id` component
- Created an Angular component that uses its inputs to execute a data query and display the results in a table
- Registered that table component as a custom widget to be shown in place of the `histogramwidget` Fusion plugin when it is rendered inside of a `csdk-dashboard-by-id` component

Obviously, we didn't end up with a new histogram component in Angular (yet), but hopefully the simplicity of this guide gives you the tools you need to make that, or anything else, happen!


<!-- Source: guides/custom-widgets/custom-widgets-react.md -->

nent in Angular (yet), but hopefully the simplicity of this guide gives you the tools you need to make that, or anything else, happen!


<!-- Source: guides/custom-widgets/custom-widgets-react.md -->
# Custom Widgets

> **Note**:
> This guide is for [<img src="../../img/react-logo.png" height="18px" style="vertical-align: text-bottom; padding-bottom: 3px" /> React](../../getting-started/quickstart.md). For other frameworks, see the [<img src="../../img/angular-logo.png" height="18px" style="vertical-align: text-bottom; padding-bottom: 2px" /> Angular](custom-widgets-angular.md) and [<img src="../../img/vue-logo.png" height="14px" /> Vue](custom-widgets-vue.md) guides.

This guide explains how to define your own custom widget component and register it in your application code, so that it will be automatically rendered (based on the corresponding widget type) when using the `DashboardById` component. Custom widgets in Compose SDK can be used to replace Fusion plugins when displaying dashboards.

**Note:** It is assumed that the application is [already configured correctly](../../getting-started/quickstart.md) for use with Compose SDK.

d to replace Fusion plugins when displaying dashboards.

**Note:** It is assumed that the application is [already configured correctly](../../getting-started/quickstart.md) for use with Compose SDK.

## Sample dashboard

The `histogramwidget` plugin is included with Sisense Fusion, so we'll be using it as our example. We'll start by creating a dashboard in Fusion, containing a single `histogramwidget` widget with `Sample ECommerce` as its data source.

![Dashboard in Fusion](../../img/plugins-guide/dashboard-in-fusion.png 'Dashboard in Fusion')

ard in Fusion, containing a single `histogramwidget` widget with `Sample ECommerce` as its data source.

![Dashboard in Fusion](../../img/plugins-guide/dashboard-in-fusion.png 'Dashboard in Fusion')

## Displaying the dashboard in your application

To display a dashboard using Compose SDK, we need the `oid` for the relevant dashboard. The simplest way to find this, is to copy the value from the end of the URL when viewing the dashboard in Fusion, e.g. `/app/main/dashboards/{dashboardOid}`.

The dashboard can be easily displayed using the `DashboardById` component, passing this value into the `dashboardOid` prop.

```ts
import { DashboardById } from '@sisense/sdk-ui';

function App() {
  return (
    <DashboardById dashboardOid={'66f23d1b202c89002abd64ac'} />;
  );
}

export default App;
```

Since Compose SDK does not support the `histogramwidget` plugin out of the box, it is expected that Compose SDK will display an error in place of the histogram widget.

![Dashboard in Compose SDK (no registered custom widget)](../../img/plugins-guide/dashboard-in-csdk-unregistered.png 'Dashboard in Compose SDK (no registered custom widget)')

In order to resolve this, we will explore how to define a custom widget component and register it with Compose SDK, so that it knows what to do when it encounters a `histogramwidget` plugin from Fusion.

rder to resolve this, we will explore how to define a custom widget component and register it with Compose SDK, so that it knows what to do when it encounters a `histogramwidget` plugin from Fusion.

## Defining a custom widget using Compose SDK

Before registering our custom widget, we first need to define a custom widget component that will replace the Fusion plugin. This component will:
1. Receive the props that Compose SDK will pass to our custom widget when rendering the `DashboardById` component
2. Run a data query using those props
3. Render a visualization with the results

Purely for the **simplicity** of this guide, we have chosen to define a custom widget component which renders a table of the query results. In reality, you would more likely define a React implementation of a histogram chart, or however else you wish to represent the Fusion plugin in your Compose SDK dashboard.

This guide also aims to demonstrate the flexibility of the `registerCustomWidget` interface - as long as you provide a functional component that matches the shape of [`CustomWidgetComponent`](../../modules/sdk-ui/type-aliases/type-alias.CustomWidgetComponent.md), Compose SDK will render that component as a replacement for the designated Fusion plugin.

A note on the `dataOptions` prop that is passed to our component: For those familiar with the Fusion plugin / add-on architecture, `dataOptions` is the Compose SDK equivalent of `panels` on the [WidgetMetadata](https://developer.sisense.com/guides/customJs/jsApiRef/widgetClass/widget-metadata.html) object.

Compose SDK translates all widget metadata and filters to Compose SDK data structures (e.g. values inside [`dataOptions`](../../modules/sdk-ui/type-aliases/type-alias.ChartDataOptions.md) are of type [`StyledColumn`](../../modules/sdk-ui/interfaces/interface.StyledColumn.md) and [`StyledMeasureColumn`](../../modules/sdk-ui/interfaces/interface.StyledMeasureColumn.md), the same types you'd expect for [`dataOptions`](../../modules/sdk-ui/type-aliases/type-alias.ChartDataOptions.md) into the [`Chart`](../../modules/sdk-ui/charts/function.Chart.md) component).

In the custom widget component, we can use the props directly with the `useExecuteCustomWidgetQuery` hook which runs a data query and applies some formatting on the results (defined by the `StyledColumn` information in `dataOptions`).

```ts
import { CustomWidgetComponent, useExecuteCustomWidgetQuery } from '@sisense/sdk-ui';

const ResultsTable: CustomWidgetComponent = (props) => {
  const { data } = useExecuteCustomWidgetQuery(props);

  if (!data) {
    return null;
  }

  return (
    <table style={{ margin: '20px' }}>
      <thead>
        <tr>
          {data.columns.map((column, columnIndex) => (
            <th key={columnIndex}>{column.name}</th>
          ))}
        </tr>
      </thead>
      <tbody>
        {data.rows.map((row, rowIndex) => (
          <tr key={rowIndex}>
            {row.map((cell, cellIndex) => (
              <td key={cellIndex}>{cell.text}</td>
            ))}
          </tr>
        ))}
      </tbody>
    </table>
  );
};

...
```

If you prefer to work with the raw data without any formatting applied, you can use `extractDimensionsAndMeasures` with `useExecuteQuery` instead.

```ts
import { useExecuteQuery, extractDimensionsAndMeasures } from '@sisense/sdk-ui';

const { dimensions, measures } = extractDimensionsAndMeasures(props.dataOptions);
const { data } = useExecuteQuery({
  dimensions,
  measures,
  filters: props.filters,
});
```

m '@sisense/sdk-ui';

const { dimensions, measures } = extractDimensionsAndMeasures(props.dataOptions);
const { data } = useExecuteQuery({
  dimensions,
  measures,
  filters: props.filters,
});
```

## Registering the custom widget with Compose SDK

To register the custom widget, we need to call `registerCustomWidget`, which is returned from the `useCustomWidgets` hook.

```ts
import { DashboardById, useCustomWidgets } from '@sisense/sdk-ui';

...

function App() {
  const { registerCustomWidget } = useCustomWidgets();
  registerCustomWidget('histogramwidget', ResultsTable);

  return <DashboardById dashboardOid={'66f4d4dd384428002ae0a21d'} />;
};

...
```

If we refresh our application, instead of seeing the error in place of the widget as before, we should now see something like this:

![Dashboard in Compose SDK (registered custom widget)](../../img/plugins-guide/dashboard-in-csdk-registered.png 'Dashboard in Compose SDK (registered custom widget)')

d now see something like this:

![Dashboard in Compose SDK (registered custom widget)](../../img/plugins-guide/dashboard-in-csdk-registered.png 'Dashboard in Compose SDK (registered custom widget)')

## Summary

Here's what we accomplished:
- Displayed an existing Fusion dashboard in our application by rendering a `DashboardById` component
- Created a React component that uses its props to execute a data query and display the results in a table
- Registered that table component as a custom widget to be shown in place of the `histogramwidget` Fusion plugin when it is rendered inside of a `DashboardById` component

Obviously, we didn't end up with a new histogram component in React (yet), but hopefully the simplicity of this guide gives you the tools you need to make that, or anything else, happen!

## Migration from previous Plugin Interface to Custom Widget Interface

If you have existing code that uses the [previous Compose SDK "plugin" interface](https://developer.sisense.com/guides/sdkPrevious/v1/guides/chart-plugins.html), here's how to migrate to the new "custom widget" interface.

de that uses the [previous Compose SDK "plugin" interface](https://developer.sisense.com/guides/sdkPrevious/v1/guides/chart-plugins.html), here's how to migrate to the new "custom widget" interface.

### API Changes

| Previous (Compose SDK Plugin Interface) | New (ComposeSDK Custom Widget Interface) |
|------------------------------|-------------------------------------|
| `usePlugins()` | `useCustomWidgets()` |
| `registerPlugin()` | `registerCustomWidget()` |
| `PluginComponent` | `CustomWidgetComponent` |
| `PluginComponentProps` | `CustomWidgetComponentProps` |
| `useExecutePluginQuery()` | `useExecuteCustomWidgetQuery()` |
| `widget.pluginType` | `widget.customWidgetType` |
| `widget.widgetType -> 'plugin'` | `widget.widgetType -> 'custom'` |

nentProps` |
| `useExecutePluginQuery()` | `useExecuteCustomWidgetQuery()` |
| `widget.pluginType` | `widget.customWidgetType` |
| `widget.widgetType -> 'plugin'` | `widget.widgetType -> 'custom'` |

### Code Migration Example

**Before (Compose SDK Plugin Interface):**
```ts
import {
  DashboardById,
  PluginComponent,
  useExecutePluginQuery,
  usePlugins
} from '@sisense/sdk-ui';

const MyWidget: PluginComponent = (props) => {
  const { data } = useExecutePluginQuery(props);
  // ... component implementation
};

function App() {
  const { registerPlugin } = usePlugins();
  registerPlugin('my-widget', MyWidget); // 'my-widget' represents a Fusion plugin
  return <DashboardById dashboardOid={'your-dashboard-id'} />;
}
```

**After (Compose SDK Custom Widget Interface):**
```ts
import {
  DashboardById,
  CustomWidgetComponent,
  useExecuteCustomWidgetQuery,
  useCustomWidgets
} from '@sisense/sdk-ui';

const MyWidget: CustomWidgetComponent = (props) => {
  const { data } = useExecuteCustomWidgetQuery(props);
  // ... component implementation
};

function App() {
  const { registerCustomWidget } = useCustomWidgets();
  registerCustomWidget('my-widget', MyWidget); // 'my-widget' represents a Fusion plugin
  return <DashboardById dashboardOid={'your-dashboard-id'} />;
}
```

sterCustomWidget } = useCustomWidgets();
  registerCustomWidget('my-widget', MyWidget); // 'my-widget' represents a Fusion plugin
  return <DashboardById dashboardOid={'your-dashboard-id'} />;
}
```

### Migration Steps

1. **Update imports**: Change all Compose SDK plugin-related imports to their custom widget equivalents
2. **Update type annotations**: Replace `PluginComponent` with `CustomWidgetComponent` and `PluginComponentProps` with `CustomWidgetComponentProps`
3. **Update hooks**: Replace `usePlugins()` with `useCustomWidgets()` and `useExecutePluginQuery()` with `useExecuteCustomWidgetQuery()`
4. **Update registration calls**: Replace `registerPlugin()` with `registerCustomWidget()`

The functionality remains the same - only the Compose SDK naming convention has changed, while adding support for [Angular](custom-widgets-angular.md) and [Vue](custom-widgets-vue.md). Custom widgets in Compose SDK still serve as replacements for Fusion plugins when displaying dashboards.


<!-- Source: guides/custom-widgets/custom-widgets-vue.md -->

d [Vue](custom-widgets-vue.md). Custom widgets in Compose SDK still serve as replacements for Fusion plugins when displaying dashboards.


<!-- Source: guides/custom-widgets/custom-widgets-vue.md -->
# Custom Widgets

> **Note**:
> This guide is for [<img src="../../img/vue-logo.png" height="14px" /> Vue](../../getting-started/quickstart-vue.md). For other frameworks, see the [<img src="../../img/react-logo.png" height="18px" style="vertical-align: text-bottom; padding-bottom: 3px" /> React](custom-widgets-react.md) and [<img src="../../img/angular-logo.png" height="18px" style="vertical-align: text-bottom; padding-bottom: 2px" /> Angular](custom-widgets-angular.md) guides.

This guide explains how to define your own custom widget component and register it in your application code, so that it will be automatically rendered (based on the corresponding widget type) when using the `DashboardById` component. Custom widgets in Compose SDK can be used to replace Fusion plugins when displaying dashboards.

**Note:** It is assumed that the application is [already configured correctly](../../getting-started/quickstart-vue.md) for use with Compose SDK.

replace Fusion plugins when displaying dashboards.

**Note:** It is assumed that the application is [already configured correctly](../../getting-started/quickstart-vue.md) for use with Compose SDK.

## Sample dashboard

The `histogramwidget` plugin is included with Sisense Fusion, so we'll be using it as our example. We'll start by creating a dashboard in Fusion, containing a single `histogramwidget` widget with `Sample ECommerce` as its data source.

![Dashboard in Fusion](../../img/plugins-guide/dashboard-in-fusion.png 'Dashboard in Fusion')

ard in Fusion, containing a single `histogramwidget` widget with `Sample ECommerce` as its data source.

![Dashboard in Fusion](../../img/plugins-guide/dashboard-in-fusion.png 'Dashboard in Fusion')

## Displaying the dashboard in your application

To display a dashboard using Compose SDK, we need the `oid` for the relevant dashboard. The simplest way to find this, is to copy the value from the end of the URL when viewing the dashboard in Fusion, e.g. `/app/main/dashboards/{dashboardOid}`.

The dashboard can be easily displayed using the `DashboardById` component, passing this value into the `dashboardOid` prop.

```vue
<template>
  <DashboardById :dashboardOid="'66f23d1b202c89002abd64ac'" />
</template>

<script setup>
import { DashboardById } from '@sisense/sdk-ui-vue';
</script>
```

Since Compose SDK does not support the `histogramwidget` plugin out of the box, it is expected that Compose SDK will display an error in place of the histogram widget.

![Dashboard in Compose SDK (no registered custom widget)](../../img/plugins-guide/dashboard-in-csdk-unregistered.png 'Dashboard in Compose SDK (no registered custom widget)')

In order to resolve this, we will explore how to define a custom widget component and register it with Compose SDK, so that it knows what to do when it encounters a `histogramwidget` plugin from Fusion.

rder to resolve this, we will explore how to define a custom widget component and register it with Compose SDK, so that it knows what to do when it encounters a `histogramwidget` plugin from Fusion.

## Defining a custom widget using Compose SDK

Before registering our custom widget, we first need to define a custom widget component that will replace the Fusion plugin. This component will:
1. Receive the props that Compose SDK will pass to our custom widget when rendering the `DashboardById` component
2. Run a data query using those props
3. Render a visualization with the results

Purely for the **simplicity** of this guide, we have chosen to define a custom widget component which renders a table of the query results. In reality, you would more likely define a Vue implementation of a histogram chart, or however else you wish to represent the Fusion plugin in your Compose SDK dashboard.

This guide also aims to demonstrate the flexibility of the `registerCustomWidget` interface - as long as you provide a component that matches the shape of [`CustomWidgetComponent`](../../modules/sdk-ui-vue/type-aliases/type-alias.CustomWidgetComponent.md), Compose SDK will render that component as a replacement for the designated Fusion plugin.

A note on the `dataOptions` prop that is passed to our component: For those familiar with the Fusion plugin / add-on architecture, `dataOptions` is the Compose SDK equivalent of `panels` on the [WidgetMetadata](https://developer.sisense.com/guides/customJs/jsApiRef/widgetClass/widget-metadata.html) object.

Compose SDK translates all widget metadata and filters to Compose SDK data structures (e.g. values inside [`dataOptions`](../../modules/sdk-ui-vue/type-aliases/type-alias.ChartDataOptions.md) are of type [`StyledColumn`](../../modules/sdk-ui-vue/interfaces/interface.StyledColumn.md) and [`StyledMeasureColumn`](../../modules/sdk-ui-vue/interfaces/interface.StyledMeasureColumn.md), the same types you'd expect for [`dataOptions`](../../modules/sdk-ui-vue/type-aliases/type-alias.ChartDataOptions.md) into the [`Chart`](../../modules/sdk-ui-vue/charts/class.Chart.md) component).

In the custom widget component, we can use the props directly with the `useExecuteCustomWidgetQuery` composable which runs a data query and applies some formatting on the results (defined by the `StyledColumn` information in `dataOptions`).

```vue
<template>
  <table v-if="data" style="margin: 20px;">
    <thead>
      <tr>
        <th v-for="(column, index) in data.columns" :key="index">
          {{ column.name }}
        </th>
      </tr>
    </thead>
    <tbody>
      <tr v-for="(row, rowIndex) in data.rows" :key="rowIndex">
        <td v-for="(cell, cellIndex) in row" :key="cellIndex">
          {{ cell.text }}
        </td>
      </tr>
    </tbody>
  </table>
</template>

<script setup>
import { defineComponent } from 'vue';
import { useExecuteCustomWidgetQuery } from '@sisense/sdk-ui-vue';

const props = defineProps({
  title: String,
  dataOptions: Object,
  filters: Array
});

const { data } = useExecuteCustomWidgetQuery(props);
</script>
```

If you prefer to work with the raw data without any formatting applied, you can use `extractDimensionsAndMeasures` with `useExecuteQuery` instead.

```vue
<script setup>
import { useExecuteQuery, extractDimensionsAndMeasures } from '@sisense/sdk-ui-vue';

const props = defineProps({
  title: String,
  dataOptions: Object,
  filters: Array
});

const { dimensions, measures } = extractDimensionsAndMeasures(props.dataOptions);
const { data } = useExecuteQuery({
  dimensions,
  measures,
  filters: props.filters,
});
</script>
```

Array
});

const { dimensions, measures } = extractDimensionsAndMeasures(props.dataOptions);
const { data } = useExecuteQuery({
  dimensions,
  measures,
  filters: props.filters,
});
</script>
```

## Registering the custom widget with Compose SDK

To register the custom widget, we need to use the `useCustomWidgets` composable and call `registerCustomWidget`.

```vue
<template>
  <DashboardById :dashboardOid="'66f4d4dd384428002ae0a21d'" />
</template>

<script setup>
import { onMounted } from 'vue';
import { DashboardById, useCustomWidgets } from '@sisense/sdk-ui-vue';
import ResultsTable from './ResultsTable.vue';

const { registerCustomWidget } = useCustomWidgets();
registerCustomWidget('histogramwidget', ResultsTable);

</script>
```

If we refresh our application, instead of seeing the error in place of the widget as before, we should now see something like this:

![Dashboard in Compose SDK (registered custom widget)](../../img/plugins-guide/dashboard-in-csdk-registered.png 'Dashboard in Compose SDK (registered custom widget)')

d now see something like this:

![Dashboard in Compose SDK (registered custom widget)](../../img/plugins-guide/dashboard-in-csdk-registered.png 'Dashboard in Compose SDK (registered custom widget)')

## Summary

Here's what we accomplished:
- Displayed an existing Fusion dashboard in our application by rendering a `DashboardById` component
- Created a Vue component that uses its props to execute a data query and display the results in a table
- Registered that table component as a custom widget to be shown in place of the `histogramwidget` Fusion plugin when it is rendered inside of a `DashboardById` component

Obviously, we didn't end up with a new histogram component in Vue (yet), but hopefully the simplicity of this guide gives you the tools you need to make that, or anything else, happen!


<!-- Source: guides/dashboards/index.md -->
# Embedded Dashboards

Alternative to iFrame and Embed SDK, Compose SDK now allows you (1) to embed an existing Fusion dashboard into your application, (2) to customize the dashboard to your specific needs, or (3) to compose a dashboard fully in code. These capabilities are available in React, Angular, and Vue.

<SectionIndex />


<!-- Source: guides/dashboards/guide-1-embed-fusion-dashboard.md -->
# 1 | Embed Fusion Dashboard

oard fully in code. These capabilities are available in React, Angular, and Vue.

<SectionIndex />


<!-- Source: guides/dashboards/guide-1-embed-fusion-dashboard.md -->
# 1 | Embed Fusion Dashboard

## Component `DashboardById`

To embed a Fusion dashboard into your application as-is, you can use component `DashboardById` available from the `sdk-ui-*` package. This method is the quickest and simplest, but it comes with limited customization options for the dashboard.

The following code examples and screenshots use the Sample ECommerce dashboard identified by OID pre-existing in a Sisense instance.

##### React

```ts
import { DashboardById } from '@sisense/sdk-ui';

const CodeExample = () => {
  return (
    <DashboardById dashboardOid='your-dashboard-oid'/>
  );
};

export default CodeExample;
```

##### Angular

```ts
import { Component } from '@angular/core';

@Component({
  selector: 'code-example',
  template: `
    <div style="width: 100vw;">
      <csdk-dashboard-by-id *ngIf="dashboardOid" [dashboardOid]="dashboardOid" />
    </div>
  `,
})
export class CodeExampleComponent {
  dashboardOid = 'your-dashboard-oid';
}
```

##### Vue
```ts
<script setup lang="ts">
import { DashboardById } from '@sisense/sdk-ui-vue';
import { ref } from 'vue';

const dashboardOid = ref<string>('your-dashboard-oid');
</script>
<template>
  <div style="width: 100vw"><DashboardById v-if="dashboardOid" :dashboardOid="dashboardOid" /></div>
</template>
```

![Embedded Sample ECommerce Dashboard](../../img/dashboard-guides/fusion-dashboard-light-theme.png 'Embedded Sample ECommerce Dashboard')

::: tip Note
Follow [this guide](../custom-widgets/index.md) to learn how to define your own custom widget component, and have it rendered in place of a corresponding Fusion widget plugin when using the `DashboardById` component.
:::

/custom-widgets/index.md) to learn how to define your own custom widget component, and have it rendered in place of a corresponding Fusion widget plugin when using the `DashboardById` component.
:::

## Simple customization

While `DashboardById` does not allow customizations, you can still use a `ThemeProvider` (React and Vue) or `ThemeService` (Angular) to apply a consistent look and feel to the dashboard elements including toolbar, widgets panel, and filters panel.

The following React code example renders the dashboard in dark mode:

```ts
import { DashboardById, ThemeProvider, getDefaultThemeSettings } from '@sisense/sdk-ui';

const CodeExample = () => {
  const darkTheme = getDefaultThemeSettings(true);

  return (
    <ThemeProvider theme={darkTheme}>
      <DashboardById dashboardOid='your-dashboard-oid'/>
    </ThemeProvider>
  );
};

export default CodeExample;
```

![Embedded Sample ECommerce Dashboard in Dark Mode](../../img/dashboard-guides/fusion-dashboard-dark-theme.png 'Embedded Sample ECommerce Dashboard in Dark Mode')


## Next Up

In this section you learned how to embed a Fusion dashboard using component `DashboardById`. In the next section, you'll see how to customize the elements of the embedded Fusion dashboard.

Go to the [next lesson](./guide-2-customize-fusion-dashboard.md).



<!-- Source: guides/dashboards/guide-2-customize-fusion-dashboard.md -->
# 2 | Customize Fusion Dashboard

dded Fusion dashboard.

Go to the [next lesson](./guide-2-customize-fusion-dashboard.md).



<!-- Source: guides/dashboards/guide-2-customize-fusion-dashboard.md -->
# 2 | Customize Fusion Dashboard

## Generic `Dashboard` Component

You can write a little more code to embed the dashboard with customizations. In the following example, we use a combination of the `useGetDashboardModel` hook and `Dashboard` component, in lieu of the `DashboardById` component.

##### React

```ts
import { Dashboard, dashboardModelTranslator, useGetDashboardModel } from '@sisense/sdk-ui';

const CodeExample = () => {
  // DashboardModel is the data representation of a Fusion dashboard in Compose SDK
  const { dashboard } = useGetDashboardModel({
    dashboardOid: 'your-dashboard-oid',
    includeFilters: true,
    includeWidgets: true,
  });

  if (!dashboard) {
    return null;
  }

  // DashboardProps is a set of properties for the generic Dashboard component
  const { title, widgets, layoutOptions, filters, styleOptions, widgetsOptions } =
    dashboardModelTranslator.toDashboardProps(dashboard);

  return (
    <Dashboard
      title={title}
      layoutOptions={layoutOptions}
      widgets={widgets}
      filters={filters}
      styleOptions={styleOptions}
      widgetsOptions={widgetsOptions}
    />
  );
};

export default CodeExample;
```

##### Angular

```ts
import { Component } from '@angular/core';
import {
  type DashboardProps,
  DashboardService,
  dashboardModelTranslator,
} from '@sisense/sdk-ui-angular';

@Component({
  selector: 'code-example',
  template: `
    <div style="width: 100vw">
      <csdk-dashboard
        *ngIf="dashboardProps"
        [title]="dashboardProps.title"
        [layoutOptions]="dashboardProps.layoutOptions"
        [widgets]="dashboardProps.widgets"
        [filters]="dashboardProps.filters"
        [defaultDataSource]="dashboardProps.defaultDataSource"
        [widgetsOptions]="dashboardProps.widgetsOptions"
      />
    </div>
  `,
})
export class CodeExampleComponent {
  dashboardProps: DashboardProps | null = null;

  constructor(private dashboardService: DashboardService) {}

  async ngOnInit(): Promise<void> {
    const dashboardModel = await this.dashboardService.getDashboardModel(
      '66fb233ae2c222003368dac1',
      { includeWidgets: true, includeFilters: true },
    );
    this.dashboardProps = dashboardModelTranslator.toDashboardProps(dashboardModel);
  }
}
```

##### Vue
```ts
<script setup lang="ts">
import { dashboardModelTranslator, useGetDashboardModel, Dashboard } from '@sisense/sdk-ui-vue';
import { computed } from 'vue';

const { dashboard } = useGetDashboardModel({
  dashboardOid: 'your-dashboard-oid',
  includeWidgets: true,
  includeFilters: true,
});

const dashboardProps = computed(() =>
  dashboard.value ? dashboardModelTranslator.toDashboardProps(dashboard.value) : null,
);
</script>
<template>
  <div style="width: 100vw">
    <Dashboard
      v-if="dashboardProps"
      :title="dashboardProps.title"
      :layoutOptions="dashboardProps.layoutOptions"
      :widgets="dashboardProps.widgets"
      :filters="dashboardProps.filters"
      :defaultDataSource="dashboardProps.defaultDataSource"
      :widgetsOptions="dashboardProps.widgetsOptions"
      :styleOptions="dashboardProps.styleOptions"
    />
  </div>
</template>
```

![Embedded Sample ECommerce Dashboard](../../img/dashboard-guides/fusion-dashboard-light-theme.png 'Embedded Sample ECommerce Dashboard')

As shown in the code, there is a clear separation between `DashboardModel` and `DashboardProps`.

In Compose SDK, `DashboardModel` is the data representation of a Fusion dashboard – in other words, metadata of a Fusion dashboard.

On the other hand, `DashboardProps` is a set of properties for the generic `Dashboard` component.

Following the design principle of Separation of Concerns, `DashboardProps` and `Dashboard` are no longer coupled to the `DashboardModel`.

It is still very simple to translate the `DashboardModel` to `DashboardProps` using the provided utilty function, `dashboardModelTranslator.toDashboardProps`, and you have access to all elements of the dashboard for manipulation, which we will demonstrate in the next example.

using the provided utilty function, `dashboardModelTranslator.toDashboardProps`, and you have access to all elements of the dashboard for manipulation, which we will demonstrate in the next example.

## Customize Embedded Fusion Dashboard

Here, we add a dashboard filter on the `Gender` dimension. We also customize the look of the charts by adding rounded corners for the bars.

Basically, a dashboard and its props are composed of existing building blocks in Compose SDK including `ChartWidget` and `*FilterTile`. Any APIs supported in chart widgets like `onBeforeRender`, `onDataPointClick` are also available for manipulation in `DashboardProps.widgets`.

##### React

```ts
import { Dashboard, dashboardModelTranslator, useGetDashboardModel } from '@sisense/sdk-ui';
import * as DM from './sample-ecommerce';
import { filterFactory } from '@sisense/sdk-data';

const CodeExample = () => {
  // DashboardModel is the data representation of a Fusion dashboard in Compose SDK
  const { dashboard } = useGetDashboardModel({
    dashboardOid: 'your-dashboard-oid',
    includeFilters: true,
    includeWidgets: true,
  });

  if (!dashboard) {
    return null;
  }

  // DashboardProps is a set of properties for the Dashboard component
  const { title, widgets, layoutOptions, filters, styleOptions, widgetsOptions } =
    dashboardModelTranslator.toDashboardProps(dashboard);

  // Add a filter to the dashboard filters
  const updatedFilters = [...filters, filterFactory.members(DM.Commerce.Gender, ['Male'])];

  // Customize the look of the chart widgets that are based on Highcharts
  const updatedWidgets = widgets.map((widget) => ({
    ...widget,
    onBeforeRender: (highchartsOptions: any) => {
      highchartsOptions.series.forEach((s: any) => {
        s.borderRadiusTopLeft = `10px`;
        s.borderRadiusTopRight = `10px`;
      });
      return highchartsOptions;
    },
  }));

  return (
    <Dashboard
      title={title}
      layoutOptions={layoutOptions}
      widgets={updatedWidgets}
      filters={updatedFilters}
      styleOptions={styleOptions}
      widgetsOptions={widgetsOptions}
    />
  );
};

export default CodeExample;
```

##### Angular

```ts
import { Component } from '@angular/core';
import {
  type DashboardProps,
  DashboardService,
  dashboardModelTranslator,
} from '@sisense/sdk-ui-angular';
import * as DM from './sample-ecommerce';
import { filterFactory } from '@sisense/sdk-data';

@Component({
  selector: 'code-example',
  template: `
    <div style="width: 100vw">
      <csdk-dashboard
        *ngIf="dashboardProps"
        [title]="dashboardProps.title"
        [layoutOptions]="dashboardProps.layoutOptions"
        [widgets]="dashboardProps.widgets"
        [filters]="dashboardProps.filters"
        [defaultDataSource]="dashboardProps.defaultDataSource"
        [widgetsOptions]="dashboardProps.widgetsOptions"
      />
    </div>
  `,
})
export class CodeExampleComponent {
  dashboardProps: DashboardProps | null = null;

  constructor(private dashboardService: DashboardService) {}

  async ngOnInit(): Promise<void> {
    const dashboardModel = await this.dashboardService.getDashboardModel(
      'your-dashboard-oid',
      { includeWidgets: true, includeFilters: true },
    );

    this.dashboardProps = dashboardModelTranslator.toDashboardProps(dashboardModel);

    const { filters, widgets } = this.dashboardProps;

    // Add a filter to the dashboard filters
    this.dashboardProps.filters = [
      ...(filters ?? []),
      filterFactory.members(DM.Commerce.Gender, ['Male']),
    ];

    // Customize the look of the chart widgets that are based on Highcharts
    this.dashboardProps.widgets = widgets.map((widget) => ({
      ...widget,
      onBeforeRender: (highchartsOptions: any) => {
        highchartsOptions.series.forEach((s: any) => {
          s.borderRadiusTopLeft = `10px`;
          s.borderRadiusTopRight = `10px`;
        });
        return highchartsOptions;
      },
    }));
  }
}
```

##### Vue
```ts
<script setup lang="ts">
import { filterFactory } from '@sisense/sdk-data';
import { dashboardModelTranslator, useGetDashboardModel, Dashboard } from '@sisense/sdk-ui-vue';
import * as DM from '../assets/sample-ecommerce-model';
import { computed } from 'vue';

const { dashboard } = useGetDashboardModel({
  dashboardOid: '66fb233ae2c222003368dac1',
  includeWidgets: true,
  includeFilters: true,
});

const dashboardProps = computed(() => {
  if (!dashboard.value) {
    return null;
  }

  const props = dashboardModelTranslator.toDashboardProps(dashboard.value);

  return {
    ...props,
    // Add a filter to the dashboard filters
    filters: [...props.filters, filterFactory.members(DM.Commerce.Gender, ['Male'])],
    // Customize the look of the chart widgets that are based on Highcharts
    widgets: props.widgets.map((widget) => ({
      ...widget,
      onBeforeRender: (highchartsOptions: any) => {
        highchartsOptions.series.forEach((s: any) => {
          s.borderRadiusTopLeft = `10px`;
          s.borderRadiusTopRight = `10px`;
        });
        return highchartsOptions;
      },
    })),
  };
});
</script>
<template>
  <div style="width: 100vw">
    <Dashboard
      v-if="dashboardProps"
      :title="dashboardProps.title"
      :layoutOptions="dashboardProps.layoutOptions"
      :widgets="dashboardProps.widgets"
      :filters="dashboardProps.filters"
      :defaultDataSource="dashboardProps.defaultDataSource"
      :widgetsOptions="dashboardProps.widgetsOptions"
      :styleOptions="dashboardProps.styleOptions"
    />
  </div>
</template>
```

![Embedded Sample ECommerce Dashboard with Customizations](../../img/dashboard-guides/fusion-dashboard-customized.png 'Embedded Sample ECommerce Dashboard with Customizations')


::: tip Note
Alternative to manipulating `DashboardProps.filters` directly, you can use dashboard helper functions available from each of the `sdk-ui-*` packages.
:::

hboard with Customizations')


::: tip Note
Alternative to manipulating `DashboardProps.filters` directly, you can use dashboard helper functions available from each of the `sdk-ui-*` packages.
:::


## Next Up

In this section you learned how to embed a Fusion dashboard and customize it to your specific needs using the `Dashboard` component. In the next section, you'll see how to compose a dashboard fully in code.

Go to the [next lesson](./guide-3-compose-dashboard-in-code.md).



<!-- Source: guides/dashboards/guide-3-compose-dashboard-in-code.md -->
# 3 | Compose Dashboard In Code

It’s time to detach ourselves from Fusion dashboards.

In the following examples, you'll learn how to programmatically create a dashboard based on the data fetched from Sisense using the generic `Dashboard` component — without relying on any pre-existing Fusion dashboards.

::: tip Note
The examples below assume that the app is already set up to connect to the Sample ECommerce data model in a Sisense instance using `SisenseContextProvider` – see [Quickstart guides](../../getting-started/index.md).

To keep the code concise, the examples are provided in React, but the same configurations can be adapted for Angular and Vue.
:::

rovider` – see [Quickstart guides](../../getting-started/index.md).

To keep the code concise, the examples are provided in React, but the same configurations can be adapted for Angular and Vue.
:::

## Create an Empty Dashboard

In this example, we'll start `dashboardProps` almost empty with just title and an empty array of WidgetProps.

##### React

```ts
import { Dashboard, DashboardProps, WidgetProps } from '@sisense/sdk-ui';
import { useMemo } from 'react';

const CodeExample = () => {
  // DashboardProps is a set of properties for the Dashboard component
  const dashboardProps: DashboardProps = useMemo(() => {
    const widgets: WidgetProps[] = [];

    return { title: 'Fabulous ECommerce Dashboard', widgets };
  }, []);

  return <Dashboard {...dashboardProps} />;
};

export default CodeExample;
```

![Empty Sample ECommerce Dashboard](../../img/dashboard-guides/generic-dashboard-empty.png 'Empty Sample ECommerce Dashboard')

<Dashboard {...dashboardProps} />;
};

export default CodeExample;
```

![Empty Sample ECommerce Dashboard](../../img/dashboard-guides/generic-dashboard-empty.png 'Empty Sample ECommerce Dashboard')

## Add a Chart Widget

Let's add a chart widget to the list of widgets. It is a simple indicator displaying Total Revenue.

##### React

```ts
import { Dashboard, DashboardProps, WidgetProps } from '@sisense/sdk-ui';
import * as DM from './sample-ecommerce';
import { useMemo } from 'react';
import { measureFactory } from '@sisense/sdk-data';

const CodeExample = () => {
  // DashboardProps is a set of properties for the Dashboard component
  const dashboardProps: DashboardProps = useMemo(() => {
    const widgets: WidgetProps[] = [
      {
        id: 'widget-1',
        widgetType: 'chart',
        chartType: 'indicator',
        title: 'Total Revenue',
        dataOptions: {
          value: [
            {
              column: measureFactory.sum(DM.Commerce.Revenue, 'Total Revenue').format('0,0$'),
            },
          ],
        },
      },
    ];

    return { title: 'Fabulous ECommerce Dashboard', widgets };
  }, []);

  return <Dashboard {...dashboardProps} />;
};

export default CodeExample;
```

![Dashboard with One Widget](../../img/dashboard-guides/generic-dashboard-one-chart-widget.png 'Dashboard with One Widget')

Let's take a closer look at `WidgetProps`:
- `id` is needed for layout and widget options.
- `widgetType` can be one of the four currently supported types: `chart`, `pivot`, `text`, and `plugin`.
- `filters` is not provided as the dashboard does not have any filters yet.
- `layoutOptions` helps to customize how `widgets` are laid out. If it is not provided, dashboard will use a simple vertical column layout by default.

This isn't a very interesting dashboard. Let’s improve this in the next example.

ze how `widgets` are laid out. If it is not provided, dashboard will use a simple vertical column layout by default.

This isn't a very interesting dashboard. Let’s improve this in the next example.

## Add Dashboard Filters, Other Widgets, and Set Up Layout

Below is the code for the same Sample Ecommerce dashboard created programatically.

##### React

```ts
import {
  Dashboard,
  DashboardProps,
  IndicatorStyleOptions,
  LineStyleOptions,
  NumberFormatConfig,
  ScatterStyleOptions,
  StackableStyleOptions,
  WidgetProps,
  WidgetsPanelColumnLayout,
} from '@sisense/sdk-ui';
import * as DM from './sample-ecommerce';
import { useMemo } from 'react';
import { Filter, filterFactory, measureFactory } from '@sisense/sdk-data';

const seriesToColorMap = {
  Female: '#00cee6',
  Male: '#9b9bd7',
  Unspecified: '#6eda55',
};

export const getIndicatorStyleOptions = (
  title: string,
  secondaryTitle = '',
): IndicatorStyleOptions => {
  return {
    indicatorComponents: {
      title: {
        shouldBeShown: true,
        text: title,
      },
      secondaryTitle: {
        text: secondaryTitle,
      },
      ticks: {
        shouldBeShown: true,
      },
      labels: {
        shouldBeShown: true,
      },
    },
    subtype: 'indicator/gauge',
    skin: 1,
  };
};

const scatterStyleOptions: ScatterStyleOptions = {
  xAxis: {
    logarithmic: true,
  },
  yAxis: {
    logarithmic: true,
  },
  height: 454,
};

const barStyleOptions: StackableStyleOptions = {
  subtype: 'bar/stacked',
  height: 454,
};

const numberFormat: NumberFormatConfig = {
  name: 'Numbers',
  decimalScale: 2,
  trillion: true,
  billion: true,
  million: true,
  kilo: true,
  thousandSeparator: true,
  prefix: false,
  symbol: '$',
};

const lineChartStyleOptions: LineStyleOptions = {
  subtype: 'line/spline',
  lineWidth: { width: 'bold' },
  yAxis: {
    title: { enabled: true, text: 'SALES' },
  },
  y2Axis: {
    title: { enabled: true, text: 'QUANTITY' },
  },
  markers: {
    enabled: true,
    fill: 'hollow',
  },
  height: 454,
};

const CodeExample = () => {
  // DashboardProps is a set of properties for the Dashboard component
  const dashboardProps: DashboardProps = useMemo(() => {
    const widgets: WidgetProps[] = [
      {
        id: 'widget-1',
        widgetType: 'chart',
        chartType: 'indicator',
        title: 'Total Revenue',
        dataOptions: {
          value: [
            {
              column: DM.Measures.SumRevenue,
              numberFormatConfig: numberFormat,
            },
          ],
          secondary: [],
          min: [measureFactory.constant(0)],
          max: [measureFactory.constant(125000000)],
        },
        styleOptions: getIndicatorStyleOptions('Total Revenue'),
      },
      {
        id: 'widget-2',
        widgetType: 'chart',
        chartType: 'indicator',
        title: 'Total Units Sold',
        dataOptions: {
          value: [DM.Measures.Quantity],
          secondary: [],
          min: [measureFactory.constant(0)],
          max: [measureFactory.constant(250000)],
        },
        styleOptions: getIndicatorStyleOptions('Total Units Sold'),
      },
      {
        id: 'widget-3',
        widgetType: 'chart',
        chartType: 'indicator',
        title: 'Total Sales',
        dataOptions: {
          value: [measureFactory.countDistinct(DM.Commerce.VisitID)],
          secondary: [],
          min: [measureFactory.constant(0)],
          max: [measureFactory.constant(100000)],
        },
        styleOptions: getIndicatorStyleOptions('Total Sales'),
      },
      {
        id: 'widget-4',
        widgetType: 'chart',
        chartType: 'indicator',
        title: 'Total Brands',
        dataOptions: {
          value: [measureFactory.countDistinct(DM.Brand.BrandID)],
          secondary: [],
          min: [measureFactory.constant(0)],
          max: [measureFactory.constant(2500)],
        },
        styleOptions: getIndicatorStyleOptions('Total Brands'),
      },
      {
        id: 'widget-5',
        widgetType: 'chart',
        chartType: 'line',
        title: 'REVENUE vs.UNITS SOLD',
        dataOptions: {
          category: [
            {
              column: DM.Commerce.Date.Months,
              dateFormat: 'yy-MM',
            },
          ],
          value: [
            DM.Measures.SumRevenue,
            {
              column: DM.Measures.Quantity,
              showOnRightAxis: true,
              chartType: 'column',
            },
          ],
          breakBy: [],
        },
        styleOptions: lineChartStyleOptions,
      },
      {
        id: 'widget-6',
        widgetType: 'chart',
        chartType: 'pie',
        title: 'GENDER BREAKDOWN',
        dataOptions: {
          category: [DM.Commerce.Gender],
          value: [DM.Measures.SumRevenue],
        },
        filters: [filterFactory.members(DM.Commerce.Gender, ['Male', 'Female'])],
        styleOptions: scatterStyleOptions,
      },
      {
        id: 'widget-7',
        widgetType: 'chart',
        chartType: 'pie',
        title: 'AGE RANGE BREAKDOWN',
        dataOptions: {
          category: [DM.Commerce.AgeRange],
          value: [DM.Measures.SumRevenue],
        },
        filters: [filterFactory.members(DM.Commerce.Gender, ['Male', 'Female'])],
        styleOptions: scatterStyleOptions,
      },
      {
        id: 'widget-8',
        widgetType: 'chart',
        chartType: 'scatter',
        title: 'TOP CATEGORIES BY REVENUE, UNITS SOLD AND GENDER',
        dataOptions: {
          x: DM.Measures.SumRevenue,
          y: DM.Measures.Quantity,
          breakByPoint: DM.Category.Category,
          breakByColor: DM.Commerce.Gender,
          size: DM.Measures.SumCost,
          seriesToColorMap,
        },
        filters: [
          filterFactory.members(DM.Commerce.Gender, ['Male', 'Female']),
          filterFactory.topRanking(DM.Category.Category, DM.Measures.SumRevenue, 10),
        ],
        styleOptions: scatterStyleOptions,
      },
      {
        id: 'widget-9',
        widgetType: 'chart',
        chartType: 'bar',
        title: 'TOP 3 CATEGORIES BY REVENUE AND AGE',
        dataOptions: {
          category: [DM.Commerce.AgeRange],
          value: [DM.Measures.SumRevenue],
          breakBy: [DM.Category.Category],
        },
        filters: [filterFactory.topRanking(DM.Category.Category, DM.Measures.SumRevenue, 3)],
        styleOptions: barStyleOptions,
      },
    ];

    const filters: Filter[] = [
      filterFactory.members(DM.Commerce.Date.Years, ['2013-01-01T00:00:00']),
      filterFactory.members(DM.Country.Country, []),
      filterFactory.greaterThan(DM.Commerce.Revenue, 0),
    ];

    const widgetsPanelLayout: WidgetsPanelColumnLayout = {
      columns: [
        {
          widthPercentage: 20,
          rows: [
            { cells: [{ widthPercentage: 100, widgetId: 'widget-1' }] },
            { cells: [{ widthPercentage: 100, widgetId: 'widget-2' }] },
            { cells: [{ widthPercentage: 100, widgetId: 'widget-3' }] },
            { cells: [{ widthPercentage: 100, widgetId: 'widget-4' }] },
          ],
        },
        {
          widthPercentage: 40,
          rows: [
            { cells: [{ widthPercentage: 100, widgetId: 'widget-5' }] },
            {
              cells: [
                { widthPercentage: 50, widgetId: 'widget-6' },
                { widthPercentage: 50, widgetId: 'widget-7' },
              ],
            },
          ],
        },
        {
          widthPercentage: 40,
          rows: [
            { cells: [{ widthPercentage: 100, widgetId: 'widget-8' }] },
            { cells: [{ widthPercentage: 100, widgetId: 'widget-9' }] },
          ],
        },
      ],
    };

    return {
      title: 'Fabulous ECommerce Dashboard',
      widgets,
      filters,
      layoutOptions: { widgetsPanel: widgetsPanelLayout },
    };
  }, []);

  return <Dashboard {...dashboardProps} />;
};

export default CodeExample;
```

![Sample ECommerce Dashboard In Code](../../img/dashboard-guides/generic-dashboard-ecommerce.png 'Sample ECommerce Dashboard In Code')

The dashboard is fully interactive. Cross filtering and drilldown work as expected.

At first glance, this code may seem like a significant leap from the previous example. However, upon closer inspection, you'll notice there's no advanced coding or complex algorithms involved. It's simply a standard configuration of dashboard elements: 9 widgets, 3 dashboard filters, and a widget layout.
The Compose SDK handles all the internal wiring and interactions for you.

involved. It's simply a standard configuration of dashboard elements: 9 widgets, 3 dashboard filters, and a widget layout.
The Compose SDK handles all the internal wiring and interactions for you.


## Learn More

In this section you learned how to compose a dashboard fully in code using the `Dashboard` component.

To deepen your understanding, check out [the API Doc](../../modules/index.md) and [Compose SDK Playground](https://www.sisense.com/developers/playground/?example=fusion-assets%2Ffusion-dashboard).



<!-- Source: guides/drilldown/index.md -->

e API Doc](../../modules/index.md) and [Compose SDK Playground](https://www.sisense.com/developers/playground/?example=fusion-assets%2Ffusion-dashboard).



<!-- Source: guides/drilldown/index.md -->
# Drilldown

Drilling down on a chart allows your users to see more detailed data by selecting a dimension to drill down on. This enables them to examine complex datasets in a more manageable and intuitive way.

With Compose SDK you can create a drilldown experience using the charts in the `sdk-ui-*` modules:

![Drilldown with Compose SDK chart](../../img/drilldown-guide/csdk-context-menu.png 'Drilldown with Compose SDK chart')

You can also create a drilldown experience using third party charts:

![Drilldown with third party chart](../../img/drilldown-guide/plotly-csdk-context-menu.png 'Drilldown with third party chart')

With both types of charts, you can use the built in drilldown-related components to show drilldown context menus and drilldown breadcrumbs:

![Drilldown with Compose SDK components](../../img/drilldown-guide/csdk-components.png 'Drilldown with Compose SDK components')

Or you can provide your own custom context menu and breadcrumbs components:

![Drilldown with custom components](../../img/drilldown-guide/custom-components.png 'Drilldown with custom components')

If you're new to drilldown charts, start by learning how to create a [simple drilldown chart](./guide-1-simple-drilldown.md).

<SectionIndex />


<!-- Source: guides/drilldown/guide-1-simple-drilldown.md -->

e new to drilldown charts, start by learning how to create a [simple drilldown chart](./guide-1-simple-drilldown.md).

<SectionIndex />


<!-- Source: guides/drilldown/guide-1-simple-drilldown.md -->
# 1 | Simple Drilldown Chart

To create a drilldown experience on a Compose SDK chart, you need to wrap the chart inside a `<DrilldownWidget>`.

The `<DrilldownWidget>` component allows you to specify which dimensions can be used to drill down on and adds the following functionality to your chart:

- A context menu for initiating drilldown actions
- Breadcrumbs that allow for navigating the drilldown hierarchy and clearing the current drilldown selection
- Filters for the drilldown operation

## Chart

To demonstrate how to add a drilldown experience to a Compose SDK chart, let's start with this simple column chart:

![Column chart](../../img/drilldown-guide/plain-chart.png 'Column chart')

```ts
<Chart
  chartType="column"
  dataSet={DM.DataSource}
  dataOptions={{
    category: [DM.Commerce.AgeRange],
    value: [measureFactory.sum(DM.Commerce.Revenue)],
  }}
/>
```

'Column chart')

```ts
<Chart
  chartType="column"
  dataSet={DM.DataSource}
  dataOptions={{
    category: [DM.Commerce.AgeRange],
    value: [measureFactory.sum(DM.Commerce.Revenue)],
  }}
/>
```

## Drilldown Widget

Once you have a chart that you want to add a drilldown experience to, you need to wrap the chart in a `<DrilldownWidget>` and provide it with:

- `initialDimension`: The initial dimension that the wrapped chart will show
- `drilldownDimensions`: List of drilldown options that users can choose to drill down on

The widget then provides the chart with:

- Drilldown results in the form of the `drilldownDimension` and `drilldownFilters` to apply to the chart
- Functions for handling the selection of data points (`onDataPointsSelected`) and the showing of the drilldown context menu (`onContextMenu`)

For example, wrapping a chart in a `<DrilldownWidget>` may look something like this:

```ts
<DrilldownWidget
  initialDimension={DM.Commerce.AgeRange}
  drilldownDimensions={
    [DM.Commerce.Gender,
    DM.Commerce.Condition,
    DM.Category.Category
  ]}
>
  {({ drilldownDimension, drilldownFilters, onDataPointsSelected, onContextMenu }) => (
      <Chart
      // Chart properties go here
      />
  )}
</DrilldownWidget>
```

Here you can see that the `initialDimension` is set to be **Age Range**, as it was in the chart before adding drilldown functionality. Also, the `drilldownDimensions` is set to a list of the drilldown options. In this case, users can drill down on the **Gender**, **Condition**, and **Category** dimensions.

drilldown functionality. Also, the `drilldownDimensions` is set to a list of the drilldown options. In this case, users can drill down on the **Gender**, **Condition**, and **Category** dimensions.

## Apply to Chart

After wrapping the chart in a `<DrilldownWidget>`, you need to pass the control to the wrapper so the chart can be modified based on drilldown actions.

That means you need to:

- Switch out the chart's static `category` for the `drilldownDimension` from the `<DrilldownWidget>`
- Add a `filters` property to the chart with the value being the `drilldownFilters` from the `<DrilldownWidget>`
- Use the `onDataPointsSelected` and `onContextMenu` functions from the `<DrilldownWidget>` to provide the wrapper with the selected data and context menu position (typically, this is done using chart event callbacks, such as `onDataPointsSelected` and `onDataPointClick`)

That should leave you with code that looks something like this:

```ts
<DrilldownWidget
  initialDimension={DM.Commerce.AgeRange}
  drilldownDimensions={[
    DM.Commerce.Gender,
    DM.Commerce.Condition,
    DM.Category.Category
  ]}
>
  {({ drilldownFilters, drilldownDimension, onDataPointsSelected, onContextMenu }) => (
    <Chart
      chartType="column"
      dataSet={DM.DataSource}
      dataOptions={{
        category: [drilldownDimension],
        value: [measureFactory.sum(DM.Commerce.Revenue)],
      }}
      filters={drilldownFilters}
      onDataPointsSelected={(points: DataPoint[], nativeEvent: MouseEvent) => {
        onDataPointsSelected(points, nativeEvent);
        onContextMenu({
          left: nativeEvent.clientX,
          top: nativeEvent.clientY,
        });
      }}
      onDataPointClick={(point: DataPoint, nativeEvent: MouseEvent) => {
        onDataPointsSelected([point], nativeEvent);
        onContextMenu({
          left: nativeEvent.clientX,
          top: nativeEvent.clientY,
        });
      }}
    />
  )}
</DrilldownWidget>
```

onDataPointsSelected([point], nativeEvent);
        onContextMenu({
          left: nativeEvent.clientX,
          top: nativeEvent.clientY,
        });
      }}
    />
  )}
</DrilldownWidget>
```

## Results

At this point, you have a chart that you can drill down on. You can start the drilldown process by either clicking a a data point or selecting a number of data points.

For example, if you click on the 35-44 age range, you get a context menu with the drilldown category options you set in your code.

![Drilldown context menu](../../img/drilldown-guide/csdk-context-menu.png 'Drilldown context menu')

If you then click on a drilldown category, such as **Condition**, the chart updates accordingly. Note the breadcrumbs above the chart that indicate the current drilldown status.

![Drill down condition](../../img/drilldown-guide/drilldown-condition.png 'Drill down condition')

You can then continue to drill down. For example, you can click on the **Used** column and drill down on **Category**.

![Drill down again](../../img/drilldown-guide/csdk-components.png 'Drill down again')

As you drill down, the breadcrumbs keep track of the actions you've performed. You can use the breadcrumbs to go back up some of your drill hierarchy or to clear all the drilling down to return to the original chart.

the breadcrumbs keep track of the actions you've performed. You can use the breadcrumbs to go back up some of your drill hierarchy or to clear all the drilling down to return to the original chart.

## Next Up

In this section you learned how to create a drilldown experience using Compose SDK components. In the next section, you'll see how to customize the look and feel of a drilldown chart by providing custom context menu.

Go to the [next lesson](./guide-2-custom-context-menu.md).

SDK components. In the next section, you'll see how to customize the look and feel of a drilldown chart by providing custom context menu.

Go to the [next lesson](./guide-2-custom-context-menu.md).

## Full Code

For your convenience, here is the full code for the simple drilldown chart:

```ts
import * as DM from '../sample-ecommerce';
import { Chart, DataPoint, DrilldownWidget } from '@sisense/sdk-ui';
import { measureFactory } from '@sisense/sdk-data';

export const DrilldownChart = () => {
  return (
    <DrilldownWidget
        initialDimension={DM.Commerce.AgeRange}
        drilldownDimensions={[DM.Commerce.Gender, DM.Commerce.Condition, DM.Category.Category]}
    >
      {({ drilldownDimension, drilldownFilters, onDataPointsSelected, onContextMenu }) => (
        <Chart
          chartType="column"
          dataSet={DM.DataSource}
          dataOptions={{
            category: [drilldownDimension],
            value: [measureFactory.sum(DM.Commerce.Revenue)],
          }}
          filters={drilldownFilters}
          onDataPointsSelected={(points: DataPoint[], nativeEvent: MouseEvent) => {
            onDataPointsSelected(points, nativeEvent);
            onContextMenu({
                left: nativeEvent.clientX,
                top: nativeEvent.clientY,
            });
          }}
          onDataPointClick={(point: DataPoint, nativeEvent: MouseEvent) => {
            onDataPointsSelected([point], nativeEvent);
            onContextMenu({
                left: nativeEvent.clientX,
                top: nativeEvent.clientY,
            });
          }}
          styleOptions={{ width: 750 }}
        />
      )}
    </DrilldownWidget>
  );
};
```



<!-- Source: guides/drilldown/guide-2-custom-context-menu.md -->

lientY,
            });
          }}
          styleOptions={{ width: 750 }}
        />
      )}
    </DrilldownWidget>
  );
};
```



<!-- Source: guides/drilldown/guide-2-custom-context-menu.md -->
# 2 | Custom Context Menu

In this section, you'll learn how to customize the look and feel of a drilldown chart by providing a custom context menu.

You can use any components of you choose as the basis for a custom context menu. In this guide, we use the [Material UI Menu component](https://mui.com/material-ui/react-menu/) as the basis for the custom context menu.

## Props

A context menu has the following properties:

- `position`: The position at which to display the context menu
- `itemsSections`: The items for the context menu, organized by section (more on this below)
- `children`: Additional content, if there is any, to be displayed at the bottom of the context menu
- `closeContextMenu`: Function to run when the context menu is closed

So the first step in creating a custom context menu is to create a component with these properties:

```ts
export const CustomContextMenu = ({
  position,
  itemSections,
  children,
  closeContextMenu
}: ContextMenuProps) => {
    // Component code goes here
};
```

omponent with these properties:

```ts
export const CustomContextMenu = ({
  position,
  itemSections,
  children,
  closeContextMenu
}: ContextMenuProps) => {
    // Component code goes here
};
```

## Menu Component

Next, you can start to apply some of these properties in your component code:

- Use `position` to determine if the context menu is open and to place it in the correct location
- Use `closeContextMenu` to determine what happens when the context menu is closed
- Place any children that are passed through to the component at the bottom of your context menu

Using the `<Menu>` component, your code would look something like this:

```ts
const open = !!position;

return (
  <Menu
    anchorReference="anchorPosition"
    anchorPosition={position ?? { left: 0, top: 0 }}
    open={open}
    onClose={closeContextMenu}
  >
    {/* Menu items go here */}
    {children}
  </Menu>
);
```

nchorReference="anchorPosition"
    anchorPosition={position ?? { left: 0, top: 0 }}
    open={open}
    onClose={closeContextMenu}
  >
    {/* Menu items go here */}
    {children}
  </Menu>
);
```

## Menu Content

Finally, you need to add the drilldown options to the context menu. Do that by applying the information in `itemSections` to the contents of the `<Menu>` component.

The `itemSections` array contains information about the current drilldown dimension and the remaining possible dimensions to drill down on.

For example, consider the chart we discussed in the previous section where the `initialDimension` is **Age Range** and the `drilldownDimensions` are **Gender**, **Condition**, and **Category**. Before drilling down on the chart, the `itemSections` array contains the following:

```ts
[
  {
      sectionTitle: 'AgeRange',
  },
  {
      sectionTitle: 'Drill',
      items: [
        { caption: 'Gender' },
        { caption: 'Condition' },
        { caption: 'Category' }
      ],
  },
];
```

Then after drilling down on **Condition**, the `itemSections` array contains the following:

```ts
[
    {
        sectionTitle: 'Condition',
    },
    {
        sectionTitle: 'Drill',
        items: [
          { caption: 'Gender' },
          { caption: 'Category' }
        ],
    },
];
```

Now that you understand the contents of the `itemSections` array, you can decide how you want to use it to populate your menu options. You can of course choose to do this however you like.

Here, we ignore the current drilldown dimension and just create a menu item for each remaining drill category.

Each menu item contains an icon and the caption of the drilldown dimension. When the item is clicked, the context menu is closed and the `onClick` function from the item object is called to perform the drill down.

```ts
{!!itemSections &&
  !!(itemSections as Array<{ items: Array<object> }>)[1].items.length &&
  itemSections?.map(({ items }) =>
    items?.map((item) => (
      <MenuItem
        key={item.key ?? item.caption}
        onClick={() => {
          closeContextMenu();
          item.onClick?.();
        }}
      >
        <ListItemIcon>
          <MoveDown fontSize='small' />
        </ListItemIcon>
        <ListItemText> {item.caption}</ListItemText>
      </MenuItem>
    ))
  )
}
```

If there are no remaining drilldown dimensions, you may want to create a single menu item alerting the user that they cannot drill down any further.

```ts
{(!itemSections ||
  !(itemSections as Array<{ items: Array<object> }>)[1].items.length) && (
  <MenuItem key={'none'}>
    <ListItemText> {'Cannot drill down any further'}</ListItemText>
  </MenuItem>
)}
```

tions ||
  !(itemSections as Array<{ items: Array<object> }>)[1].items.length) && (
  <MenuItem key={'none'}>
    <ListItemText> {'Cannot drill down any further'}</ListItemText>
  </MenuItem>
)}
```

## Apply

Once you have a custom context menu component, you need to apply it to your chart. All you need to do is to add a `config` property to the `<DrilldownWidget>` that wraps the chart. Within the `config` object, set the `contextMenuComponent` property to the component you created.

```ts
<DrilldownWidget
  initialDimension={DM.Commerce.AgeRange}
  drilldownDimensions={[
    DM.Commerce.Gender,
    DM.Commerce.Condition,
    DM.Category.Category,
  ]}
  config={{
    contextMenuComponent: CustomContextMenu,
  }}
>
```

## Results

At this point, your custom context menu is ready for action. When you select a data point in your chart, you should see a context menu that looks like this:

![Custom context menu](../../img/drilldown-guide/custom-context-menu.png 'Custom context menu')

## Next Up

In this section you learned how to create a custom context menu. In the next section, you'll continue to customize the drilldown experience by creating a custom breadcrumbs component.

Go to the [next lesson](./guide-3-custom-breadcrumbs.md).

custom context menu. In the next section, you'll continue to customize the drilldown experience by creating a custom breadcrumbs component.

Go to the [next lesson](./guide-3-custom-breadcrumbs.md).

## Full Code

For your convenience, here is the full code for our custom context menu component:

```ts
import Menu from '@mui/material/Menu';
import ListItemText from '@mui/material/ListItemText';
import ListItemIcon from '@mui/material/ListItemIcon';
import MenuItem from '@mui/material/MenuItem';
import MoveDown from '@mui/icons-material/MoveDown';
import { ContextMenuProps } from '@sisense/sdk-ui';

export const CustomContextMenu = ({
  position,
  itemSections,
  children,
  closeContextMenu,
}: ContextMenuProps) => {
  const open = !!position;

  return (
    <Menu
      anchorReference='anchorPosition'
      anchorPosition={position ?? { left: 0, top: 0 }}
      open={open}
      onClose={closeContextMenu}
    >
      {!!itemSections &&
        !!(itemSections as Array<{ items: Array<object> }>)[1].items.length &&
        itemSections?.map(({ items }) =>
          items?.map((item) => (
            <MenuItem
              key={item.key ?? item.caption}
              onClick={() => {
                closeContextMenu();
                item.onClick?.();
              }}
            >
              <ListItemIcon>
                <MoveDown fontSize='small' />
              </ListItemIcon>
              <ListItemText> {item.caption}</ListItemText>
            </MenuItem>
          ))
        )}
      {(!itemSections ||
        !(itemSections as Array<{ items: Array<object> }>)[1].items.length) && (
        <MenuItem key={'none'}>
          <ListItemText> {'Cannot drill down any further'}</ListItemText>
        </MenuItem>
      )}
      {children}
    </Menu>
  );
};
```



<!-- Source: guides/drilldown/guide-3-custom-breadcrumbs.md -->

ListItemText> {'Cannot drill down any further'}</ListItemText>
        </MenuItem>
      )}
      {children}
    </Menu>
  );
};
```



<!-- Source: guides/drilldown/guide-3-custom-breadcrumbs.md -->
# 3 | Custom Breadcrumbs

In this section, you'll learn how to customize the look and feel of our drilldown chart by providing custom breadcrumbs.

Similar to the custom context menu, when building a custom breadcrumbs component, you can use whatever components you choose. In this guide, we use the [Material UI Breadcrumbs component](https://mui.com/material-ui/api/breadcrumbs/) as the basis for our custom breadcrumbs.

## Props

A breadcrumbs component has the following properties:

- `currentDimension`: The current drilldown dimension
- `filtersDisplayValues`: List of applied drilldown filters (more on this below)
- `clearDrilldownSelections`: Function to run when the clear button is clicked
- `sliceDrilldownSelections`: Function to run when a breadcrumb is clicked

So the first step in creating custom breadcrumbs is to create a component with these properties:

```ts
export const CustomBreadCrumbs = ({
  currentDimension,
  filtersDisplayValues,
  clearDrilldownSelections,
  sliceDrilldownSelections,
}: DrilldownBreadcrumbsProps) => {
  // Component code goes here
};
```

nst CustomBreadCrumbs = ({
  currentDimension,
  filtersDisplayValues,
  clearDrilldownSelections,
  sliceDrilldownSelections,
}: DrilldownBreadcrumbsProps) => {
  // Component code goes here
};
```

## Breadcrumbs Component

The breadcrumb component we build in this guide uses [Material UI Chip](https://mui.com/material-ui/api/chip/) components as the individual breadcrumbs. Again, you can choose to use another component if you want.

Here, whenever breadcrumbs are shown, there will be two chips on either end of the breadcrumbs.

- The first chip contains a button to clear the drilldown and return the chart to its original state
- The last chip displays the current drilldown dimension

For example, here you can see the clear button in the first chip and the current drilldown dimension, **Category** as the last chip:

![Special breadcrumb chips](../../img/drilldown-guide/breadcrumb-chips.png 'Special breadcrumb chips')

To create these chips, you can start to apply some of the properties mentioned above in your component code.

- Use `filterDisplayValues` to define which breadcrumbs to show
- Use `clearDrilldownSelections` to return the chart to its original state when the clear button in the first chip is clicked
- Use `currentDimension` to build the last drilldown chip

```ts
if (!filtersDisplayValues.length) return null;

return (
  <Breadcrumbs>
    <Chip label="Clear" key="Clear" color="error" onClick={clearDrilldownSelections} icon={<CancelIcon />} />
    {/* Code for additional chips goes here */}
    <Chip label={`${currentDimension.name || ''} (All)`} key="All" color="default" icon={<MoveDown />} />
  </Breadcrumbs>
);
```

={<CancelIcon />} />
    {/* Code for additional chips goes here */}
    <Chip label={`${currentDimension.name || ''} (All)`} key="All" color="default" icon={<MoveDown />} />
  </Breadcrumbs>
);
```

## Drilldown Chips

Now you can fill in the remaining chips for the current drilldown hierarchy.

You know how many chips to create based on the number of elements in the `filterDisplayValue` array. Each element in the array is an array itself of a drilldown level. When a single data point is selected for drilling down, the drilldown level is an array with a single element. If more than one data point is selected for drilling down, the drilldown level is an array containing all the selected points.

For example, consider the chart we discussed in previous sections where the `initialDimension` is **Age range** and the `drilldownDimensions` are **Gender**, **Condition**, and **Category**. If a user initially selects the **25-34** and **35-44** age ranges, drills down on category, and the selects the **New** category to drill down by age, the `filterDisplayValue` array will look like this:

```ts
[['25-34', '35-44'], ['New']];
```

Here two similar types of chips are used to display the values in the `filtersDisplayValue` array. In both types of chips, a value from `filtersDisplayValue` is used to show which dimensions have been selected for drilling down. If the value contains multiple category selections, you can choose how to display those. Here we choose to separate them with a pipe character (`|`).

The difference between the two types of chips is whether they are clickable or not. Clickable chips allow users to go back up the drilldown hierarchy. You go back up the hierarchy using the `sliceDrilldownSelections` callback.

Here you can see the two types of chips. The clickable chips are blue and the others are gray. Clickable chips where it makes sense to move back up the drilldown hierarchy. Non-clickable chips are used in all other cases.

![Breadcrumb chip types](../../img/drilldown-guide/breadcrumb-chips.png 'Breadcrumb chip types')

To create these chips, check the location of the current chip in `filtersDisplayValues` and then build the appropriate type of chip:

```ts
{
  filtersDisplayValues.map((displayValue, i) => {
    const isClickable = i < filtersDisplayValues.length - 1;
    return isClickable ? (
      <Chip
        label={displayValue.join(' | ')}
        key={displayValue.join(' | ')}
        onClick={() => sliceDrilldownSelections(i + 1)}
        color="primary"
        icon={<MoveDown />}
      />
    ) : (
      <Chip
        label={displayValue.join(' | ')}
        key={displayValue.join(' | ')}
        color="default"
        icon={<MoveDown />}
      />
    );
  });
}
```

own />}
      />
    ) : (
      <Chip
        label={displayValue.join(' | ')}
        key={displayValue.join(' | ')}
        color="default"
        icon={<MoveDown />}
      />
    );
  });
}
```

## Apply

Now that you've created a custom breadcrumbs component, you can apply it to a chart. All you need to do is to add a property in the `<DrilldownWidget>` `config`. Within the `config` object, set the `breadcrumbsMenuComponent` property to the component you created.

In the code below, we also choose to detach the breadcrumbs from the chart component so that we can place it wherever we want.

To do so:

- Set `isBreadcrumbsDetached` to `true`
- Add `breadcrumbsComponent` to the destructuring of the `<DrilldownWidget>` return value
- Place the `breadcrumbsComponent` where you want it to display

For example, the following code shows the breadcrumbs component right below the chart:

```ts
<DrilldownWidget
  initialDimension={DM.Commerce.AgeRange}
  drilldownDimensions={[
    DM.Commerce.Gender,
    DM.Commerce.Condition,
    DM.Category.Category,
  ]}
  config={{
    isBreadcrumbsDetached: true,
    breadcrumbsComponent: CustomBreadCrumbs,
  }}
>
  {({
      drilldownFilters,
      drilldownDimension,
      onDataPointsSelected,
      onContextMenu,
      breadcrumbsComponent,
    }) => (
      <>
        <Chart
          // Chart code here ...
        />
        {breadcrumbsComponent}
        </>
  )}
    </DrilldownWidget>
  );
}
```

Note that you can also detach the default breadcrumbs component and place it wherever you want using the same process.

{breadcrumbsComponent}
        </>
  )}
    </DrilldownWidget>
  );
}
```

Note that you can also detach the default breadcrumbs component and place it wherever you want using the same process.

## Results

At this point, your breadcrumbs component is ready for action. When you drill down on your chart, you should see a breadcrumbs component that looks like this:

![Custom breadcrumbs](../../img/drilldown-guide/custom-breadcrumbs.png 'Custom breadcrumbs')

## Next Up

In this section you learned how to create a breadcrumbs component. In the next section, you'll see how to create a drilldown experience on a third party chart.

Go to the [next lesson](./guide-4-third-party-chart.md).

learned how to create a breadcrumbs component. In the next section, you'll see how to create a drilldown experience on a third party chart.

Go to the [next lesson](./guide-4-third-party-chart.md).

## Full Code

For your convenience, here is the full code for our custom breadcrumbs component:

```ts
import { Breadcrumbs, Chip } from '@mui/material';
import { DrilldownBreadcrumbsProps } from '@sisense/sdk-ui';
import CancelIcon from '@mui/icons-material/Cancel';
import MoveDown from '@mui/icons-material/MoveDown';
import { CollectionsBookmark } from '@mui/icons-material';

export const CustomBreadCrumbs = ({
  currentDimension,
  filtersDisplayValues,
  clearDrilldownSelections,
  sliceDrilldownSelections,
}: DrilldownBreadcrumbsProps) => {
  if (!filtersDisplayValues.length) return null;

  return (
    <Breadcrumbs>
      <Chip
        label="Clear"
        key="Clear"
        color="error"
        onClick={clearDrilldownSelections}
        icon={<CancelIcon />}
      />
      {filtersDisplayValues.map((displayValue, i) => {
        const isClickable = i < filtersDisplayValues.length - 1;
        return isClickable ? (
            <Chip
                label={displayValue.join(' | ')}
                key={displayValue.join(' | ')}
                onClick={() => sliceDrilldownSelections(i + 1)}
                color="primary"
                icon={<MoveDown />}
            />
        ) : (
            <Chip
                label={displayValue.join(' | ')}
                key={displayValue.join(' | ')}
                color="default"
                icon={<MoveDown />}
            />
        );
      })}
      <Chip
        label={`${currentDimension.name || ''} (All)`}
        key="All"
        color="default"
        icon={<MoveDown />}
      />
    </Breadcrumbs>
  );
};
```



<!-- Source: guides/drilldown/guide-4-third-party-chart.md -->

ion.name || ''} (All)`}
        key="All"
        color="default"
        icon={<MoveDown />}
      />
    </Breadcrumbs>
  );
};
```



<!-- Source: guides/drilldown/guide-4-third-party-chart.md -->
# 4 | Third Party Drilldown Chart

In this section, you'll how to drill down when using a 3rd party charting library. In this guide, we'll switch out our Compose SDK chart with a chart from [Plotly.js](https://plotly.com/javascript/).

n this section, you'll how to drill down when using a 3rd party charting library. In this guide, we'll switch out our Compose SDK chart with a chart from [Plotly.js](https://plotly.com/javascript/).

## Plotly Wrapper

To get started, you need to build a wrapper around a Plotly chart component so that you can populate it with data retrieved by Compose SDK.

:::tip Learn more
Here, we briefly discuss this process. To learn more about using a third party chart with Compose SDK, see the [External Charts](../charts/guide-external-charts.md) section of the [Charts Guide](../charts/).
:::

In addition to being able to handle the data we provide it with, the wrapper needs to be able to handle data point selection and display a context menu when needed.

So the first step in creating the wrapper is to create a component with the following properties:

```ts
type Props = {
  rawData: QueryResultData,
  onDataPointsSelected: DataPointsEventHandler,
  onContextMenu: (menuPosition: MenuPosition) => void,
};

export const PlotlyBarChart: React.FC<Props> = ({ rawData, onDataPointsSelected, onContextMenu }) => {
  // Chart code goes here
};
```

Next, you to keep track of the data points selected for drilling down. To do so, create a state variable:

```ts
const [selectedCategories, setSelectedCategories] = useState<string[]>([]);
```

And you also need to store the data for the current state of the drilldown chart as well as the data converted to the format we need for the Plotly chart. To do so create some memoized variables:

```ts
const data = useMemo(
  () =>
    rawData.rows.map(([category, value]) => ({
      category: category.data as string,
      value: value.data as string | number,
    })),
  [rawData.rows]
);

const trace = useMemo(() => {
  setSelectedCategories([]);
  return generateTrace(data, rawData.columns[1].name);
}, [data, rawData.columns]);
```

Note that the `generateTrace()` function is used to reformat the data for the Plotly chart. That function looks like this:

```ts
const generateTrace = (
  data: { [key: string]: Datum }[],
  name: string
): Partial<Plotly.ScatterData> => ({
  type: 'bar',
  x: data.map((d) => d.category),
  y: data.map((d) => d.value),
  name: name,
});
```

Next, you need to handle clicks to open the drilldown context menu. To do so, use the `useEffect()` hook to create an event listener that uses the `onContextMenu` function from the component's props:

```ts
useEffect(() => {
  const handleContextMenu = (event: MouseEvent) => {
    event.preventDefault();
    if (!selectedCategories.length) return;
    onContextMenu({ left: event.clientX, top: event.clientY });
  };

  document.addEventListener('contextmenu', handleContextMenu);

  return () => {
    document.removeEventListener('contextmenu', handleContextMenu);
  };
}, [selectedCategories, onDataPointsSelected, onContextMenu]);
```

After that, you need to handle user selection of data points in the chart. To do so, use the `useCallback()` hook to set the `selectedCategories` state variable:

```ts
const handleSelection = useCallback(
  (event: PlotSelectionEvent) => {
    if (event.points.length) {
      const internalSelectedCategories = event.points.map((point) => {
        const clickedIndex = point.pointNumber;
        return data[clickedIndex].category;
      });
      setTimeout(
        () => setSelectedCategories(internalSelectedCategories),
        250
      );
      setTimeout(
        () =>
          onDataPointsSelected(
            internalSelectedCategories.map((category) => ({
              value: undefined,
              categoryValue: category,
              categoryDisplayValue: category,
              seriesValue: undefined,
            })),
            event as unknown as MouseEvent
          ),
        250
      );
    }
  },
  [data, onDataPointsSelected]
);
```

Finally, with all that done, you can apply it to the Plotly `<Plot>` component:

```ts
return (
  <Plot
    data={[trace]}
    layout={{
      datarevision: Date.now(),
    }}
    onSelected={handleSelection}
  />
);
```

When you put all the above code together, it looks like this:

```ts
import { useCallback, useEffect, useMemo, useState } from 'react';
import { QueryResultData } from '@sisense/sdk-data';
import Plot from 'react-plotly.js';
import { Datum, PlotSelectionEvent } from 'plotly.js';
import { DataPointsEventHandler, MenuPosition } from '@sisense/sdk-ui';

type Props = {
  rawData: QueryResultData;
  onDataPointsSelected: DataPointsEventHandler;
  onContextMenu: (menuPosition: MenuPosition) => void;
};

const generateTrace = (
  data: { [key: string]: Datum }[],
  name: string
): Partial<Plotly.ScatterData> => ({
  type: 'bar',
  x: data.map((d) => d.category),
  y: data.map((d) => d.value),
  name: name,
});

export const PlotlyBarChart: React.FC<Props> = ({
  rawData,
  onDataPointsSelected,
  onContextMenu,
}) => {
  const [selectedCategories, setSelectedCategories] = useState<string[]>([]);

  const data = useMemo(
    () =>
      rawData.rows.map(([category, value]) => ({
        category: category.data as string,
        value: value.data as string | number,
      })),
    [rawData.rows]
  );

  const trace = useMemo(() => {
    setSelectedCategories([]);
    return generateTrace(data, rawData.columns[1].name);
  }, [data, rawData.columns]);

  useEffect(() => {
    const handleContextMenu = (event: MouseEvent) => {
      event.preventDefault();
      if (!selectedCategories.length) return;
      onContextMenu({ left: event.clientX, top: event.clientY });
    };

    document.addEventListener('contextmenu', handleContextMenu);

    return () => {
      document.removeEventListener('contextmenu', handleContextMenu);
    };
  }, [selectedCategories, onDataPointsSelected, onContextMenu]);

  const handleSelection = useCallback(
    (event: PlotSelectionEvent) => {
      if (event.points.length) {
        const internalSelectedCategories = event.points.map((point) => {
          const clickedIndex = point.pointNumber;
          return data[clickedIndex].category;
        });
        setTimeout(
          () => setSelectedCategories(internalSelectedCategories),
          250
        );
        setTimeout(
          () =>
            onDataPointsSelected(
              internalSelectedCategories.map((category) => ({
                value: undefined,
                categoryValue: category,
                categoryDisplayValue: category,
                seriesValue: undefined,
              })),
              event as unknown as MouseEvent
            ),
          250
        );
      }
    },
    [data, onDataPointsSelected]
  );

  return (
    <Plot
      style={{ width: '700px', height: '450px' }}
      data={[trace]}
      layout={{
        datarevision: Date.now(),
      }}
      onSelected={handleSelection}
    />
  );
};

```

n (
    <Plot
      style={{ width: '700px', height: '450px' }}
      data={[trace]}
      layout={{
        datarevision: Date.now(),
      }}
      onSelected={handleSelection}
    />
  );
};

```

## Apply Drilldown Widget

Now that you have a Plotly chart properly wrapped, you can further wrap it in a `<DrilldownWidget>` component to add the drilldown functionality. To do so, you work exactly the same way as you would when wrapping a Compose SDK chart.

Here, since you're already using a custom chart, we'll also use the custom context menu and breadcrumbs from the previous sections. But if you want, you can use the Compose SDK components with your third party chart instead.

```ts
export const PlotlyDrilldownChart = () => {
  return (
    <DrilldownWidget
      initialDimension={DM.Commerce.AgeRange}
      drilldownDimensions={[
        DM.Commerce.Gender,
        DM.Commerce.Condition,
        DM.Category.Category
      ]}
      config={{
        isBreadcrumbsDetached: true,
        contextMenuComponent: CustomContextMenu,
        breadcrumbsComponent: CustomBreadCrumbs,
      }}
    >
      {/* Query and chart code go here */}
    </DrilldownWidget>
  );
};
```

Next, you need to execute a query to get the data for the third party chart. To do so, use the `<ExecuteQuery>` component. The properties of `<ExecuteQuery>` look a lot like the properties of the Compose SDK `<Chart>` from the beginning of this guide since they are both doing the same things under the hood to retrieve data.

Once again, in the `<ExecuteQuery>` we use the `drilldownDimension` and `drilldownFilters` to define which data we want to query for:

```ts
<ExecuteQuery
  dataSource={DM.DataSource}
  dimensions={[drilldownDimension]}
  measures={[measureFactory.sum(DM.Commerce.Revenue)]}
  filters={drilldownFilters}
>
  {({ data }) => {
    if (data) {
      return {
        /* Chart code goes here */
      };
    }
  }}
</ExecuteQuery>
```

All that's left to do now is to pass the retrieved data to your wrapped third party chart:

```ts
<PlotlyBarChart
  rawData={data}
  onContextMenu={onContextMenu}
  onDataPointsSelected={onDataPointsSelected}
/>
```

When you put all the above code together, it looks like this:

```ts
import * as DM from '../sample-ecommerce';
import { DrilldownWidget, ExecuteQuery } from '@sisense/sdk-ui';
import { measureFactory } from '@sisense/sdk-data';
import { CustomContextMenu } from './CustomContextMenu';
import { CustomBreadCrumbs } from './CustomBreadCrumbs';
import { PlotlyBarChart } from './PlotlyBarChart';

export const PlotlyDrilldownChart = () => {
  return (
    <DrilldownWidget
      initialDimension={DM.Commerce.AgeRange}
      drilldownDimensions={[
        DM.Commerce.Gender,
        DM.Commerce.Condition,
        DM.Category.Category
      ]}
      config={{
          isBreadcrumbsDetached: true,
          contextMenuComponent: CustomContextMenu,
          breadcrumbsComponent: CustomBreadCrumbs,
      }}
    >
      {({
        drilldownFilters,
        drilldownDimension,
        onDataPointsSelected,
        onContextMenu,
        breadcrumbsComponent
      }) => (
        <ExecuteQuery
          dataSource={DM.DataSource}
          dimensions={[drilldownDimension]}
          measures={[measureFactory.sum(DM.Commerce.Revenue)]}
          filters={drilldownFilters}
        >
          {({ data }) => {
            if (data) {
              return (
                <>
                  <PlotlyBarChart
                    rawData={data}
                    onContextMenu={onContextMenu}
                    onDataPointsSelected={onDataPointsSelected}
                  />
                  {breadcrumbsComponent}
                </>
              );
            }
          }}
        </ExecuteQuery>
      )}
    </DrilldownWidget>
  );
};
```

ted}
                  />
                  {breadcrumbsComponent}
                </>
              );
            }
          }}
        </ExecuteQuery>
      )}
    </DrilldownWidget>
  );
};
```

## Results

At this point, your custom third party chart is ready for action. When you select data points and drill down, your chart should look something like this:

![Third party drilldown chart](../../img/drilldown-guide/third-party.png 'Third party drilldown chart')



================================================================================
# Tutorials

Step-by-step tutorials for building with Compose SDK
================================================================================


<!-- Source: tutorials/index.md -->
# Tutorials

Here you'll find tutorials that will walk you through building your first projects with Compose SDK.

<SectionIndex />


<!-- Source: tutorials/tutorial-charts/index.md -->
# Tutorial

In this tutorial, we’ll walk you through the steps of creating your first project with Compose SDK. We’ll work with charts and learn several ways to customize them. After completing this tutorial, you’ll have the fundamental skills necessary to start your own Compose SDK projects.

ith Compose SDK. We’ll work with charts and learn several ways to customize them. After completing this tutorial, you’ll have the fundamental skills necessary to start your own Compose SDK projects.

## What you'll learn

Along the way, you’ll learn how to:

- Setup a new project to work with Compose SDK
- Work with chart data from a Sisense instance
- Filter and highlight the chart data
- Use callbacks to customize the look and behavior of your charts
- Dynamically change the contents and layout a chart

## What you'll build

While developing our project, we’ll focus on functionality and try to minimize any code that will distract from that goal. So, while what we build might not look too pretty, it will be packed with features that you can apply to lots of different situations.

When done, we’ll have built a page that includes two charts. The charts use the Sample Retail data model from a Sisense instance. The top chart shows sales revenue per product category. The bottom chart also shows sales revenue per product category, but broken down by either product color, country region, or team manager.

We’ll build the first chart so that you can highlight certain data using toggle buttons or by clicking on data in the chart. Highlighting data in the top chart changes which data is displayed in the bottom chart.

We’ll also add the option to change the chart type from a column chart to bar chart.

![Tutorial result](../../img/tutorial/0-end-product.png 'Tutorial result')

ta is displayed in the bottom chart.

We’ll also add the option to change the chart type from a column chart to bar chart.

![Tutorial result](../../img/tutorial/0-end-product.png 'Tutorial result')

## Get started

Let's get started by setting up a Compose SDK project. Go to [Lesson 1](./lesson1.md).


<!-- Source: tutorials/tutorial-charts/lesson1.md -->
# Lesson 1 | Setup

In this lesson you’ll learn how to set up a new Compose SDK project and display your first chart in that project.

## Prerequisites

Before getting started, you’ll need:

- Node.js version 16 or higher
- npm

You’ll also need access to a Sisense instance with:

- The Sample Retail data source (you may need to go into the Sample Retail data model and unhide some of the columns that are hidden by default)
- An [API Token](../../getting-started/authentication-security.md#api-token) you can use to query with
- [CORS settings](../../getting-started/authentication-security.md#set-up-cors) that allow requests from `http://localhost:5173`, the URL that Vite serves your project on locally

n use to query with
- [CORS settings](../../getting-started/authentication-security.md#set-up-cors) that allow requests from `http://localhost:5173`, the URL that Vite serves your project on locally

## Project Code

You can follow along with this tutorial, writing the code as you go, to build the project on your own. You can also find the code for the tutorial project in a [GitHub repo](https://github.com/sisense/compose-sdk-charts-tutorial).

The tutorial repo is structured with a number of branches, each branch contains the code as it should be at a number of natural stopping points along the way of building the project. We’ll point out the stopping points when we reach them. The main branch of the repository contains the code for the finished project.

To work with the code from the repository:

1. Fork the repo
1. Run `npm install` to install all dependencies
1. Rename the `env.local.example` file to `env.local`
1. In the `env.local` file, enter the URL and API Token you’ll use to connect to your Sisense instance
1. Run `npm run dev`

From here on, we’ll assume that you’re writing the code on your own. But always know that you can use the code from the project if you get stuck, to skip ahead, or if you’re just too lazy to write the code yourself. Don’t worry, we won’t tell anybody.

de on your own. But always know that you can use the code from the project if you get stuck, to skip ahead, or if you’re just too lazy to write the code yourself. Don’t worry, we won’t tell anybody.

## Create a project

Let’s start by creating a React project and installing dependencies. We’ll use Vite to create a new project.

1. Navigate to the directory where you want to create your project
1. Run `npm create vite@latest`
1. Name your project `compose-sdk-charts-tutorial` when prompted
1. Select `React` as the framework
1. Select `TypeScript` as the variant
1. Run `cd compose-sdk-charts-tutorial` to navigate to your project directory
1. Run `npm install` to install your project and dependencies
1. Run `npm i @sisense/sdk-ui @sisense/sdk-data` to install Sisense packages

## Generate data model

Next we’ll generate a TypeScript representation of the Sample Retail data model. We’ll use this in our code when we need to refer to the data model in the Sisense instance.

You can generate a data model TypeScript file using the Compose SDK CLI tool.

To generate the data model:

1. Create a folder in the `src` directory of you project named `models`
1. Run the following command

```sh
npx @sisense/sdk-cli@latest get-data-model --token <api-token> --output src/models/sample-retail.ts --dataSource "Sample Retail" --url <your-instance-url>
```

Be sure to replace the placeholders with your API token and the URL of your Sisense instance.

-token> --output src/models/sample-retail.ts --dataSource "Sample Retail" --url <your-instance-url>
```

Be sure to replace the placeholders with your API token and the URL of your Sisense instance.

## Add a context provider

Now we can start writing our first bit of code.

Since most of our Compose SDK functionality needs access to a Sisense instance, the first thing we need to do is set up that access with `<SisenseContextProvider>`. There are a number of places you can choose to add it. Here, we’ll add the provider in `main.tsx`.

In `main.tsx`, import the `SisenseContextProvider` from the `sdk-ui` module:

```ts
import { SisenseContextProvider } from '@sisense/sdk-ui';
```

Wrap the `<App>` component with a `<SisenseContextProvider>` like this:

```ts
<SisenseContextProvider
  url={import.meta.env.VITE_APP_SISENSE_URL}
  token={import.meta.env.VITE_APP_SISENSE_TOKEN}
>
  <App />
</SisenseContextProvider>
```

This will read the Sisense instance URL and API Token from an `.env`, so let’s add that file now.

1. Create a file named `.env.local` in your project’s root directory
1. Add a `VITE_APP_SISENSE_URL` variable and set its value to your Sisense instance’s URL
1. Add a `VITE_APP_SISENSE_TOKEN` variable and set it value to your API Token

Your `.env.local` file should look something like this:

```
VITE_APP_SISENSE_URL="http://myinstanceurl/"
VITE_APP_SISENSE_TOKEN="OiJhbGJeyciIUzI1..."
```

ariable and set it value to your API Token

Your `.env.local` file should look something like this:

```
VITE_APP_SISENSE_URL="http://myinstanceurl/"
VITE_APP_SISENSE_TOKEN="OiJhbGJeyciIUzI1..."
```

## Add a chart

Finally, with all the setup out of the way we can add our first chart to our project.

In the `App.tsx` file, import the `<Chart>` component, the `measureFactory` namespace, and the TypeScript representation of the Sample Retail data model that we created earlier.

Note: From here on in we won’t mention imports anymore. Just know that you’ll need to add the appropriate imports as we continue to add code to our project.

```ts
import { Chart } from '@sisense/sdk-ui';
import { measureFactory } from '@sisense/sdk-data';
import * as DM from './models/sample-retail';
```

Then, replace the contents of the `App()` function with the following code to create a chart.

```ts
return (
  <Chart
    dataSet={DM.DataSource}
    chartType={'column'}
    dataOptions={{
        category: [DM.DimProducts.CategoryName],
        value: [measureFactory.sum(DM.Fact_Sale_orders.OrderRevenue)],
    }}
    styleOptions={{
        width: 1000,
        height: 400,
    }}
  />
);
```

This is our first chart, so let’s take a minute to understand what this code does.

---

First we add a chart component to our app.

```ts
<Chart
//...
/>
```

---

Inside the chart component we set the chart’s data set as the data source of the Sample Retail data model we imported.

```ts
dataSet={DM.DataSource}
```

---

We also set the chart’s type to be a column chart.

```ts
chartType={'column'}
```

---

Then, we set the data options. For this chart we’re getting the sum of sales order revenue categorized by product categories.

```ts
dataOptions={{
  category: [DM.DimProducts.CategoryName],
  value: [measureFactory.sum(DM.Fact_Sale_orders.OrderRevenue)],
}}
```

Notice how we’re using the imported data model again. This lets us conveniently refer to the attributes in our data model. Here we also use a measure function to perform an aggregation on one of our attributes to create a value for our chart.

---

And finally, we set some basic style options to define the size of the chart.

```ts
styleOptions={{
  width: 1000,
  height: 400,
}}
```

one of our attributes to create a value for our chart.

---

And finally, we set some basic style options to define the size of the chart.

```ts
styleOptions={{
  width: 1000,
  height: 400,
}}
```

## Run

Use the `npm run dev` command to get your project up and running so you can see it in action.
Navigate to http://localhost:5173 in a browser to see your first chart. It should look like this:

![First chart](../../img/tutorial/1-first-chart.png 'First chart')

::: tip
The code up until this point can be found in branch [1-setup](https://github.com/sisense/compose-sdk-charts-tutorial/tree/1-setup).
:::

## Up next

Great job creating your first chart. In the next lesson you’ll learn about different ways to show data in a chart. [Go to Lesson 2](./lesson2.md).


<!-- Source: tutorials/tutorial-charts/lesson2.md -->
# Lesson 2 | Chart data

In this lesson you’ll learn how to add more data to your chart. You’ll learn to work with the axes and labels to better indicate what data your chart is showing. You’ll also learn to group the data in a chart.

## Duplicate chart

Let’s begin by duplicating our current chart. Since we’ll now have two components in your return statement, make sure to wrap them in a React fragment.

At this point your code should look something like this, which should cause you to see two of the same chart on the page:

```ts
return (
  <>
    <Chart
      // Chart details here
    />
    <Chart
      // Chart details here
    />
  </>
);
```

e this, which should cause you to see two of the same chart on the page:

```ts
return (
  <>
    <Chart
      // Chart details here
    />
    <Chart
      // Chart details here
    />
  </>
);
```

## Multiple values

On the first chart, let’s add a second value in addition to the total sale order revenue. You might have noticed that both the `category` and `value` properties are arrays. That’s because we can have multiple categories and multiple values.

In this case, we want to add the total sale order quantity as a value. To do that, all we need to do is use a measure function to create a new value and add it to the `dataOptions.value` array. Each of the values in the array are `MeasureColumn` types.

```ts
dataOptions={{
  category: [DM.DimProducts.CategoryName],
  value: [
    measureFactory.sum(DM.Fact_Sale_orders.OrderRevenue),
    measureFactory.sum(DM.Fact_Sale_orders.OrderQty),
  ],
}}
```

If you take a look at your charts, you’ll see something a bit strange. The sale order quantity data doesn’t seem to show up.

![Chart with multiple values](../../img/tutorial/2-multiple-values.png 'Chart with multiple values')

But if you have a keen eye, you might have noticed that the top chart’s columns are now narrower than they were before and the order quantity was added to the chart’s legend.

This should tip us off as to the problem here. The quantities are showing up, but they’re being measured on the same scale as the revenue. Since sales revenue is many times greater than sales quantity, the quantity is too small to be seen.

here. The quantities are showing up, but they’re being measured on the same scale as the revenue. Since sales revenue is many times greater than sales quantity, the quantity is too small to be seen.

## Styled columns

To remedy this situation, we can add a second Y-axis for the quantity. We’ll do this by adding a `StyledMeasureColumn` for our second measure. Doing this lets us add the option to show the second value on an additional Y-axis, which appears on the right side of the chart.

```ts
dataOptions={{
  category: [DM.DimProducts.CategoryName],
  value: [
    measureFactory.sum(DM.Fact_Sale_orders.OrderRevenue),
    {
      column: measureFactory.sum(DM.Fact_Sale_orders.OrderQty),
      showOnRightAxis: true,
    },
  ],
}}
```

That should give you something that looks like this:

![Chart with second Y-axis](../../img/tutorial/2-styled-column.png 'Chart with second Y-axis')

showOnRightAxis: true,
    },
  ],
}}
```

That should give you something that looks like this:

![Chart with second Y-axis](../../img/tutorial/2-styled-column.png 'Chart with second Y-axis')

## Labels

Okay, that’s already a bit better because we can see the quantity data. But it’s still not crystal clear as to which Y-axis belongs to which set of values. And while we’re at it, we can clean up the names of the values in the legend.

We can do this quite easily. First we’ll clean up the legend by adding a name when we create our measures. We’ll do this both times we call the `measureFactory.sum()` function.

```ts
dataOptions={{
  category: [DM.DimProducts.CategoryName],
  value: [
    measureFactory.sum(DM.Fact_Sale_orders.OrderRevenue, 'Total Revenue'),
    {
      column: measureFactory.sum(
        DM.Fact_Sale_orders.OrderQty,
        'Total Order Quantity'
      ),
      showOnRightAxis: true,
    },
  ],
}}
```

And we can add labels to the Y-axes using style options.

```ts
styleOptions={{
  width: 1000,
  height: 400,
  yAxis: { title: { enabled: true, text: 'Revenue' } },
  y2Axis: { title: { enabled: true, text: 'Quantity' } },
}}
```

Now you should have a chart that looks like this, including clear axes labels and a cleaned up legend.

![Chart with labels](../../img/tutorial/2-labels.png 'Chart with labels')

::: tip
The code up until this point can be found in branch [2a-chart-data](https://github.com/sisense/compose-sdk-charts-tutorial/tree/2a-chart-data).
:::

utorial/2-labels.png 'Chart with labels')

::: tip
The code up until this point can be found in branch [2a-chart-data](https://github.com/sisense/compose-sdk-charts-tutorial/tree/2a-chart-data).
:::

## Break by

Now let’s turn our attention to the bottom chart on the page. Let’s break down each of the categories in the chart by color.

To do so, all we need to do is add the `dataOptions.breakBy` property to the chart with the attribute we want to break on.

You know the drill by now. We use the imported data model to get the attribute and wrap it in an array.

```ts
dataOptions={{
  category: [DM.DimProducts.CategoryName],
  value: [measureFactory.sum(DM.Fact_Sale_orders.OrderRevenue)],
  breakBy: [DM.DimProducts.Color],
}}
```

That should give you a chart that looks like this:

![Chart with break by](../../img/tutorial/2-break-by.png 'Chart with break by')

_orders.OrderRevenue)],
  breakBy: [DM.DimProducts.Color],
}}
```

That should give you a chart that looks like this:

![Chart with break by](../../img/tutorial/2-break-by.png 'Chart with break by')

## Color map

Our chart is looking pretty good except for the incongruity between the column colors and the product colors they’re representing. It would probably be better for blue products to be represented by blue columns instead of purple ones.

We can easily fix this using a series-to-color map. This map does exactly what its name implies. It maps series of data to colors on a chart. In our case, we want each of our product colors to be represented by a corresponding hex color in the chart.

We can do that by adding a `seriesToColorMap` object to our `dataOptions`, where the object’s properties are the series we broke our data by and their values are corresponding color hex codes or [named colors](https://developer.mozilla.org/en-US/docs/Web/CSS/Reference/Values/named-color)::

```ts
dataOptions={{
  category: [DM.DimProducts.CategoryName],
  value: [measureFactory.sum(DM.Fact_Sale_orders.OrderRevenue)],
  breakBy: [DM.DimProducts.Color],
  seriesToColorMap: {
    Black: '#1b1b1b',
    Blue: '#0000cd',
    Gold: '#fcc200',
    Red: '#ce2029',
    Silver: '#acacac',
    Yellow: '#eee600'
  },
}}
```

Now our chart should look like this, with the colors matching:

![Chart with color map](../../img/tutorial/2-series-to-color.png 'Chart with color map')

::: tip
The code up until this point can be found in branch [2b-chart-data](https://github.com/sisense/compose-sdk-charts-tutorial/tree/2b-chart-data).
:::

ries-to-color.png 'Chart with color map')

::: tip
The code up until this point can be found in branch [2b-chart-data](https://github.com/sisense/compose-sdk-charts-tutorial/tree/2b-chart-data).
:::

## Up next

By now, you should feel pretty comfortable populating charts with data. In the next lesson you’ll learn how to filter and highlight the chart data. [Go to Lesson 3](./lesson3.md).


<!-- Source: tutorials/tutorial-charts/lesson3.md -->
# Lesson 3 | Filters & Highlights

In this lesson you’ll learn how to filter and highlight data in charts. You’ll learn to work with pre-built filtering components and to build your own filtering experiences.

Let’s start our filtering journey by filtering our charts based on product categories. We’ll do that first by using the pre-built filtering components and then later using our other components.

Before we do that, let’s revert our top chart to only show the sale order revenue, since that’s the only information we’ll be using going forward.

```ts
<Chart
  dataSet={DM.DataSource}
  chartType={'column'}
  dataOptions={{
    category: [DM.DimProducts.CategoryName],
    value: [
      measureFactory.sum(
        DM.Fact_Sale_orders.OrderRevenue,
        'Total Revenue'
      )
    ],
  }}
  styleOptions={{
    width: 1000,
    height: 400,
  }}
/>
```

oryName],
    value: [
      measureFactory.sum(
        DM.Fact_Sale_orders.OrderRevenue,
        'Total Revenue'
      )
    ],
  }}
  styleOptions={{
    width: 1000,
    height: 400,
  }}
/>
```

## Filtering preparation

Before we get to adding any components, let’s set the groundwork for how our filters will work.

To start, we need to add a couple of variables to keep track of our filters. We use a state variable to get and set the category we’re going to filter on. We also use a memoized array to hold the list of filters we’re currently filtering on.

```ts
const [categoryFilter, setCategoryFilter] = useState<Filter | null>(null);
const chartFilters = useMemo(
  () => (categoryFilter ? [categoryFilter] : []),
  [categoryFilter]
);
```

This is a common pattern to use when working with filters. In our case, we’re using only one filter criteria, but this pattern can be extended to using multiple filter criteria. In that case you would add a new state variable for each additional filter criteria and build the single memoized array accordingly.

We’ll start without any filters set, but we could just as easily use our state variable to set an initial filter when the page loads.

ilter criteria and build the single memoized array accordingly.

We’ll start without any filters set, but we could just as easily use our state variable to set an initial filter when the page loads.

## Filter tiles

Now we can add a filter tile to let users change the chart filters. This isn’t going to look too pretty, but let’s just add it like this for now.

```ts
<MemberFilterTile
  title={'Category'}
  dataSource={DM.DataSource}
  attribute={DM.DimProducts.CategoryName}
  filter={categoryFilter}
  onChange={setCategoryFilter}
/>
```

---

We start by giving the filter tile a title so users know what the tile will be filtering on.

```ts
title={'Category'}
```

---

Next, we connect the filter tile to the data source and the attribute it’s going to get its filter criteria from.

```ts
dataSource={DM.DataSource}
attribute={DM.DimProducts.CategoryName}
```

---

Then, we set the filter tile’s current filter. The filter tile itself is showing the category names, so it needs to know which ones are currently filtered and which ones are not.

```ts
filter = { categoryFilter };
```

---

Finally, we set what happens when a user changes the filter criteria using the filter tile. In this case we want to call the function that updates our state variable.

```ts
onChange = { setCategoryFilter };
```

et what happens when a user changes the filter criteria using the filter tile. In this case we want to call the function that updates our state variable.

```ts
onChange = { setCategoryFilter };
```

## Chart filter

The last step is to set our chart filter. To do that all we need to do is set the chart’s `filters` property to the variable holding our filters.

First, let’s do that only on the top chart. So, the top chart, should look like this:

```ts
<Chart
  dataSet={data}
  chartType={'column'}
  dataOptions={{
    category: [DM.DimProducts.CategoryName],
    value: [
      measureFactory.sum(
        DM.Fact_Sale_orders.OrderRevenue,
        'Total Revenue'
      )
    ],
  }}
  filters={chartFilters}
  styleOptions={{
    width: 1000,
    height: 400,
  }}
/>
```

Now you can use the filter tile and see how it filters the top chart.

![Chart with filter tile](../../img/tutorial/3-filter-tile.png 'Chart with filter tile')

## Filtering multiple charts

You can also filter more than one chart using the same filter tiles.

In our case, since all the groundwork is already set, all we need to do is add a `filters` property to the second chart that uses the same filters variable.

```ts
filters = {chartFilters}
```

After adding that code, when you use the filter tile to set a filter, it filters both charts at the same time.

![Two charts with filter](../../img/tutorial/3-double-filter.png 'Two charts with filter')

r adding that code, when you use the filter tile to set a filter, it filters both charts at the same time.

![Two charts with filter](../../img/tutorial/3-double-filter.png 'Two charts with filter')

## Highlighting

Highlighting works similarly to filtering. In fact, we can use just about everything we’ve built to add filtering to our charts to add highlighting instead. You create a highlight by applying a filter. Just keep in mind that when highlighting you can only use filters where the filter attribute matches the grouping of the chart.

In our case, let’s change the filtering in the top chart to highlight instead. To do so, all we need to do is change the `filters` property to a `highlights` property. So now our top chart looks like this:

```ts
<Chart
  dataSet={DM.DataSource}
  chartType={'column'}
  dataOptions={{
    category: [DM.DimProducts.CategoryName],
    value: [
      measureFactory.sum(
        DM.Fact_Sale_orders.OrderRevenue,
        'Total Revenue'
      )
    ],
  }}
  highlights={chartFilters}
  styleOptions={{
    width: 1000,
    height: 400,
  }}
/>
```

After changing that code, when you use the filter tile to set a filter, it highlights in the top chart and filters in the bottom chart.

![Charts with highlight and filter](../../img/tutorial/3-highlight-filter.png 'Charts with highlight and filter')

::: tip
The code up until this point can be found in branch [3a-filters-and-highlights](https://github.com/sisense/compose-sdk-charts-tutorial/tree/3a-filters-and-highlights).
:::

ight and filter')

::: tip
The code up until this point can be found in branch [3a-filters-and-highlights](https://github.com/sisense/compose-sdk-charts-tutorial/tree/3a-filters-and-highlights).
:::

## Custom filtering UI

Now that we’ve seen how to build filtering and highlighting using filter tiles, let’s see what we can do so without the pre-built components.

Of course, filtering is not dependent on the UI of your application. You can perform filtering for all sorts of reasons without any UI at all. But for now, let’s allow our users to filter using a UI, but use a UI of our choosing.

For our UI components, let’s use [Material UI](https://mui.com/material-ui/getting-started/). We’ll need to begin by installing some packages:

```sh
npm install @mui/material @emotion/react @emotion/styled
```

Next, we’ll add a hardcoded array of all our product categories. Really, you’d want to query for this information, but we’re hardcoding it here to make our example a little simpler. So we’ll add this:

```ts
const productCategories = [
  'Bikes',
  'Body Armor',
  'Build Kits',
  'Cables & Housing',
  'Frames',
  'Helmets',
  'Wheels & Wheelsets',
];
```

After that, we’ll change a bit how we store the filter information. This will make it a bit easier to work with our chosen UI elements.

So, whereas before we had a state variable holding a `Filter` object, now we’ll use it to hold an array of strings that we want to filter on.

```ts
// Change this line
const [categoryFilter, setCategoryFilter] = useState<Filter | null>(null);

// To this line
const [categories, setCategories] = useState<string[]>([]);
```

And before where we had a memoized list of filters, now we’ll build our filter from our list of strings to filter on.

```ts
// Change these lines
const chartFilters = useMemo(
  () => (categoryFilter ? [categoryFilter] : []),
  [categoryFilter]
);

// To these lines
const chartFilters = useMemo(
  () =>
    categories
      ? [filterFactory.members(DM.DimProducts.CategoryName, categories)]
      : [],
  [categories]
);
```

We’ve done all that so we can easily work with a Material UI `<ToggleButtonGroup>`. So now let’s replace our filter tile component with a toggle button group.

```ts
<ToggleButtonGroup value={categories} onChange={handleCategoryChange}>
  {productCategories.map((productCategory) => (
    <ToggleButton key={productCategory} value={productCategory}>
      {productCategory}
    </ToggleButton>
  ))}
</ToggleButtonGroup>
```

Here we’re using the toggle button group to work with our `categories` state variable. To create the various toggle buttons, we loop through the array of product categories and create a button for each category.

Now all we have to do is create a function to handle users toggling buttons on and off. This function simply takes the categories set using the toggle buttons and uses them to set the new value of our categories state variable.

```ts
const handleCategoryChange = (
  _event: React.MouseEvent<HTMLElement>,
  newCategories: string[]
) => {
  setCategories(newCategories);
};
```

You can now go back to your charts and see that the functionality is the same, but with the toggle buttons controlling the highlighting and filtering of the charts.

![Toggle button filter](../../img/tutorial/3-toggle-buttons.png 'Toggle button filter')

::: tip
The code up until this point can be found in branch [3b-filters-and-highlights](https://github.com/sisense/compose-sdk-charts-tutorial/tree/3b-filters-and-highlights).
:::

e button filter')

::: tip
The code up until this point can be found in branch [3b-filters-and-highlights](https://github.com/sisense/compose-sdk-charts-tutorial/tree/3b-filters-and-highlights).
:::

## Up next

At this point, you should know how to display the data you want in a chart and work with the way that data is displayed. In the next lesson you’ll learn how to take a bit more control of how a chart behaves. [Go to Lesson 4](./lesson4.md).


<!-- Source: tutorials/tutorial-charts/lesson4.md -->
# Lesson 4 | Callbacks

Chart callbacks are functions that run when specific events happen to a chart. You can use these callbacks to change the look and feel of a chart as well as add functionality to a chart.

Callbacks

Chart callbacks are functions that run when specific events happen to a chart. You can use these callbacks to change the look and feel of a chart as well as add functionality to a chart.

## Before render

One of the events you can handle with a callback occurs just before a chart is ready to render. You can use this event to change the underlying chart options. Compose SDK uses the [Highcharts](https://www.highcharts.com/) charting library under the hood. You can use the `HighchartsOptions` object sent to the `onBeforeRender()` callback to change the chart options.

In our project, let’s change the way our charts display tooltips when a user hovers over one of the chart’s columns. To do that, let’s start by adding this callback to the top chart’s properties.

```ts
onBeforeRender={(options: HighchartsOptions) => {
  if (options.tooltip) {
    options.tooltip.formatter = function () {
      const value = (
        this.y && this.y !== 0 ? this.y / 1000 : 0
      ).toFixed(1);
      return `${this.x}: <b>${value}K</b>`;
    };
  }
  return options;
}}
```

Here you can see that the callback function receives the `HighchartsOptions` object. Our function manipulates that object and then returns the changed object to be used as the chart’s options.

In our case, we check if our chart has a tooltip. If it does, we add a formatter function to define the contents of the tooltip. Here we take the raw Y-value and divide it by 1000, keeping one digit after the decimal. Then we return a string literal with the format we want for our condensed tooltip.

When users hover over a chart now, they’ll see the tooltip on the right in the image below instead of the one on the left.

![Chart with tooltips](../../img/tutorial/4-tooltips.png 'Chart with tooltips')

We can do something similar for the bottom chart. But since that chart is broken down further, let’s add some additional information to the tooltip by adding this callback.

```ts
onBeforeRender={(options: HighchartsOptions) => {
  if (options.tooltip) {
    options.tooltip.formatter = function () {
      const value = (
        this.y && this.y !== 0 ? this.y / 1000 : 0
      ).toFixed(1);
      return `${this.x} - ${this.series.name}: <b>${value}K</b>`;
    };
  }
  return options;
}}
```

This is very similar to the callback that we added to the top chart. The difference here is that we’ve added the series name to the formatter function, which results in a tooltip that looks like this:

![Chart with custom tooltip](../../img/tutorial/4-tooltip-break.png 'Chart with custom tooltip')

::: tip
The code up until this point can be found in branch [4a-callbacks](https://github.com/sisense/compose-sdk-charts-tutorial/tree/4a-callbacks).
:::

ltip-break.png 'Chart with custom tooltip')

::: tip
The code up until this point can be found in branch [4a-callbacks](https://github.com/sisense/compose-sdk-charts-tutorial/tree/4a-callbacks).
:::

## Data point click

In addition to the before render callback, there are other callbacks you can use to handle user interactions with a chart. To see how to use these, we’ll build an interaction that happens when a user clicks a data point.

In our project, we’ll add a handler to the top chart that handles clicks on the data columns. When a user clicks one of the columns, we’ll use a handler to toggle the highlighting of that column in the top chart and the filtering of that group in the bottom chart. While we’re at it, we’ll have the click also toggle the corresponding toggle button on or off.

To do that, let’s add this callback to the top chart’s properties.

```ts
onDataPointClick={(point: DataPoint) => {
  const category = point.categoryValue as string;
  setCategories((categories) =>
    categories.includes(category)
      ? categories.filter((item) => item !== (category as string))
      : [...categories, category as string]
  );
}}
```

Here, the callback gets the current category that was clicked. It then checks if the clicked category is already in the array of categories we store in our state variable. If the clicked category is already in the array, we remove it. If the clicked category is not yet in the list, we add it. Since we’re using the same array as the toggle buttons, clicking on the categories in the charts, will also affect which toggle buttons are selected.

::: tip
The code up until this point can be found in branch [4b-callbacks](https://github.com/sisense/compose-sdk-charts-tutorial/tree/4b-callbacks).
:::

o affect which toggle buttons are selected.

::: tip
The code up until this point can be found in branch [4b-callbacks](https://github.com/sisense/compose-sdk-charts-tutorial/tree/4b-callbacks).
:::

## Up next

At this point, you’ve learned the basics of working with charts and their properties. In the next lesson, you’ll learn how to dynamically change the data displayed in a chart and the layout of the chart itself. [Go to Lesson 5](./lesson5.md).


<!-- Source: tutorials/tutorial-charts/lesson5.md -->
# Lesson 5 | Dynamic Charts

One of the main advantages to creating charts in code, is that you can build them and manipulate them dynamically with code.

In this lesson we change our charts dynamically in a couple of ways. First, we’ll add functionality so our users can change what dimension the bottom chart is broken down by. Then, we also let users decide if they want to see the chart data in a column chart, as we’ve been presenting it until now, or as a bar chart.

These are only some examples of how you can dynamically change a chart. You can, of course, choose to change just about anything in a chart dynamically.

presenting it until now, or as a bar chart.

These are only some examples of how you can dynamically change a chart. You can, of course, choose to change just about anything in a chart dynamically.

## Dynamic break by

Let’s start by adding a way for users to change the break down of the bottom chart.

To start off this process, we need to add a new state variable that will track which dimension we want to break by. Here we set it to default to color.

```ts
const [breakBy, setBreakBy] = useState('color');
```

Next, we need another toggle button group. We’ll add this one so it appears under the bottom chart. To keep things simple, we hard code the different choices we want to let users break the chart by.

```ts
<ToggleButtonGroup value={breakBy} onChange={handleBreakChange} exclusive>
  <ToggleButton key={'color'} value={'color'}>
    Color
  </ToggleButton>
  <ToggleButton key={'region'} value={'region'}>
    Region
  </ToggleButton>
  <ToggleButton key={'manager'} value={'manager'}>
    Team Manager
  </ToggleButton>
</ToggleButtonGroup>
```

Now we need to add a function to handle changes to the toggle button group. All this function needs to do is to set the state variable that tracks what we’re currently breaking our chart by.

```ts
const handleBreakChange = (
    _event: React.MouseEvent<HTMLElement>,
    newBreak: string
) => {
    setBreakBy(newBreak);
};
```

After setting all that up, we need to apply the changes in state to our chart. But before we do that, we’ll need to add a utility function to change the the state variable value, which is stored as a string, to a dimension from our imported data model.

```ts
const breakStringToColumn = (breakString: string) => {
  if (breakString === 'manager') {
    return DM.DimEmployees.TeamManager;
  } else if (breakString === 'region') {
    return DM.DimCountries.Region;
  } else {
    return DM.DimProducts.Color;
  }
};
```

Then we call that function and pass it the `breakBy` state variable to dynamically assign the dimension we want to break by in the bottom charts `breakBy` property.

```ts
breakBy: [breakStringToColumn(breakBy)],
```

Finally, to finish things off we can add another couple of values to the mapping of the data series to colors. Here we add mappings for the series we get when breaking by region.

```ts
seriesToColorMap: {
  Black: '#1b1b1b',
  Blue: '#0000cd',
  Gold: '#fcc200',
  Red: '#ce2029',
  Silver: '#acacac',
  Yellow: '#eee600',
  USA: '#00008b',
  Europe: '#dc143c',
},
```

::: tip
The code up until this point can be found in branch [5a-dynamic-charts](https://github.com/sisense/compose-sdk-charts-tutorial/tree/5a-dynamic-charts).
:::

08b',
  Europe: '#dc143c',
},
```

::: tip
The code up until this point can be found in branch [5a-dynamic-charts](https://github.com/sisense/compose-sdk-charts-tutorial/tree/5a-dynamic-charts).
:::

## Dynamic chart type

For the final feature of this tutorial, we’ll let users decide what type of chart they want use to view the data. A lot of what we need to do should be familiar to you already.

We start by adding another state variable to track the current chart type.

```ts
const [chartType, setChartType] = useState<ChartType>('column');
```

Next, we’ll add another toggle button group for users to make their choices. But this time we’ll use icons in our buttons. So first we need to install the Material UI icons by running the following command:

```sh
npm install @mui/icons-material
```

Then, we can add the toggle button group. Here we’ll use two bar chart icons, which actually depict Compose SDK column charts. So we rotate the second icon 90 degrees to look like a Compose SDK bar chart. Let's add this group between the two charts.

```ts
<ToggleButtonGroup value={chartType} onChange={handleTypeChange} exclusive>
  <ToggleButton key={'column'} value={'column'}>
    <BarChartIcon />
  </ToggleButton>
  <ToggleButton key={'bar'} value={'bar'}>
    <BarChartIcon style={{ transform: 'rotate(90deg)' }} />
  </ToggleButton>
</ToggleButtonGroup>
```

After that, we add a simple handler function that handles changes to the toggle button group by updating the the state variable that tracks the chart type.

```ts
const handleTypeChange = (
  _event: React.MouseEvent<HTMLElement>,
  newType: ChartType
) => {
  if (newType) setChartType(newType);
};
```

Finally, we can go to both of our charts and update their chart types to read from the `chartType` state variable instead of a hardcoded string.

```ts
chartType = {chartType}
```

Now you can go back to your charts and use the toggle button to change the chart types.

::: tip
The code up until this point can be found in branch [5b-dynamic-charts](https://github.com/sisense/compose-sdk-charts-tutorial/tree/5b-dynamic-charts).
:::

button to change the chart types.

::: tip
The code up until this point can be found in branch [5b-dynamic-charts](https://github.com/sisense/compose-sdk-charts-tutorial/tree/5b-dynamic-charts).
:::

## The end

That concludes our tutorial. You now have a great foundation to go out and integrate Compose SDK into your own projects.


<!-- Source: tutorials/tutorial-genai/index.md -->
# Tutorial

In this tutorial, we’ll walk you through the setup and customization of the Compose SDK Generative AI components.

::: tip Note
For more information on requirements for enabling Generative AI features, please refer to the [Generative AI documentation](https://docs.sisense.com/main/SisenseLinux/genai.htm)
:::

## What you'll learn

Along the way, you’ll learn how to:

- Setup a new project to work with Compose SDK
- Render chatbots and customize them
- Display natural language textual insights from a query

## Get started

Let's get started by setting up a Compose SDK project with your first Generative AI component, the `Chatbot`. Go to [Lesson 1](./lesson1.md).


<!-- Source: tutorials/tutorial-genai/lesson1.md -->
# Lesson 1 | Setup

In this lesson, you’ll learn how to set up a new Compose SDK project and display a chatbot in that project. If you've gone through the Charts Tutorial, you'll notice that it's similar to [Lesson 1](../tutorial-charts/lesson1.md).

w to set up a new Compose SDK project and display a chatbot in that project. If you've gone through the Charts Tutorial, you'll notice that it's similar to [Lesson 1](../tutorial-charts/lesson1.md).

## Prerequisites

Before getting started, you’ll need:

- Node.js version 16 or higher
- npm

You’ll also need access to a Sisense instance with:

- The Sample Retail and Sample ECommerce data sources (you may need to go into each data model and unhide some of the columns that are hidden by default)
- An [API Token](../../getting-started/authentication-security.md#api-token) you can use to query with
- [CORS settings](../../getting-started/authentication-security.md#set-up-cors) that allow requests from `http://localhost:5173`, the URL that Vite serves your project on locally
- [GenAI enabled](https://docs.sisense.com/main/SisenseLinux/genai.htm#EnablingGenAI)

## Create a project

Let’s start by creating a React project and installing dependencies. We’ll use Vite to create a new project.

1. Navigate to the directory where you want to create your project
1. Run `npm create vite@latest`
1. Name your project `compose-sdk-genai-tutorial` when prompted
1. Select `React` as the framework
1. Select `TypeScript` as the variant
1. Run `cd compose-sdk-genai-tutorial` to navigate to your project directory
1. Run `npm install` to install your project and dependencies
1. Run `npm i @sisense/sdk-ui @sisense/sdk-data` to install Sisense packages

e-sdk-genai-tutorial` to navigate to your project directory
1. Run `npm install` to install your project and dependencies
1. Run `npm i @sisense/sdk-ui @sisense/sdk-data` to install Sisense packages

## Add context providers

Now we can start writing our first bit of code.

Since most of our Compose SDK functionality needs access to a Sisense instance, the first thing we need to do is set up that access with `<SisenseContextProvider>`. There are a number of places you can choose to add it. Here, we’ll add the provider in `main.tsx`.

In `main.tsx`, import the `SisenseContextProvider` from the `sdk-ui` module:

```ts
import { SisenseContextProvider } from '@sisense/sdk-ui';
```

Wrap the `<App>` component with a `<SisenseContextProvider>` like this:

```ts
<SisenseContextProvider
  url={import.meta.env.VITE_APP_SISENSE_URL}
  token={import.meta.env.VITE_APP_SISENSE_TOKEN}
>
  <App />
</SisenseContextProvider>
```

This will read the Sisense instance URL and API Token from an `.env`, so let’s add that file now.

1. Create a file named `.env.local` in your project’s root directory
1. Add a `VITE_APP_SISENSE_URL` variable and set its value to your Sisense instance’s URL
1. Add a `VITE_APP_SISENSE_TOKEN` variable and set it value to your API Token

Your `.env.local` file should look something like this:

```
VITE_APP_SISENSE_URL="http://myinstanceurl/"
VITE_APP_SISENSE_TOKEN="OiJhbGJeyciIUzI1..."
```

You'll also need the `<AiContextProvider>`. This is required for using any of the components exported from `@sisense/sdk-ui/ai`.

In `main.tsx`, import the `SisenseContextProvider` from the `sdk-ui/ai` namespace:

```ts
import { AiContextProvider } from '@sisense/sdk-ui/ai';
```

This component internally uses the `SisenseContextProvider`, so we'll go ahead and nest this provider in between our `<SisenseContextProvider>` and `<App>` components.

```ts
<SisenseContextProvider
  url={import.meta.env.VITE_APP_SISENSE_URL}
  token={import.meta.env.VITE_APP_SISENSE_TOKEN}
>
  <AiContextProvider>
    <App />
  </AiContextProvider>
</SisenseContextProvider>
```

ContextProvider
  url={import.meta.env.VITE_APP_SISENSE_URL}
  token={import.meta.env.VITE_APP_SISENSE_TOKEN}
>
  <AiContextProvider>
    <App />
  </AiContextProvider>
</SisenseContextProvider>
```

## Add a chatbot

Finally, with all the setup out of the way, we can add a chatbot to our project.

In the `App.tsx` file, import the `<Chatbot>` component.

Note: From here on in we won’t mention imports anymore. Just know that you’ll need to add the appropriate imports as we continue to add code to our project.

```ts
import { Chatbot } from '@sisense/sdk-ui/ai';
```

Then, replace the contents of the `App()` function with the following code to render a basic chatbot.

```ts
return (
  <Chatbot />
);
```

## Run

Use the `npm run dev` command to get your project up and running so you can see it in action.
Navigate to `http://localhost:5173` in a browser to see your chatbot. It should look like this:

![First chatbot](../../img/tutorial-genai/1-first-chatbot.png 'First chatbot')

Nice! We now have a chatbot that shows available data topics. Clicking on a data topic will start a chat with that data model/perspective as the chat context.

## Up next

In the next lesson, you'll learn how to customize the chatbot and render multiple chatbots on the same page. [Go to Lesson 2](./lesson2.md).


<!-- Source: tutorials/tutorial-genai/lesson2.md -->

xt

In the next lesson, you'll learn how to customize the chatbot and render multiple chatbots on the same page. [Go to Lesson 2](./lesson2.md).


<!-- Source: tutorials/tutorial-genai/lesson2.md -->
# Lesson 2 | Chatbot Customization

In this lesson, you'll learn how to customize your chatbot's behavior and look-and-feel. You'll learn how to display multiple chatbot instances.

ai/lesson2.md -->
# Lesson 2 | Chatbot Customization

In this lesson, you'll learn how to customize your chatbot's behavior and look-and-feel. You'll learn how to display multiple chatbot instances.

## Modify chatbot behavior

Let's start by adding some specific options to our current chatbot.

```ts
return (
  <Chatbot
    width="600px"
    height="600px"
    config={{
      defaultContextTitle: "Sample Retail",
      suggestionsWelcomeText: false,
      welcomeText: false,
    }}
  />
);
```

This resizes the chatbot, hides some text content, and skips the data topics screen by setting the default chat context to be "Sample Retail". Your app should now look like this:

![Custom chatbot](../../img/tutorial-genai/2-custom-chatbot.png 'Custom chatbot')

Let's change the look and feel of the chatbot and give it a dark theme. We'll need to wrap the chatbot in a `ThemeProvider`.

```ts
return (
  <ThemeProvider
    theme={{
      typography: {
        fontFamily: "Arial",
      },
      aiChat: {
        backgroundColor: "#121212",
        primaryTextColor: "#E5E7EB",
        userMessages: {
          backgroundColor: "#1E3A8A",
        },
        systemMessages: {
          backgroundColor: "#1F2937",
        },
        input: {
          backgroundColor: "#1C1C1E",
        },
        header: {
          textColor: "#E5E7EB",
          backgroundColor: "#0D1B2A",
        },
        suggestions: {
          textColor: "#E5E7EB",
          backgroundColor: "#1F2937",
          hover: {
            textColor: "#E5E7EB",
          },
        },
        clickableMessages: {
          textColor: "#E5E7EB",
          backgroundColor: "#1F2937",
          hover: {
            textColor: "#E5E7EB",
          },
        },
        icons: {
          color: "#FFFFFF",
        },
      },
    }}
  >
    <Chatbot
      width="600px"
      height="600px"
      config={{
        defaultContextTitle: "Sample Retail",
        suggestionsWelcomeText: false,
        welcomeText: false,
      }}
    />
  </ThemeProvider>
);
```

Your chatbot should now look something like this:

![Themed chatbot](../../img/tutorial-genai/2-themed-chatbot.png 'Themed chatbot')

welcomeText: false,
      }}
    />
  </ThemeProvider>
);
```

Your chatbot should now look something like this:

![Themed chatbot](../../img/tutorial-genai/2-themed-chatbot.png 'Themed chatbot')

## Multiple chatbots

It'd be nice to have 2 chatbots side-by-side, pointing to different contexts. Let's render another chatbot that uses Sample ECommerce as its default model.

```ts
return (
  <div style={{ display: "flex", columnGap: "20px" }}>
    <ThemeProvider
      theme={{
        // ...
      }}
    >
      <Chatbot
        width="600px"
        height="600px"
        config={{
          defaultContextTitle: "Sample Retail",
          suggestionsWelcomeText: false,
          welcomeText: false,
        }}
      />
    </ThemeProvider>
    <Chatbot
      width="600px"
      height="600px"
      config={{
        defaultContextTitle: "Sample ECommerce",
      }}
    />
  </div>
);
```

With this code, the two chatbots are spaced apart on the same row. The Sample ECommerce chatbot is configured with the default behavior and styling.

![Multiple chatbots](../../img/tutorial-genai/2-multiple-chatbots.png 'Multiple chatbots')

d apart on the same row. The Sample ECommerce chatbot is configured with the default behavior and styling.

![Multiple chatbots](../../img/tutorial-genai/2-multiple-chatbots.png 'Multiple chatbots')

## Code sample

Here's the complete `App.tsx` file after the past two lessons.

```ts
import { ThemeProvider } from '@sisense/sdk-ui';
import { Chatbot } from '@sisense/sdk-ui/ai';

function App() {
  return (
    <div style={{ display: "flex", columnGap: "20px" }}>
      <ThemeProvider
        theme={{
          typography: {
            fontFamily: "Arial",
          },
          aiChat: {
            backgroundColor: "#121212",
            primaryTextColor: "#E5E7EB",
            userMessages: {
              backgroundColor: "#1E3A8A",
            },
            systemMessages: {
              backgroundColor: "#1F2937",
            },
            input: {
              backgroundColor: "#1C1C1E",
            },
            header: {
              textColor: "#E5E7EB",
              backgroundColor: "#0D1B2A",
            },
            suggestions: {
              textColor: "#E5E7EB",
              backgroundColor: "#1F2937",
              hover: {
                textColor: "#E5E7EB",
              },
            },
            clickableMessages: {
              textColor: "#E5E7EB",
              backgroundColor: "#1F2937",
              hover: {
                textColor: "#E5E7EB",
              },
            },
            icons: {
              color: "#FFFFFF",
            },
          },
        }}
      >
        <Chatbot
          width="600px"
          height="600px"
          config={{
            defaultContextTitle: "Sample Retail",
            suggestionsWelcomeText: false,
            welcomeText: false,
          }}
        />
      </ThemeProvider>
      <Chatbot
        width="600px"
        height="600px"
        config={{
          defaultContextTitle: "Sample ECommerce",
        }}
      />
    </div>
  );
}

export default App;
```

vider>
      <Chatbot
        width="600px"
        height="600px"
        config={{
          defaultContextTitle: "Sample ECommerce",
        }}
      />
    </div>
  );
}

export default App;
```

## Up next

In the next lesson, you’ll learn how to display natural language textual insights from a query using Compose SDK. [Go to Lesson 3](./lesson3.md).


<!-- Source: tutorials/tutorial-genai/lesson3.md -->
# Lesson 3 | NLG

In this lesson, we'll use Compose SDK to show natural language insights from a query. We won't be building on the code from the previous lessons, so feel free to create a new file for this lesson.

## Generate data model

To define a query using Compose SDK, we’ll first need to generate a TypeScript representation of the data model. We'll do this using the Compose SDK CLI tool for the Sample Retail model.

To generate the data model:

1. Create a folder in the `src` directory of you project named `models`
1. Run the following command

```sh
npx @sisense/sdk-cli@latest get-data-model --token <api-token> --output src/models/sample-retail.ts --dataSource "Sample Retail" --url <your-instance-url>
```

Be sure to replace the placeholders with your API token and the URL of your Sisense instance.

-token> --output src/models/sample-retail.ts --dataSource "Sample Retail" --url <your-instance-url>
```

Be sure to replace the placeholders with your API token and the URL of your Sisense instance.

## Add a chart

We'll assume you already know about how charts work, but if you don't, check out [Lesson 1](../tutorial-charts/lesson1.md#add-a-chart) from the Charts Tutorial for more information on anything that's confusing here.

We'll use the empty `App` component again as an example, but feel free to give your component a different name.

Go ahead and add the following to render a chart.

```ts
import { Chart } from "@sisense/sdk-ui";
import { measureFactory } from "@sisense/sdk-data";
import * as DM from "./models/sample-retail";

function App() {
  const dimensions = [DM.DimProducts.CategoryName];
  const measures = [
    measureFactory.sum(DM.Fact_Sale_orders.OrderRevenue),
    measureFactory.sum(DM.Fact_Sale_orders.OrderQty),
  ];

  return (
    <div
      style={{
        display: "flex",
        flexDirection: "column",
        rowGap: 20,
        width: 1000,
      }}
    >
      <Chart
        dataSet={DM.DataSource}
        chartType={"column"}
        dataOptions={{
          category: dimensions,
          value: [
            measures[0],
            {
              column: measures[1],
              showOnRightAxis: true,
            },
          ],
        }}
        styleOptions={{
          height: 400,
        }}
      />
    </div>
  );
}

export default App;
```

This should be the result:

![Chart](../../img/tutorial-genai/3-chart.png 'Chart')

}}
        styleOptions={{
          height: 400,
        }}
      />
    </div>
  );
}

export default App;
```

This should be the result:

![Chart](../../img/tutorial-genai/3-chart.png 'Chart')

## Add NLG

Let's supplement this chart with some insights using Sisense's natural language generation (NLG) API. We'll add the `GetNlgInsights` component underneath the chart we just made.

```ts
<Chart
  // ...
/>
<GetNlgInsights
  dataSource={DM.DataSource}
  dimensions={dimensions}
  measures={measures}
>
```

The props into the `GetNlgInsights` component are pretty similar to what is passed into the `ExecuteQuery` component. The difference is that we're getting text in natural language instead of tabular data as a result.

Depending on how your LLM is configured, the text output might be a little different, but it should look something like this:

![Chart with summary](../../img/tutorial-genai/3-chart-with-summary.png 'Chart with summary')

LLM is configured, the text output might be a little different, but it should look something like this:

![Chart with summary](../../img/tutorial-genai/3-chart-with-summary.png 'Chart with summary')

## Format NLG output

We want to highlight key text from the NLG output, like any numbers or quantities that might appear. To do this, it might be easier to switch to the `useGetNlgInsights` hook, which will just give us a plain string without the container.

Let's go ahead and add the hook right after where we define our `dimensions` and `measures` variables.

```ts
const dimensions = [DM.DimProducts.CategoryName];
const measures = [
  measureFactory.sum(DM.Fact_Sale_orders.OrderRevenue),
  measureFactory.sum(DM.Fact_Sale_orders.OrderQty),
];
const { data } = useGetNlgInsights({
  dataSource: DM.DataSource,
  dimensions,
  measures,
})
```

The `useGetNlgInsights` hook expects the exact same props as the `GetNlgInsights` component.

Let's format the data and then render it right underneath our `GetNlgInsights` hook.

```ts
const { data } = useGetNlgInsights({
  dataSource: DM.DataSource,
  dimensions,
  measures,
})

let summaryMarkup;
if (data) {
  summaryMarkup = {
    __html: data.replace(/(\d+)/g, "<b>$1</b>"),
  };
}

return (
  <div /* ... */>
    <Chart
      // ...
    />
    <GetNlgInsights
      // ...
    />
    {summaryMarkup && <div dangerouslySetInnerHTML={summaryMarkup} />}
  </div>
)
```

It's not the cleanest code, but we've effectively made all digits in the text summary bold, so here's the expected result:

![Chart with formatted summary](../../img/tutorial-genai/3-chart-with-formatted-summary.png 'Chart with formatted summary')

made all digits in the text summary bold, so here's the expected result:

![Chart with formatted summary](../../img/tutorial-genai/3-chart-with-formatted-summary.png 'Chart with formatted summary')

## Code sample

Here's the complete `App.tsx` file with all the code we've written in this lesson.

```ts
import { Chart } from "@sisense/sdk-ui";
import { GetNlgInsights, useGetNlgInsights } from "@sisense/sdk-ui/ai";
import { measureFactory } from "@sisense/sdk-data";
import * as DM from "./models/sample-retail";

function App() {
  const dimensions = [DM.DimProducts.CategoryName];
  const measures = [
    measureFactory.sum(DM.Fact_Sale_orders.OrderRevenue),
    measureFactory.sum(DM.Fact_Sale_orders.OrderQty),
  ];
  const { data } = useGetNlgInsights({
    dataSource: DM.DataSource,
    dimensions,
    measures,
  });

  let summaryMarkup;
  if (data) {
    summaryMarkup = {
      __html: data.replace(/(\d+)/g, "<b>$1</b>"),
    };
  }

  return (
    <div
      style={{
        display: "flex",
        flexDirection: "column",
        rowGap: 20,
        width: 1000,
      }}
    >
      <Chart
        dataSet={DM.DataSource}
        chartType={"column"}
        dataOptions={{
          category: dimensions,
          value: [
            measures[0],
            {
              column: measures[1],
              showOnRightAxis: true,
            },
          ],
        }}
        styleOptions={{
          height: 400,
        }}
      />
      <GetNlgInsights
        dataSource={DM.DataSource}
        dimensions={dimensions}
        measures={measures}
      />
      {summaryMarkup && <div dangerouslySetInnerHTML={summaryMarkup} />}
    </div>
  );
}

export default App;
```


================================================================================

{summaryMarkup && <div dangerouslySetInnerHTML={summaryMarkup} />}
    </div>
  );
}

export default App;
```


================================================================================
# Troubleshooting

Common issues and solutions
================================================================================


<!-- Source: troubleshooting/index.md -->
# Compose SDK Troubleshooting

These troubleshooting guides contain solutions to common issues you might encounter while using Compose SDK.

<SectionIndex />


<!-- Source: troubleshooting/troubleshooting-cli.md -->
# CLI Troubleshooting

This troubleshooting guide provides possible answers to common issues that may arise when using the Compose SDK CLI.

## Get Data Model Syntax

**Issue:**

When running the CLI command, `get-data-model` to generate the TS/JS representation of my data model there is a `syntax error near unexpected token` error.

**Solution:**

You may be using the wrong format for your arguments.

* For *Windows Powershell* use double quotes for your string type arguments.
* For Linux/MAC only use double quotes for string-type arguments that contain white spaces.

g format for your arguments.

* For *Windows Powershell* use double quotes for your string type arguments.
* For Linux/MAC only use double quotes for string-type arguments that contain white spaces.

## Missing data model

**Issue:**

After generating a TS/JS representation of my data model, I can't locate the generated model.

**Solution:**

1. Check the file path specified for argument `--output`. If you are using a relative path, for example, `--output src/sample-ecommerce.ts`, trace the path from the current directory you are running the CLI command in.
2. If the file is not in the specified directory, check the directory's permissions and make sure you have write access.
3. Check the authentication to your Sisense instance. See, the [Authentication](troubleshooting-setup.md#authentication) section in the Setup and Infrastructure Troubleshooting Guide for more information.
4. Verify that your Sisense instance URL is correct.
5. Verify that your Sisense instance URL is accessible. If it isn't, check your security, firewall, or VPN settings.

## Password Prompt

**Issue:**

When using a token for authentication I still see the `Enter password for username` message.

**Solution:**

Don't provide the `--username` flag together with the `--token` flag.



<!-- Source: troubleshooting/troubleshooting-dependencies.md -->

ee the `Enter password for username` message.

**Solution:**

Don't provide the `--username` flag together with the `--token` flag.



<!-- Source: troubleshooting/troubleshooting-dependencies.md -->
# Dependency Version Troubleshooting

This troubleshooting guide provides possible answers to potential dependency version conflicts that may arise when using Compose SDK, especially when your application and `@sisense/sdk-ui` depend on different versions of the same library.

ible answers to potential dependency version conflicts that may arise when using Compose SDK, especially when your application and `@sisense/sdk-ui` depend on different versions of the same library.

## MUI version conflicts when using `@sisense/sdk-ui`

**Issue:**

After installing `@sisense/sdk-ui` (and related packages such as `@sisense/sdk-shared-ui`), you see one or more of the following:

- TypeScript errors mentioning incompatible types coming from different `@mui/*` packages.
- Build-time bundler errors about missing or renamed exports from `@mui/material` or related packages.
- Multiple copies of the same `@mui/*` package appearing in your dependency tree (for example, different versions used by your app and by `@sisense/sdk-ui`).

**Cause:**

`@sisense/sdk-ui` currently declares a concrete dependency on specific `@mui/*` versions. If your application uses a different major version of MUI (for example, your app uses MUI v5 or v7 while `@sisense/sdk-ui` depends on MUI v6), your package manager may install multiple copies of `@mui/*` or create a type mismatch between the versions used by your app and by `@sisense/sdk-ui`. This can result in type errors, build failures, or runtime issues.

**Solution:**

Use your package manager's capability to **override** or **force-resolve** dependency versions so that **all** packages in your project (including `@sisense/sdk-ui` and `@sisense/sdk-shared-ui`) use a **single, consistent MUI version**.

The exact configuration depends on whether you use `npm`, `yarn`, or `pnpm`. The examples below assume you want to standardize on MUI v5.17.1, but you can replace these versions with the MUI version used in your application.

pends on whether you use `npm`, `yarn`, or `pnpm`. The examples below assume you want to standardize on MUI v5.17.1, but you can replace these versions with the MUI version used in your application.

## Using npm `overrides`

If you are using **npm 8+**, you can use the `overrides` field in your root `package.json` to force all dependencies that depend on `@mui/*` packages (including `@sisense/sdk-ui`) to use the same MUI versions.

In your root `package.json`:

```json
{
  "overrides": {
    "@mui/material": "5.17.1",
    "@mui/system": "5.17.1",
    "@mui/utils": "5.17.1",
    "@mui/icons-material": "5.17.1"
  }
}
```

Then:

1. Delete your lockfile (`package-lock.json`) and MUI-related folders from `node_modules` if necessary.
2. Run `npm install` again.
3. Verify that only the desired MUI package version is installed by checking the application’s dependencies via:

   ```bash
   npm ls <package name>
   ```

All dependencies that depend on `@mui/*` packages (including `@sisense/sdk-ui`) should resolve to the same version.

g the application’s dependencies via:

   ```bash
   npm ls <package name>
   ```

All dependencies that depend on `@mui/*` packages (including `@sisense/sdk-ui`) should resolve to the same version.

## Using Yarn `resolutions`

If you use **Yarn** (classic v1 or modern v2+), you can use the `resolutions` field in your root `package.json` to force a single MUI version.

In your root `package.json`:

```json
{
  "resolutions": {
    "@mui/material": "5.17.1",
    "@mui/system": "5.17.1",
    "@mui/icons-material": "5.17.1",
    "@mui/utils": "5.17.1"
  }
}
```

Then:

1. Delete your lockfile (`yarn.lock`) and MUI-related folders from `.yarn/cache` or `node_modules` if applicable.
2. Run `yarn install` again.
3. Verify that only the desired MUI package version is installed by checking the application’s dependencies via:

   ```bash
   yarn why <package name>
   ```

All dependencies that depend on `@mui/*` packages (including `@sisense/sdk-ui`) should resolve to the same version.

the application’s dependencies via:

   ```bash
   yarn why <package name>
   ```

All dependencies that depend on `@mui/*` packages (including `@sisense/sdk-ui`) should resolve to the same version.

## Using `pnpm.overrides`

If you use **pnpm**, you can configure the `pnpm.overrides` field in your root `package.json` (or `pnpm-workspace.yaml`) to enforce a single MUI version.

In your root `package.json`:

```json
{
  "pnpm": {
    "overrides": {
      "@mui/material": "5.17.1",
      "@mui/system": "5.17.1",
      "@mui/icons-material": "5.17.1",
      "@mui/utils": "5.17.1"
    }
  }
}
```

Then:

1. Delete your lockfile (`pnpm-lock.yaml`) if necessary.
2. Run `pnpm install` again.
3. Verify that only the desired MUI package version is installed by checking the application’s dependencies via:

   ```bash
   pnpm list <package name>
   ```

All dependencies that depend on `@mui/*` packages (including `@sisense/sdk-ui`) should resolve to the same version.

::: tip Note
Most package managers also support **package-scoped overrides/resolutions**, which let you change the MUI version only for specific dependencies (for example, just for `@sisense/sdk-ui` and related Compose SDK packages) instead of globally for the entire application.
The examples above demonstrate how to change the version **globally** at the application level. For package-scoped configuration, please refer to your package manager’s documentation.
:::

plication.
The examples above demonstrate how to change the version **globally** at the application level. For package-scoped configuration, please refer to your package manager’s documentation.
:::

## Verifying that the conflict is resolved

After applying overrides with your package manager:

1. **Inspect the dependency tree** using the commands shown above to confirm that all `@mui/*` packages resolve to your chosen version.
2. **Rebuild and type-check** your application.
3. **Manually test** the application to ensure that no runtime issues occur.

If issues persist after enforcing a single MUI version, collect:

- The versions of `@sisense/sdk-ui` and the `@mui/*` packages you are using.
- The output of your dependency tree inspection (for example, `npm ls @mui/material`).
- Any build or runtime error messages.

Then contact Sisense Support and include this information to aid further investigation.



<!-- Source: troubleshooting/troubleshooting-genai.md -->
# Generative AI Troubleshooting

This troubleshooting guide provides possible answers to common issues that may arise when using the Compose SDK Generative AI components.

::: tip Note
For more information on requirements for enabling Generative AI features, please refer to the [Generative AI documentation](https://docs.sisense.com/main/SisenseLinux/genai.htm)
:::

s.

::: tip Note
For more information on requirements for enabling Generative AI features, please refer to the [Generative AI documentation](https://docs.sisense.com/main/SisenseLinux/genai.htm)
:::

## Component Errors

Here are some common errors that you may encounter.

#### Blank screen with Uncaught SyntaxError: The requested module [...] does not provide an export named 'AiContextProvider'

Check that you are importing from `@sisense/sdk-ui/ai` and not `@sisense/sdk-ui`.

#### Error: No QueryClient set, use QueryClientProvider to set one

Check that your app is wrapped in an `AiContextProvider`.

#### `<Chatbot />` shows infinite loading icon

Check that your app is wrapped in an `AiContextProvider`.



<!-- Source: troubleshooting/troubleshooting-runtime.md -->
# Runtime Troubleshooting

This troubleshooting guide provides possible solutions to common issues that may arise when executing Compose SDK code.

<!--
Additional categories of potential troubleshooting.
## Data Models

Use of invalid data options. - Solution is to validate data correctly.

-->
## Chart Configurations

**Issue:**
There are double labels in my chart.

**Solution:**
You may be using multiple categories with labels. Use only one category instead.

<!--
Additional categories of potential troubleshooting.
### Filter configurations

-->

s in my chart.

**Solution:**
You may be using multiple categories with labels. Use only one category instead.

<!--
Additional categories of potential troubleshooting.
### Filter configurations

-->
## Event Handlers

**Issue:**

My chart isn’t updating when I select filter values.

**Solution:**

1. Check the callback for filter change in the filter component.
2. Check to make sure that your callback affects the state of the chart.

**Issue:**

When clicking a point in my chart nothing happens.

**Solution:**

1. Check to make sure you provide a callback.
2. Check to make sure that your callback affects the state of the chart.



<!-- Source: troubleshooting/troubleshooting-setup.md -->
# Setup and Infrastructure Troubleshooting

This troubleshooting guide provides possible answers to common issues that may arise when trying to install Compose SDK using `yarn` or `npm`.

etup.md -->
# Setup and Infrastructure Troubleshooting

This troubleshooting guide provides possible answers to common issues that may arise when trying to install Compose SDK using `yarn` or `npm`.

## Error Messages

| **Action**             | **Error Message/Behavior**                                                                                           | **Solution/Workaround**                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
|------------------------|----------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `yarn install`         | RequestError: unable to get local issuer certificate                                                                 | Check your Internet security firewalls or VPNs to see if external access is blocked.                                                                                                                                                                                                                                                                                                                                                                                                                  |
| `yarn install`         | Invalid authentication (as an anonymous user)                                                                        | Configure your personal access token for the GitHub Packages Registry (GPR). <br /> Try deleting `yarn.lock` and running `yarn cache clean --all` before running `yarn install` again. <br /><br /> Note that since version `0.11.3`, the SDK packages are hosted on public NPM registry. Consider upgrading SDK to the latest version and removing the configuration for GPR.                                                                                                                        |
| `yarn install`         | No `@sisense/sdk\*` modules installed in `node\_modules` causing the CLI command to fail to generate the data model  | Check if `Yarn Plug'n'Play` is enabled by checking to see if `pnp.cjs` is in the root folder after running `yarn install`. To fix, add `nodeLinker: node-modules` to your `.yarnrc.yml` file located in the root folder and run `yarn install` again.                                                                                                                                                                                                                                                 |
| CLI command with `npx` | No output in the console and the data model file is not generated                                                    | Check if `Yarn Plug'n'Play` is enabled by checking to see if `pnp.cjs` is in the root folder after running `yarn install`. <br /><br />This feature is available in **Yarn 4.x**, which is not a stable version. To fix, switch to Yarn version 3.x (stable) by running the command `yarn set version stable`. Run `yarn -v` to see your current version, and verify that version 3.x is used. <br /><br />Run `yarn install` to install the packages again. <br /><br />Run the `npx` command again. |

sion stable`. Run `yarn -v` to see your current version, and verify that version 3.x is used. <br /><br />Run `yarn install` to install the packages again. <br /><br />Run the `npx` command again. |

## Authentication

**Issue:**

I can't access my Sisense instance.

**Solution:**

First check that you can access your Sisense instance directly. If this works, then check your authentication methods to see if they are configured correctly. You can use the following authentication methods:

* [SSO](../getting-started/authentication-security.md#single-sign-on)
* [Web access tokens](../getting-started/authentication-security.md#web-access-token)
* [Sisense API token](../getting-started/authentication-security.md#api-token)

## Browser Security

**Issue:**

There is a warning saying that my app website is not secure.

**Solution:**
1. This warning is displayed on any page served over an insecure protocol such as HTTP. Contact your administrator to resolve it by enabling the HTTPS protocol.
2. This may be an issue with SSL certificate. Contact your administrator to correct the certificate or to make a new one available for you to use.
3. This may be a conflict with your anti-virus software and your corporate network. Contact your administrator for more assistance.



================================================================================

conflict with your anti-virus software and your corporate network. Contact your administrator for more assistance.



================================================================================
# Reference

Additional reference material
================================================================================


<!-- Source: reference/index.md -->
# Reference

Here you'll find additional reference resources to be used with Compose SDK

<SectionIndex />


<!-- Source: reference/functions.md -->
# Formula Functions

For the most up to date formula functions reference, please check the [Sisense Fusion documentation](https://docs.sisense.com/main/SisenseLinux/dashboard-functions-reference.htm)

For convenience, a reference of functions you may use within [`measureFactory.customFormula()`](../modules/sdk-data/factories/namespace.measureFactory/functions/function.customFormula.md) of Compose SDK is also included below.

of functions you may use within [`measureFactory.customFormula()`](../modules/sdk-data/factories/namespace.measureFactory/functions/function.customFormula.md) of Compose SDK is also included below.

## Overview

The following functions are available:

- [Universal Functions](#universal-functions)
  - [Aggregative Functions](#aggregative-functions)
    - [Average (`AVG`)](#average-avg)
    - [Count Unique (`COUNT`)](#count-unique-count)
    - [Count with Duplicates (`DUPCOUNT`)](#count-with-duplicates-dupcount)
    - [Largest (`LARGEST`)](#largest-largest)
    - [Maximum (`MAX`)](#maximum-max)
    - [Median (`MEDIAN`)](#median-median)
    - [Minimum (`MIN`)](#minimum-min)
    - [Mode (`MODE`)](#mode-mode)
    - [Sum (`SUM`)](#sum-sum)
  - [Statistical Functions](#statistical-functions)
    - [Contribution (`CONTRIBUTION`)](#contribution-contribution)
    - [Percentile (`PERCENTILE`)](#percentile-percentile)
    - [Quartile (`QUARTILE`)](#quartile-quartile)
    - [Rank (`RANK`)](#rank-rank)
    - [Standard Deviation - Population (`STDEVP`)](#standard-deviation---population-stdevp)
    - [Standard Deviation - Sample (`STDEV`)](#standard-deviation---sample-stdev)
    - [Variance - Population (`VARP`)](#variance---population-varp)
    - [Variance - Sample (`VAR`)](#variance---sample-var)
  - [Mathematical Functions](#mathematical-functions)
    - [Absolute Value (`ABS`)](#absolute-value-abs)
    - [Arccosine (`ACOS`)](#arccosine-acos)
    - [Arcsine (`ASIN`)](#arcsine-asin)
    - [Arctangent (`ATAN`)](#arctangent-atan)
    - [Ceiling (`CEILING`)](#ceiling-ceiling)
    - [Cosine (`COS`)](#cosine-cos)
    - [Cotangent (`COT`)](#cotangent-cot)
    - [Exponential (`EXP`)](#exponential-exp)
    - [Floor (`FLOOR`)](#floor-floor)
    - [Natural Log (`LN`)](#natural-log-ln)
    - [Log Base-10 (`LOG10`)](#log-base-10-log10)
    - [Modulo (`MOD`)](#modulo-mod)
    - [Power (`POWER`)](#power-power)
    - [Quotient (`QUOTIENT`)](#quotient-quotient)
    - [Round (`ROUND`)](#round-round)
    - [Sine (`SIN`)](#sine-sin)
    - [Square Root (`SQRT`)](#square-root-sqrt)
    - [Tangent (`TAN`)](#tangent-tan)
  - [Time-related Functions](#time-related-functions)
    - [Second Difference (`SDIFF`)](#second-difference-sdiff)
    - [Minute Difference (`MNDIFF`)](#minute-difference-mndiff)
    - [Hour Difference (`HDIFF`)](#hour-difference-hdiff)
    - [Day Difference (`DDIFF`)](#day-difference-ddiff)
    - [Month Difference (`MDIFF`)](#month-difference-mdiff)
    - [Quarter Difference (`QDIFF`)](#quarter-difference-qdiff)
    - [Year Difference (`YDIFF`)](#year-difference-ydiff)
    - [Past Week Difference (`DIFFPASTWEEK`)](#past-week-difference-diffpastweek)
    - [Past Month Difference (`DIFFPASTMONTH`)](#past-month-difference-diffpastmonth)
    - [Past Quarter Difference (`DIFFPASTQUARTER`)](#past-quarter-difference-diffpastquarter)
    - [Past Year Difference (`DIFFPASTYEAR`)](#past-year-difference-diffpastyear)
    - [Past Period Difference (`DIFFPASTPERIOD`)](#past-period-difference-diffpastperiod)
    - [Growth (`GROWTH`)](#growth-growth)
    - [Growth Rate (`GROWTHRATE`)](#growth-rate-growthrate)
    - [Growth Past Week (`GROWTHPASTWEEK`)](#growth-past-week-growthpastweek)
    - [Growth Past Month (`GROWTHPASTMONTH`)](#growth-past-month-growthpastmonth)
    - [Growth Past Quarter (`GROWTHPASTQUARTER`)](#growth-past-quarter-growthpastquarter)
    - [Growth Past Year (`GROWTHPASTYEAR`)](#growth-past-year-growthpastyear)
    - [Past Day (`PASTDAY`)](#past-day-pastday)
    - [Past Week (`PASTWEEK`)](#past-week-pastweek)
    - [Past Month (`PASTMONTH`)](#past-month-pastmonth)
    - [Past Quarter (`PASTQUARTER`)](#past-quarter-pastquarter)
    - [Past Year (`PASTYEAR`)](#past-year-pastyear)
    - [Week to Date Average (`WTDAVG`)](#week-to-date-average-wtdavg)
    - [Week to Date Sum (`WTDSUM`)](#week-to-date-sum-wtdsum)
    - [Month to Date Average (`MTDAVG`)](#month-to-date-average-mtdavg)
    - [Month to Date Sum (`MTDSUM`)](#month-to-date-sum-mtdsum)
    - [Quarter to Date Average (`QTDAVG`)](#quarter-to-date-average-qtdavg)
    - [Quarter to Date Sum (`QTDSUM`)](#quarter-to-date-sum-qtdsum)
    - [Year to Date Average (`YTDAVG`)](#year-to-date-average-ytdavg)
    - [Year to Date Sum (`YTDSUM`)](#year-to-date-sum-ytdsum)
  - [Measured Value Functions](#measured-value-functions)
    - [All (`ALL`)](#all-all)
    - [Previous (`PREV`)](#previous-prev)
    - [Next (`NEXT`)](#next-next)
    - [Now (`NOW`)](#now-now)
  - [Other Functions](#other-functions)
    - [Case (`CASE`)](#case-case)
    - [If (`IF`)](#if-if)
    - [Is Null (`ISNULL`)](#is-null-isnull)
    - [Now (`NOW`)](#now-now-1)
    - [Running Average (`RAVG`)](#running-average-ravg)
    - [Running Sum (`RSUM`)](#running-sum-rsum)
- [Elasticube-only Functions](#fusion-elasticube-only-functions)
  - [Aggregative Functions](#aggregative-functions-1)
    - [Correlation (`CORREL`)](#correlation-correl)
    - [Covariance - Population (`COVARP`)](#covariance---population-covarp)
    - [Covariance - Sample (`COV`)](#covariance---sample-covar)
    - [Skewness - Population (`SKEWP`)](#skewness---population-skewp)
    - [Skewness - Sample (`SKEW`)](#skewness---sample-skew)
    - [Slope (`SLOPE`)](#slope-slope)
  - [Statistical Functions](#statistical-functions-1)
    - [Exponential Distribution (`EXPONDIST`)](#exponential-distribution-expondist)
    - [Intercept (`INTERCEPT`)](#intercept-intercept)
    - [Normal Distribution (`NORMDIST`)](#normal-distribution-normdist)
    - [Poisson Distribution (`POISSONDIST`)](#poisson-distribution-poissondist)
    - [T Distribution (`TDIST`)](#t-distribution-tdist)
  - [Mathematical Functions](#mathematical-functions-1)
    - [Hyperbolic Cosine (`COSH`)](#hyperbolic-cosine-cosh)
    - [Hyperbolic Sine (`SINH`)](#hyperbolic-sine-sinh)
    - [Hyperbolic Tangent (`TAN`)](#hyperbolic-tangent-tanh)
  - [Other Functions](#other-functions-1)
    - [Ordering (`ORDERING`)](#ordering-ordering)
    - [R Double (`RDOUBLE`)](#r-double-rdouble)
    - [R Integer (`RINT`)](#r-integer-rint)

-tangent-tanh)
  - [Other Functions](#other-functions-1)
    - [Ordering (`ORDERING`)](#ordering-ordering)
    - [R Double (`RDOUBLE`)](#r-double-rdouble)
    - [R Integer (`RINT`)](#r-integer-rint)

### Everything aggregative

The Analytical Engine requires that every measure defined in a formula be aggregative. For example, instead of `DDiff([Discharge Time], [Admission Time])`, use `AVG(DDiff([Discharge Time], [Admission Time]))`.

### Multi-pass

All aggregative functions can be run by themselves or as part of a multi-pass aggregation. The multi-pass version of an aggregative function in essence runs an aggregation on a function (instead of a value) and groups the results.

Multi-pass aggregations take the following form, where `INNER` is a function, `<group_by_field>` is the field to group the inner function's results by, and `OUTER` is an aggregation over the inner function's grouped results:

```
OUTER(<group_by_field>, INNER(<field>))

```

This concept is a bit easier to understand after seeing it in practice, so let's take a look how you might calculate something like the average total revenue per product.

Consider the following multi-pass call:

```
AVG([Product], SUM(Revenue));

```

This call calculates the average total revenue per product. It does so by calculating the total revenue per product and then taking the average of all those totals.

G([Product], SUM(Revenue));

```

This call calculates the average total revenue per product. It does so by calculating the total revenue per product and then taking the average of all those totals.

### Date resolution

Datetime fields within queries can be resolved at a number of levels. For the purpose of the functions in this reference, you can resolve the dates in your queries to years, quarters, months, weeks, or days.

The active date resolution of a query is determined by the minimum date level of the date dimension used for presentation and filtering.

For example, suppose you have a data model containing data for 2 complete years.

If you query that model for total cost and you resolve a date in the query to years, you receive the total cost for each of the 2 years.

| Year in Date | Total Cost    |
| ------------ | ------------- |
| 2022         | 33,705,906.25 |
| 2023         | 37,722,696.58 |

However, if you query that same data model for total cost and you resolve a date to quarters, you receive the total cost for each of the 8 quarters in the 2 years.

| Quarter in Date |   Total Cost |
| --------------- | -----------: |
| 2022 Q1         | 6,970,893.27 |
| 2022 Q2         | 7,549,119.55 |
| 2022 Q3         | 8,136,195.73 |
| 2022 Q4         | 11,049,697.6 |
| 2023 Q1         |  8,594,218.7 |
| 2023 Q2         | 9,408,611.73 |
| 2023 Q3         | 10,169,728.6 |
| 2023 Q4         | 9,550,137.52 |

The resolution of datetime fields also affects how time-related functions are calculated.

As an example, let's use the same data model with 2 complete years of data to examine how the date resolution of a query affects the `DIFFPASTYEAR()` function, which calculates the difference between the current year's data and the previous year's data.

If you query that model for the `DIFFPASTYEAR(SUM([COST]))` and you resolve a date in the query to years, you receive the cost of the previous year for each of the 2 years and the difference in cost from the first year to the second year.

| Year in Date | Total Cost    | Difference in Cost |
| ------------ | ------------- | ------------------ |
| 2022         | 33,705,906.25 |                    |
| 2023         | 37,722,696.58 | 4,016,790.33       |

However, if you query that same data model for difference in total cost and you resolve that date to quarters, you receive the total cost for each of the 8 quarters in the 2 years and the difference in cost between quarters. Notice how the difference in cost is calculated based on the same quarter in the previous year. So the difference in total cost for 2023 Q3 is the difference when compared to the total cost of 2022 Q3.

| Year in Date | Total Cost    | Difference in Cost |
| ------------ | ------------- | ------------------ |
| 2022 Q1      | 6,970,893.27  |                    |
| 2022 Q2      | 7,549,119.55  |                    |
| 2022 Q3      | 8,136,195.73  |                    |
| 2022 Q4      | 11,049,697.69 |                    |
| 2023 Q1      | 8,594,218.7   | 1,623,325.44       |
| 2023 Q2      | 9,408,611.73  | 1,859,492.17       |
| 2023 Q3      | 10,169,728.63 | 2,033,532.90       |
| 2023 Q4      | 9,550,137.52  | -1,499,560.17      |

8,594,218.7   | 1,623,325.44       |
| 2023 Q2      | 9,408,611.73  | 1,859,492.17       |
| 2023 Q3      | 10,169,728.63 | 2,033,532.90       |
| 2023 Q4      | 9,550,137.52  | -1,499,560.17      |

## Universal Functions

These functions may be used for both Live and ElastiCube models within the Sisense Fusion platform.

,033,532.90       |
| 2023 Q4      | 9,550,137.52  | -1,499,560.17      |

## Universal Functions

These functions may be used for both Live and ElastiCube models within the Sisense Fusion platform.

### Aggregative Functions

Functions that create aggregations.

---

#### Average (`AVG`)

Gets the average of given values.

##### Syntax (`AVG`)

```
AVG(<numeric_field>)

```

| Argument          | Description       |
| ----------------- | ----------------- |
| `<numeric_field>` | Any numeric field |

##### Example (`AVG`)

Calculate the average revenue.

```
AVG([Revenue]);

```

---

#### Count Unique (`COUNT`)

Counts the number of unique values.

##### Syntax (`COUNT`)

```
COUNT(<numeric_field>)

```

##### Example (`COUNT`)

Count the number of different category IDs.

```
COUNT([Category ID])

```

---

#### Count with Duplicates (`DUPCOUNT`)

Counts the number of values, including duplicates.

##### Syntax (`DUPCOUNT`)

```
DUPCOUNT(<numeric_field>)

```

##### Example (`DUPCOUNT`)

Count the number of category IDs.

```
DUPCOUNT([Category ID])

```

---

#### Largest (`LARGEST`)

Gets the nth largest of the given values.

##### Syntax (`LARGEST`)

```
LARGEST(<numeric_field>, <n>)

```

- `numeric_field`: Field to find the largest from.
- `n`: Which value from the largest value to get. For example, when `n` is `3`, the third largest value is retrieved.

##### Example (`LARGEST`)

Gets the third largest sales value.

```
LARGEST([Sales], 3);

```

---

#### Maximum (`MAX`)

Gets the largest of the given values.

##### Syntax (`MAX`)

```
MAX(<numeric_field>)

```

##### Example

Get the maximum revenue value.

```
MAX([Revenue]);

```

---

#### Median (`MEDIAN`)

Gets the median value of the given values.

##### Syntax (`MEDIAN`)

```
MEDIAN(<numeric_field>)

```

##### Example (`MEDIAN`)

Get the median revenue value.

```
MEDIAN([Revenue]);

```

---

#### Minimum (`MIN`)

Gets the smallest of the given values.

##### Syntax (`MIN`)

```
MIN(<numeric_field>)

```

##### Example (`MIN`)

Get the minimum revenue value.

```
MIN([Revenue]);

```

---

#### Mode (`MODE`)

Gets the mode of the given values. The mode is the most frequently occurring value. If there is more than one mode value, one of them is returned at random.

##### Syntax (`MODE`)

```
MODE(<numeric_field>)

```

##### Example (`MODE`)

Get the mode revenue value.

```
MODE([Revenue]);

```

---

#### Sum (`SUM`)

Calculates the total of the given values.

##### Syntax (`SUM`)

```
SUM(<numeric_field>)

```

##### Example (`SUM`)

Calculates the total cost across all items.

```
SUM([Cost]);

```

---

`SUM`)

Calculates the total of the given values.

##### Syntax (`SUM`)

```
SUM(<numeric_field>)

```

##### Example (`SUM`)

Calculates the total cost across all items.

```
SUM([Cost]);

```

---

### Statistical Functions

Functions that calculate statistical data.

---

#### Contribution (`CONTRIBUTION`)

Calculates the contribution, in percentage, of a value towards the total.

##### Syntax (`CONTRIBUTION`)

```
CONTRIBUTION(<numeric_field>)

```

##### Example (`CONTRIBUTION`)

Calculate the percentage of total sales per group out of total sales for all groups together.

```
CONTRIBUTION([Total Sales])

```

---

#### Percentile (`PERCENTILE`)

Gets the nth percentile value of the given values.

##### Syntax (`PERCENTILE`)

```
PERCENTILE(<numeric_field>, <n>)

```

- `numeric_field`: Field to find the percentile from.
- `n`: A number between `0` and `1` (inclusive) to indicate the percentile.

##### Example (`PERCENTILE`)

Gets the 90th percentile of total sales.

```
PERCENTILE([Total Sales], 0.9)

```

---

#### Quartile (`QUARTILE`)

Gets the nth quartile value of the given values. Can return minimum value, first quartile, second quartile, third quartile, or max value.

##### Syntax (`QUARTILE`)

```
QUARTILE(<numeric_field>, <n>)

```

- `numeric_field`: Field to find the quartile from.
- `n`: A number between `0` and `4` (inclusive) to indicate the quartile.
  - `0`: Minimum value
  - `1`: First quartile (25th percentile)
  - `2`: Third quartile (50th percentile)
  - `3`: First quartile (75th percentile)
  - `4`: Maximum value

##### Example (`QUARTILE`)

Gets the first quartile of a given item.

```
QUARTILE([Item], 1);

```

---

#### Rank (`RANK`)

Gets the rank of a value from the given values.

##### Syntax (`RANK`)

```
RANK(<numeric_field>, [sort_order], [rank_type], [<group-by field 1>,... , <group-by field n>])

```

- `numeric_field`: Field to rank by.
- `sort_order`: Optional sort order. Either `DESC` or `ASC`. Defaults to ascending order.
- `rank_type`: Optional ranking type. Defaults to `1224` ranking.
  - `1224`: Standard competition, meaning items that rank equally receive the same ranking number, and then a gap is left after the equally ranked items in the ranking numbers.
  - `1334`: Modified competition ranking, meaning items that rank equally receive the same ranking number, and a gap is left before the equally ranked items in the ranking numbers. Only supported for Fusion Datamodels.
  - `1223`: Dense ranking, meaning items that rank equally receive the same ranking number, and the next items receive the immediately following ranking number.
  - `1234`: Ordinal ranking, meaning all items receive distinct ordinal numbers, including items that rank equally. The assignment of distinct ordinal numbers for equal-ranking items is arbitrary.
- `[<group-by field 1>,... , <group-by field n>]`: Optional fields to group by.

##### Example (`RANK`)

Gets the rank of the total annual cost per product, sorted in ascending order.

```
RANK([Total Cost], "ASC", "1224", [Product], [Years])

```

---

#### Standard Deviation - Population (`STDEVP`)

Gets the standard deviation of the given values (population). Standard deviation is the square root of the average squared deviation from the mean. The standard deviation of a population gives researchers the amount of dispersion of data for an entire population of survey respondents.

##### Syntax (`STDEVP`)

```
STDEVP(<numeric_field>)

```

##### Example (`STDEVP`)

Get the standard deviation of the values in a given population.

```
STDEVP([Score])

```

---

#### Standard Deviation - Sample (`STDEV`)

Gets the standard deviation of the given values (sample). Standard deviation is the square root of the average squared deviation from the mean. A standard deviation of a sample estimates the amount of dispersion in a given data set, based on a random sample.

##### Syntax (`STDEV`)

```
STDEV(<numeric_field>)

```

##### Example (`STDEV`)

Get the standard deviation of the given values in a given sample.

```
STDEV([Score])

```

---

#### Variance - Population (`VARP`)

Gets the variance of the given values (population). Variance (population) is the average squared deviation from the mean, based on an entire population of survey respondents.

##### Syntax (`VARP`)

```
VARP(<numeric_field>)

```

##### Example (`VARP`)

Get the variance of grades in a student population.

```
VARP([Grade]);

```

---

#### Variance - Sample (`VAR`)

Gets the variance of the given values (sample). Variance (sample) is the average squared deviation from the mean, based on a random sample of the population.

##### Syntax (`VAR`)

```
VAR(<numeric_field>)

```

##### Example (`VAR`)

Gets the variance of grades in a random sample.

```
VAR([Grade]);

```

---

based on a random sample of the population.

##### Syntax (`VAR`)

```
VAR(<numeric_field>)

```

##### Example (`VAR`)

Gets the variance of grades in a random sample.

```
VAR([Grade]);

```

---

### Mathematical Functions

Functions that perform mathematical operations.

---

#### Absolute Value (`ABS`)

Gets the absolute value of a given value.

##### Syntax (`ABS`)

```
ABS(<numeric_field>)

```

##### Example (`ABS`)

Get the absolute cost value.

```
ABS([Cost]);

```

---

#### Arccosine (`ACOS`)

Gets the angle, in radians, whose cosine is a given numeric expression. Also referred to as arccosine.

##### Syntax (`ACOS`)

```
ACOS(<numeric_field>)

```

#### Examples (`ACOS`)

Get the angle, in radians, whose cosine is a given total revenue.

```
ACOS([Total Revenue])

```

---

#### Arcsine (`ASIN`)

Gets the angle, in radians, whose sine is a given numeric expression. Also referred to as arcsine.

##### Syntax (`ASIN`)

```
ASIN(<numeric_field>)

```

##### Example (`ASIN`)

Get the angle, in radians, whose sine is a given total revenue.

```
ASIN([Total Revenue])

```

---

#### Arctangent (`ATAN`)

Gets the angle in radians whose tangent is a given numeric expression. Also referred to as arctangent.

##### Syntax (`ATAN`)

```
ATAN(<numeric_field>)

```

##### Example (`ATAN`)

Get the angle in radians whose tangent is a given total revenue.

```
ATAN([Total Revenue])

```

---

#### Ceiling (`CEILING`)

Calculates a number rounded up to the nearest multiple of significance.

##### Syntax (`CEILING`)

```
CEILING(<numeric_field>)

```

##### Example (`CEILING`)

Calculate the rounded up total cost. For example, when the cost is 83.2 it is rounded up to 84.

```
CEILING([Total Cost])

```

---

#### Cosine (`COS`)

Calculates the trigonometric cosine of a given angle (in radians).

##### Syntax (`COS`)

```
COS(<numeric_field>)

```

##### Example (`COS`)

Calculate the trigonometric cosine of the average angle.

```
COS([Average Angle])

```

---

#### Cotangent (`COT`)

Calculates the trigonometric cotangent of a given angle (in radians).

##### Syntax (`COT`)

```
COT(<numeric_field>)

```

##### Example (`COT`)

Calculate the trigonometric cotangent of the average angle.

```
COT([Average Angle])

```

---

#### Exponential (`EXP`)

Calculates the exponential value of a given value.

##### Syntax (`EXP`)

```
EXP(<numeric_field>)

```

##### Example (`EXP`)

Calculate the exponential value of sales.

```
EXP([Sales]);

```

---

#### Floor (`FLOOR`)

Calculates a number rounded down to the nearest multiple of 1.

##### Syntax (`FLOOR`)

```
FLOOR(<numeric_field>)

```

##### Example (`FLOOR`)

Calculate the rounded down total cost. For example, when the cost is 83.2 it is rounded down to 83.

```
CEILING([Total Cost])

```

---

#### Natural Log (`LN`)

Calculates the base-e logarithm of a given value.

##### Syntax (`LN`)

```
LN(<numeric_field>)

```

##### Example (`LN`)

Returns the base e-logarithm of the interest rate.

```
LN([Interest Rate])

```

---

#### Log Base-10 (`LOG10`)

Calculates the base-10 logarithm of a given value.

##### Syntax (`LOG10`)

```
LOG10(<numeric_field>)

```

##### Example (`LOG10`)

Calculates the base-10 logarithm of the interest rate.

```
LOG10([Interest Rate])

```

---

#### Modulo (`MOD`)

Calculates the remainder (modulo) after a given value is divided by a number.

##### Syntax (`MOD`)

```
MOD(<numeric_field>)

```

##### Example (`MOD`)

Calculate the remainder of the cost divided by 10. For example, if the cost is 25, the remainder is 5.

```
MOD([Cost], 10);

```

---

#### Power (`POWER`)

Calculates a given value raised to a specified power.

##### Syntax (`POWER`)

```
POWER(<numeric_field>)

```

##### Example (`POWER`)

Calculate the value of the revenue squared.

```
POWER([Revenue], 2);

```

---

#### Quotient (`QUOTIENT`)

Calculates the integer portion of a division.

##### Syntax (`QUOTIENT`)

```
QUOTIENT(<numeric_field>)

```

##### Example (`QUOTIENT`)

Calculate the cost divided by 10. For example, if the cost is 25, the quotient is 2.

```
QUOTIENT([Cost], 10);

```

---

#### Round (`ROUND`)

Calculates a given value rounded to a specified number of digits.

##### Syntax (`ROUND`)

```
ROUND(<numeric_field>, <decimal_places>)

```

- `numeric_field`: Field to round.
- `decimal_places`: Number of decimal places to round to.

##### Example (`ROUND`)

Calculate the revenue rounded to two decimal places.

```
ROUND([Revenue], 2);

```

---

#### Sine (`SIN`)

Calculates the trigonometric sine of a given angle (in radians).

##### Syntax (`SIN`)

```
SIN(<numeric_field>)

```

##### Example (`SIN`)

Calculate the trigonometric sine of the average angle.

```
SIN([Average Angle])

```

---

#### Square Root (`SQRT`)

Calculates the square root of a given value. The given values must be positive numbers.

##### Syntax (`SQRT`)

```
SQRT(<numeric_field>)

```

##### Example (`SQRT`)

Calculate the square root of the cost.

```
SQRT([Cost]);

```

---

#### Tangent (`TAN`)

Calculates the trigonometric tangent of a given angle (in radians).

##### Syntax (`TAN`)

```
TAN(<numeric_field>)

```

##### Example (`TAN`)

Calculate the trigonometric tangent of the average angle.

```
TAN([Average Angle])

```

---

a given angle (in radians).

##### Syntax (`TAN`)

```
TAN(<numeric_field>)

```

##### Example (`TAN`)

Calculate the trigonometric tangent of the average angle.

```
TAN([Average Angle])

```

---

### Time-related Functions

Functions that work with dates and times.

---

#### Second Difference (`SDIFF`)

Calculates the difference between an end time and start time in seconds.

##### Syntax (`SDIFF`)

```
SDIFF(<end_datetime_field>, <start_datetime_field>)

```

- `end_datetime_field`: Ending time to take the difference from
- `start_datetime_field`: Starting time to take the difference from

##### Example (`SDIFF`)

Calculate the difference in seconds from the time of entering to the time of leaving.

```
SDIFF([Leave Time], [Enter Time])

```

---

#### Minute Difference (`MNDIFF`)

Calculates the difference between an end time and start time in whole minutes.

##### Syntax (`MNDIFF`)

```
MNDIFF(<end_datetime_field>, <start_datetime_field>)

```

- `end_datetime_field`: Ending time to take the difference from
- `start_datetime_field`: Starting time to take the difference from

##### Example (`MNDIFF`)

Calculate the difference in minutes from the time of entering to the time of leaving.

```
MNDIFF([Leave Time], [Enter Time])

```

---

#### Hour Difference (`HDIFF`)

Calculates the difference between an end time and start time in whole hours.

##### Syntax (`HDIFF`)

```
HDIFF(<end_datetime_field>, <start_datetime_field>)

```

- `end_datetime_field`: Ending time to take the difference from
- `start_datetime_field`: Starting time to take the difference from

##### Example (`HDIFF`)

Calculate the difference in hours from the time of entering to the time of leaving.

```
HDIFF([Leave Time], [Enter Time])

```

---

#### Day Difference (`DDIFF`)

Calculates the difference between an end time and start time in whole days.

##### Syntax (`DDIFF`)

```
DDIFF(<end_datetime_field>, <start_datetime_field>)

```

- `end_datetime_field`: Ending time to take the difference from
- `start_datetime_field`: Starting time to take the difference from

##### Example (`DDIFF`)

Calculate the difference in days from the time of entering to the time of leaving.

```
DDIFF([Leave Time], [Enter Time])

```

---

#### Month Difference (`MDIFF`)

Calculates the difference between an end time and start time in whole months.

##### Syntax (`MDIFF`)

```
MDIFF(<end_datetime_field>, <start_datetime_field>)

```

- `end_datetime_filed`: Ending time to take the difference from
- `start_datetime_field`: Starting time to take the difference from

##### Example (`MDIFF`)

Calculate the difference in months from the time of entering to the time of leaving.

```
MDIFF([Leave Time], [Enter Time])

```

---

#### Quarter Difference (`QDIFF`)

Calculates the difference between an end time and start time in whole quarters.

##### Syntax (`QDIFF`)

```
QDIFF(<end_datetime_field>, <start_datetime_field>)

```

- `end_datetime_filed`: Ending time to take the difference from
- `start_datetime_field`: Starting time to take the difference from

##### Example (`QDIFF`)

Calculate the difference in quarters from the time of entering to the time of leaving.

```
QDIFF([Leave Time], [Enter Time])

```

---

#### Year Difference (`YDIFF`)

Calculates the difference between an end time and start time in whole years.

##### Syntax (`YDIFF`)

```
YDIFF(<end_datetime_field>, <start_datetime_field>)

```

- `end_datetime_filed`: Ending time to take the difference from
- `start_datetime_field`: Starting time to take the difference from

##### Example (`YDIFF`)

Calculate the difference in years from the time of entering to the time of leaving.

```
YDIFF([Leave Time], [Enter Time])

```

---

#### Past Week Difference (`DIFFPASTWEEK`)

Calculates the difference between this week's data and the data from the previous week.

Use this function when the [date resolution](#date-resolution) used in your query is day or week.

- For day resolution, calculates the sales in the current day minus the sales in the same day one week ago.
- For week resolution, calculates the sales in current week minus the sales in previous week.

##### Syntax (`DIFFPASTWEEK`)

```
DIFFPASTWEEK(<numeric_field>)

```

##### Example (`DIFFPASTWEEK`)

Calculate the difference between this week's sales and the previous week's sales.

```
DIFFPASTWEEK([Total Sales])

```

---

#### Past Month Difference (`DIFFPASTMONTH`)

Calculates the difference between this month's data and the data from the previous month.

Use this function when the [date resolution](#date-resolution) used in your query is month, week, or day.

- For day resolution, calculates the sales in the current day minus the sales in the same day one month ago.
- For week resolution, calculates the sales in current week minus the sales in the same week one month ago.
- For month resolution, calculates the sales in the current month minus the sales in the previous month.

##### Syntax (`DIFFPASTMONTH`)

```
DIFFPASTMONTH(<numeric_field>)

```

##### Example (`DIFFPASTMONTH`)

Calculate the difference between this month's sales and the previous month's sales.

```
DIFFPASTMONTH([Total Sales])

```

---

#### Past Quarter Difference (`DIFFPASTQUARTER`)

Calculates the difference between this quarter's data and the data from the previous quarter.

Use this function when the [date resolution](#date-resolution) used in your query is month, quarter, week, or day.

- For day resolution, calculates the sales in the current day minus the sales in the same day one quarter ago.
- For week resolution, calculates the sales in current week minus the sales in the same week one quarter ago.
- For month resolution, calculates the sales in current month minus the sales in the same month one quarter ago.
- For quarter resolution, calculates the sales in the current quarter minus the sales in the previous quarter.

##### Syntax (`DIFFPASTQUARTER`)

```
DIFFPASTQUARTER(<numeric_field>)

```

##### Example (`DIFFPASTQUARTER`)

Calculate the difference between this quarter's sales and the previous quarter's sales.

```
DIFFPASTQUARTER([Total Sales])

```

---

#### Past Year Difference (`DIFFPASTYEAR`)

Calculates the difference between this year's data and the data from the previous year.

You can use this function with any [date resolution](#date-resolution) (day, week, month, quarter, or year) in your query.

- For day resolution, calculates the sales in the current day minus the sales in the same day one year ago.
- For month resolution, calculates the sales in current month minus the sales in the same month one year ago.
- For week resolution, calculates the sales in current week minus the sales in the same week one year ago.
- For quarter resolution, calculates the sales in the current quarter minus the sales in the previous quarter.
- For year resolution, calculates the sales in the current year minus the sales in the previous year.

##### Syntax (`DIFFPASTYEAR`)

```
DIFFPASTYEAR(<numeric_field>)

```

##### Example (`DIFFPASTYEAR`)

Calculate the difference between this year's sales and the previous year's sales.

```
DIFFPASTYEAR([Total Sales])

```

---

#### Past Period Difference (`DIFFPASTPERIOD`)

Calculates the difference between this period's data and the data from the previous period.

You can use this function with any [date resolution](#time-related-functions) (day, week, month, quarter, or year) in your query.

##### Syntax (`DIFFPASTPERIOD`)

```
DIFFPASTPERIOD(<numeric_field>)

```

##### Example (`DIFFPASTPERIOD`)

Calculate the difference between this period's sales and the previous period's sales.

```
DIFFPASTPERIOD([Total Sales])

```

---

#### Growth (`GROWTH`)

Calculates growth over a period of time.

You can use this function with any [date resolution](#date-resolution) (day, week, month, quarter, or year) in your query.

Growth is calculated as the current period's value minus the previous period's value divided by the previous period's value (`(current - previous) / previous`). If the previous period's value is greater than the current period's value, the growth will be negative.

For example:

- If this period the value is 12 and the previous period's value was 10, the growth for this period is 20%, returned as '0.2' (calculation: (12 – 10) / 10 = 0.2).
- If this period the value is 80, and the previous period's value was 100, the growth for this period is -20%, returned as -0.2 (calculation: (80 – 100) / 100 = -0.2).

##### Syntax (`GROWTH`)

```
GROWTH(<numeric_field>)

```

##### Example (`GROWTH`)

Calculate the growth of total sales over a period of time.

```
GROWTH([Total Sales])

```

---

#### Growth Rate (`GROWTHRATE`)

Calculates growth rate over a period of time.

You can use this function with any [date resolution](#date-resolution) (day, week, month, quarter, or year) in your query.

Growth rate is calculated as the current period's value divided by the previous period's value (`current / previous`). If the previous period's value is greater than the current period's value, the growth rate will be less than `1`.

For example:

- If this period the value is 12 and the previous period's value was 10, the growth rate for this period is 120%, returned as '1.2' (calculation: 12 / 10 = 1.2).
- If this period the value is 80, and the previous period's value was 100, the growth for this period is 80%, returned as 0.8 (calculation: 80 / 100 = .8).

##### Syntax (`GROWTHRATE`)

```
GROWTHRATE(<numeric_field>)

```

##### Example (`GROWTHRATE`)

Calculate the growth rate of total sales over a period of time.

```
GROWTHRATE([Total Sales])

```

---

#### Growth Past Week (`GROWTHPASTWEEK`)

Calculates the growth from the past week to the current week.

Use this function when the [date resolution](#date-resolution) in your query is days or weeks.

- For day resolution, calculates the growth for the current day in comparison to the same day one week ago.
- For week resolution, calculates the growth for the current week in comparison to the previous week.

Growth is calculated as the current week's value minus the previous week's value divided by the previous week's value (`(current - previous) / previous`). If the previous week's value is greater than the current week's value, the growth will be negative.

For example:

- If this week the value is 12 and the previous week's value was 10, the growth for this week is 20%, returned as '0.2' (calculation: (12 – 10) / 10 = 0.2).
- If this week the value is 80, and the previous week's value was 100, the growth for this week is -20%, returned as -0.2 (calculation: (80 – 100) / 100 = -0.2).

##### Syntax (`GROWTHPASTWEEK`)

```
GROWTHPASTWEEK(<numeric_field>)

```

##### Example (`GROWTHPASTWEEK`)

Calculate the growth of total sales over the past week.

```
GROWTHPASTWEEK([Total Sales])

```

---

#### Growth Past Month (`GROWTHPASTMONTH`)

Calculates the growth from the past month to the current month.

Use this function when the [date resolution](#date-resolution) in your query is days, weeks, or months.

- For day resolution, calculates the growth for the current day in comparison to the same day one month ago.
- For week resolution, calculates the growth for the current week in comparison to the same week one month ago.
- For month resolution, calculates the growth for the current month in comparison to the previous month.

Growth is calculated as the current month's value minus the previous month's value divided by the previous month's value (`(current - previous) / previous`). If the previous month's value is greater than the current week's value, the growth will be negative.

For example:

- If this month the value is 12 and the previous month's value was 10, the growth for this month is 20%, returned as '0.2' (calculation: (12 – 10) / 10 = 0.2).
- If this month the value is 80, and the previous month's value was 100, the growth for this month is -20%, returned as -0.2 (calculation: (80 – 100) / 100 = -0.2).

##### Syntax (`GROWTHPASTMONTH`)

```
GROWTHPASTMONTH(<numeric_field>)

```

##### Example (`GROWTHPASTMONTH`)

Calculate the growth of total sales over the past month.

```
GROWTHPASTMONTH([Total Sales])

```

---

#### Growth Past Quarter (`GROWTHPASTQUARTER`)

Calculates the growth from the past quarter to the current quarter.

Use this function when the [date resolution](#date-resolution) in your query is days, months, weeks, or quarters.

- For day resolution, calculates the growth for the current day in comparison to the same day one month ago.
- For week resolution, calculates the growth for the current week in comparison to the same week one month ago.
- For month resolution, calculates the growth for the current month in comparison to the same month one quarter ago.
- For quarter resolution, calculates the growth for the current quarter in comparison to the previous quarter.

Growth is calculated as the current quarter's value minus the previous quarter's value divided by the previous quarter's value (`(current - previous) / previous`). If the previous quarter's value is greater than the current quarter's value, the growth will be negative.

For example:

- If this quarter the value is 12 and the previous quarter's value was 10, the growth for this quarter is 20%, returned as '0.2' (calculation: (12 – 10) / 10 = 0.2).
- If this quarter the value is 80, and the previous quarter's value was 100, the growth for this quarter is -20%, returned as -0.2 (calculation: (80 – 100) / 100 = -0.2).

##### Syntax (`GROWTHPASTQUARTER`)

```
GROWTHPASTQUARTER(<numeric_field>)

```

##### Example (`GROWTHPASTQUARTER`)

Calculate the growth of total sales over the past quarter.

```
GROWTHPASTQUARTER([Total Sales])

```

---

#### Growth Past Year (`GROWTHPASTYEAR`)

Calculates the growth from the past year to the current year.

Use this function when the [date resolution](#date-resolution) in your query is days, weeks, months, quarters, or years.

- For day resolution, calculates the growth for the current day in comparison to the same day one year ago.
- For week resolution, calculates the growth for the current week in comparison to the same week one year ago.
- For month resolution, calculates the growth for the current month in comparison to the same month one year ago.
- For quarter resolution, calculates the growth for the current quarter in comparison to the same quarter one year ago.
- For year resolution, calculates the growth for the current year in comparison to the previous year.

Growth is calculated as the current year's value minus the previous year's value divided by the previous year's value (`(current - previous) / previous`). If the previous year's value is greater than the current year's value, the growth will be negative.

For example:

- If this year the value is 12 and the previous year's value was 10, the growth for this year is 20%, returned as '0.2' (calculation: (12 – 10) / 10 = 0.2).
- If this year the value is 80, and the previous year's value was 100, the growth for this year is -20%, returned as -0.2 (calculation: (80 – 100) / 100 = -0.2).

##### Syntax (`GROWTHPASTYEAR`)

```
GROWTHPASTYEAR(<numeric_field>)

```

##### Example (`GROWTHPASTYEAR`)

Calculate the growth of total sales over the past year.

```
GROWTHPASTYEAR([Total Sales])

```

---

#### Past Day (`PASTDAY`)

Gets the value for a previous day. You can specify the number of days to go back. By default, gets the value for the previous day.

You can use this function when the [date resolution](#date-resolution) in your query is day.

##### Syntax (`PASTDAY`)

```
PASTDAY(<numeric_field>, [<number_of_periods>])

```

- `numeric_field`: Field to get the value from.
- `number_of_perionds`: Optional. The number of prior periods to use for the calculation. Defaults to the previous day.

##### Examples (`PASTDAY`)

Get the total sales value for yesterday.

```
PASTDAY([Total Sales])

```

Get the total sales value for 2 days ago.

```
PASTDAY([Total Sales], 2)

```

---

#### Past Week (`PASTWEEK`)

Returns the value for the same period in the previous week. You can specify the number of weeks to go back. By default, gets the value for the previous week.

You can use this function when the [date resolution](#date-resolution) in your query is day or week.

- For day resolution, gets the value for the current day in a previous week.
- For week resolution, gets the value for a previous week.

##### Syntax (`PASTWEEK`)

```
PASTWEEK(<numeric_field>, [<number_of_periods>])

```

- `numeric_field`: Field to get the value from.
- `number_of_perionds`: Optional. The number of prior periods to use for the calculation. Defaults to the previous week.

##### Examples (`PASTWEEK`)

Get the total sales value from last week.

```
PASTWEEK([Total Sales])

```

Get the total sales value from two weeks ago.

```
PASTWEEK([Total Sales], 2)

```

---

#### Past Month (`PASTMONTH`)

Returns the value for the same period in the previous month. You can specify the number of months to go back. By default, gets the value for the previous month.

You can use this function when the [date resolution](#date-resolution) in your query is day, week, or month.

- For day resolution, gets the value for the current day in a previous month.
- For week resolution, gets the value for the current week in a previous month.
- For month resolution, gets the value for a previous month.

##### Syntax (`PASTMONTH`)

```
PASTMONTH(<numeric_field>, [<number_of_periods>])

```

- `numeric_field`: Field to get the value from.
- `number_of_perionds`: Optional. The number of prior periods to use for the calculation. Defaults to the previous month.

##### Examples (`PASTMONTH`)

Get the total sales value from last month.

```
PASTMONTH([Total Sales])

```

Get the total sales value from two months ago.

```
PASTMONTH([Total Sales], 2)

```

---

#### Past Quarter (`PASTQUARTER`)

Returns the value for the same period in the previous quarter. You can specify the number of quarters to go back. By default, gets the value for the previous quarter.

You can use this function when the [date resolution](#date-resolution) in your query is day, week, month, or quarter.

- For day resolution, gets the value for the current day in a previous quarter.
- For week resolution, gets the value for the current week in a previous quarter.
- For month resolution, gets the value for the current month in a previous quarter.
- For quarter resolution, gets the value for a previous quarter.

##### Syntax (`PASTQUARTER`)

```
PASTQUARTER(<numeric_field>, [<number_of_periods>])

```

- `numeric_field`: Field to get the value from.
- `number_of_perionds`: Optional. The number of prior periods to use for the calculation. Defaults to the previous quarter.

##### Examples (`PASTQUARTER`)

Get the total sales value from last quarter.

```
PASTQUARTER([Total Sales])

```

Get the total sales value from two quarters ago.

```
PASTQUARTER([Total Sales], 2)

```

---

#### Past Year (`PASTYEAR`)

Returns the value for the same period in the previous year. You can specify the number of years to go back. By default, gets the value for the previous year.

You can use this function when the [date resolution](#date-resolution) in your query is day, week, month, quarter, or year.

- For day resolution, gets the value for the current day in a previous year.
- For week resolution, gets the value for the current week in a previous year.
- For month resolution, gets the value for the current month in a previous year.
- For quarter resolution, gets the value for the current month in a previous year.
- For year resolution, gets the value for a previous year.

##### Syntax (`PASTYEAR`)

```
PASTYEAR(<numeric_field>, [<number_of_periods>])

```

- `numeric_field`: Field to get the value from.
- `number_of_perionds`: Optional. The number of prior periods to use for the calculation. Defaults to the previous year.

##### Examples (`PASTYEAR`)

Get the total sales value from last year.

```
PASTYEAR([Total Sales])

```

Get the total sales value from two years ago.

```
PASTYEAR([Total Sales], 2)

```

---

#### Week to Date Average (`WTDAVG`)

Calculates a running average starting from the beginning of the week up to the current day.

You can use this function when the [date resolution](#date-resolution) in your query is day.

##### Syntax (`WTDAVG`)

```
WTDAVG(<numeric_field>)

```

##### Example (`WTDAVG`)

Calculate the running average of total sales starting from the beginning of the week up to the current day.

```
WTDAVG([Total Sales])

```

---

#### Week to Date Sum (`WTDSUM`)

Calculates a running sum starting from the beginning of the week up to the current day.

You can use this function when the [date resolution](#date-resolution) in your query is day.

##### Syntax (`WTDSUM`)

```
WTDSUM(<numeric_field>)

```

##### Example (`WTDSUM`)

Calculate the running sum of total sales starting from the beginning of the week up to the current day.

```
WTDSUM([Total Sales])

```

---

#### Month to Date Average (`MTDAVG`)

Calculates a running average starting from the beginning of the month up to the current day or week.

You can use this function when the [date resolution](#date-resolution) in your query is days or weeks.

- For day resolution, gets the running average from the beginning of the year up to the current day.
- For week resolution, gets the running average from the beginning of the year up to the current week.

##### Syntax (`MTDAVG`)

```
MTDAVG(<numeric_field>)

```

##### Example (`MTDAVG`)

Calculate the running average of total sales starting from the beginning of the month up to the current day or week.

```
MTDAVG([Total Sales])

```

---

#### Month to Date Sum (`MTDSUM`)

Calculates a running sum starting from the beginning of the month up to the current day or week.

You can use this function when the [date resolution](#date-resolution) in your query is days or weeks.

- For day resolution, gets the running sum from the beginning of the year up to the current day.
- For week resolution, gets the running sum from the beginning of the year up to the current week.

##### Syntax (`MTDSUM`)

```
MTDSUM(<numeric_field>)

```

##### Example (`MTDSUM`)

Calculate the running average of total sales starting from the beginning of the month up to the current day or week.

```
MTDSUM([Total Sales])

```

---

#### Quarter to Date Average (`QTDAVG`)

Calculates a running average starting from the beginning of the quarter up to the current day, week, or month.

You can use this function when the [date resolution](#date-resolution) in your query is days, weeks, or months.

- For day resolution, gets the running average from the beginning of the year up to the current day.
- For week resolution, gets the running average from the beginning of the year up to the current week.
- For month resolution, gets the running average from the beginning of the year up to the current month.

##### Syntax (`QTDAVG`)

```
QTDAVG(<numeric_field>)

```

##### Example (`QTDAVG`)

Calculate the running average of total sales starting from the beginning of the quarter up to the current day, week, or month.

```
QTDAVG([Total Sales])

```

---

#### Quarter to Date Sum (`QTDSUM`)

Calculates a running sum starting from the beginning of the quarter up to the current day, week, or month.

You can use this function when the [date resolution](#date-resolution) in your query is days, weeks, or months.

- For day resolution, gets the running sum from the beginning of the year up to the current day.
- For week resolution, gets the running sum from the beginning of the year up to the current week.
- For month resolution, gets the running sum from the beginning of the year up to the current month.

##### Syntax (`QTDSUM`)

```
QTDSUM(<numeric_field>)

```

##### Example (`QTDSUM`)

Calculate the running sum of total sales starting from the beginning of the quarter up to the current day, week, or month.

```
QTDSUM([Total Sales])

```

---

#### Year to Date Average (`YTDAVG`)

Calculates a running average starting from the beginning of the year up to the current day week, month, or quarter.

You can use this function when the [date resolution](#date-resolution) in your query is days, weeks, months, or quarters.

- For day resolution, gets the running average from the beginning of the year up to the current day.
- For week resolution, gets the running average from the beginning of the year up to the current week.
- For month resolution, gets the running average from the beginning of the year up to the current month.
- For quarter resolution, gets the running average from the beginning of the year up to the current quarter.

##### Syntax (`YTDAVG`)

```
YTDAVG(<numeric_field>)

```

##### Example (`YTDAVG`)

Calculate the running average of total sales starting from the beginning of the year up to the current day, week, month, or quarter.

```
YTDAVG([Total Sales])

```

---

#### Year to Date Sum (`YTDSUM`)

Calculates a running sum starting from the beginning of the year up to the current day week, month, or quarter.

You can use this function when the [date resolution](#date-resolution) in your query is days, weeks, months, or quarters.

- For day resolution, gets the running sum from the beginning of the year up to the current day.
- For week resolution, gets the running sum from the beginning of the year up to the current week.
- For month resolution, gets the running sum from the beginning of the year up to the current month.
- For quarter resolution, gets the running sum from the beginning of the year up to the current quarter.

##### Example (`YTDSUM`)

Calculate the running sum of total sales starting from the beginning of the year up to the current day, week, month, or quarter.

```
YTDSUM([Total Sales])

```

---

rter.

##### Example (`YTDSUM`)

Calculate the running sum of total sales starting from the beginning of the year up to the current day, week, month, or quarter.

```
YTDSUM([Total Sales])

```

---

### Measured Value Functions

Formulas often need to take into account specific criteria. To do this, Sisense provides a feature called Measured Values. A measured value only performs a calculation when the values in a field meet specific criteria. Criteria for measured values can be based on any logical operators in a filter.

Measured values are used to:

- Cancel the filters in a formula
- Cancel the grouping in a formula

---

#### All (`ALL`)

Changes the scope of a measure calculation to ignore grouping and filters while calculating a formula.

##### Syntax (`ALL`)

```
ALL(<any_field_type>)

```

- `any_field_type`: Any groupable field.

##### Example (`ALL`)

Calculates the total revenue for all years together, despite any grouping or filtering by years.

```
SUM([Revenue]), ALL([Years in Date]);

```

---

#### Previous (`PREV`)

Gets the time period member in a time field which is a specified number of periods before the current member. By default, if no number of periods is specified, the immediately previous period is retrieved.

This function works will all [date resolutions](#date-resolution). However, the active date resolution of the query must match the date resolution in the function.

##### Syntax (`PREV`)

```
PREV(<datetime_field>, [<n>])

```

- `datetime_field`: Any field containing a datetime.
- `n`: Optional. The number of periods to go back.

##### Examples (`PREV`)

Get the total quantity for the previous month when grouping by month.

```
(SUM([Quantity]), PREV([Months in Date]))

```

Get the total quantity for 2 months proir when grouping by month.

```
(SUM([Quantity]), PREV([Months in Date], 2))

```

---

#### Next (`NEXT`)

Gets the time period member in a time field which is a specified number of periods after the current member. By default, if no number of periods is specified, the immediately next period is retrieved.

This function works will all [date resolutions](#date-resolution). However, the active date resolution of the query must match the date resolution in the function.

##### Syntax (`NEXT`)

```
PREV(<datetime_field>, [<n>])

```

- `datetime_field`: Any field containing a datetime.
- `n`: Optional. The number of periods to go forward.

##### Example (`NEXT`)

Get the total quantity for the next month when grouping by month.

```
(SUM([Quantity]), NEXT([Months in Date]))

```

Get the total quantity for 2 months later when grouping by month.

```
(SUM([Quantity]), NEXT([Months in Date], 2))

```

---

#### Now (`NOW`)

Gets the time period member in a time field which matches the current query execution time.

This function works will all [date resolutions](#date-resolution). However, the active date resolution of the query must match the date resolution in the function.

##### Syntax (`NOW`)

```
NOW(<datetime_field>)

```

##### Example (`NOW`)

Get the total quantity for the current month when grouping by month.

```
(SUM([Quantity]), NOW([Months in Date]))

```

---

## Syntax (`NOW`)

```
NOW(<datetime_field>)

```

##### Example (`NOW`)

Get the total quantity for the current month when grouping by month.

```
(SUM([Quantity]), NOW([Months in Date]))

```

---

### Other Functions

Additional functions for conditionals, null checking, and more.

#### Case (`CASE`)

Returns the result expression of the first condition that evaluates as true. If none of the conditions are true, the `ELSE` result expression for the is returned if one is specified.

##### Syntax (`CASE`)

```
(WHEN <condition> THEN <result_expression_true> [...] [ELSE <result expression_false>] END)

```

- `condition`: Boolean expression.
- `result_expression_true`: Any number, formula, or function that is returned when the `condition` is true.
- `result_expression_false`: Any number, formula, or function that is returned when the `condition` is false.

#### Examples (`CASE`)

Return 1 when the total sales is less than 100. Return 2 if total sales value is 100 or greater.

```
CASE WHEN SUM([Sales]) < 100 THEN 1 ELSE 2 END

```

Return 1 when the total sales is less than 100. Return 2 if total sales value is between 100 and 1000. Return 3 in when total sales are above 1000.

```
CASE WHEN SUM([Sales]) < 100 THEN 1 WHEN SUM ([Sales]) < 1000 THEN 2 ELSE 3 END

```

---

#### If (`IF`)

Returns the first expression when the condition is true and it returns the second expression when the condition is false. Nested conditional statements are supported.

##### Syntax (`IF`)

```
IF(<condition>, <numeric_expression_true>, <numeric_expression_false>)

```

- `condition`: Boolean expression.
- `numeric_expression_true`: Numeric expression that is evaluated when the `condition` is true.
- `numeric_expression_true`: Numeric expression that is evaluated when the `condition` is false.

##### Example (`IF`)

If total sales is larger than 100, return the Total Sales x 1.1 (sales increase of 10%). Otherwise, return the total sales without an increase.

```
IF(SUM([Sales]) > 100, SUM([Sales]) * 1.1, SUM([Sales]))

```

---

#### Is Null (`ISNULL`)

Returns true if the expression does not contain data.

##### Syntax (`ISNULL`)

```
ISNULL(<numeric_field>)

```

##### Example (`ISNULL`)

```
If (ISNULL(SUM([Sales])), 0, SUM([Sales]) )

```

---

#### Now (`NOW`)

Returns the current execution time.

##### Syntax (`NOW`)

```
NOW()

```

##### Example (`NOW`)

Get the hour difference from enter time until now.

```
HDiff(NOW(), [Enter Time])

```

#### Running Average (`RAVG`)

Returns the running average of the given values according to the query's sorting order.

By default, `RAVG` averages a measure by the sorting order of the query's dimension. To average by another order, add the relevant measure to the query and by that measure.

You can specify a boolean value to indicate whether to calculate the average continuously when there are two or more dimensions. By default, the average is not calculated continuously.

##### Syntax (`RAVG`)

```
RAVG(<numeric_field>, [<continuous>])

```

- `numeric_field`: Field to calculate the running average for.
- `continuous`: Optional. A boolean value that determines whether to calculate the average continuously when there are two or more dimensions. Defaults to `FALSE`.

##### Example (`RAVG`)

Get the running average of the total revenue.

```
RAVG([Total Revenue])

```

---

#### Running Sum (`RSUM`)

Returns the running sum of the given values according to the query's sorting order.

By default, `RSUM` accumulates a measure by the sorting order of the query's dimension. To accumulate by another order, add the relevant measure to the query and by that measure.

You can specify a boolean value to indicate whether to accumulate the sum continuously when there are two or more dimensions. By default, the sum is not accumulated continuously.

##### Syntax (`RSUM`)

```
RSUM(<numeric_field>, [<continuous>])

```

- `numeric_field`: Field to calculate the running sum for.
- `continuous`: Optional. A boolean value that determines whether to accumulate the sum continuously when there are two or more dimensions. Defaults to `FALSE`.

##### Example (`RSUM`)

Get the running total of the total revenue.

```
RSUM([Total Revenue])

```

---

accumulate the sum continuously when there are two or more dimensions. Defaults to `FALSE`.

##### Example (`RSUM`)

Get the running total of the total revenue.

```
RSUM([Total Revenue])

```

---

## Fusion Elasticube-only Functions

These functions can **only** be used with Fusion ElastiCube datamodels (see [documentation](https://docs.sisense.com/main/SisenseLinux/data-sources.htm?tocpath=Data%20Sources%7C_____1#DataSourceConnectionTypes) for further details).

ed with Fusion ElastiCube datamodels (see [documentation](https://docs.sisense.com/main/SisenseLinux/data-sources.htm?tocpath=Data%20Sources%7C_____1#DataSourceConnectionTypes) for further details).

### Aggregative Functions

Functions that create aggregations.

---

#### Correlation (`CORREL`)

Calculates the correlation coefficient of two numeric fields.

##### Syntax (`CORREL`)

```
CORREL(<numeric_field_a>, <numeric_field_b>)

```

```
CORREL(<group_by_field>, <aggregation_a>, <aggregation_b>)

```

##### Examples (`CORREL`)

Calculate the correlation between revenue and cost.

```
CORREL([Revenue], [Cost]);

```

Calculate the correlation between the average revenue and average cost per product.

```
CORREL([Products], AVG([Revenue]), AVG([Cost]));

```

---

#### Covariance - Population (`COVARP`)

Calculates the population covariance of two numeric fields.

##### Syntax (`COVARP`)

```
COVARP(<numeric_field_a>, <numeric_field_b>)

```

```
COVARP(<group_by_field>, <aggregation_a>, <aggregation_b>)

```

##### Examples (`COVARP`)

Calculate the population covariance of revenue and cost.

```
COVARP([Revenue], [Cost]);

```

Calculate the population covariance of the average revenue and the average cost per product.

```
COVARP([Products], AVG([Revenue]), AVG([Cost]));

```

---

#### Covariance - Sample (`COVAR`)

Calculates the sample covariance of two numeric fields.

##### Syntax (`COVAR`)

```
COVAR(<numeric_field_a>, <numeric_field_b>)

```

```
COVAR(<group_by_field>, <aggregation_a>, <aggregation_b>)

```

##### Examples (`COVAR`)

Calculate the sample covariance of revenue and cost.

```
COVAR([Revenue], [Cost]);

```

Calculate the sample covariance of the average revenue and the average cost per product.

```
COVAR([Products], AVG([Revenue]), AVG([Cost]));

```

---

#### Skewness - Population (`SKEWP`)

Calculates the skewness of the distribution of a given value in a population.

##### Syntax (`SKEWP`)

```
SKEWP(<numeric_field>)

```

##### Example (`SKEWP`)

Calculate the skewness of the distribution of scores in a population.

```
SKEWP([Score]);

```

---

#### Skewness - Sample (`SKEW`)

Calculates the skewness of the distribution of a given value in a sample.

##### Syntax (`SKEW`)

```
SKEW(<numeric_field>)

```

##### Example (`SKEW`)

Calculate the skewness of the distribution of scores in a sample.

```
SKEW([Score]);

```

---

#### Slope (`SLOPE`)

Calculates the slope of a linear regression line through the provided series of x and y values.

##### Syntax (`SLOPE`)

```
SLOPE(<numeric_field>, <numeric_field>)

```

##### Example (`SLOPE`)

Calculate the slope of the regression line that represents a trend of items sold for each month.

```
SLOPE([month.int], [Total Sales])

```

---

ld>, <numeric_field>)

```

##### Example (`SLOPE`)

Calculate the slope of the regression line that represents a trend of items sold for each month.

```
SLOPE([month.int], [Total Sales])

```

---

### Statistical Functions

Functions that calculate statistical data.

---

#### Exponential Distribution (`EXPONDIST`)

Calculates the exponential distribution for a given value and a supplied distribution parameter lambda. Choose whether to use a cumulative distribution function by specifying `TRUE` or a probability density function by specifying `FALSE`.

##### Syntax (`EXPONDIST`)

```
EXPONDIST(<numeric_field>, <lambda>, <cumulative>)

```

- `<numeric_field>`: Any numeric field.
- `<lambda>`: Any number.
- `<cumulative>`: A boolean value. `TRUE` for cumulative distribution function. `FALSE` For probability density function.

##### Examples (`EXPONDIST`)

Calculate the cumulative exponential distribution density of the number of leads per country where lambda is 2.

```
EXPONDIST(COUNT([Leads]), 2, TRUE);

```

Calculate the probability exponential distribution density of the number of leads per country where lambda is 2.

```
EXPONDIST(COUNT([Leads]), 2, FALSE);

```

---

#### Intercept (`INTERCEPT`)

Calculates the intercept of a linear regression line through the provided series of x and y values.

##### Syntax (`INTERCEPT`)

```
INTERCEPT(<numeric_field>, <numeric_field>)

```

##### Example (`INTERCEPT`)

Calculate the intercept of the regression line that represents the trend of items sold for each month.

```
INTERCEPT([month.int], [Total Sales])

```

---

#### Normal Distribution (`NORMDIST`)

Calculates the standard normal distribution for a given value, a supplied distribution mean, and standard deviation. Choose whether to use a cumulative distribution function by specifying `TRUE` or a probability mass function by specifying `FALSE`.

##### Syntax (`NORMDIST`)

```
NORMDIST(SUM<numeric_field>, (Mean(<numeric_field>), All(<numeric_field>)),
(standard_deviation(<numeric_field>), All(<numeric field>)), <cumulative>)

```

- `numeric_field`: Any numeric field.
- `mean`: A number representing the distribution mean.
- `standard_deviation`: A number representing the standard deviation.
- `cumulative`: A boolean value. `TRUE` for cumulative distribution function. `FALSE` probability mass function.

##### Example (`NORMDIST`)

Calculate the normal probability density of a given student score.

```
NORMDIST([Score], (MEAN([Score]), ALL([Score])), (STDEV([Score]), ALL([Score])), FALSE);

```

---

#### Poisson Distribution (`POISSONDIST`)

Calculates the Poisson distribution for a given value and a supplied distribution mean. Choose whether to use a cumulative Poisson distribution function by specifying `TRUE` or a Poisson probability mass function by specifying `FALSE`.

##### Syntax (`POISSONDIST`)

```
POISSONDIST(<numeric_field>, <mean>, <cumulative>)

```

- `numeric_field`: Any numeric field.
- `mean`: A number representing the distribution mean.
- `cumulative`: A boolean value. `TRUE` for cumulative Poisson distribution function. `FALSE` Poisson probability mass function.

##### Example (`POISSONDIST`)

Calculate the Poisson probability density of a given number of scores.

```
POISSONDIST([Score], (MEAN([Score]), ALL([Score])), (STDEV([Score]), ALL([Score])), FALSE);

```

---

#### T Distribution (`TDIST`)

Calculates the T-distribution for a given value and a supplied number of degrees of freedom. Choose whether to use a cumulative distribution function by specifying `TRUE` or a probability density function by specifying `FALSE`.

##### Syntax (`TDIST`)

```
TDIST(<numeric field>, <degrees_freedom>, <cumulative>)

```

- `<numeric_field>`: Any numeric field.
- `<degrees_freedom>`: Any value representing the degrees of freedom.
- `<cumulative>`: A boolean value. `TRUE` for cumulative distribution function. `FALSE` for probability density function.

##### Example (`TDIST`)

Calculate a student's T-distribution of a given score, with 3 degrees of freedom.

```
TDIST([Score], 3, TRUE);

```

---

unction. `FALSE` for probability density function.

##### Example (`TDIST`)

Calculate a student's T-distribution of a given score, with 3 degrees of freedom.

```
TDIST([Score], 3, TRUE);

```

---

### Mathematical Functions

Functions that perform mathematical operations.

#### Hyperbolic Cosine (`COSH`)

Calculates the hyperbolic cosine of a given value.

##### Syntax (`COSH`)

```
COSH(<numeric_field>)

```

##### Example (`COSH`)

Calculates the hyperbolic cosine of the total revenue.

```
COSH([Total Revenue])

```

---

#### Hyperbolic Sine (`SINH`)

Calculates the hyperbolic sine of a given value.

##### Syntax (`SINH`)

```
SINH(<numeric_field>)

```

##### Example (`SINH`)

Calculates the hyperbolic sine of the total revenue.

```
SINH([Total Revenue])

```

---

#### Hyperbolic Tangent (`TANH`)

Calculates the hyperbolic tangent of a given value.

##### Syntax (`TANH`)

```
TANH(<numeric_field>)

```

##### Example (`TANH`)

Calculates the hyperbolic tangent of the total revenue.

```
TANH([Total Revenue])

```

---

tangent of a given value.

##### Syntax (`TANH`)

```
TANH(<numeric_field>)

```

##### Example (`TANH`)

Calculates the hyperbolic tangent of the total revenue.

```
TANH([Total Revenue])

```

---

### Other Functions

Additional functions for R expressions.

---

#### Ordering (`ORDERING`)

Calculates the numeric order position of rows sorted into ascending or descending order based on the specified. The expressions must be aggregated by applying the `MIN`/`MAX` functions.

##### Example (`ORDERING`)

```
ORDERING(MIN([Sales Person Name]), MIN([Days in Transaction_Date]), -1 * SUM([Sales]))

```

---

#### R Double (`RDOUBLE`)

Returns a numeric result for a given R expression and a list of numeric values. The R expression is passed to the running Rserve.

Syntax:

```
RDOUBLE(<R expression>, [<ordering>], <numeric value 1>, [<numeric value 2>, ..., <numeric value n>])
RDOUBLE(<recycle>, <R expression>, [<ordering>], <numeric value 1>, [<numeric value 2>, ..., <numeric value n>])

```

Arguments:

- `<R expression>`: Your R code, wrapped in double quotes. R expects the return type to be an array with the same size as the query's row count. Nulls will be used to make up for shorter arrays, and longer arrays will be trimmed. Use single quotes to wrap strings within your R code, so that there will be no double-quote collision with the quotes wrapping your R code.
- `<Numeric Field>`: Numeric values can be passed as arguments to your R code. All arguments are passed to R as a 1-based list named `args`. Each item in the list contains an array that represents the field. For example:
  - `args[[1]]` returns an array which represents the first field that was used as an argument
  - `args[[2]][3]` returns the 3rd data value within the 2nd field that was used as an argument
- `<Ordering>`: Optional. Defines the sort order in which numeric data is sent to R. The argument of the Ordering parameter can be an index in your data source or you can use the [`ORDERING()`](#ordering-ordering) function to determine the order of your fields. This function arranges the values of the arguments into ascending or descending order, breaking ties by further arguments. For example: `ORDERING([Total Sales], -1*[COUNT Salesman], MIN(<Office Name>))`
- `<recycle>`: Optional. Controls whether the results from R should be recycled (cached), so that consequent queries will not have to be recalculated unless they or the data have changed. Generally, behavior is automatically managed by the ElastiCube automatically. However, since R code might have non-deterministic components to it (such as randomality functions or date-specific functions), the ElastiCube cannot rely on a data set and function that has not changed not to return a different result in multiple executions.
  - `TRUE`: Default. Results will be cached for unchanged functions and data.
  - `FALSE`: Results will not be cached. Use this option if your R code contains randomality or other non-deterministic content.

##### Example (RDOUBLE)

Returns the k-means cluster (R expression) of the total cost and total revenue.

```
RDOUBLE("m <-log(matrix(unlist(args), ncol=2)); kmeans (m,3)$cluster", [Total Cost], [Total Revenue])

```

For additional discussion on using `RDOUBLE` and how to do advanced forecasting with R, see [this community post](https://community.sisense.com/kb/faqs/so-how-exactly-does-r-work-with-sisense/8817).

---

#### R Integer (`RINT`)

Returns an integer result for a given R expression and a list of numeric values. The R expression is passed to the running Rserve.

Syntax:

```
RINT(<R expression>, [<ordering>], <numeric value 1>, [<numeric value 2>, ..., <numeric value n>])
RINT(<recycle>, <R expression>, [<ordering>], <numeric value 1>, [<numeric value 2>, ..., <numeric value n>])

```

Arguments:

- `<R expression>`: Your R code, wrapped in double quotes. R expects the return type to be an array with the same size as the query's row count. Nulls will be used to make up for shorter arrays, and longer arrays will be trimmed. Use single quotes to wrap strings within your R code, so that there will be no double-quote collision with the quotes wrapping your R code.
- `<Numeric Field>`: Numeric values can be passed as arguments to your R code. All arguments are passed to R as a 1-based list named `args`. Each item in the list contains an array that represents the field. For example:
  - `args[[1]]` returns an array which represents the first field that was used as an argument
  - `args[[2]][3]` returns the 3rd data value within the 2nd field that was used as an argument
- `<Ordering>`: Optional. Defines the sort order in which numeric data is sent to R. The argument of the Ordering parameter can be an index in your data source or you can use the [`ORDERING()`](#ordering-ordering) function to determine the order of your fields. This function arranges the values of the arguments into ascending or descending order, breaking ties by further arguments. For example: `ORDERING([Total Sales], -1*[COUNT Salesman], MIN(<Office Name>))`
- `<recycle>`: Optional. Controls whether the results from R should be recycled (cached), so that consequent queries will not have to be recalculated unless they or the data have changed. Generally, behavior is automatically managed by the ElastiCube automatically. However, since R code might have non-deterministic components to it (such as randomality functions or date-specific functions), the ElastiCube cannot rely on a data set and function that has not changed not to return a different result in multiple executions.
  - `TRUE`: Default. Results will be cached for unchanged functions and data.
  - `FALSE`: Results will not be cached. Use this option if your R code contains randomality or other non-deterministic content.

##### Example (RINT)

Returns the k-means cluster (R expression) of the total cost and total revenue.

```
RINT("m <-log(matrix(unlist(args), ncol=2)); kmeans (m,3)$cluster", [Total Cost], [Total Revenue])

```

For additional discussion on using `RINT` and how to do advanced forecasting with R, see [this community post](https://community.sisense.com/kb/faqs/so-how-exactly-does-r-work-with-sisense/8817).

---

================================================================================

, see [this community post](https://community.sisense.com/kb/faqs/so-how-exactly-does-r-work-with-sisense/8817).

---

================================================================================
# CROSS-FRAMEWORK EMBEDDING WORKFLOW REFERENCE
================================================================================

This section maps the core Compose SDK embedding workflow across React, Angular,
and Vue. All three frameworks support the same capabilities but use different
patterns (hooks vs services vs composables).

## The Core Embedding Workflow

The Compose SDK "decomposed dashboard" pattern has 4 steps:

1. **Fetch** a dashboard definition from Sisense by OID
2. **Translate** the dashboard model into framework-renderable widget props
3. **Render** individual widgets in your own custom layout
4. **Query** raw data via JAQL for custom components that aren't dashboard widgets

---

## Step 1: Fetch Dashboard Model

### React
```tsx
import { useGetDashboardModel } from '@sisense/sdk-ui';

const { dashboard, isLoading, isError } = useGetDashboardModel({
  dashboardOid: '69af2a2d88988f584e3ea433',
  includeWidgets: true,
  includeFilters: true,
});
```

dModel } from '@sisense/sdk-ui';

const { dashboard, isLoading, isError } = useGetDashboardModel({
  dashboardOid: '69af2a2d88988f584e3ea433',
  includeWidgets: true,
  includeFilters: true,
});
```

### Angular
```typescript
import { DashboardService, DashboardModel } from '@sisense/sdk-ui-angular';

@Component({ /* ... */ })
export class MyComponent implements OnInit {
  dashboardModel: DashboardModel | undefined;

  constructor(private dashboardService: DashboardService) {}

  async ngOnInit() {
    this.dashboardModel = await this.dashboardService.getDashboardModel(
      '69af2a2d88988f584e3ea433',
      { includeWidgets: true, includeFilters: true }
    );
  }
}
```

### Vue
```vue
<script setup lang="ts">
import { useGetDashboardModel } from '@sisense/sdk-ui-vue';

const { dashboard, isLoading, isError } = useGetDashboardModel({
  dashboardOid: '69af2a2d88988f584e3ea433',
  includeWidgets: true,
  includeFilters: true,
});
</script>
```

---

## Step 2: Translate to Renderable Props

### React
```tsx
import { dashboardModelTranslator, useComposedDashboard } from '@sisense/sdk-ui';

// Option A: Simple translation (no cross-filtering coordination)
const dashboardProps = dashboard
  ? dashboardModelTranslator.toDashboardProps(dashboard)
  : null;

// Option B: Composed dashboard (adds cross-filtering, drill coordination)
const { dashboard: composedDashboard, filters, setFilters } = useComposedDashboard({
  ...dashboardModelTranslator.toDashboardProps(dashboard),
});
```

ard (adds cross-filtering, drill coordination)
const { dashboard: composedDashboard, filters, setFilters } = useComposedDashboard({
  ...dashboardModelTranslator.toDashboardProps(dashboard),
});
```

### Angular
```typescript
import {
  DashboardService,
  dashboardModelTranslator,
  type DashboardProps,
} from '@sisense/sdk-ui-angular';

@Component({ /* ... */ })
export class MyComponent implements OnInit, OnDestroy {
  dashboardProps: DashboardProps | undefined;
  private composedDashboard: ReturnType<DashboardService['createComposedDashboard']> | undefined;
  dashboard$: Observable<DashboardProps> | undefined;

  constructor(private dashboardService: DashboardService) {}

  async ngOnInit() {
    const dashboardModel = await this.dashboardService.getDashboardModel(
      '69af2a2d88988f584e3ea433',
      { includeWidgets: true, includeFilters: true }
    );

    // Option A: Simple translation
    this.dashboardProps = dashboardModelTranslator.toDashboardProps(dashboardModel);

    // Option B: Composed dashboard (cross-filtering, drill coordination)
    const initialDashboard = dashboardModelTranslator.toDashboardProps(dashboardModel);
    this.composedDashboard = this.dashboardService.createComposedDashboard(initialDashboard);
    this.dashboard$ = this.composedDashboard.dashboard$;
  }

  ngOnDestroy() {
    this.composedDashboard?.destroy();
  }
}
```

rd = this.dashboardService.createComposedDashboard(initialDashboard);
    this.dashboard$ = this.composedDashboard.dashboard$;
  }

  ngOnDestroy() {
    this.composedDashboard?.destroy();
  }
}
```

### Vue
```vue
<script setup lang="ts">
import {
  useGetDashboardModel,
  useComposedDashboard,
  dashboardModelTranslator,
} from '@sisense/sdk-ui-vue';
import { computed } from 'vue';

const { dashboard } = useGetDashboardModel({
  dashboardOid: '69af2a2d88988f584e3ea433',
  includeWidgets: true,
  includeFilters: true,
});

// Option A: Simple translation
const dashboardProps = computed(() =>
  dashboard.value ? dashboardModelTranslator.toDashboardProps(dashboard.value) : null
);

// Option B: Composed dashboard
const { dashboard: composedDashboard, filters, setFilters } = useComposedDashboard({
  ...dashboardModelTranslator.toDashboardProps(dashboard.value),
});
</script>
```

---

## Step 3: Render Widgets in Custom Layout

composedDashboard, filters, setFilters } = useComposedDashboard({
  ...dashboardModelTranslator.toDashboardProps(dashboard.value),
});
</script>
```

---

## Step 3: Render Widgets in Custom Layout

### React
```tsx
import { Widget } from '@sisense/sdk-ui';

// Render individual widgets from the translated props
const MyCustomLayout = ({ dashboardProps }) => {
  return (
    <div className="my-grid-layout">
      {dashboardProps.widgets.map((widgetProps) => (
        <div key={widgetProps.id} className="my-widget-card">
          <Widget {...widgetProps} />
        </div>
      ))}
    </div>
  );
};
```

You can also render a specific widget by ID from a Fusion dashboard:
```tsx
import { WidgetById } from '@sisense/sdk-ui';

<WidgetById
  widgetOid="widget-oid-here"
  dashboardOid="dashboard-oid-here"
/>
```

### Angular
```typescript
// In your component template:
// <csdk-widget
//   *ngFor="let widgetProps of dashboardProps.widgets"
//   [widgetType]="widgetProps.widgetType"
//   [chartType]="widgetProps.chartType"
//   [dataOptions]="widgetProps.dataOptions"
//   [dataSource]="widgetProps.dataSource"
//   [filters]="widgetProps.filters"
//   [title]="widgetProps.title"
// />

// Or render by widget OID:
// <csdk-widget-by-id
//   [widgetOid]="'widget-oid-here'"
//   [dashboardOid]="'dashboard-oid-here'"
// />
```

dgetProps.filters"
//   [title]="widgetProps.title"
// />

// Or render by widget OID:
// <csdk-widget-by-id
//   [widgetOid]="'widget-oid-here'"
//   [dashboardOid]="'dashboard-oid-here'"
// />
```

### Vue
```vue
<template>
  <div class="my-grid-layout">
    <div v-for="widgetProps in dashboardProps?.widgets" :key="widgetProps.id" class="my-widget-card">
      <Widget v-bind="widgetProps" />
    </div>
  </div>
</template>

<script setup lang="ts">
import { Widget } from '@sisense/sdk-ui-vue';
</script>
```

Or render by widget OID:
```vue
<WidgetById
  :widgetOid="'widget-oid-here'"
  :dashboardOid="'dashboard-oid-here'"
/>
```

---

## Step 4: Raw JAQL Queries for Custom Components

For custom KPI cards, tables, or any UI that isn't a Sisense dashboard widget.

idget-oid-here'"
  :dashboardOid="'dashboard-oid-here'"
/>
```

---

## Step 4: Raw JAQL Queries for Custom Components

For custom KPI cards, tables, or any UI that isn't a Sisense dashboard widget.

### React
```tsx
import { useExecuteQuery } from '@sisense/sdk-ui';
import { measureFactory, filterFactory } from '@sisense/sdk-data';
import * as DM from './sample-ecommerce';

const FleetSummaryCard = () => {
  const { data, isLoading, isError } = useExecuteQuery({
    dataSource: DM.DataSource,
    dimensions: [DM.Commerce.AgeRange],
    measures: [
      measureFactory.sum(DM.Commerce.Revenue, 'Total Revenue'),
      measureFactory.count(DM.Commerce.VisitId, 'Total Visits'),
    ],
    filters: [filterFactory.greaterThan(DM.Commerce.Revenue, 1000)],
  });

  if (isLoading) return <div>Loading...</div>;
  if (isError) return <div>Error</div>;

  return (
    <div>
      <h3>Fleet Summary</h3>
      <p>Rows: {data?.rows.length}</p>
      {/* Render your custom table/cards from data.rows and data.columns */}
    </div>
  );
};
```

r</div>;

  return (
    <div>
      <h3>Fleet Summary</h3>
      <p>Rows: {data?.rows.length}</p>
      {/* Render your custom table/cards from data.rows and data.columns */}
    </div>
  );
};
```

### Angular
```typescript
import { QueryService } from '@sisense/sdk-ui-angular';
import { measureFactory, filterFactory } from '@sisense/sdk-data';
import * as DM from './sample-ecommerce';

@Component({ /* ... */ })
export class FleetSummaryComponent implements OnInit {
  queryResult: any;

  constructor(private queryService: QueryService) {}

  async ngOnInit() {
    this.queryResult = await this.queryService.executeQuery({
      dataSource: DM.DataSource,
      dimensions: [DM.Commerce.AgeRange],
      measures: [
        measureFactory.sum(DM.Commerce.Revenue, 'Total Revenue'),
        measureFactory.count(DM.Commerce.VisitId, 'Total Visits'),
      ],
      filters: [filterFactory.greaterThan(DM.Commerce.Revenue, 1000)],
    });
  }
}
```

mmerce.Revenue, 'Total Revenue'),
        measureFactory.count(DM.Commerce.VisitId, 'Total Visits'),
      ],
      filters: [filterFactory.greaterThan(DM.Commerce.Revenue, 1000)],
    });
  }
}
```

### Vue
```vue
<script setup lang="ts">
import { useExecuteQuery } from '@sisense/sdk-ui-vue';
import { measureFactory, filterFactory } from '@sisense/sdk-data';
import * as DM from './sample-ecommerce';

const { data, isLoading, isError } = useExecuteQuery({
  dataSource: DM.DataSource,
  dimensions: [DM.Commerce.AgeRange],
  measures: [
    measureFactory.sum(DM.Commerce.Revenue, 'Total Revenue'),
    measureFactory.count(DM.Commerce.VisitId, 'Total Visits'),
  ],
  filters: [filterFactory.greaterThan(DM.Commerce.Revenue, 1000)],
});
</script>

<template>
  <div v-if="isLoading">Loading...</div>
  <div v-else-if="isError">Error</div>
  <div v-else>
    <h3>Fleet Summary</h3>
    <p>Rows: {{ data?.rows.length }}</p>
  </div>
</template>
```

---

late>
  <div v-if="isLoading">Loading...</div>
  <div v-else-if="isError">Error</div>
  <div v-else>
    <h3>Fleet Summary</h3>
    <p>Rows: {{ data?.rows.length }}</p>
  </div>
</template>
```

---

## Framework Equivalence Quick Reference

| Capability | React (sdk-ui) | Angular (sdk-ui-angular) | Vue (sdk-ui-vue) |
|---|---|---|---|
| **Context Provider** | `<SisenseContextProvider>` | `SisenseContextModule` | `<SisenseContextProvider>` |
| **Fetch Dashboard** | `useGetDashboardModel()` hook | `DashboardService.getDashboardModel()` | `useGetDashboardModel()` composable |
| **Fetch All Dashboards** | `useGetDashboardModels()` | `DashboardService.getDashboardModels()` | `useGetDashboardModels()` |
| **Translate Model** | `dashboardModelTranslator.toDashboardProps()` | `dashboardModelTranslator.toDashboardProps()` | `dashboardModelTranslator.toDashboardProps()` |
| **Composed Dashboard** | `useComposedDashboard()` hook | `DashboardService.createComposedDashboard()` | `useComposedDashboard()` composable |
| **Render Widget** | `<Widget>` component | `<csdk-widget>` component | `<Widget>` component |
| **Render by OID** | `<WidgetById>` component | `<csdk-widget-by-id>` component | `<WidgetById>` component |
| **Execute Query** | `useExecuteQuery()` hook | `QueryService.executeQuery()` | `useExecuteQuery()` composable |
| **Query by Widget ID** | `useExecuteQueryByWidgetId()` | `QueryService.executeQueryByWidgetId()` | `useExecuteQueryByWidgetId()` |
| **Chart Component** | `<Chart>` | `<csdk-chart>` | `<Chart>` |
| **Dashboard Component** | `<Dashboard>` | `<csdk-dashboard>` | `<Dashboard>` |
| **Dashboard by OID** | `<DashboardById>` | `<csdk-dashboard-by-id>` | `<DashboardById>` |
| **AI Chatbot** | `<Chatbot>` (from sdk-ui/ai) | `SdkAiModule` | `<Chatbot>` (from sdk-ui-vue/ai) |

---

| **Dashboard by OID** | `<DashboardById>` | `<csdk-dashboard-by-id>` | `<DashboardById>` |
| **AI Chatbot** | `<Chatbot>` (from sdk-ui/ai) | `SdkAiModule` | `<Chatbot>` (from sdk-ui-vue/ai) |

---

## Key Packages by Framework

| Package | Description |
|---|---|
| `@sisense/sdk-data` | Shared across all frameworks. Data model types, `measureFactory`, `filterFactory`, `analyticsFactory` |
| `@sisense/sdk-ui` | React components and hooks |
| `@sisense/sdk-ui-angular` | Angular components, directives, and services |
| `@sisense/sdk-ui-vue` | Vue components and composables |
| `@sisense/sdk-cli` | CLI tool for generating TypeScript data models from Sisense instance |
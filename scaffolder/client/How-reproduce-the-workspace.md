# How reproduce the workspace

## workspace creation

```[powershell]
npx create-nx-workspace@latest boobafetes-chatbot --pm=yarn --preset=apps  --interactive --no-nxCloud
cd boobafetes-chatbot
# add nx projects dependencies
yarn add @nx/express @nx/react @nx/js
```

 > info : today (may 2023), nx create a v16.1.1 workspace, tomorrow it will be highter and theses command can not works

 We use the clean architecture to design our software.

## create client presenter with react.js

```[powershell]
yarn nx g @nx/react:application client-presenter-react --tags="client, application" --bundler=webpack --pascalCaseFiles --routing --style="@emotion/styled" --no-strict --e2eTestRunner=none
yarn add @mui/material @emotion/react @emotion/styled
```

### debug with vscode

1. in your app project file (project.json)

add property host and port in the serve target like this

```[json]
 "serve": {
      "executor": "@nx/webpack:dev-server",
      ...,
      "options": {
        ...,
        // The most important configuration is to set this property to the localhost ip value !!
        "host": "127.0.0.1",
        // set port value to prevent confusion for react developers, they works with port 3000 since the CRA (currently obsolete) has set it like that 
        "port": 3000
      }
 }
```

first of all, set `host` porperty to "127.0.0.1"

if you don't, breakpoint will not working because alias "localhost" is already in use by webpack's dev server so we have to set the real value of "localhost" alias : 127.0.0.1.

Now it's working without any other configuration !!

it's kiss !

2. in vscode add a new launcher as you always do

```[json]
{
      "type": "chrome",
      "request": "launch",
      "name": "Launch Client",
      "url": "http://localhost:3000",
      "webRoot": "${workspaceFolder}/apps/client-presenter-react"
    }
```

The trick is to point the webRoot property's value that aims the app you would like to debug, if you don't target the app, breakpoint will may not worksnot been loaded by vscode

> default setting `"webRoot": "${workspaceFolder}"` is working for me on Windows 11, but I have some latencies, and other people has reached issues.
>
> So I thinks it's a good advise to set the value like the provided exemple but it is a good advise to aim your application root folder

## create client application with typescript

```[powershell]
yarn nx g @nx/js:library client-application --tags="client, library" --publishable --bundler=tsc --importPath=@boobafetes-chatbot/client-application --includeBabelRc --pascalCaseFiles --unitTestRunner=jest
```

## create client domain with typescript

```[powershell]
yarn nx g @nx/js:library client-domain --tags="client, library" --publishable --bundler=tsc --importPath=@boobafetes-chatbot/client-domain --includeBabelRc --pascalCaseFiles --unitTestRunner=jest
```

## create client infrastructure with typescript

```[powershell]
yarn nx g @nx/js:library client-infrastructure --tags="client, library" --publishable --bundler=tsc --importPath=@boobafetes-chatbot/client-infrastructure --includeBabelRc --pascalCaseFiles --unitTestRunner=jest
```

## create server's presenter as webapis with express.js

```[powershell]
yarn nx g @nx/express:application server-presenter-express --tags="server, application" --frontendProject client-presenter-react --pascalCaseFiles --unitTestRunner=jest
```

> the api keys (there are secrets !! do not expose them !) used for
>
> - openAi : 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

## create server application with typescript

```[powershell]
yarn nx g @nx/js:library server-application --tags="server, library" --publishable --bundler=tsc --importPath=@boobafetes-chatbot/server-application --includeBabelRc --pascalCaseFiles --unitTestRunner=jest
```

## create server domain with typescript

```[powershell]
yarn nx g @nx/js:library server-domain --tags="server, library" --publishable --bundler=tsc --importPath=@boobafetes-chatbot/server-domain --includeBabelRc --pascalCaseFiles --unitTestRunner=jest
```

## create server infrastructure with typescript

```[powershell]
yarn nx g @nx/js:library server-infrastructure --tags="server, library" --publishable --bundler=tsc --importPath=@boobafetes-chatbot/server-infrastructure --includeBabelRc --pascalCaseFiles --unitTestRunner=jest
```

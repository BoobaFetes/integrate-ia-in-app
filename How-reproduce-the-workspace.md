# How reproduce the workspace

## workspace creation

```[powershell]
npx create-nx-workspace@latest boobafetes --pm=yarn --preset=apps  --interactive --no-nxCloud
```

 > NX create a v16.1.1 workspace... or highter

## react application creation

```[powershell]
cd boobafetes
yarn add @nx/react
yarn nx g @nx/react:application converter --e2eTestRunner=none --pascalCaseFiles --routing --style=scss  --no-strict --tags=application
```

### debug the application with vscode

1. in your app proect file (project.json)

add property host and port in the serve target like this

```[json]
 "serve": {
      "executor": "@nx/webpack:dev-server",
      "defaultConfiguration": "development",
      "options": {
        "buildTarget": "converter:build",
        "hmr": true,
        "host": "127.0.0.1", <- THE MOST IMPORTANT IS TO SET THIS PROPERTY TO THE LOCALHOST IP VALUE !!
        "port": 3000 <- set this value to do not change how react devs works, CRA was hosting the local server on this port
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
      "name": "Launch Converter",
      "url": "http://localhost:3000",
      "webRoot": "${workspaceFolder}/apps/converter"
    }
```

The trick is to point the webRoot property's value that aims the app you would like to debug, if you don't target the app, breakpoint will may not worksnot been loaded by vscode

> default setting `"webRoot": "${workspaceFolder}"` is working for me on Windows 11, but I have some latencies, and other people has reached issues.
>
> So I thinks it's a good advise to set the value like the provided exemple but it is a good advise to aim your application root folder

## TypeScript library creation : ia-handler

this library woill be in charge of taking care of the message sent to the OpenAI chatbot, it's settings, and to trig events, no react here !

```[powershell]
yarn add @nx/js
yarn nx g @nx/js:library ia-handler --publishable --bundler=tsc --importPath=@boobafetes/ia-handler --includeBabelRc --pascalCaseFiles --unitTestRunner=jest --tags=library
```

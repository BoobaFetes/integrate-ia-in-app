npx create-nx-workspace@latest boobafetes-chatbot --pm=yarn --preset=apps  --interactive --no-nxCloud
Set-Location ./boobafetes-chatbot
# add nx projects dependencies
yarn add @nx/express @nx/react @nx/js

yarn nx g @nx/react:application client-presenter-react --tags="client, application" --bundler=webpack --pascalCaseFiles --routing --style="@emotion/styled" --no-strict --e2eTestRunner=none
yarn add @mui/material @emotion/react @emotion/styled
yarn nx g @nx/js:library client-application --tags="client, library" --publishable --bundler=tsc --importPath=@boobafetes-chatbot/client-application --includeBabelRc --pascalCaseFiles --unitTestRunner=jest
yarn nx g @nx/js:library client-domain --tags="client, library" --publishable --bundler=tsc --importPath=@boobafetes-chatbot/client-domain --includeBabelRc --pascalCaseFiles --unitTestRunner=jest
yarn nx g @nx/js:library client-infrastructure --tags="client, library" --publishable --bundler=tsc --importPath=@boobafetes-chatbot/client-infrastructure --includeBabelRc --pascalCaseFiles --unitTestRunner=jest

yarn nx g @nx/express:application server-presenter-express --tags="server, application" --frontendProject client-presenter-react --pascalCaseFiles --unitTestRunner=jest
yarn nx g @nx/js:library server-application --tags="server, library" --publishable --bundler=tsc --importPath=@boobafetes-chatbot/server-application --includeBabelRc --pascalCaseFiles --unitTestRunner=jest
yarn nx g @nx/js:library server-domain --tags="server, library" --publishable --bundler=tsc --importPath=@boobafetes-chatbot/server-domain --includeBabelRc --pascalCaseFiles --unitTestRunner=jest
yarn nx g @nx/js:library server-infrastructure --tags="server, library" --publishable --bundler=tsc --importPath=@boobafetes-chatbot/server-infrastructure --includeBabelRc --pascalCaseFiles --unitTestRunner=jest


yarn nx g @nx/express:application server --tags="server, application" --pascalCaseFiles --unitTestRunner=jest

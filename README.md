# elm-gamehostserver
An attempt to create a server hosting an game code written in elm.

## Usage
###Build a distributable version:
`npm run build` builds both the client and server code resulting files output to `dist/`. Start the server with `npm run startServer`. Navigate to `http://localhost:3000/` to view.

###During development:
`npm run watchServer` will auto-recompile the server code on save. `npm run startDev` will recompile the client code on save and will also host it so that hot module replacement is supported. `npm run startServer` starts the server and will restart when the server file is recompiled. `npm run startDebugServer` starts the server with debug params set so that logs are output to the console.

Can also debug the server code using vscode, use the provided `.vscode/launch.json` file

###To run unit tests:
`npm run test` and navigate to `http://localhost:8000/`.
On save, webpack will auto rebuild and any browser windows will auto reload.

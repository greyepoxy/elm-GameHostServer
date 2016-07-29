# elm-gamehostserver
A Server hosting a website written mostly in Elm.

## Setup
As with any node/npm based project their are a couple one time setup steps.

1. Install node.js https://nodejs.org/
1. Install elm, `npm install -g elm`
1. Get the project dependencies, `npm install`
1. Get the Elm project dependencies, `elm package install`

## Usage
### Development:
Fastest way to get started is run the `gulp dev` task.
Once you see nodemon start the server navigate to `http://localhost:3000/` to view.

`gulp dev` starts several dev tasks
1. `webpack-dev-server:client` will auto-recompile the client code on save. It also hosts the client code at `http://localhost:3010/` with hot module replacement support.
1. `build-dev:server` will auto-recompile the server code on save.
1. `start-dev:server:new-process` will start the server at `http://localhost:3000/` and will auto-restart whenever the compiled server file is changed.
1. `webpack-dev-server:tests` will auto-recompile the test code on save and will also host it at `http://localhost:8000/`.

If you wish to debug then you can use vscode, use the provided `.vscode/launch.json` file

### Test production version:
This project is intended to run on anything that supports iisnode (like azure web apps). Use `gulp prepare:prod` to prepare a production ready distributable version of the site in the `_dist` folder.

You can validate that it works by running the `gulp run:prod` command to start the server using the production scripts. Navigate to `http://localhost:3000/` to view.

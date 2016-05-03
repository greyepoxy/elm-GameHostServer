var make = function make(localRuntime) {
  localRuntime.Native = localRuntime.Native || {};
  localRuntime.Native.Http = localRuntime.Native.Http || {};
  localRuntime.Native.Http.Response = localRuntime.Native.Http.Response || {};
  localRuntime.Native.Http.Response.Write = localRuntime.Native.Http.Response.Write || {};

  if (localRuntime.Native.Http.Response.Write.values) {
    return localRuntime.Native.Http.Response.Write.values;
  }

  var toHtml = require('vdom-to-html');

  return {
    'toHtml': toHtml
  };
};

Elm.Native = Elm.Native || {};
Elm.Native.Http = Elm.Native.Http || {};
Elm.Native.Http.Response = Elm.Native.Http.Response || {};
Elm.Native.Http.Response.Write = Elm.Native.Http.Response.Write || {};
Elm.Native.Http.Response.Write.make = make;

if (typeof window === "undefined") {
  window = global;
}

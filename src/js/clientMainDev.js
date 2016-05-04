'use strict';

require("basscss/css/basscss.css");

var Elm = require('../ClientMainDev.elm');
var mountNode = document.getElementById('main');

var app = Elm.embed(Elm.ClientMainDev, mountNode, { swap: false });

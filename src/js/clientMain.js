'use strict';

require("basscss/css/basscss.css");

var Elm = require('../ClientMain.elm');
var mountNode = document.getElementById('main');

var app = Elm.embed(Elm.ClientMain, mountNode);

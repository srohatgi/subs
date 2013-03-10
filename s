#!/bin/bash

make
nodemon -e '.coffee|.jade|.json|.html|.css|.hbs' server/lib/dev.js

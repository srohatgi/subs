#!/bin/bash

make
nodemon -e '.coffee|.jade|.json|.html|.css|.hbs' lib/dev.js

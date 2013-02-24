#!/bin/bash

make
nodemon -e '.coffee|.jade|.json' lib/dev.js

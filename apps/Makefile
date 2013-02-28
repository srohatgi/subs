tgt = $(patsubst %.coffee,build/%.min.js,$(wildcard **/*.coffee))
tgt += $(patsubst %.hbs,build/%.hbjs,$(wildcard **/*.hbs))
tgt += $(patsubst %.png,build/%.png,$(wildcard **/*.png))
tgt += $(patsubst %.jpg,build/%.jpg,$(wildcard **/*.jpg))

pub = ../public/javascripts

all: node_modules $(tgt) $(pub)/handlebars.runtime.js $(pub)/underscore-min.js $(pub)/backbone-min.js

.PHONY: clean all 

node_modules: package.json
	-rm -rf node_modules
	npm install

clean: 
	-rm -rf build

build/%.js: %.coffee
	coffee -o $(dir $@) $<

build/%.min.js: build/%.js
	node_modules/uglify-js/bin/uglifyjs -o $@ $<

build/%.hbjs: %.hbs
	node_modules/handlebars/bin/handlebars -m $< -f $@

build/%.png: %.png
	cp -f $< $@

build/%.jpg: %.jpg
	cp -f $< $@

$(pub)/handlebars.runtime.js: node_modules/handlebars/lib/handlebars/runtime.js
	cp -f $< $@

$(pub)/underscore-min.js: node_modules/backbone/node_modules/underscore/underscore-min.js
	cp -f $< $@

$(pub)/backbone-min.js: node_modules/backbone/backbone-min.js
	cp -f $< $@
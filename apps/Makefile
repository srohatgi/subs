tgt = $(patsubst %.coffee,build/%.min.js,$(wildcard ./**/*.coffee))

all: node_modules $(tgt)

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
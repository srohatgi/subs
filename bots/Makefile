tgt = $(patsubst src/%.coffee,lib/%.js,$(wildcard src/*.coffee src/**/*.coffee))
tgt += $(patsubst src/%.json,lib/%.json,$(wildcard src/*.json src/**/*.json))

all: node_modules $(tgt)

.PHONY: all clean cleanall

apps: 
	$(MAKE) -C ../apps

node_modules: package.json
	-rm -rf node_modules
	npm install

cleanall: 
	rm -rf lib node_modules
	
clean:
	rm -rf lib

lib/%.js: src/%.coffee
	coffee -o $(dir $@) $<

lib/%.json: src/%.json
	mkdir -p $(dir $@)
	cp $< $@

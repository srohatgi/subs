tgt = $(patsubst src/%.coffee,lib/%.js,$(wildcard src/*.coffee src/**/*.coffee))
tgt += $(patsubst src/%.json,lib/%.json,$(wildcard src/*.json src/**/*.json))

all: apps node_modules $(tgt)

.PHONY: all transfer clean server apps cleanall

apps: 
	$(MAKE) -C ../apps

node_modules: package.json
	-rm -rf node_modules
	npm install

cleanall: 
	$(MAKE) -C apps clean
	rm -rf lib
	
clean:
	rm -rf lib

lib/%.js: src/%.coffee
	coffee -o $(dir $@) $<

lib/%.json: src/%.json
	mkdir -p $(dir $@)
	cp $< $@

tgt = $(patsubst %.coffee,build/%.js,$(wildcard **/*.coffee))
tgt += $(patsubst %.hbs,build/%.hbjs,$(wildcard **/*.hbs))
tgt += $(patsubst %.png,build/%.png,$(wildcard **/*.png))
tgt += $(patsubst %.jpg,build/%.jpg,$(wildcard **/*.jpg))

ftype = -name '*.hbs' -o -name '*.coffee' -o -name '*.png' -o -name '*.jpg' -o -name '*.css'
pub = ../server/public/js/vendor
clt_js = $(pub)/handlebars.runtime.js $(pub)/underscore-min.js $(pub)/backbone-min.js 
clt_js += $(pub)/backbone.localStorage.js
spas = $(shell \ls -l | grep ^d | awk '{print $$NF}' | grep -v node_modules | grep -v build)

all: | build/node_modules ../server/public/css/default.css $(tgt) $(clt_js) $(spas)

process_js = cat build/$(1)/*_model.js build/$(1)/*_view.hbjs  build/$(1)/*_view.js build/$(1)/*router.js > ../server/public/js/$(1)-app.js
ifeq ($(minify),true)
process_js = 	build/node_modules/uglify-js/bin/uglifyjs -o ../server/public/js/$(1)-app.js `ls build/$(1)/*.js build/$(1)/*.hbjs`
endif

define spa_builder
../server/public/$(1)-index.html: $(shell find $(1) $(ftype) -type f) index.html
	# create main-app.js
	$(call process_js,$(1))
	# copy over css file
	cat $(1)/*.css > ../server/public/css/$(1)-app.css
	# copy over any changed images (jpg, png) to public/img
	echo $$? | awk '{ for(i=1;i<=NF;i++) if (match($$$$i,/\.(png|jpg)$$$$/)) system(sprintf("cp %s ../server/public/img/",$$$$i)); }'
	# finally copy over the html file
	sed -e 's/__app\.js__/$(1)-app.js/g' -e 's/__app\.css__/$(1)-app.css/g' index.html > $$@

$(1): ../server/public/$(1)-index.html
endef

$(foreach x,$(spas),$(eval $(call spa_builder,$(x))))

.PHONY: clean all 

build/node_modules: build/package.json
	-rm -rf build/node_modules
	cd build; npm install

build/package.json: package.json
	cp -f $< $@

clean: 
	-rm -rf build ../server/public

build/%.js: %.coffee
	coffee -o $(dir $@) $<

build/%.min.js: build/%.js
	build/node_modules/uglify-js/bin/uglifyjs -o $@ $<

build/%.hbjs: %.hbs
	build/node_modules/handlebars/bin/handlebars $< -f $@

build/%.png: %.png
	cp -f $< $@

build/%.jpg: %.jpg
	cp -f $< $@

../server/public: 
	mkdir -p ../server/public
	cp -Rf ../vendor/initializr/* ../server/public

../server/public/css/default.css: default.less ../server/public
	build/node_modules/less/bin/lessc -x $< > $@

$(pub)/handlebars.runtime.js: build/node_modules/handlebars/dist/handlebars.runtime.js ../server/public 
	build/node_modules/uglify-js/bin/uglifyjs -o $@ $<

$(pub)/underscore-min.js: build/node_modules/backbone/node_modules/underscore/underscore-min.js ../server/public 
	cp -f $< $@

$(pub)/backbone-min.js: build/node_modules/backbone/backbone-min.js ../server/public 
	cp -f $< $@

$(pub)/backbone.localStorage.js: ../vendor/backbone.localStorage.js ../server/public
	cp -f $< $@

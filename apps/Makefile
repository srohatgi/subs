tgt = $(patsubst %.coffee,build/%.js,$(wildcard **/*.coffee))
tgt += $(patsubst %.hbs,build/%.hbjs,$(wildcard **/*.hbs))
tgt += $(patsubst %.png,build/%.png,$(wildcard **/*.png))
tgt += $(patsubst %.jpg,build/%.jpg,$(wildcard **/*.jpg))

ftype = -name '*.hbs' -o -name '*.coffee' -o -name '*.png' -o -name '*.jpg' -o -name '*.css'
pub = ../public/js/vendor
clt_js = $(pub)/handlebars.runtime.js $(pub)/underscore-min.js $(pub)/backbone-min.js 
clt_js += $(pub)/backbone.localStorage.js
spas = $(shell \ls -l | grep ^d | awk '{print $$NF}' | grep -v node_modules | grep -v build)

all: | node_modules ../public/css/default.css $(tgt) $(clt_js) $(spas)

process_js = cat build/$(1)/*_model.js build/$(1)/*_view.hbjs  build/$(1)/*_view.js build/$(1)/*router.js > ../public/js/$(1)-app.js
ifeq ($(minify),true)
process_js = 	node_modules/uglify-js/bin/uglifyjs -o ../public/js/$(1)-app.js `ls build/$(1)/*.js build/$(1)/*.hbjs`
endif

define spa_builder
../public/$(1)-index.html: $(shell find $(1) $(ftype) -type f) index.html
	# create main-app.js
	$(call process_js,$(1))
	# copy over css file
	cat $(1)/*.css > ../public/css/$(1)-app.css
	# copy over any changed images (jpg, png) to public/img
	echo $$? | awk '{ for(i=1;i<=NF;i++) if (match($$$$i,/\.(png|jpg)$$$$/)) system(sprintf("cp %s ../public/img/",$$$$i)); }'
	# finally copy over the html file
	sed -e 's/__app\.js__/$(1)-app.js/g' -e 's/__app\.css__/$(1)-app.css/g' index.html > $$@

$(1): ../public/$(1)-index.html
endef

$(foreach x,$(spas),$(eval $(call spa_builder,$(x))))

.PHONY: clean all 

node_modules: package.json
	-rm -rf node_modules
	npm install

clean: 
	-rm -rf build ../public

build/%.js: %.coffee
	coffee -o $(dir $@) $<

build/%.min.js: build/%.js
	node_modules/uglify-js/bin/uglifyjs -o $@ $<

build/%.hbjs: %.hbs
	node_modules/handlebars/bin/handlebars $< -f $@

build/%.png: %.png
	cp -f $< $@

build/%.jpg: %.jpg
	cp -f $< $@

../public: 
	mkdir -p ../public
	cp -Rf ../initializr/* ../public

../public/css/default.css: default.less ../public
	node_modules/less/bin/lessc -x $< > $@

$(pub)/handlebars.runtime.js: node_modules/handlebars/dist/handlebars.runtime.js ../public 
	node_modules/uglify-js/bin/uglifyjs -o $@ $<

$(pub)/underscore-min.js: node_modules/backbone/node_modules/underscore/underscore-min.js ../public 
	cp -f $< $@

$(pub)/backbone-min.js: node_modules/backbone/backbone-min.js ../public 
	cp -f $< $@

$(pub)/backbone.localStorage.js: ../vendor/backbone.localStorage.js
	cp -f $< $@
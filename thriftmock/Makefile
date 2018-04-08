MOCHA_OPTS = --compilers coffee:coffee-script/register --timeout $(TIMEOUT) --slow $(SLOW)

test: 
	@./node_modules/mocha/bin/mocha \
	--reporter spec \
	$(MOCHA_OPTS) \
	test/*.test.coffee

.PHONY: test
test:
	@./node_modules/mocha/bin/mocha \
		--reporter spec\
		--compilers coffee:coffee-script/register\
		--timeout 3000\
		--slow 500\
		test/*.test.coffee | tee test.result.log

.PHONY: test
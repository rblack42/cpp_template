# Recursive Makefile for cpp_template

SUBS	= src tests

all:
	for dir in $(SUBS); do \
		(cd $$dir; ${MAKE} all); \
	done

tests:
	+cd tests; ${MAKE} all;

test:	tests
	tests/test

clean:
	for dir in $(SUBS); do \
		(cd $$dir; ${MAKE} clean); \
	done

.PHONY:	all



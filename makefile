srcDir  := src
testDir := test

PERL      := perl
PERLFLAGS := -I $(realpath .)/${srcDir}
PROG      := ${srcDir}/main.pl
CTAGS     := ctags

.PHONY: all ${PROG} tags test clean syntax-check unit-test

export PERL PERLFLAGS PROG

all: syntax-check unit-test

syntax-check:
	${MAKE} -C ${srcDir}

tags:
	${CTAGS} -R ${srcDir}

test: unit-test
	${MAKE} -C ${testDir}

unit-test:
	${MAKE} -C ${testDir} $@

clean:
	${MAKE} -C ${testDir} clean

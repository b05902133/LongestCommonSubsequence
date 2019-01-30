srcDir  := src
testDir := test

PERL      := perl
PERLFLAGS := -I $(realpath .)/${srcDir}
PROG      := ${srcDir}/main.pl
CTAGS     := ctags

.PHONY: all release debug ${PROG} tags test clean

export PERL PERLFLAGS PROG

all: debug
	${MAKE} -C ${srcDir}

tags:
	${CTAGS} -R ${srcDir}

test: debug
	${MAKE} -C ${testDir}

clean:
	${MAKE} -C ${testDir} clean

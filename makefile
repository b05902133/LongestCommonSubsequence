CXX      := g++
CXXFLAGS := -std=c++11 -Wall
LD       := g++
PROG     := lcs
CTAGS    := ctags

srcDir  := src
testDir := test

.PHONY: all release debug ${PROG} tags test clean

export CXX CXXFLAGS LD PROG

all: debug

release: CXXFLAGS += -O2
release: ${PROG}

debug: CXXFLAGS += -g
debug: ${PROG}

${PROG}:
	${MAKE} -C ${srcDir}

tags:
	${CTAGS} -R ${srcDir}

test: debug
	${MAKE} -C ${testDir}

clean:
	${MAKE} -C ${srcDir} clean
	rm ${PROG}

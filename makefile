srcDir  := src
testDir := test

JAVAC     := javac
JAVAFLAGS :=
JAVA      := java
PROG      := ${srcDir}/Main.class
CTAGS     := ctags

.PHONY: all release debug ${PROG} tags test clean

export JAVAC JAVAFLAGS JAVA PROG srcDir

all: debug

release: ${PROG}

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

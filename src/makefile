# JAVAC JAVAFLAGS PROG from ../makefile
program := ../${PROG}

.PHONY: all

all: ${program}

${program}: $(wildcard *.java)
	${JAVAC} ${JAVAFLAGS} $^

clean:
	rm *.class

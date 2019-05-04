# JAVAC JAVAFLAGS PROG from ../makefile
program := ../${PROG}

.PHONY: all

all: ${program}

${program}: main.java $(filter-out main.java,$(wildcard *.java))
	${JAVAC} ${JAVAFLAGS} $<

clean:
	rm *.class

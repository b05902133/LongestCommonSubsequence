# CXX CXXFLAGS LD PROG from ../makefile
OBJS    := $(subst .cpp,.o,$(wildcard *.cpp))
program := ../${PROG}

.PHONY: all

all: ${program}

-include $(subst .o,.d,${OBJS})

${program}: ${OBJS}
	${LD} -o $@ $^

%.o: %.d

%.d: %.cpp
	${CXX} ${CXXFLAGS} -MM -MT "$@ $(subst .d,.o,$@)" $< > $@

clean:
	rm *.{o,d}

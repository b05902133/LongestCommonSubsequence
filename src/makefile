# PERL PERLFLAGS from ../makefile
moduleDir := LCS
modules   := $(wildcard ${moduleDir}/*.pm)

.PHONY: all syntax-check

all: syntax-check

syntax-check: main.pl ${modules}
	@${PERL} -e 'system "${PERL} ${PERLFLAGS} -c $$_" for ( qw( $^ ) );'

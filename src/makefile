# PERL PERLFLAGS from ../makefile
moduleDir := LCS
modules   := $(wildcard ${moduleDir}/*.pm)

.PHONY: all syntax-check

all: syntax-check

syntax-check: main.pl ${modules}
	@${PERL} -e ' \
		for my $$file ( qw( $^ ) ) \
		{ \
			system "${PERL} ${PERLFLAGS} -c $$file"; \
		}'

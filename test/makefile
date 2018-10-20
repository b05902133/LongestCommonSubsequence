# PROG from ../makefile
testcaseDir    := Testcase
testResultsDir := TestResults

program := ../${PROG}

testcases    := $(wildcard ${testcaseDir}/*.input)
testcaseRefs := $(wildcard ${testcaseDir}/*.output)
testResults  := $(patsubst ${testcaseDir}/%.input,${testResultsDir}/%.log,${testcases})

.PHONY: all ${testcaseRefs}

all: ${testResultsDir} ${testResults} ${testcaseRefs}

${testResultsDir}:
	mkdir ${testResultsDir}

${testResults}: case += $(patsubst ${testResultsDir}/%.log,${testcaseDir}/%.input,$@)
${testResults}: ${program}
	cat ${case} | ${program} > $@

${testcaseRefs}: result += $(patsubst ${testcaseDir}/%.output,${testResultsDir}/%.log,$@)
${testcaseRefs}:
	@diff $@ ${result} > /dev/null; \
	if [ $$? ]; then \
		echo "${result} test fail!"; \
	else \
		echo "${result} test pass!"; \
	fi

# PROG from ../makefile
testcaseDir    := Testcase
testResultsDir := TestResults

program := ../${PROG}

testcases    := $(wildcard ${testcaseDir}/*.input)
testcaseRefs := $(wildcard ${testcaseDir}/*.output)
testResults  := $(patsubst ${testcaseDir}/%.input,${testResultsDir}/%.log,${testcases})

timeLimit := 1000  # unit: second
memLimit  := 64000 # unit: KB

.PHONY: all ${testcaseRefs}

all: ${testResultsDir} ${testResults} ${testcaseRefs}

${testResultsDir}:
	mkdir ${testResultsDir}

${testResults}: case += $(patsubst ${testResultsDir}/%.log,${testcaseDir}/%.input,$@)
${testResults}: ${program}
	ulimit -v ${memLimit} -t ${timeLimit}; \
	cat ${case} | ${program} > $@

${testcaseRefs}: result += $(patsubst ${testcaseDir}/%.output,${testResultsDir}/%.log,$@)
${testcaseRefs}:
	@diff $@ ${result} > /dev/null; \
	if [ $$? -eq 0 ]; then \
		echo "${result} test pass!"; \
	else \
		echo "${result} test fail!"; \
	fi

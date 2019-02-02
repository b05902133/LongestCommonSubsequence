# PERL PERLFLAGS PROG from ../makefile
PERLPROVE := prove

testcaseDir    := Testcase
testResultsDir := TestResults
unitTestDir    := Data Table

program := ../${PROG}

testcases     := $(wildcard ${testcaseDir}/*.input)
testcaseRefs  := $(wildcard ${testcaseDir}/*.output)
testResults   := $(patsubst ${testcaseDir}/%.input,${testResultsDir}/%.log,${testcases})
unitTestcases := $(foreach dir,${unitTestDir},$(wildcard ${dir}/*.t))

timeLimit := 1  		# unit: second
memLimit  := 64000 	# unit: KB

.PHONY: all ${testcaseRefs} unit-test

all: ${testResultsDir} ${testResults} ${testcaseRefs}

${testResultsDir}:
	mkdir ${testResultsDir}

${testResults}: case += $(patsubst ${testResultsDir}/%.log,${testcaseDir}/%.input,$@)
${testResults}: ${program}
	ulimit -v ${memLimit} -t ${timeLimit}; \
	cat ${case} | ${PERL} ${PERLFLAGS} ${program} > $@

${testcaseRefs}: result += $(patsubst ${testcaseDir}/%.output,${testResultsDir}/%.log,$@)
${testcaseRefs}:
	@diff -w $@ ${result} > /dev/null; \
	if [ $$? -eq 0 ]; then \
		echo "${result} test pass!"; \
	else \
		echo "${result} test fail!"; \
	fi

unit-test: ${unitTestcases}
	${PERLPROVE} ${PERLFLAGS} ${unitTestDir}

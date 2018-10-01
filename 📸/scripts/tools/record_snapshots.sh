#!/bin/bash

# Add -record flag to iUITests test run
# By default run all tests. If test name passed as argument, run tests only for this testcase

# setup destinations

export currentDirectory="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${currentDirectory}/snapshot_environment.sh

destinations=$1

# run tests
testCommand="xcodebuild test-without-building -maximum-concurrent-test-simulator-destinations 2 -xctestrun $filePath $destinations"
eval $testCommand

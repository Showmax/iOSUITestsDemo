#!/bin/bash

export currentDirectory="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${currentDirectory}/snapshot_environment.sh

cd $currentDirectory

first_phase="xcodebuild test -workspace ${WORKSPACE_PATH}/showmax.xcworkspace -maximum-concurrent-test-simulator-destinations 4 -scheme iOSUITests -derivedDataPath 'build' $IPHONE_DESTINATIONS"
eval $first_phase

second_phase="xcodebuild test -workspace ${WORKSPACE_PATH}/showmax.xcworkspace -maximum-concurrent-test-simulator-destinations 3 -scheme iOSUITests -derivedDataPath 'build' $IPAD_DESTINATIONS"
eval $second_phase

third_phase="xcodebuild test -workspace ${WORKSPACE_PATH}/showmax.xcworkspace -maximum-concurrent-test-simulator-destinations 3 -scheme iOSUITests -derivedDataPath 'build' $IPAD_LANDSCAPE_DESTINATIONS"
bash prepare_simulators.sh && eval $third_phase

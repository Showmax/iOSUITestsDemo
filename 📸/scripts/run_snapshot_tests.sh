#!/bin/bash

export currentDirectory="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${currentDirectory}/tools/snapshot_environment.sh

cd $currentDirectory

first_phase="xcodebuild test -workspace ${PROJECT_ROOT_DIR}/showmax.xcworkspace -maximum-concurrent-test-simulator-destinations 4 -scheme 📸 -derivedDataPath 'build' $IPHONE_DESTINATIONS"
eval $first_phase

second_phase="xcodebuild test -workspace ${PROJECT_ROOT_DIR}/showmax.xcworkspace -maximum-concurrent-test-simulator-destinations 3 -scheme 📸 -derivedDataPath 'build' $IPAD_DESTINATIONS"
eval $second_phase

third_phase="xcodebuild test -workspace ${PROJECT_ROOT_DIR}/showmax.xcworkspace -maximum-concurrent-test-simulator-destinations 3 -scheme 📸 -derivedDataPath 'build' $IPAD_LANDSCAPE_DESTINATIONS"
bash tools/prepare_simulators.sh && eval $third_phase

#!/bin/bash

export currentDirectory="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${currentDirectory}/snapshot_environment.sh

cd $currentDirectory

destinations=("${IPHONE_DESTINATIONS[@]} ${IPAD_DESTINATIONS[@]} ${IPAD_LANDSCAPE_DESTINATIONS[@]} ")

# build project
buildable="xcodebuild -workspace ${WORKSPACE_PATH}/showmax.xcworkspace -scheme iOSUITests build-for-testing -derivedDataPath 'build' $destinations"
eval $buildable

if [ $? -ne 0 ]; then
    echo "Looks like building the project failed. Please ensure the project is buildable and stable"
    exit 1
fi

# add flag to xctestrun
export filePath=$(find build/Build/Products -name '*.xctestrun')
swifty='
import Cocoa
import Foundation

let file = ProcessInfo.processInfo.arguments[1]
guard let dict = NSDictionary(contentsOfFile: file) else {
    fatalError("Cant read dict")
}
let argsKey = "CommandLineArguments"
let keys = dict.allKeys as! [String]
for key in keys {
    let content = dict[key] as! NSDictionary
    let list = (content[argsKey] as? NSArray)?.mutableCopy() as? NSMutableArray ?? NSMutableArray()
    list.add("-record")
    content.setValue(list, forKey: argsKey)
}
dict.write(toFile: file, atomically: true)
'
echo "$swifty" > plistUpdate.swift
swiftc plistUpdate.swift
update="./plistUpdate $filePath"
eval $update
rm plistUpdate.swift
rm plistUpdate

bash record_snapshots.sh "$IPHONE_DESTINATIONS"\
&& bash record_snapshots.sh "$IPAD_DESTINATIONS"\
&& bash prepare_simulators.sh \
&& bash record_snapshots.sh "$IPAD_LANDSCAPE_DESTINATIONS"

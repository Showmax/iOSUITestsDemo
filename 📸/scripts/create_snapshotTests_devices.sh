#!/bin/bash

# You might want to delete all your devices to prevent redundancy. It is possible to have 2 devices with same name.
if [ "$1" == "--delete-devices" ]; then
    xcrun simctl delete $(xcrun simctl list | grep -o '[0-9A-F]\{8\}-[0-9A-F]\{4\}-[0-9A-F]\{4\}-[0-9A-F]\{4\}-[0-9A-F]\{12\}' | xargs)
    xcrun simctl delete unavailable
    echo "All simulators deleted."
fi

# You should run this script everytime you install new Xcode with updated iOS version, because Xcode automatically deletes the older custom created simulators.
# This just works, we need to find better solution to get the runtime. I think this should do for a while.
#
#runtime="com.apple.CoreSimulator.SimRuntime.iOS-11-4"

# This takes latest runtime available in xcode build. (IT counts with beta...)
runtime=$(xcrun simctl list runtimes | grep "iOS" | tail -1 | awk -F' - ' '{print $3F}')

# Simulators should carry the iOS version. And probably CI Prefix.
# Check if simulators alreadz exists.
echo "The current iOS runtime is: $runtime"
xcrun simctl create "CI iPad Air 2 (Landscape)" com.apple.CoreSimulator.SimDeviceType.iPad-Air-2 $runtime
xcrun simctl create "CI iPad Pro (10.5-inch) (Landscape)" com.apple.CoreSimulator.SimDeviceType.iPad-Pro--10-5-inch- $runtime
xcrun simctl create "CI iPad Pro (12.9-inch) (Landscape)" com.apple.CoreSimulator.SimDeviceType.iPad-Pro--12-9-inch---2nd-generation- $runtime

xcrun simctl create "CI iPad Air 2" com.apple.CoreSimulator.SimDeviceType.iPad-Air-2 $runtime
xcrun simctl create "CI iPad Pro (10.5-inch)" com.apple.CoreSimulator.SimDeviceType.iPad-Pro--10-5-inch- $runtime
xcrun simctl create "CI iPad Pro (12.9-inch)" com.apple.CoreSimulator.SimDeviceType.iPad-Pro--12-9-inch---2nd-generation- $runtime


xcrun simctl create "CI iPhone SE" com.apple.CoreSimulator.SimDeviceType.iPhone-SE $runtime
xcrun simctl create "CI iPhone 6" com.apple.CoreSimulator.SimDeviceType.iPhone-6 $runtime
xcrun simctl create "CI iPhone 6 Plus"  com.apple.CoreSimulator.SimDeviceType.iPhone-6-Plus $runtime
xcrun simctl create "CI iPhone X" com.apple.CoreSimulator.SimDeviceType.iPhone-X $runtime

# We run our unit tests on iPhone 7.
xcrun simctl create "iPhone 7" com.apple.CoreSimulator.SimDeviceType.iPhone-X $runtime 

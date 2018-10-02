#!/bin/bash

export currentDirectory="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${currentDirectory}/snapshot_environment.sh

for i in "${IPAD_LANDSCAPE_SIMULATORS[@]}"
do
   xcrun simctl boot "$i"
done

open -a "Simulator.app"
osascript rotate_simulators.scpt ${#IPAD_LANDSCAPE_SIMULATORS[@]}

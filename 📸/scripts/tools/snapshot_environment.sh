#!bin/bash
currentDirectory="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

#The main pathsoo
export PROJECT_ROOT_DIR=${currentDirectory}/../../..

# Devices used to test

IPHONE_ARRAY=(
    "CI iPhone SE"
    "CI iPhone 6"
    "CI iPhone 6 Plus"
    "CI iPhone X"
)

IPAD_ARRAY=(
    "CI iPad Air 2"
    "CI iPad Pro (10.5-inch)"
    "CI iPad Pro (12.9-inch)"

)

IPAD_LANDSCAPE_ARRAY=(
    "CI iPad Air 2 (Landscape)"
    "CI iPad Pro (10.5-inch) (Landscape)"
    "CI iPad Pro (12.9-inch) (Landscape)"
)

IPHONE_DESTINATIONS=""
IPAD_DESTINATIONS=""
IPAD_LANDSCAPE_DESTINATIONS=""

IPHONE_SIMULATORS=( "${IPHONE_ARRAY[@]}" )
IPAD_SIMULATORS=( "${IPAD_ARRAY[@]}" )
IPAD_LANDSCAPE_SIMULATORS=( "${IPAD_LANDSCAPE_ARRAY[@]}" )

for i in ${!IPHONE_SIMULATORS[*]}
do
IPHONE_DESTINATIONS="$IPHONE_DESTINATIONS -destination 'platform=iOS Simulator,name=${IPHONE_SIMULATORS[$i]}'"
done


for i in ${!IPAD_SIMULATORS[*]}
do
IPAD_DESTINATIONS="$IPAD_DESTINATIONS -destination 'platform=iOS Simulator,name=${IPAD_SIMULATORS[$i]}'"
done


for i in ${!IPAD_LANDSCAPE_SIMULATORS[*]}
do
IPAD_LANDSCAPE_DESTINATIONS="$IPAD_LANDSCAPE_DESTINATIONS -destination 'platform=iOS Simulator,name=${IPAD_LANDSCAPE_SIMULATORS[$i]}'"
done

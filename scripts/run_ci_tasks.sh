#!/bin/bash

#####################################################
# This script is used for Continuous Integration
#
# Run locally to verify before committing your code.
#
# Options:
#   -z to run Flutter Analysis
#   -a to run Android CI tasks.
#   -i to run iOS CI tasks.
#####################################################

set -o pipefail
set -e

# get platforms
ANDROID=true
ANALYZE=true
IOS=true

# Parse arguments
OPTS=`getopt haiz $*`
if [ $? != 0 ] ; then echo "Failed parsing options." >&2 ; exit 1 ; fi
eval set -- "$OPTS"

while true; do
  case "$1" in
    -h  ) echo -ne "-a to run Android CI tasks.\n-i to run iOS CI tasks.\n -z to run Flutter analysis tasks.\n  Defaults to all. \n"; exit 0;;
    -z  ) ANALYZE=true;ANDROID=false;IOS=false;;
    -a  ) ANDROID=true;IOS=false;ANALYZE=false;;
    -i  ) IOS=true;ANDROID=false;ANALYZE=false;;
    *   ) break ;;
  esac
  shift
done

flutter packages get

# Flutter Analysis
if $ANALYZE; then
    flutter analyze
    # Perform publish dry run to ensure the package can be published
    flutter pub pub publish --dry-run
fi

# Android
if $ANDROID ; then
    cd example
    # Set Ndk dir path
    echo "ndk.dir=/usr/local/lib/android/sdk/ndk-bundle" > ./android/local.properties
    # Build sample using flutter tool
    flutter build apk --release
    cd ..
fi

# iOS
if $IOS; then
    cd example
    if [ ! -f ios/AirshipConfig.plist ]; then
      cp ios/AirshipConfig.plist.sample ios/AirshipConfig.plist
    fi
    flutter build ios --release --no-codesign
    cd ..
fi
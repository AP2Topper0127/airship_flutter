#!/bin/bash
set -e
set -x

ROOT_PATH=`dirname "${0}"`/..
AIRSHIP_VERSION=$(awk <"$ROOT_PATH/pubspec.yaml" "\$1 == \"version:\" { print \$2 }")

if [ $1 = $AIRSHIP_VERSION ]; then
 exit 0
else
 exit 1
fi

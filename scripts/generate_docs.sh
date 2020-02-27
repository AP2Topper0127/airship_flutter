#!/bin/bash

#####################################################
# This script is used for Continuous Integration
#
# Run locally to verify before committing your code.
#
#
#####################################################

set -o pipefail
set -e

# Generate doc
$FLUTTER_ROOT/bin/cache/dart-sdk/bin/dartdoc  --exclude 'dart:async,dart:collection,dart:convert,dart:core,dart:developer,dart:ffi,dart:html,dart:io,dart:isolate,dart:js,dart:js_util,dart:math,dart:typed_data,dart:ui'


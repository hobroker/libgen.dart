#!/bin/bash

set -e

pub global activate coverage

echo "-- Starting tests..."
pub run test -r expanded --coverage=coverage

echo "-- Generating LCOV report..."
pub global run coverage:format_coverage -l -i coverage -o coverage/lcov.info --packages=.packages --report-on=lib

if [ "$1" = "--html" ]; then
  genhtml -o coverage coverage/lcov.info && open coverage/index.html
fi

#!/bin/bash

set -e

echo "-- Starting tests..."
dart test \
  --reporter=expanded \
  --coverage=coverage

echo "-- Generating LCOV report..."
pub global run coverage:format_coverage \
  --lcov \
  --in=coverage \
  --out=coverage/lcov.info \
  --packages=.packages \
  --report-on=lib

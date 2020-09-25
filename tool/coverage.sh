#!/bin/bash

set -e

pub get
pub global activate coverage

OBS_PORT=9292
echo "-- Collecting coverage on port $OBS_PORT..."

# Start tests in one VM.
echo "-- Starting tests..."
dart \
  --disable-service-auth-codes \
  --enable-vm-service=$OBS_PORT \
  --pause-isolates-on-exit \
  test/index.dart &

# Run the coverage collector to generate the JSON coverage report.
echo "-- Collecting coverage..."
pub global run coverage:collect_coverage \
  --port=$OBS_PORT \
  --out=coverage/coverage.json \
  --wait-paused \
  --resume-isolates

echo "-- Generating LCOV report..."
pub global run coverage:format_coverage \
  --lcov \
  --in=coverage/coverage.json \
  --out=coverage/lcov.info \
  --packages=.packages \
  --report-on=lib

echo "-- Converting LCOV report to HTML..."
type genhtml && genhtml -o coverage coverage/lcov.info || echo "...skipping"

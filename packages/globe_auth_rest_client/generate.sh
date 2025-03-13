#!/bin/sh

# Delete lib/api directory if it exists
rm -rf lib/api

# Generate code from OpenAPI spec
dart run swagger_parser

# Run build_runner to generate additional code
dart run build_runner build -d

# Replace "required dynamic body" with "dynamic body" in API files
find lib/api -type f -name "*.dart" -exec sed -i '' 's/required dynamic body/dynamic body/g' {} +

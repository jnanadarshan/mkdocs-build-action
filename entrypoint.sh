#!/bin/sh

set -x # verbose mode
set -e # stop executing after error

echo "Starting mkdocs build"

####################################################
# Set workspace permissions
####################################################

chmod -R a+w /github/workspace

####################################################
# Build the Mkdocs site
####################################################

mkdocs build

####################################################
# Build completed
####################################################

echo "Completed mkdocs build"

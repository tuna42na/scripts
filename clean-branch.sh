#!/bin/bash

# Cleans the build
cd ../mobile
rm -rf node_modules
yarn
(cd ios && pod deintegrate && pod install)
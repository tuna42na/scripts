#!/bin/bash

# This script is used to perform git stash with a descriptive message
set -e
MESSAGE=$(gum input --prompt "Stash message: " --placeholder 'ex. tmp cache testing...')
git stash -um "$MESSAGE"

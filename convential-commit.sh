#!/bin/bash
# This script is used to create a conventional commit message with gum

# VARIABLES
ACTION=$(gum choose 'feat' 'fix' 'docs' 'style' 'refactor' 'perf' 'test' 'build' 'ci' 'chore' 'revert')
PR=$(gum input --placeholder 'Enter the PR number')
MESSAGE=$(gum input --placeholder 'Enter the commit message')
BREAKING_CHANGE=$(gum confirm 'Is this a breaking change?')
if [ "$BREAKING_CHANGE" = "yes" ]; then
  BANG="!"
fi

# COMMIT MESSAGE
git commit -m "$ACTION[$PR]: $MESSAGE" -m "BREAKING CHANGE: $BREAKING_CHANGE"
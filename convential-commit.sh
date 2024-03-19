#!/bin/bash
# This script is used to create a conventional commit message with gum

# VARIABLES
echo 'Commit Type:'
ACTION=$(gum choose 'feat' 'fix' 'docs' 'style' 'refactor' 'perf' 'test' 'build' 'ci' 'chore' 'revert')
PR=$(gum input --placeholder 'Enter the PR number')
MESSAGE=$(gum input --placeholder 'Enter the commit message')
echo 'Breaking change?:'
BREAKING_CHANGE=$(gum choose 'nope' 'yup')
if [ "$BREAKING_CHANGE" = "yup" ]; then
  BANG="!"
else
  BANG=""
fi

# COMMIT MESSAGE
git commit -m "$BANG$ACTION[$PR]: $MESSAGE"
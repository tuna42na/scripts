#!/bin/bash
# This script is used to create a conventional commit message with gum
set -e 
# VARIABLES
echo "Commit type:"
ACTION=$(gum choose 'feat' 'fix' 'docs' 'style' 'refactor' 'perf' 'test' 'build' 'ci' 'chore' 'revert')
tput cuu1
tput el
echo "Commit type: $ACTION ✅"
PR=$(gum input --placeholder 'Enter the PR number')
echo "PR: $PR ✅"
MESSAGE=$(gum input --placeholder 'Enter the commit message')
echo "Commit message: $MESSAGE ✅"

echo 'Breaking change?:'
BREAKING_CHANGE=$(gum choose 'nope' 'yup')
if [ "$BREAKING_CHANGE" = "yup" ]; then
  BANG="!"
else
  BANG=""
fi
tput cuu1
tput el
echo "Breaking change: $BREAKING_CHANGE ✅"

# COMMIT MESSAGE
git commit -m "$BANG$ACTION[$PR]: $MESSAGE"
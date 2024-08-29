#!/bin/bash
# This script is used to create a conventional commit message with gum
set -e 

# What is the action of the commit
ACTION=$(gum filter --placeholder "Commit type:" 'build' 'chore' 'ci' 'docs' 'feat' 'fix' 'perf' 'refactor' 'revert' 'style' 'test')
tput cuu1
tput el
echo "Commit type: $ACTION ✅"

# Branch Name
BRANCH=$(git rev-parse --abbrev-ref HEAD)
TEAM=$(echo $BRANCH | cut -d '-' -f1)
PR_NUMBER=$(echo $BRANCH | cut -d'-' -f2)
PR=$(gum choose "$TEAM-$PR_NUMBER" "other")
if [ "$PR" = "other" ]; then
  PR=$(gum input --prompt "PR Number: " --placeholder "$TEAM-$PR_NUMBER")
fi
echo "PR: $PR ✅"

# Commit message
MESSAGE=$(gum input --prompt "Commit message: " --placeholder 'added a commit message...')
echo "Commit message: $MESSAGE ✅"

# Breaking change (maybe never necessary, but 🤷🏼‍♂️)
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
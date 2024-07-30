#!/bin/bash
# This script is used to create a conventional commit message with gum
set -e 
# VARIABLES
ACTION=$(gum filter --placeholder "Commit type:" 'build' 'chore' 'ci' 'docs' 'feat' 'fix' 'perf' 'refactor' 'revert' 'style' 'test')
tput cuu1
tput el
echo "Commit type: $ACTION ✅"
PR=$(gum input --prompt "PR Number: " --placeholder 'ex. CL-*** || SB-***')
echo "PR: $PR ✅"
MESSAGE=$(gum input --prompt "Commit message: " --placeholder 'added a commit message...')
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
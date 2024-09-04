#!/bin/bash
# This script is used to create a smoke user
set -e 

DEV_ENV_PATH="../groundfloor_dev_env"
PROFILE='edge'

function check_aws_login() {
  # Check if the user is logged in to AWS
  echo "Checking if the user is logged in to AWS..."
  if [[ $NAMESPACE == 'edge' ]]; then
    PROFILE='edge'
  else
    PROFILE='sandbox'
  fi
  set +e
  aws sts get-caller-identity --query "Account" --profile $PROFILE &> /dev/null
  RESULT="$?" 
  set -e
  echo "Result: $RESULT"
  if [[  $RESULT -ne 0 ]]; then
    echo "User is not logged in to AWS ❌"
    echo "Logging in to AWS..."
    aws sso login --profile $PROFILE
  fi
  echo "User is logged in to AWS ✅"
}

function create_smoke_user() {
  # Create a smoke user
  echo "Creating a smoke user..."
  cd $DEV_ENV_PATH
  ./bin/k8s-console -n $NAMESPACE -p $PROFILE -c "bundle exec rake smokes:$TYPE[$EMAIL]"
  echo "Smoke user created ✅"
}

# Actual script
NAMESPACE=$(gum input --prompt "Environment:" --placeholder 'ex. api-pr***  || edge')
check_aws_login
TYPE=$(gum filter --placeholder "Type: " 'investing' 'lending')
tput cuu1
tput el
EMAIL=$(gum input --prompt "Email: " --placeholder "tuna@example.com")
echo "Environment: $NAMESPACE ✅"
echo "Smoke Type: $TYPE ✅" 
echo "Email: $EMAIL ✅"

# CONFIRMATION
CONFIRM=$(gum confirm && create_smoke_user || echo "Smoke user creation cancelled ❌ 👋🏼")
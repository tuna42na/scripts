#!/bin/bash

GUM=$(which gum| echo $?) # Check if gum is installed
if [[ $GUM == 0 ]]; then
    echo "Gum is already installed ✅"
else
    echo "Gum is not installed"
    echo "run brew install gum to install gum"
fi

# Add this directory path to the zshrc file
if [ -z $SCRIPTS_DIR ]; then
    echo "Script directory is already added to zshrc ✅"
else
    echo "Adding script directory to zshrc..."
    echo "export SCRIPTS_DIR=\"$(pwd)\"" >> ~/.zshrc
    source ~/.zshrc
fi




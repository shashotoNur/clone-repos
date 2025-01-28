#!/bin/bash

# Check if gh is installed
if ! command -v gh &> /dev/null; then
    echo "GitHub CLI (gh) is not installed. Please install it and try again."
    exit 1
fi

# Ensure the user is authenticated
if ! gh auth status &> /dev/null; then
    echo "You are not authenticated with GitHub CLI. Please run 'gh auth login' to authenticate."
    exit 1
fi

# Create a directory to store cloned repositories
TARGET_DIR="Repositories"
mkdir -p "$TARGET_DIR"
cd "$TARGET_DIR" || exit

# Define an array for visibility types
VISIBILITIES=("public" "private" "internal")

# Fetch all repositories for the authenticated user
echo "Fetching repositories..."
REPOS=()
for VISIBILITY in "${VISIBILITIES[@]}"; do
    REPOS+=($(gh repo list --visibility "$VISIBILITY" --json nameWithOwner --limit 1000 --jq '.[].nameWithOwner'))
done

# Clone each repository
echo "Cloning repositories..."
for REPO in "${REPOS[@]}"; do
    if [ -d "$(basename "$REPO")" ]; then
        echo "Repository $REPO already exists. Skipping..."
    else
        echo "Cloning $REPO..."
        gh repo clone "$REPO"
    fi
done

echo "All repositories have been cloned!"

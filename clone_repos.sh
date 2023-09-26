#!/bin/bash

# Your GitHub username and personal access token
USERNAME="YOUR_USERNAME"
TOKEN="YOUR_PERSONAL_ACCESS_TOKEN"

# Initialize page number
PAGE=1

# Configure git to cache my token (paste token in password field)
git config --global credential.helper 'cache --timeout=3600'

# Loop to fetch and clone all repositories
while true; do
  # Fetch the list of repositories for the current page
  REPOS_JSON=$(curl -s -H "Authorization: token $TOKEN" "https://api.github.com/user/repos?page=$PAGE&per_page=100")

  # Check if there are no more repositories
  if [ -z "$REPOS_JSON" ]; then
    break
  fi

  # Parse JSON to extract repository URLs and names
  REPOS_URLS=($(echo "$REPOS_JSON" | jq -r '.[].clone_url'))
  REPOS_NAMES=($(echo "$REPOS_JSON" | jq -r '.[].name'))
  NUM_REPOS=${#REPOS_URLS[@]}
  echo "Number of repositories on page $PAGE: $NUM_REPOS"

  # Check if there are no more repositories
  if [ $NUM_REPOS -eq 0 ]; then
    echo "No more repositories to fetch. Exiting..."
    break
  fi

  # Loop through and clone repositories for this page
  for ((i=0; i<${#REPOS_URLS[@]}; i++)); do
    REPO_URL="${REPOS_URLS[i]}"
    REPO_NAME="${REPOS_NAMES[i]}"
    git clone "$REPO_URL"
  done

  # Increment the page number for the next request
  ((PAGE++))
done

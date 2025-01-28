# GitHub Repositories Cloning Script

This script automates the process of cloning all your GitHub repositories—public, private, and internal—using the GitHub CLI (`gh`). It ensures you can fetch and clone all repositories tied to your GitHub account into a single directory.

## Prerequisites

1. **GitHub CLI (gh)**: Make sure the GitHub CLI is installed. You can install it by following the instructions [here](https://cli.github.com/).
2. **Authentication**: Ensure you are authenticated with GitHub CLI: `gh auth login`

## Features

- Fetches and clones **public**, **private**, and **internal** repositories.
- Skips cloning repositories that are already present in the target directory.
- Organizes repositories into a folder named `github_repos`.

## Usage

1. Clone or copy the script to your local machine.
2. Save the script to a file, e.g., `clone_repos.sh`.
3. Make the script executable: `chmod +x clone.sh`
4. Run the script: `./clone.sh`

### Workflow

1. Checks if `gh` is installed.
2. Verifies if you are authenticated with the GitHub CLI.
3. Creates a directory named `github_repos` in the current working directory.
4. Fetches the list of repositories for each visibility type (`public`, `private`, `internal`).
5. Clones repositories into the `github_repos` directory. If a repository already exists, it skips cloning it.

## Notes

- The script uses the `gh repo list` command with the `--visibility` flag to fetch repositories.
- If you don’t have any `internal` repositories, the script will simply skip that step.
- By default, the script clones up to 1000 repositories per visibility type. If you have more, you can modify the `--limit` flag in the script.

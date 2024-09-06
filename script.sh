#!/bin/bash

# Check if Git is already initialized
if [ -d ".git" ]; then
    echo "Git is already initialized"
else
    echo "Initializing a new Git repository..."
    git init
    git add .

    # Prompt for commit message
    read -p "Enter the commit message: " message
    git commit -m "$message"

    # Ask user for GitHub repository name
    read -p "Enter the GitHub repository name: " repo_name

    # Create GitHub repository using the 'gh' command
    echo "Creating GitHub repository '$repo_name'..."
    gh repo create "$repo_name" --public --source=. --remote=origin

    # Get the GitHub repository URL
    repo_url=$(gh repo view "$repo_name" --json url -q ".url")
    echo "GitHub repository created at: $repo_url"

    # Set the remote origin and push to the repository
    git remote add origin "$repo_url"
    git branch -M main
    git push -u origin main

    echo "Repository pushed to GitHub successfully!"
fi
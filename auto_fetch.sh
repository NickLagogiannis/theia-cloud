#!/bin/bash

# Name of the branch to update
BRANCH_NAME="main"

# Check if the current directory is a Git repository
if [ ! -d .git ]; then
  echo "⚠️  This is not a Git repository. Please run this script from the root of your local Git repo."
  exit 1
fi

# Fetch the latest changes from the upstream repository
echo "📡 Fetching changes from upstream..."
git fetch upstream

# Check if fetch was successful
if [ $? -ne 0 ]; then
  echo "❌ Failed to fetch from upstream. Make sure the 'upstream' remote is set correctly."
  exit 1
fi

# Checkout the branch you want to update
echo "🔀 Checking out branch $BRANCH_NAME..."
git checkout $BRANCH_NAME

# Check if checkout was successful
if [ $? -ne 0 ]; then
  echo "❌ Failed to switch to branch '$BRANCH_NAME'. Make sure it exists."
  exit 1
fi

# Merge or rebase the changes from upstream into your local branch
echo "📦 Merging changes from upstream/$BRANCH_NAME into $BRANCH_NAME..."
git merge upstream/$BRANCH_NAME

# If there are conflicts, alert the user
if [ $? -ne 0 ]; then
  echo "⚠️  Merge conflicts detected! Resolve them, then run 'git add .' and 'git commit' to complete the process."
  exit 1
fi

# Push the changes to your forked repository
echo "🚀 Pushing updated branch to origin..."
git push origin $BRANCH_NAME

# Check if push was successful
if [ $? -ne 0 ]; then
  echo "❌ Failed to push changes to origin. Please check for issues or permissions."
  exit 1
fi

echo "✅ Your forked repository is now up to date with the upstream changes!"

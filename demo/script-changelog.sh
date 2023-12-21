#!/bin/bash

set -e

# Increment version number
VERSION=$(npm version patch --no-git-tag-version)

# Get last version from changelog
LAST_VERSION=$(grep -m1 -oP '(?<=## )\d+\.\d+\.\d+' CHANGELOG.md || echo "$VERSION")

# Create commit message
COMMIT_MESSAGE=$(echo -e "chore(release): $VERSION\n\n$(git log --pretty=format:'%s' "$LAST_VERSION"..HEAD | commitizen)")

# Commit changes
git add .
git commit -m "$COMMIT_MESSAGE"

# Generate changelog
npx standard-version --skip.changelog

# Push changes
git push
git push --tags

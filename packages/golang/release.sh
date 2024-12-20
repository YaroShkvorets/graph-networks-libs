#!/bin/bash

set -e

# Check if git repo is clean
if [[ -n $(git status -s) ]]; then
    echo "Error: Git working directory is not clean. Please commit or stash changes first."
    exit 1
fi

# Get version from version.go
VERSION=$(grep -o 'const Version = "[^"]*"' lib/version.go | cut -d'"' -f2)
if [[ -z "$VERSION" ]]; then
    echo "Error: Could not extract version from version.go"
    exit 1
fi

# Show latest tag and confirm new version
LATEST_TAG=$(git describe --tags --abbrev=0 2>/dev/null || echo "no previous tags")
NEW_TAG="packages/golang/v$VERSION"
echo "Latest released version: $LATEST_TAG"
echo "Preparing to release version: $NEW_TAG"
read -p "Do you want to continue? (y/N) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Release cancelled"
    exit 1
fi

# Create git tag
echo "Creating git tag: $NEW_TAG..."
git tag -a "$NEW_TAG" -m "Release $NEW_TAG"

# Push to remote
echo "Pushing tag to remote..."
git push origin "$NEW_TAG"

echo "Release $NEW_TAG completed successfully!"
echo "The module can now be imported with: \"go get github.com/pinax-network/graph-networks-libs/packages/golang@latest\""

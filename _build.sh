#!/usr/bin/env bash

set -e # halt script on error

SOURCE_BRANCH=gh-pages
TARGET_BRANCH=master

# Pull requests and commits to other branches shouldn't try to deploy, just build to verify
if [ "$TRAVIS_PULL_REQUEST" != "false" -o "$TRAVIS_BRANCH" != "$SOURCE_BRANCH" ]; then
	echo "Skipping build. Not on ${SOURCE_BRANCH}"
	exit 0
fi

REPOSITORY="git@github.com:${TRAVIS_REPO_SLUG}"

# Get the deploy key by using Travis's stored variables to decrypt deploy_key.enc
ENCRYPTED_KEY_VAR="encrypted_${ENCRYPTION_LABEL}_key"
ENCRYPTED_IV_VAR="encrypted_${ENCRYPTION_LABEL}_iv"
ENCRYPTED_KEY=${!ENCRYPTED_KEY_VAR}
ENCRYPTED_IV=${!ENCRYPTED_IV_VAR}
openssl aes-256-cbc -K $ENCRYPTED_KEY -iv $ENCRYPTED_IV -in deploy.key.enc -out deploy.key -d
chmod 600 deploy.key
eval `ssh-agent -s`
ssh-add deploy.key

git clone $REPOSITORY build-area
cd ./build-area
git checkout $TARGET_BRANCH || git checkout --orphan $TARGET_BRANCH
cd ..
rm -rf build-area/**/* || exit 0

bundle exec jekyll build -d ./build-area
bundle exec htmlproofer ./build-area --disable-external

cd ./build-area

git config user.name "Travis CI"
git config user.email "${COMMIT_AUTHOR_EMAIL:-dev@adaxisoft.be}"

# If there are no changes to the compiled out (e.g. this is a README update) then just bail.
if [ -z `git diff --exit-code` ]; then
	echo "No changes to the output on this push; exiting."
	exit 0
fi

git add .
git commit -m "Deploy to branch ${TRAVIS_BRANCH}: ${TRAVIS_COMMIT}"

# Now that we're all set up, we can push.
git push $REPOSITORY $TARGET_BRANCH



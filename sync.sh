#!/usr/bin/bash

# Prepare environment
source /tmp/cirrus-ci-build/env.sh
mkdir -p ~/aosp
cd ~/aosp

# Setting up Git
git config --global user.name "${GIT_NAME}"
git config --global user.email "${GIT_EMAIL}"

# Initialize the repository
repo init --manifest-url=https://github.com/${ROM_REPO} --manifest-branch=${ROM_BRANCH} --depth=1 --groups=default,-darwin,-mips,-notdefault
git clone https://github.com/${LOCAL_MANIFEST_REPO} -b ${LOCAL_MANIFEST_BRANCH} .repo/local_manifests

# Sync the repository
repo sync --jobs=8 --current-branch --no-clone-bundle --optimized-fetch --quiet

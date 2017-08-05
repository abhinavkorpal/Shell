#!/bin/bash
# Deploy to via pushing to a remote git repository.
#
# Add the following environment variables to your project configuration and make
# sure the public SSH key from your projects General settings page is allowed to
# push to the remote repository as well.
# * REMOTE_REPOSITORY, e.g. "git@github.com:xxxxx/xxxxxx.git"
# * REMOTE_BRANCH, e.g. "production"
#
# Include in your builds via
#

REMOTE_REPOSITORY=${REMOTE_REPOSITORY:?'You need to configure the REMOTE_REPOSITORY environment variable!'}
REMOTE_BRANCH=${REMOTE_BRANCH:?'You need to configure the REMOTE_BRANCH environment variable!'}

set -e

git fetch -unshallow || true
git push "${REMOTE_REPOSITORY}" "${CLI_COMMIT_ID}:${REMOTE_BRANCH}"

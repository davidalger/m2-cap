#!/usr/bin/env bash

set -e

patch_version="$1"
if [[ "$patch_version" == "" ]]; then
    echo "Usage: setup-patch-version.sh <version>"
    exit -1
fi

if [[ ! -f composer.json ]]; then
    echo "Please run this from the repo root!"
    exit -1
fi

echo "==> requiring version $patch_version"
composer require magento/product-community-edition "$patch_version" --no-update

echo "==> updating composer.lock file"
exit_code=0
composer update -q --no-scripts || exit_code=$?
if [[ $exit_code -ne 0 ]]; then
    echo "Error: update failed, resetting composer.json and composer.lock"
    git checkout composer.json composer.lock
    exit -1
fi
rm -rf vendor

echo "==> changed files"
git status -s

echo "==> committing $patch_version"
git commit -am "Magento $patch_version"
git tag "$patch_version"

#!/usr/bin/env bash

set -e

branch_name="$1"
patch_version="$2"

if [[ "$branch_name" == "" ]]; then
    echo "Usage: update-release-branch.sh <branch> <version>"
    exit -1
fi

if [[ "$patch_version" == "" ]]; then
    echo "Usage: update-release-branch.sh <branch> <version>"
    exit -1
fi

if [[ ! -f README.md ]]; then
    echo "Please run this from the repo root!"
    exit -1
fi

git checkout $branch_name
git pull

magento_edition=ce
magento_product_pkg="$(grep magento/product composer.json | cut -d\" -f2)"
if [[ "$magento_product_pkg" == "magento/product-enterprise-edition" ]]; then
    magento_edition=ee
fi

echo "==> requiring version $magento_edition-$patch_version"
composer require "$magento_product_pkg" "$patch_version" --no-update

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

echo "==> committing $magento_edition-$patch_version"
if [[ "$magento_edition" == "ee" ]]; then
    git commit -am "Magento EE $patch_version update"
else
    git commit -am "Magento CE $patch_version update"
fi
git tag "$magento_edition-$patch_version"

git checkout master

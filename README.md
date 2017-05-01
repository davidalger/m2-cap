# M2 Cap Test Config

This is a test configuration for use in development of the [capistrano-magento2](https://github.com/davidalger/capistrano-magento2/) gem. It requires that there be valid SSH config settings present for connections to the target servers in `single.rb` and `multi.rb` to function. Because this is a test repository meant to be run against transient targets, a working test `env.php` artifact is copied up (for the sake of simplicity) to the target via a special rake task in `lib/capistrano/tasks/artifacts.rake`.

## Example SSH Config

    Host web1 web2
      HostName 127.0.0.1
      User vagrant
      UserKnownHostsFile /dev/null
      StrictHostKeyChecking no
      PasswordAuthentication no
      IdentityFile /Volumes/Server/.vagrant/machines/web1/virtualbox/private_key
      IdentityFile /Volumes/Server/.vagrant/machines/web2/virtualbox/private_key
      IdentitiesOnly yes
      LogLevel FATAL
      ForwardAgent yes
    
    Host web1
      Port 2200
    
    Host web2
      Port 2201

## M2 Release Branch Setup

    git checkout --orphan ce-2.1
    composer create-project magento/project-community-edition --no-scripts --no-install \
        --repository-url=https://repo.magento.com/ ./m2/ 2.1.0
    mv m2/* ./
    mv m2/.gitignore ./
    git commit -m "Added Magento CE 2.1.0"
    cp /sites/m2shared/app/etc/config.php app/etc/
    git commit -m "Added app config"
    composer install -q --no-scripts
    git add composer.lock
    rm -rf vendor/
    git commit -m "Added composer.lock"
    git tag ce-2.1.0;
    git push --set-upstream origin ce-2.1
    git push --tags

## M2 Release Branch Update

To update a release branch with new composer information for new patch versions, run the following script for every new version on each release branch.

    ./scripts/update-release-branch.sh ce-2.1 2.1.5

## Easy Testing

1. Make sure you've configured bundler to use local override for capistrano-magento2 git repo

        bundle config local.capistrano-magento2 /server/tools/capistrano-magento2/

2. Use the following string in the `Gemfile`

        gem 'capistrano-magento2', :github => 'davidalger/capistrano-magento2', :branch => 'develop'

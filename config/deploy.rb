# config valid only for current version of Capistrano
lock '~> 3.7'

set :application, 'm2cap_demo'
set :repo_url, 'git@github.com:davidalger/m2-cap.git'
set :keep_releases, 1
set :format_options, command_output: :stderr

set :deploy_to, '/home/vagrant/sites/m2cap.demo'
set :branch, ENV['BRANCH']

# set :magento_deploy_production, false
# set :magento_deploy_maintenance, false
set :magento_deploy_themes, ['Magento/blank', 'Magento/backend']

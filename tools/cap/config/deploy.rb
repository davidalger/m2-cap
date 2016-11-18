# config valid only for current version of Capistrano
lock '~> 3.6'

set :application, 'm2cap_demo'
set :repo_url, 'git@github.com:davidalger/m2-cap.git'
set :keep_releases, 1
set :format_options, command_output: :stderr

set :deploy_to, '/home/vagrant/sites/m2cap.demo'
set :branch, ENV['BRANCH'] || "master"

# set :magento_deploy_production, false
set :magento_deploy_maintenance, false
set :magento_deploy_themes, ['Magento/blank', 'Magento/backend']

# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }

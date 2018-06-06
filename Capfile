# Load DSL and set up stages
require 'capistrano/setup'

# Load Magento deployment tasks
require 'capistrano/magento2/deploy'
require 'capistrano/magento2/pending'
require 'capistrano/magento2/notifier'
require 'capistrano/magento2/cachetool'

# Load Git plugin
require "capistrano/scm/git"
install_plugin Capistrano::SCM::Git

# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }

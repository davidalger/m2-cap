role :app, %w{
  www-data@capistrano-magento2.cldev.net
}

set :deploy_to, '/var/www/html'
set :magento_deploy_themes, []

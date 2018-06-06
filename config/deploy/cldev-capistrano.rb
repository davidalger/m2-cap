role :app, %w{
  www-data@capistrano-web1.cldev.net
  www-data@capistrano-web2.cldev.net
}

set :deploy_to, '/var/www/html'

set :magento_deploy_themes, []
set :magento_deploy_languages, []

set :app_env_file, 'artifacts/env.cldev-capistrano.php'

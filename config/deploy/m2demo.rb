role :app, %w{
  www-data@m2demo.classyllama.cloud
}

set :deploy_to, '/var/www/html'
set :magento_deploy_themes, []

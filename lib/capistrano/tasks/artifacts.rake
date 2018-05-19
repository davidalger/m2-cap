
namespace :deploy do
  before 'magento:deploy:verify', :artifacts do
    on release_roles :all do
      upload! fetch(:app_env_file, 'artifacts/env.php'), shared_path + 'app/etc/env.php'
    end
  end
end

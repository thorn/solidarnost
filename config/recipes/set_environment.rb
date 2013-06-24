namespace :environment_setup do
  desc "Setup environment variables for oauth"
  task :set, roles: :app do
    # template 'private/google1959137a931c9501.html', "#{current_path}/public/google1959137a931c9501.html"
  end
  after "deploy:cold", "environment_setup:set"
end

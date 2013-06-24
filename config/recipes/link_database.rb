after 'deploy:cold', 'deploy:db:restore'
before 'deploy:cold', 'deploy:db:backup'

namespace :deploy do
  namespace :db do

    task :restore, :roles => :web do
      run("cp -f /home/#{user}/production.sqlite3 /home/#{user}/apps/#{application}/current/production.sqlite3")
    end

    task :backup, :roles => :web do
      run("cp -f /home/#{user}/apps/#{application}/current/production.sqlite3 /home/#{user}/production.sqlite3")
    end
  end
end

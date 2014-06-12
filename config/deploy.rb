# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'Mijn_Wk_Pool'
set :repo_url, 'git@github.com:LiveNL/mijnwkpool.git'

set :branch, 'beta4'
set :deploy_to, '/var/www/mijnwkpool.com/main'
set :scm, :git
set :use_sudo, false
set :format, :pretty
set :log_level, :info

set :ssh_options, {
  forward_agent: true
}

set :keep_releases, 5

set :rbenv_type, :user
set :rbenv_ruby, '2.1.0'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all

set :rails_env, 'production'

set :linked_files, %w{config/database.yml config/application.yml}
set :linked_dirs, %w{bin log tmp vendor/bundle public/system}

# Add this to the settings section at the top:
set :ping_url, 'http://mijnwkpool.com/ping'

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  task :ping do
    system "curl --silent #{fetch(:ping_url)}"
  end

  after :publishing, :restart
  after :restart, :ping
  after :finishing, 'deploy:cleanup'
end

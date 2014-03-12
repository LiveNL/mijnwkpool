# config valid only for Capistrano 3.1
lock '3.1.0'

set :application, 'Mijn_Wk_Pool'
set :repo_url, 'git@github.com:LiveNL/mijnwkpool.git'

set :branch, 'master'
set :deploy_to, '/var/www/mijnwkpool.com/dev'
set :scm, :git
set :use_sudo, false
set :format, :pretty
set :log_level, :info

set :ssh_options, {
  forward_agent: true,
}

set :keep_releases, 5

set :rbenv_type, :user
set :rbenv_ruby, '2.1.0'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all

set :rails_env, 'production'

namespace :deploy do

  task :start, :roles => :app, :except => { :no_release => true } do
    run "cd #{current_path} && bundle exec passenger start --socket /tmp/passenger.socket --daemonize --environment production"
  end
  task :stop, :roles => :app, :except => { :no_release => true } do
    run "cd #{current_path} && bundle exec passenger stop --pid-file tmp/pids/passenger.pid"
  end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path, 'tmp', 'restart.txt')}"
  end
end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end

require 'mina/rails'
require 'mina/git'
# default tohirgoogoor bish custom uildluud hiigdej baigaa tul comment hiilee
require 'mina/bundler' # Gemfile.lock file-g git repo-d bailgahiig shaarddag
require 'mina/rvm'

set :domain, '192.168.100.217'
set :user, 'server'
set :rvm_use_path, '$HOME/.rvm/scripts/rvm'
set :deploy_to, '/var/www/rails_boilerplate'
set :repository, 'git@54.65.89.234:unimedia/rails4_boilerplate.git'
set :branch, 'master'
production_mode = true

# environment bolgondoo tohiruulaad yavaad baij bolno

# task :dev do
#   set :domain, ''
#   set :rails_env, 'development'
#   set :branch, 'master'
#   set :user, 'server'
#   production_mode = false
# end

# task :stage do
#   set :domain, ''
#   set :rails_env, 'staging'
#   set :branch, 'master'
#   # set :identity_file, '/path/to/private/key.pem'
#   # set :forward_agent, true
#   production_mode = true
# end

# task :prod do
#   set :domain, ''
#   set :rails_env, 'production'
#   set :branch, 'master'
#   # set :identity_file, '/path/to/private/key.pem'
#   # set :forward_agent, true
#   production_mode = true
# end

# shared dirs and files will be symlinked into the app-folder by the 'deploy:link_shared_paths' step.
# set :shared_dirs, fetch(:shared_dirs, []).push('somedir')
set :shared_files, fetch(:shared_files, []).push('config/database.yml')

# This task is the environment that is loaded for all remote run commands, such as
# `mina deploy` or `mina rake`.
task :environment do
  invoke :'rvm:use', 'ruby-2.2.4@r4bp'
  # command %{source ~/.bash_profile}
end
# Put any custom commands you need to run at setup
# All paths in `shared_dirs` and `shared_paths` will be created on their own.
task :setup do
  invoke :'rvm:use', 'ruby-2.2.4@r4bp'
  command %(gem install bundler)
end

desc 'Deploys the current version to the server.'
task :deploy do
  # uncomment this line to make sure you pushed your local branch to the remote origin
  # invoke :'git:ensure_pushed'
  deploy do
    # Put things that will set up an empty directory into a fully set-up
    # instance of your project.
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'

    # bundler-g ashiglasan ashiglaaguigeesee hamaaraad 1-r 2-r hesgiig songoj heregleerei
    # 1. bundler-g heregleegui tohioldold
    # command %(cp /var/www/rails_boilerplate/shared/Gemfile.lock /var/www/rails_boilerplate/current/)
    # command %(bundle install)
    # command %(cp /var/www/rails_boilerplate/current/Gemfile.lock /var/www/rails_boilerplate/shared/)
    # command %(bundle exec rake assets:precompile) if production_mode

    # 2. bundler hereglej baigaa bol
    invoke :'bundle:install'
    invoke :'rails:assets_precompile' if production_mode

    invoke :'rails:db_migrate'
    invoke :'deploy:cleanup'

    on :launch do
      in_path(fetch(:current_path)) do
        command %(mkdir -p tmp/)
        command %(touch tmp/restart.txt)
        # restart apache deed hesgiin code n application-g restart hiih uildel hiideg
        # command %{sudo service apache2 restart}
      end
    end
  end

  # you can use `run :local` to run tasks on local machine before of after the deploy scripts
  # run(:local){ say 'done' }
end

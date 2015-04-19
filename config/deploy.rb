require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rvm'

set :domain, '198.199.110.154'
set :user, 'rails-deploy'
set :deploy_to, '/home/rails-deploy/Mechempire/'
set :repository, 'https://github.com/MechEmpire/Mechempire.git'

task :deploy do
  deploy do
    # Put things that prepare the empty release folder here.
    # Commands queued here will be ran on a new release directory.
    invoke :'git:clone'
    invoke :'bundle:install'

    # These are instructions to start the app after it's been prepared.
    to :launch do
      queue 'touch tmp/restart.txt'
    end

    # This optional block defines how a broken release should be cleaned up.
    to :clean do
      queue 'log "failed deployment"'
    end
  end
end

# uncomment that if you want to deploy to several stages and want to use the capistrano multistage extensions
# if so, you should also create a custom stage deploy script i.e. config/deploy/staging.rb
# set :stages, %w(staging production)
# set :default_stage, "staging"
# require 'capistrano/ext/multistage'
require "railslove/recipes"


#############################################################################
# Application Server Configuration
#############################################################################

# the name of your application. This will be used as name for the deployment directory and webserver configuration
set :application, "" 
# the primary domain for your application
set :domain, ""
# comma seperated list of additional domains
set :domain_alias, ""
# set to true if you want to rewrite the additional domains to the default domain. (www.example.com => example.com) 
set :force_default_domain, false

# The IP addresses of your deployment servers
role :app, ""
role :web, ""
role :db,  "", :primary => true

# target directory for the application
set :deploy_to, "/var/www/rails_apps/#{application}"

#############################################################################
# Application Dependencies
#############################################################################

depend :remote, :gem, "mislav-will_paginate", ">=2.2.2"
depend :remote, :gem, "right_aws", ">=1.9.0"
depend :remote, :gem, "astrails-safe"
depend :remote, :gem, "json"
depend :remote, :gem, "haml"
depend :remote, :gem, "oauth"


#############################################################################
# Source Code Repository Configuration
#############################################################################

# URL and configuration of the application source code repository. 
set :repository, ""
set :scm, "git"
# This will specify the branch that gets checked out for the deployment.
set :branch, "master"
# Remote caching will keep a local git repo on the server you're deploying to and simply run a fetch from that rather than an entire clone.
set :deploy_via, :remote_cache
# If you're using git's submodule support for edge rails or merb, set this guy to make sure the submodules "git" checked out.
# set :git_enable_submodules, 1



#############################################################################
# SSH/Connection Configuration
#############################################################################

# SSH Configuration. By default we're using forwar_agent
set ssh_options = {:forward_agent => true, :port => 22}
default_run_options[:pty] = true
on :start do
    `ssh-add`
end

# the user. this user ownes the used to login an
set :user, "rails"
set :use_sudo, false


#############################################################################
# Shared files
#############################################################################

# the files and directories that you want to share between the releases of your application
# for example:
# set :shared_files, {:files => "files"}
# symlinks <release>/files to <shared>/files and 

set :shared_files, {}


#############################################################################
# Logrotation configuration
#############################################################################

set :logrotate_options, [ { :rotate => 7, :size => 40MB }, :daily, :missingok, :compress, :delaycompress, :notifempty, :copytruncate ]
set :logrotate_directory, "#{shared_path}/system/logs"


#############################################################################
# Capistrano Callbacks
#############################################################################

before "deploy", "deploy:web:disable",
  "backup:run"
  
after "deploy", "deploy:web:enable"

after "deploy:setup",
  "logrotate:configure",
  "apache:upload_vhost_config",
  "db:upload_config_yml",
  "gems:install"
  
after "deploy:cold",
  "apache:enable_site",
  "apache:reload"

after "deploy:finalize_update",
  "db:symlink_config_yml",
  "db:create",
  "shared:symlink",
  "deploy:cleanup"

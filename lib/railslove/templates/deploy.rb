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
# Monit configuration
#############################################################################

# this allows you to set some basic monit configuration. 
# monit is a utility for managing and monitoring, processes, files, directories and devices on a UNIX system.
# for example it can alert your if apache goes down and reboot it.
# for advanced configuration edit /etc/monit/minit.rc on your server

# options are:
# :mailserver: the complete monit mail server configuration (see: http://mmonit.com/monit/documentation/monit.html#setting_a_mail_server_for_alert_messages)
# :webserver: the complete monit web server configuration (see: http://mmonit.com/monit/documentation/monit.html#monit_httpd)
# :send_alerts_to: array with email addresses to notify

set :monit_config, {}

# Monit is a system-wide configuration so you should run this only once on your server. (deactivate this if you have several apps on your server)
after "deploy:setup", 
  "monit:setup",
  "monit:start"
    
# Example:
#set :monit_config, {
#  :mailserver => %Q{
#    set mailserver mail.example.com
#         username "username" password "password" using tlsv1
#         using hostname "host.example.org"
#  },
#  :send_alerts_to => "admin@example.com", 
#  :webserver => %Q{
#    set httpd port 2812 and
#      use address localhost
#      allow localhost
#      allow admin:kgf76878oas
#  }
#}


#############################################################################
# Ferm configuration
#############################################################################

# ferm is a to to easily configure your IPtables. 
# for more information visit: http://ferm.foo-projects.org/
# just add the ports that should be available here.
set :ferm_server_tcp_ports, "http https ssh" # only http (port 80) https (port 433) and ssh (port 22) are open.

# IPtables is a system-wide configuration so you should run this only once on your server. (deactivate this if you have several apps on your server)
after "deploy:setup", 
  "ferm:configure"


#############################################################################
# Logrotation configuration
#############################################################################

set :logrotate_options, [ { :rotate => 30, :size => "10MB" }, :delaycompress, :daily, :missingok, :compress, :delaycompress, :notifempty, :copytruncate, :sharedscripts ]
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

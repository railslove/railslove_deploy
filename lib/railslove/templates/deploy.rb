# uncomment that if you want to deploy to several stages and want to use the capistrano multistage extensions
# if so, you should also create a custom stage deploy script i.e. config/deploy/staging.rb
# set :stages, %w(staging production)
# set :default_stage, "staging"
# require 'capistrano/ext/multistage'
#
require "railslove/recipes"

set :application, ""
set :domain, ""
set :domain_alias, ""
set :repository, ""
set :scm, "git"
set :branch, "master"

on :start do
    `ssh-add`
end
set :deploy_via, :remote_cache

default_run_options[:pty] = true
ssh_options[:port] = 22
ssh_options[:forward_agent] = true


set :user, "rails"


set :shared_files, []
set :backup_dir, "/backups"


set :deploy_to, "/var/www"

set :log_directory, "#{shared_path}/system/logs"
set :log_size, "150M"
set :log_rotate, "15"


set :twitter_user, "myappname"
set :twitter_password, "password"
after "deploy", "hooks:twitter:update"

set :memcache_ip, '127.0.0.1'
set :memcache_port, 11211
set :memcache_memory, 256


after "deploy:setup",
  "logrotation:configure",
  "apache:upload_vhost_config",
  "apache:enable_site",
  "apache:reload"


after "deploy:update",
  "shared:symlink",
  "deploy:cleanup"


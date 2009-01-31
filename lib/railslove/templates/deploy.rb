require "railslove/recipes"

set :application, ""
set :domain, ""
set :domain_alias, ""
set :repository, ""
set :scm, "git"
set :branch, "master"

set :ssh_options, {:forward_agent => true}
on :start do
    `ssh-add`
end
set :deploy_via, :remote_cache

default_run_options[:pty] = true
ssh_options[:port] = 22


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


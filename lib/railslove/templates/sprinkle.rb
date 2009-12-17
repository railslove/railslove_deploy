# Require our stack
require "railslove/sprinkle"

policy :passenger_stack, :roles => :app do
  requires :webserver         # Apache
  requires :database          # MySQL, SQLite
  
  # memcached
  requires :memcached_daemon  # Memcached
  requires :libmemcached      # libmemcached
  requires :memcached_conf    # memcached-user, init.d config 
  
  requires :scm               # Git, SVN
  requires :ruby              # Ruby Enterprise
  requires :searchengine      # Sphinx
  requires :appserver         # passenger
  requires :rails_user        # special rails user with sudo rights
  requires :database_driver   # Ruby database driver
  requires :usefull_gems      # usefull, frequently needed gems
  requires :image_magick      # image magick
  requires :ferm              # ferm iptable configuration tool
  requires :ferm_conf         # configure ferm (allow http, https and ssh)
  requires :monit             # monit - system process monitoring
end

deployment do
  # mechanism for deployment
  delivery :capistrano do
    begin
      recipes 'Capfile'
    rescue LoadError
      recipes 'config/deploy'
    end
    recipes 'config/server/config.rb'
  end
 
  # source based package installer defaults
  source do
    prefix   '/usr/local'
    archives '/usr/local/sources'
    builds   '/usr/local/build'
  end
end
# Require our stack
require "railslove/sprinkle"

policy :passenger_stack, :roles => :app do
  requires :webserver
  requires :database
  requires :memcached
  requires :libmemcached
  requires :scm
  requires :ruby
  requires :searchengine
  requires :appserver
  requires :database_driver
  requires :usefull_gems
  requires :ssh #configure and harden ssh
  requires :iptable #configure and harden iptables only HTTP 443+80 and SSH is allowed
end

deployment do
  # mechanism for deployment
  delivery :capistrano do
    begin
      recipes 'Capfile'
    rescue LoadError
      recipes 'deploy'
    end
  end
 
  # source based package installer defaults
  source do
    prefix   '/usr/local'
    archives '/usr/local/sources'
    builds   '/usr/local/build'
  end
end
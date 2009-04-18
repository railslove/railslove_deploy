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
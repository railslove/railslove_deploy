# cap gems helper methods
require "capistrano"
require 'capistrano/recipes/deploy/dependencies'

Dir["#{File.dirname(__FILE__)}/recipes/*.rb"].each { |recipe| 
  Capistrano::Configuration.instance(true).load recipe  
}

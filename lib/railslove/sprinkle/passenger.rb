package :passenger_gem do
  description 'Phusion Passenger (aka mod_rails)'
  version '3.0.7'
  gem 'passenger'
  requires :ruby_enterprise

  verify do
    has_gem 'passenger'
  end
end

package :passenger_apache, :provides => :appserver do
  description "Installs and configures Passenger for use with apache webserver"
  # require the apache passenger module load/conf files before installation because of a sprinkle limitation.
  requires :apache, :passenger_gem, :passenger_module_load, :passenger_module_conf

  passenger_version = '3.0.7'

  noop do
    pre :install, 'passenger-install-apache2-module --auto'
    post :install, "sudo a2enmod passenger"
    post :install, 'echo "NameVirtualHost *:80" | sudo tee -a /etc/apache2/httpd.conf'
    # Restart apache to enable changes
    post :install, '/etc/init.d/apache2 restart'
  end

  verify do
    has_file "/usr/local/ruby-enterprise/lib/ruby/gems/1.8/gems/passenger-#{passenger_version}/ext/apache2/mod_passenger.so"
  end
end

package :passenger_module_load do

  description "Uploads the passenger module load configuration. -sprinkle currently does not allow multiple installers per package, that's why the configuration files have it's own packages"
  requires :apache, :passenger_gem

  #TODO: :render => true seems not to work? hello sprinkle?!
  passenger_version = '3.0.7'
  transfer "#{File.dirname(__FILE__)}/../templates/passenger.load", "/etc/apache2/mods-available/passenger.load", :render => true

  verify do
    has_file '/etc/apache2/mods-available/passenger.load'
  end
end

package :passenger_module_conf do

  description "Uploads the passenger module conf configuration. -sprinkle currently does not allow multiple installers per package, that's why the configuration files have it's own packages"
  requires :apache, :passenger_gem

  #TODO: :render => true seems not to work? hello sprinkle?!
  passenger_version = '3.0.7'
  transfer "#{File.dirname(__FILE__)}/../templates/passenger.conf", "/etc/apache2/mods-available/passenger.conf", :render => true

  verify do
    has_file '/etc/apache2/mods-available/passenger.conf'
  end
end

package :passenger_nginx, :provides => :appserver  do
  description "Installs and configures Passenger for use with the awesome nginx webserver"

  requires :passenger_gem

  noop do
    pre :install, "passenger-install-nginx-module --auto --auto-download"
  end
end

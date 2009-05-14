package :passenger, :provides => :appserver do
  description 'Phusion Passenger (aka mod_rails)'
  version '2.2.2'
  gem 'passenger' do
    post :install, 'echo -en "\n\n\n\n" | sudo passenger-install-apache2-module'
  end
  
  # configure apache module
  config do 
    passenger_version = '2.2.2'
    put "/etc/apache2/mods-available/passenger.load", ERB.new(open("#{File.dirname(__FILE__)}/../templates/passenger.load").read).result(binding)
    put "/etc/apache2/mods-available/passenger.conf", ERB.new(open("#{File.dirname(__FILE__)}/../templates/passenger.conf").read).result(binding)
    
    # enable passenger module
    post :install, "sudo a2enmod passenger"
    post :install, 'echo "NameVirtualHost *:80" | sudo tee -a /etc/apache2/httpd.conf'
    post :install, "a2dissite 000-default"
    # Restart apache to note changes
    post :install, '/etc/init.d/apache2 restart'
  end
  
  
  
  
  verify do
    has_gem 'passenger'
    has_file '/etc/apache2/mods-available/passenger.load'
  end
  
  requires :apache, :ruby_enterprise
end

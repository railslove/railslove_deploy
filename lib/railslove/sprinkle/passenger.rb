package :passenger, :provides => :appserver do
  description 'Phusion Passenger (aka mod_rails)'
  gem 'passenger' do
    
    # TODO: test SUDO here and automate this completely
    post :install, 'echo -en "\n\n\n\n" | sudo passenger-install-apache2-module'
    
    # Create the passenger conf file
    post :install, 'touch /etc/apache2/mods-available/passenger.conf'
    post :install, 'touch /etc/apache2/mods-available/passenger.load'
    
    config do 
      put "/etc/apache2/mods-available/passenger.load", open("#{File.dirname(__FILE__)}/../templates/passenger.load").read
    end
  
    post :install, "sudo a2enmod passenger"
  
    # Restart apache to note changes
    post :install, '/etc/init.d/apache2 restart'
    
  end
  
  
  verify do
    has_gem 'passenger'
    has_file '/etc/apache2/mods-available/passenger.load'
    has_file '/usr/local/ruby-enterprise/lib/ruby/gems/1.8/gems/passenger-2.0.6/ext/apache2/mod_passenger.so'
    has_directory '/usr/local/ruby-enterprise/lib/ruby/gems/1.8/gems/passenger-2.0.6'
  end
  
  requires :apache, :ruby_enterprise
end
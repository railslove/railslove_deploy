package :passenger, :provides => :appserver do
  description 'Phusion Passenger (aka mod_rails)'
  gem 'passenger' do
    post :install, 'echo -en "\n\n\n\n" | sudo passenger-install-apache2-module'
  end
  
  # configure apache module
  config do 
    put "/etc/apache2/mods-available/passenger.load", open("#{File.dirname(__FILE__)}/../templates/passenger.load").read
    put "/etc/apache2/mods-available/passenger.conf", open("#{File.dirname(__FILE__)}/../templates/passenger.conf").read
    
    # enable passenger module
    post :install, "sudo a2enmod passenger"
    
    # Restart apache to note changes
    post :install, '/etc/init.d/apache2 restart'

  end
  
  # add rails user
  config do 
    pre :install, "groupadd -f rails"
    pre :install, "useradd -g rails -m rails"
    run 'echo "" && echo "-----------------------------------" && echo "PLEASE SET A PASSWORD FOR THE NEW RAILS USER:" && passwd rails'
    post :install, 'mkdir /var/www/apps'
    post :install, 'chown rails:rails /var/www/apps'
  end
  
  
  verify do
    has_gem 'passenger'
    has_file '/etc/apache2/mods-available/passenger.load'
    has_file '/usr/local/ruby-enterprise/lib/ruby/gems/1.8/gems/passenger-2.0.6/ext/apache2/mod_passenger.so'
    has_directory '/usr/local/ruby-enterprise/lib/ruby/gems/1.8/gems/passenger-2.0.6'
  end
  
  requires :apache, :ruby_enterprise
end
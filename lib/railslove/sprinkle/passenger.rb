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
    # seems a bit hackish here
    new_password = ""
    password_confirmation = "!"
    while new_password != password_confirmation
      new_password = enter("Enter a new password for the rails user: ")
      password_confirmation = enter("Confirm password: ")
    end
    
    run "echo 'rails:#{new_password}' | chpasswd"
    post :install, 'mkdir /var/www/apps'
    post :install, 'chown rails:rails /var/www/apps'
    post :install, "cp /root/.gemrc /home/rails/.gemrc"
  end
  
  
  verify do
    has_gem 'passenger'
    has_file '/etc/apache2/mods-available/passenger.load'
    has_file '/usr/local/ruby-enterprise/lib/ruby/gems/1.8/gems/passenger-2.0.6/ext/apache2/mod_passenger.so'
    has_directory '/usr/local/ruby-enterprise/lib/ruby/gems/1.8/gems/passenger-2.0.6'
  end
  
  requires :apache, :ruby_enterprise
end
# from josh's (http://joshpeek.com/) slicehost dpeloyment: http://github.com/josh/slicehost/tree/master
namespace :apache do
  desc "Restart Apache"
  task :restart, :roles => :web do
    sudo "/etc/init.d/apache2 restart"
  end
  
  desc "Start Apache"
  task :start, :roles => :web do
    sudo "/etc/init.d/apache2 start"
  end

  desc "Stop Apache"
  task :stop, :roles => :web do
    sudo "/etc/init.d/apache2 stop"
  end

  desc "Reload Apache"
  task :reload, :roles => :web do
    sudo "/etc/init.d/apache2 reload"
  end

  desc "Force reload Apache"
  task :force_reload, :roles => :web do
    sudo "/etc/init.d/apache2 force-reload"
  end
  
  desc "Disable Apache site"
  task :disable_site, :roles => :web do
    sudo "sudo a2dissite #{application}"
    reload
  end

  desc "Enable Apache site"
  task :enable_site, :roles => :web do
    sudo "sudo a2ensite #{application}"
    reload
  end

  desc "Upload Apache virtual host"
  task :upload_vhost_config, :roles => :web do
    put render("vhost", binding), application
    sudo "mv #{application} /etc/apache2/sites-available/#{application}"
  end
end
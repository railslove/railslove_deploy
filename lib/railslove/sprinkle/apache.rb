package :apache, :provides => :webserver do
  description 'Apache2 web server.'
  apt 'apache2 apache2.2-common apache2-mpm-prefork apache2-utils libexpat1' do
    post :install, 'a2enmod rewrite'
    post :install, 'a2enmod deflate'
    post :install, 'a2enmod expires'
    post :install, 'a2enmod headers'
    post :install, "a2dissite 000-default"
    
    # configure /server-status module
    ["<Location /server-status>","SetHandler server-status","Order deny,allow", "Deny from all", "Allow from 127.0.0.1", "</Location>"].each do |line|
      post :install, "echo '#{line}' | sudo tee -a /etc/apache2/status.conf"
    end
  end
  
  verify do
    has_process 'apache2'
  end
  
  requires :essentials, :apache2_prefork_dev
end

package :apache_xsendfile do
  description "installs the Apache X-Sendfile module"
  source "http://tn123.ath.cx/mod_xsendfile/mod_xsendfile-0.9.tar.gz" do
    custom_install "apxs2 -cia mod_xsendfile.c"
    post :install, "touch /etc/apache2/mods-available/xsendfile.load"
    post :install, 'echo "LoadModule xsendfile_module /usr/lib/apache2/modules/mod_xsendfile.so" > /etc/apache2/mods-available/xsendfile.load'
    post :install, "a2enmod xsendfile"
  end
  requires :apache
end


package :apache2_prefork_dev do
  description 'A dependency required by some packages.'
  apt 'apache2-prefork-dev'
end

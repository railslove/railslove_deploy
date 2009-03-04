package :apache, :provides => :webserver do
  description 'Apache2 web server.'
  apt 'apache2 apache2-dev apache2.2-common apache2-mpm-prefork apache2-utils libexpat1 ssl-cert' do
    post :install, 'a2enmod rewrite'
    post :install, 'a2enmod deflate'
    post :install, 'a2enmod expires'
  end
  
  verify do
    has_process 'apache2'
  end
  
  requires :essentials, :apache2_prefork_dev
end

package :apache2_prefork_dev do
  description 'A dependency required by some packages.'
  apt 'apache2-prefork-dev'
end

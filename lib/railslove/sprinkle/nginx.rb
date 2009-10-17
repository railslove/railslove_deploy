package :nginx, :provides => :webserver do 
  description "nginx webserver installed by passenger and configured"
  # NOTE: THE NGINX IS INSTALLED BY THE PASSENGER GEM... WHICH HAS IT'S OWN PACKAGE AND IS JUST REQUIRED HERE
  requires :passenger_nginx
  
  transfer "#{File.dirname(__FILE__)}/../templates/nginx_init", "/etc/init.d/nginx", :render => true, :sudo => true do
    post :install, 'update-rc.d nginx defaults'
    post :install, '/etc/init.d/nginx start'
  end
  
  verify do
    has_file "/etc/init.d/nginx"
    has_file "/etc/init.d/nginx"
    has_executable "/opt/nginx/sbin/nginx"
  end
end
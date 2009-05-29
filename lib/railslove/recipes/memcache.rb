namespace :memcache do 
  
  desc "Start Memcached"
  task :start, :roles => :cache do
    sudo "/etc/init.d/memcached start"
    #sudo "memcached -d -m #{memcache_memory} -l #{memcache_ip} -p #{memcache_port}"
  end
  
  desc "Stop Memcached using killall"
  task :stop, :roles => :cache do
    sudo "/etc/init.d/memcached stop"
    #sudo "killall memcached; echo 0"
  end
  
  desc "Restart Memcached"
  task :restart, :roles => :cache do 
    stop
    start
  end
  
end
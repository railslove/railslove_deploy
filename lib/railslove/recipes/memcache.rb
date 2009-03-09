namespace :memcache do 
  
  desc "Start Memcached"
  task :start do
    sudo "memcached -d -m #{memcache_memory} -l #{memcache_ip} -p #{memcache_port}"
  end
  
  desc "Stop Memcached using killall"
  task :stop do
    sudo "killall memcached"
  end
  
  desc "Restart Memcached"
  task :restart do 
    stop
    start
  end
  
end
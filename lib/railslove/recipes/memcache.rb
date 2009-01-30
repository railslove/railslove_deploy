namespace :memcache do 
  
  desc "start Memcache"
  task :start do
    sudo "memcached -d -m #{memcache_memory} -l #{memcache_ip} -p #{memcache_port}"
  end
  
  desc "stop Memcache"
  task :stop do
    sudo "killall memcached"
  end
  
  desc "restart Memcache"
  task :restart do 
    stop
    start
  end
  
end
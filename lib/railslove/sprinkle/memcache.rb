package :memcached_daemon, :provides => :memcached do
  description 'Memcached, a distributed memory object store'
  source 'http://danga.com/memcached/dist/memcached-1.2.6.tar.gz' do

    config do 
      put "/etc/init.d/memcached", open("#{File.dirname(__FILE__)}/../templates/memcache_init").read, :mode => 0755
    end
    
    post :install, "groupadd -f memcached"
    post :install, "useradd -g memcached -s /bin/false -d /dev/null memcached"
    post :install, "mkdir /var/run/memcached"
    post :install, "chown memcached:memcached /var/run/memcached"

    post :install, 'update-rc.d memcached defaults'
  
    post :install, '/etc/init.d/memcached start'
  
  end
  
  verify do
    has_executable 'memcached'
  end
  requires :libevent
end

package :libmemcached do
  source 'http://download.tangent.org/libmemcached-0.25.tar.gz'
  requires :memcached_daemon
end

package :libevent do
  source 'http://monkey.org/~provos/libevent-1.4.8-stable.tar.gz' do
    post :install, 'touch /etc/ld.so.conf.d/libevent-i386.conf'
    post :install, 'echo "/usr/local/lib/" | sudo tee -a /etc/ld.so.conf.d/libevent-i386.conf'
    post :install, 'sudo ldconfig'
  end
end

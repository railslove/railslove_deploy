package :essentials do
  description 'Essential Tools'
  apt %w{sudo wget make unzip libpcre3 libpcre3-dev libpcrecpp0 libssl-dev libxml2-dev libxml2 libxslt-dev zlib1g-dev libgcrypt11-dev openssl patch libssl-dev gcc g++ gettext libreadline-dev logrotate ssl-cert flex} do
    pre :install, 'apt-get update'
  end
  
  verify do
    has_executable "sudo"
    has_executable "wget"
    has_executable "make"
    has_executable "unzip"
  end
  
end

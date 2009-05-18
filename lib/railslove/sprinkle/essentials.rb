package :essentials do
  description 'Essential Tools'
  apt %w{sudo wget make unzip libpcre3 libpcre3-dev libpcrecpp0 libssl-dev zlib1g-dev libgcrypt11-dev openssl libssl-dev gcc g++ gettext libreadline-dev logrotate} do
    pre :install, 'apt-get update'
    pre :install, 'apt-get upgrade'
  end
  
  verify do
    has_executable "sudo"
    has_executable "wget"
    has_executable "make"
    has_executable "unzip"
  end
  
end

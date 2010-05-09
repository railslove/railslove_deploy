package :mongodb, :provides => :database do
  description 'Mongodb debian package.'
  apt 'mongodb-stable' do
    pre :install, "echo '#mongodb' | tee -a /etc/apt/sources.list"
    pre :install, "echo 'deb http://downloads.mongodb.org/distros/debian 5.0 10gen' | tee -a /etc/apt/sources.list"
    pre :install, "apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10"
    pre :install, "apt-get update"
  end
  
  verify do
    has_process 'mongod'
  end
  
  requires :essentials
end
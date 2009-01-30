package :ruby_enterprise, :provides => :ruby do
  description 'Ruby Enterprise Edition'
  version '1.8.6-20090113'
  
  install_path = "/usr/local/ruby-enterprise"
  
  source "http://rubyforge.org/frs/download.php/50087/ruby-enterprise-#{version}.tar.gz" do
    custom_install 'echo -en "\n/usr/local/ruby-enterprise\n" | sudo ./installer'
    
    ["","#Adding rubyenterprise as path",
    "PATH=$PATH:#{install_path}/bin",
    "export PATH"].each do |line|
      post :install, "echo '#{line}' |sudo tee -a /etc/profile"
    end
    
    #TODO: figure out how setting the ruby-enterprise dir in PATH variable for sudo
    post :install, "ln -s /usr/local/ruby-enterprise/bin/* /usr/local/bin/"
    
    #reload /etc/profile 
    post :install, "source /etc/profile"
    post :install, "gem sources -a http://gems.github.com"
  end
  
  verify do
    has_directory install_path
    has_executable "#{install_path}/bin/ruby"
  end
  
  requires :ree_dependencies
end

package :ree_dependencies do 
  apt %w(libopenssl-ruby zlib1g-dev libreadline5-dev libssl-dev)
end
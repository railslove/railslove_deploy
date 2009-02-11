require 'net/http'
package :ruby_enterprise, :provides => :ruby do
  description 'Ruby Enterprise Edition'
  
  source_url = Net::HTTP.get( 'www.rubyenterpriseedition.com', '/download.html' ).scan(/http:.*\.tar\.gz/).first
  version "#{source_url[/(ruby-enterprise.*)(.tar.gz)/, 1]}"
  install_path = "/usr/local/ruby-enterprise"
  
  source source_url do
    custom_install 'sudo ./installer --auto=/usr/local/ruby-enterprise'
    
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
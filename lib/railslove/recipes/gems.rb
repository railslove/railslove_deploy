# THANKS: http://dev.animoto.com/articles/capistrano-gem-management
# =========== 
# CAP GEMS
# Author: Stevie Clifton
# Somewhat hackish tasks for managing/installing remote gems
# that is loosely similar to "rake gems" in rails.
#
# Usage:
# > cap gems
#   [ ] RubyInline >=3.7.0 (box1.yourdomain.com, box2.yourdomain.com)
#   [I] image_science 1.1.3 
#
# > cap gems:install
# ...lots of cap stuff echoed to screen...
# Successfully installed RubyInline >=3.7.0
#
# > cap gems
#   [I] RubyInline >=3.7.0 
#   [I] image_science 1.1.3 
#
# ===========

namespace :gems do

  # prints status of all gems on remote system
  task :default do
    results = []
    with_gem_dependencies do |dep, gem, version|
      install_status = "[#{dep.pass? ? 'I' : ' '}]"
      hosts = dep.hosts ? "(#{dep.hosts})" : ""
      results << "#{install_status} #{gem.to_s} #{version} #{hosts}"
    end
    results.each {|r| puts r}
  end
  
  desc "installs gems listed in depend declarations"
  task :install do
    results = []
    with_gem_dependencies do |dep, gem, version|
      unless dep.pass?
        run "gem install --no-ri --no-rdoc #{"--version '#{version}' " if version}#{gem}"
        results << "Successfully installed #{gem} #{version}"
      end
    end
    results.each {|r| puts r}
  end
end


#====================
package :usefull_gems do
  USEFUL_GEMS ="astrails-safe bcrypt-ruby builder bundler chronic daemons erubis eventmachine haml i18n json json_pure mail memcache-client mime-types net-sftp net-ssh ParseTree rack rack-test rack-mount rails ruby2ruby RubyInline text-format thor tzinfo wvanbergen-request-log-analyzer"
  gem USEFUL_GEMS
  
  verify do
    USEFUL_GEMS.split(" ").each do |gem|
      has_gem gem
    end
  end
end
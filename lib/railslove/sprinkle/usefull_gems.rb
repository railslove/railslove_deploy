package :usefull_gems do
  USEFUL_GEMS ="aws-s3 astrails-safe bcrypt-ruby chronic daemons dm-core dm-more erubis eventmachine haml hpricot json json_pure memcache-client money mime-types net-sftp net-ssh newrelic_rpm oauth ParseTree rails RedCloth ruby-openid ruby2ruby RubyInline sinatra starling thor thoughtbot-factory_girl will_paginate wvanbergen-request-log-analyzer xml-simple xmpp4r xmpp4r-simple"
  gem USEFUL_GEMS
  
  verify do
    USEFUL_GEMS.split(" ").each do |gem|
      has_gem gem
    end
  end
end
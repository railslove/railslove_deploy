package :usefull_gems do
  USEFUL_GEMS ="authlogic aws-s3 astrails-safe bcrypt-ruby bundler chronic couchrest couch_potato daemons devise dm-core dm-more erubis eventmachine find_by_param haml hpricot json json_pure memcache-client money mime-types net-sftp net-ssh newrelic_rpm oauth paperclip ParseTree rack rails RedCloth ruby-openid ruby2ruby RubyInline sinatra starling thor thoughtbot-factory_girl will_paginate wvanbergen-request-log-analyzer xml-simple xmpp4r xmpp4r-simple"
  gem USEFUL_GEMS
  
  verify do
    USEFUL_GEMS.split(" ").each do |gem|
      has_gem gem
    end
  end
end
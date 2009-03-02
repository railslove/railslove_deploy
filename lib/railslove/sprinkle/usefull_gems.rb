package :usefull_gems do
  USEFUL_GEMS ="aws-s3 bcrypt-ruby chronic daemons dm-core dm-more erubis eventmachine facebooker graticule haml hpricot json json_pure memcache-client merb money mime-types oauth ParseTree RedCloth rfacebook ruby-openid ruby2ruby RubyInline sinatra starling thor thoughtbot-factory_girl thoughtbot-shoulda will_paginate xml-simple xmpp4r xmpp4r-simple"
  gem USEFUL_GEMS
  
  verify do
    USEFUL_GEMS.split(" ").each do |gem|
      has_gem gem
    end
  end
end
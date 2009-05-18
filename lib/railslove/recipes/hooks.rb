# thanks to Arya Asemanfa (http://asemanfar.com/) for http://github.com/arya/capistrano_twitter
require 'net/http'
require 'uri'
require 'cgi'

namespace :hooks do 
  namespace :twitter do
    desc "Update twitter status"
    task :update do
      url = URI.parse("http://twitter.com/statuses/update.json")
      
      status = Capistrano::CLI.ui.ask("Update Twitter status to: (leave blank to skip)")
      unless status.empty?
      
        http = Net::HTTP.new(url.host, 80)
        http.open_timeout = 20
      
        headers = {'Authorization' => 'Basic ' + ["#{twitter_user}:#{twitter_password}"].pack('m').delete("\r\n")}
      
        body = "status=#{CGI.escape(status)}"
        begin
          http.send(:post, url.path, body, headers) 
        rescue Timeout::Error => e
          puts "Timeout after 20s: Seems like Twitter is down."
          puts "Use \"cap twitter:update\" to update Twitter status later w/o deploying"
        end
        # if an exception is thrown, let them see it, they're a developer (most likely)
      end
    end
  end
end

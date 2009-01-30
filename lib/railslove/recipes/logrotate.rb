namespace :logrotate do
  
  desc "generate and save a logrotation config file"
  task :configure do
    filename = "/etc/logrotate.d/#{application}"

    File.open(filename, "w+") do |file| 
      file.write(generate_logrotate_configuration)
    end
  end
  
  desc "Force logrotate to run"
  task :force do
    sudo "logrotate -f /etc/logrotate.conf"
  end
  
end

def generate_logrotate_configuration
  %Q{
#{log_directory}/*.log {
  compress
  size #{log_size}
  rotate #{log_rotate}
  missingok
  compress
  copytruncate
}
  }
end

namespace :logrotate do
  
  desc "generate and save a logrotation config file"
  task :configure do
    filename = "/etc/logrotate.d/#{application}"
    tmp_file = "/tmp/logrotate_#{application}"
    put generate_logrotate_configuration, tmp_file
    sudo "mv #{tmp_file} #{filename}"
    
  end
  
  desc "Force logrotate to run"
  task :force do
    sudo "logrotate -f /etc/logrotate.conf"
  end
  
end

def generate_logrotate_configuration
  config = []    
  fetch(:logrotate_options, []).each do |option|            
    if option.is_a?(Hash)
      option.each do |key, value|
        config << "#{key} #{value}"
      end
    else
      config << option.to_s
    end
  end    
  %Q{
#{logrotate_directory}/*.log {
  #{config.join("\n  ")}
}
  }
end

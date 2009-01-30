desc "Connect to the Server(s) via SSH"
task :ssh do
  #sorry I don't know how to make this nice and DRY... *shame on me*
  don_ips = []
  # if you enter an role - just connect to these servers
  role = Capistrano::CLI.ui.ask("Role: (leave blank to connect to all server)")
  if not role.empty?
    roles[role.to_sym].each do |server|
      if don_ips.include?(server.host)
        puts("we've already hacked on #{server.host}")
        next
      end 
      puts server.host
      
      system("ssh #{user}@#{server.host} -p #{ssh_port}")
      don_ips << server.host
      sleep 1
    end
  # else connect to all servers
  else
    roles.each do |environment,settings|
      puts "----------------------"
      puts "#{environment.to_s.capitalize}:"
      settings.each do |server|
        if don_ips.include?(server.host)
          puts("we've already hacked on #{server.host}")
          next
        end 
        puts server.host
        system("ssh #{user}@#{server.host} -p #{ssh_port}")
        don_ips << server.host
        sleep 1
      end
    end
  end
end
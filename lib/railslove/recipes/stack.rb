namespace :stack do 
  
  desc "Setup a new Server using sprinkle"
  task :setup do 
    puts "STACK SETUP"
    `sprinkle -c -f -s config/server/setup.rb`
    puts "[DONE]"
    puts open("#{File.dirname(__FILE__)}/../templates/stack_readmne.txt").read
  end
  
end

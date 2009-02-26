namespace :db do
  desc "Restarts MySQL database server"
  task :restart, :roles => :db do
    sudo "/etc/init.d/mysql restart"
  end

  desc "Starts MySQL database server"
  task :start, :roles => :db do
    sudo "/etc/init.d/mysql start"
  end

  desc "Stops MySQL database server"
  task :stop, :roles => :db do
    sudo "/etc/init.d/mysql stop"
  end

  desc "Export MySQL database"
  task :export, :roles => :db do
    database = Capistrano::CLI.ui.ask("Which database should we export: ")
    sudo "mysqldump -u root -p #{database} > #{database}.sql"
  end

  desc "run the rake db:create task for the specific environment"
  task :create, :roles => :db, :only => { :primary => true } do
    rake("db:create")
  end
  
  desc "Upload the database yml from the /config/database.yml"
  task :upload_config_yml, :roles => :db do
    put open("config/database.yml").read, "#{shared_path}/database.yml"
    run "ln -nfs #{shared_path}/database.yml #{release_path}/config/database.yml"
  end
  desc "Symlink database.yml to shared path"
  task :symlink_config_yml, :roles => :db do
    run "ln -nfs #{shared_path}/database.yml #{release_path}/config/database.yml"
  end
  
  desc "create a backup of the mysql database save it to shared/backups/database and download it to /backups"
  task :backup, :roles => :db, :only => { :primary => true } do 
    filename = "#{application}.dump.#{Time.now.to_i}.sql.bz2"
    dir = backup_dir || "#{shared_dir}/backups"
    file = "#{dir}/#{filename}"
    
    on_rollback { delete file }
    
    db = YAML::load(ERB.new(IO.read(File.join('config', 'database.yml'))).result)[rails_env]
    run "mysqldump -u #{db['username']} --password=#{db['password']} #{db['database']} | bzip2 -c > #{file}"  do |ch, stream, data|
      puts data
    end
    `mkdir -p backups/`
    get file, "backups/#{filename}"
  end
end

namespace :shared do
  
  # source is the file/folder within the release 
  # target is the file/folder in the shared folder
  
  task :setup do
    fetch(:shared_files,{}).each do |source,target|
      path = File.directory?(source) ? target : File.dirname(target)
      run "mkdir -p #{shared_path}/#{path}"
    end
  end

  task :symlink do 
    fetch(:shared_files,{}).each do |source,target|
      run "rm -rf #{source}"
      run "ln -s #{shared_path}/#{target} #{release_path}/#{source}"
    end
  end
  
end
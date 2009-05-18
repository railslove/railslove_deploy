namespace :shared do
  task :setup do
    fetch(:shared_files,{}).each do |source,target|
      path = File.directory?(source) ? File.dirname(target) : target
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
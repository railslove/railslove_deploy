# from http://pivotallabs.com/users/chad/blog/articles/1208-automating-bundler-in-your-deploy
namespace :deploy do
  desc "installs Bundler if it is not already installed"
  task :install_bundler, :roles => :app do
    sudo "sh -c 'if [ -z `which bundle` ]; then echo Installing Bundler; sudo gem install bundler; fi'"
  end

  desc "run 'bundle install' to install Bundler's packaged gems for the current deploy"
  task :bundle_install, :roles => :app do
    run "cd #{release_path} && bundle install --relock"
  end
end
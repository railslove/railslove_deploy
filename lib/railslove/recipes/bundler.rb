namespace :deploy do
  desc "run 'bundle install' to install Bundler's packaged gems for the current deploy"
  task :bundle_install, :roles => :app do
    run <<-CMD
      mkdir -p #{shared_path}/.bundle &&
      mkdir -p #{shared_path}/vendor/bundler_gems
    CMD

    run <<-CMD
      ln -s #{shared_path}/.bundle #{latest_release}/.bundle &&
      ln -s #{shared_path}/vendor/bundler_gems #{latest_release}/vendor/bundler_gems
    CMD

    run "cd #{latest_release} && /usr/local/ruby-enterprise/bin/bundle check || /usr/local/ruby-enterprise/bin/bundle install vendor/bundler_gems --disable-shared-gems --without development test"
  end
end
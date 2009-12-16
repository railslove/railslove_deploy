# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{railslove_deploy}
  s.version = "0.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Michael Bumann"]
  s.date = %q{2009-12-16}
  s.default_executable = %q{deployify}
  s.description = %q{The Railslove deploy gem is a collection of sprinkle and capistrano recipes to setup your server and app deployment. Setup your server and deploy your app within minutes and let the script }
  s.email = %q{michael@railslove.com}
  s.executables = ["deployify"]
  s.extra_rdoc_files = [
    "LICENSE",
     "README",
     "TODO"
  ]
  s.files = [
    "bin/deployify",
     "lib/railslove/recipes.rb",
     "lib/railslove/recipes/apache.rb",
     "lib/railslove/recipes/backup.rb",
     "lib/railslove/recipes/db.rb",
     "lib/railslove/recipes/deploy.rb",
     "lib/railslove/recipes/ferm.rb",
     "lib/railslove/recipes/gems.rb",
     "lib/railslove/recipes/helpers.rb",
     "lib/railslove/recipes/hooks.rb",
     "lib/railslove/recipes/job_runner.rb",
     "lib/railslove/recipes/logrotate.rb",
     "lib/railslove/recipes/memcache.rb",
     "lib/railslove/recipes/misc.rb",
     "lib/railslove/recipes/monit.rb",
     "lib/railslove/recipes/passenger.rb",
     "lib/railslove/recipes/shared.rb",
     "lib/railslove/recipes/sphinx.rb",
     "lib/railslove/recipes/workling.rb",
     "lib/railslove/sprinkle.rb",
     "lib/railslove/sprinkle/apache.rb",
     "lib/railslove/sprinkle/essentials.rb",
     "lib/railslove/sprinkle/ferm.rb",
     "lib/railslove/sprinkle/git.rb",
     "lib/railslove/sprinkle/image_magick.rb",
     "lib/railslove/sprinkle/memcache.rb",
     "lib/railslove/sprinkle/monit.rb",
     "lib/railslove/sprinkle/mysql.rb",
     "lib/railslove/sprinkle/nginx.rb",
     "lib/railslove/sprinkle/passenger.rb",
     "lib/railslove/sprinkle/rails_user.rb",
     "lib/railslove/sprinkle/ruby_enterprise.rb",
     "lib/railslove/sprinkle/sphinx.rb",
     "lib/railslove/sprinkle/sqlite.rb",
     "lib/railslove/sprinkle/subversion.rb",
     "lib/railslove/sprinkle/usefull_gems.rb",
     "lib/railslove/templates/deploy.rb",
     "lib/railslove/templates/ferm.conf.erb",
     "lib/railslove/templates/maintenance.html",
     "lib/railslove/templates/memcache_init",
     "lib/railslove/templates/monit_init",
     "lib/railslove/templates/monitoring/apache.monit.erb",
     "lib/railslove/templates/monitoring/job_worker.monit.erb",
     "lib/railslove/templates/monitoring/memcached.monit.erb",
     "lib/railslove/templates/monitoring/mysql.monit.erb",
     "lib/railslove/templates/monitoring/nginx.monit.erb",
     "lib/railslove/templates/monitoring/sphinx.monit.erb",
     "lib/railslove/templates/monitoring/sshd.monit.erb",
     "lib/railslove/templates/monitrc.erb",
     "lib/railslove/templates/nginx.conf",
     "lib/railslove/templates/nginx_init",
     "lib/railslove/templates/passenger.conf",
     "lib/railslove/templates/passenger.load",
     "lib/railslove/templates/post_logrotate",
     "lib/railslove/templates/safe.rb",
     "lib/railslove/templates/sprinkle.rb",
     "lib/railslove/templates/sprinkle_config.rb",
     "lib/railslove/templates/sshd_config.erb",
     "lib/railslove/templates/stack_readme.txt",
     "lib/railslove/templates/vhost.erb",
     "lib/railslove_deploy.rb",
     "test/railslove_deploy_test.rb",
     "test/test_helper.rb"
  ]
  s.homepage = %q{http://github.com/railslove/railslove_deploy}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{The Railslove deploy gem to setup a full ruby server stack. Includes Sprinkle setup scripts and Capistrano deployment recipes.}
  s.test_files = [
    "test/railslove_deploy_test.rb",
     "test/test_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<capistrano>, [">= 2.5"])
    else
      s.add_dependency(%q<capistrano>, [">= 2.5"])
    end
  else
    s.add_dependency(%q<capistrano>, [">= 2.5"])
  end
end


# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{railslove_deploy}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Michael Bumann"]
  s.date = %q{2009-05-14}
  s.default_executable = %q{gwify}
  s.description = %q{TODO}
  s.email = %q{michael@railslove.com}
  s.executables = ["gwify"]
  s.extra_rdoc_files = ["README", "LICENSE"]
  s.files = ["bin/gwify", "lib/railslove", "lib/railslove/recipes", "lib/railslove/recipes/apache.rb", "lib/railslove/recipes/db.rb", "lib/railslove/recipes/deploy.rb", "lib/railslove/recipes/gems.rb", "lib/railslove/recipes/god.rb", "lib/railslove/recipes/helpers.rb", "lib/railslove/recipes/hooks.rb", "lib/railslove/recipes/logrotate.rb", "lib/railslove/recipes/memcache.rb", "lib/railslove/recipes/misc.rb", "lib/railslove/recipes/passenger.rb", "lib/railslove/recipes/shared.rb", "lib/railslove/recipes/sphinx.rb", "lib/railslove/recipes/workling.rb", "lib/railslove/recipes.rb", "lib/railslove/sprinkle", "lib/railslove/sprinkle/apache.rb", "lib/railslove/sprinkle/essentials.rb", "lib/railslove/sprinkle/git.rb", "lib/railslove/sprinkle/image_magick.rb", "lib/railslove/sprinkle/memcache.rb", "lib/railslove/sprinkle/mysql.rb", "lib/railslove/sprinkle/nginx.rb", "lib/railslove/sprinkle/passenger.rb", "lib/railslove/sprinkle/ruby_enterprise.rb", "lib/railslove/sprinkle/sphinx.rb", "lib/railslove/sprinkle/sqlite.rb", "lib/railslove/sprinkle/subversion.rb", "lib/railslove/sprinkle/usefull_gems.rb", "lib/railslove/sprinkle.rb", "lib/railslove/templates", "lib/railslove/templates/deploy.rb", "lib/railslove/templates/iptables.erb", "lib/railslove/templates/memcache_init", "lib/railslove/templates/passenger.conf", "lib/railslove/templates/passenger.load", "lib/railslove/templates/sprinkle.rb", "lib/railslove/templates/sprinkle_config.rb", "lib/railslove/templates/sshd_config.erb", "lib/railslove/templates/stack_readme.txt", "lib/railslove/templates/vhost.erb", "lib/railslove_deploy.rb", "test/railslove_deploy_test.rb", "test/test_helper.rb", "README", "LICENSE"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/bumi/railslove_deploy}
  s.rdoc_options = ["--inline-source", "--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{The Railslove Deploy recipes}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<capistrano>, [">= 2.5"])
      s.add_runtime_dependency(%q<sprinkle>, [">= 0.1.9"])
    else
      s.add_dependency(%q<capistrano>, [">= 2.5"])
      s.add_dependency(%q<sprinkle>, [">= 0.1.9"])
    end
  else
    s.add_dependency(%q<capistrano>, [">= 2.5"])
    s.add_dependency(%q<sprinkle>, [">= 0.1.9"])
  end
end

package :mysql, :provides => :database do
  description 'MySQL Database'
  apt %w( mysql-server mysql-client libmysqlclient15-dev ) do
    post :install, "echo \"create user 'readonly';grant select on *.* to 'readonly'@'localhost';\" | mysql -u root"
  end
  
  verify do
    has_executable 'mysql'
  end
end
 
package :mysql_driver, :provides => :database_driver do
  description 'Ruby MySQL database driver'
  gem 'mysql'
  
  verify do
    has_gem 'mysql'
  end
  requires :ruby_enterprise
end

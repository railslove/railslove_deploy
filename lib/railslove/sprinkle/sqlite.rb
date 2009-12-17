# from the original sprinkle gem: http://github.com/crafterm/sprinkle/tree/master
# Packages to install sqlite3 and the sqlite3 ruby driver.
package :sqlite3, :provides => :database do
  description 'SQLite3 database'
  apt 'sqlite3 libsqlite3-dev libsqlite3-ruby1.8'
end

package :sqlite3_ruby_driver, :provides => :database_driver do
  description 'Ruby SQLite3 library.'
  gem 'sqlite3-ruby'
  
  verify do
    ruby_can_load 'sqlite3'
  end
end
require 'sprinkle'
Dir["#{File.dirname(__FILE__)}/sprinkle/*.rb"].each { |package| 
  require package
}
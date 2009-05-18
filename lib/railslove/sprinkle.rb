require "#{File.dirname(__FILE__)}/vendor/sprinkle/lib/sprinkle"
Dir["#{File.dirname(__FILE__)}/sprinkle/*.rb"].each { |package| 
  require package
}
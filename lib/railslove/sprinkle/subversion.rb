package :subversion, :provides => :scm do
  description 'Subversion Version Control'
  apt %w{subversion subversion-tools libsvn-dev}
end

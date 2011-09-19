package :git, :provides => :scm do
  description 'Git Distributed Version Control'
  apt 'git-core'
  verify do
    has_file '/usr/bin/git'
  end
end

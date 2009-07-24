package :monit, :provides => :monitoring do
  description 'installs monit - a system monitoring utility which allows an admin to easily monitor files, processes, directories, or devices on your system.'
  apt 'monit'
  requires :essentials
  
  
  verify do
    has_executable "monit"
  end
end

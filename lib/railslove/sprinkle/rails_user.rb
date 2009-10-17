package :rails_user do
  description 'Creates a special user (sudoer) for all the Rails stuff'
  
  noop do 

    pre :install, "groupadd -f rails"
    pre :install, "useradd -g rails -m rails;echo 0"
    pre :install, "echo 'rails\tALL=(ALL) ALL' | tee -a /etc/sudoers"
    pre :install, "mkdir /home/rails/.ssh; echo 0"
    pre :install, "chown -R rails:rails /home/rails/.ssh; echo 0"
    #run "cat /tmp/ssh_key.pub.client >> /home/rails/.ssh/authorized_keys"
    pre :install, "mkdir /var/www/rails_apps;echo 0"
    pre :install, "chown rails:rails -R /var/www/rails_apps;echo 0"
    pre :install, "cp /root/.gemrc /home/rails/.gemrc"
    pre :install, "chown rails:rails /home/rails/.gemrc;echo 0"
    pre :install, "mkdir /backup;echo 0"
  end
  
end
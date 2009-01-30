package :ssh do
  description "Install and harden SSH access"
  apt "sshd" do
    #upload ssh config
  end
  
end
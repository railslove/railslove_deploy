package :iptables do
  config do 
    
    put "/etc/iptables.up.rules", render("iptables", binding)
    
    if capture("cat /etc/network/interfaces").grep(/iptables/).empty?
      run %(cat /etc/network/interfaces |
        sed '/iface lo inet loopback/G' |
        sed -e '6s/.*/pre-up iptables-restore < \\/etc\\\/iptables.up.rules/' >
        interfaces
      )
      sudo "mv interfaces /etc/network/interfaces"
    end
    
  end
end

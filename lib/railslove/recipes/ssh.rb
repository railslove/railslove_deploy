# from josh's (http://joshpeek.com/) slicehost dpeloyment: http://github.com/josh/slicehost/tree/master 
ssh_options = { :keys => [File.expand_path("~/.ssh/id_dsa"),File.expand_path("~/.ssh/id_rsa") ], :port => 22 }

namespace :sshd do
  desc <<-DESC
    Reload SSH service.
  DESC
  task :reload, :roles => :gateway do
    sudo "/etc/init.d/ssh reload"
  end

  desc <<-DESC
    Setup SSH on the gateway host. Runs `upload_keys` and `configure_sshd` \
    then reloads the SSH service to finalize the changes.
  DESC
  task :setup, :roles => :gateway do
    upload_keys
    configure_sshd
    reload
  end

  desc <<-DESC
    Uploads your local public SSH keys to the server. A .ssh folder is created if \
    one does not already exist. The SSH keys default to the ones set in \
    Capistrano's ssh_options. You can change this by setting ssh_options[:keys] = \
    ["/home/user/.ssh/id_dsa"].

    See "SSH copy" and "SSH Permissions" sections on \
    http://articles.slicehost.com/2008/4/25/ubuntu-hardy-setup-page-1
  DESC
  task :upload_keys, :roles => :gateway do
    run "mkdir -p ~/.ssh"
    run "chown -R #{user}:#{user} ~/.ssh"
    run "chmod 700 ~/.ssh"

    authorized_keys = ssh_options[:keys].collect { |key| 
			begin
				File.read("#{key}.pub")
			rescue Errno::ENOENT => e
			end
			
	  }.join("\n")
    put authorized_keys, "./.ssh/authorized_keys", :mode => 0600
  end

  desc <<-DESC
    Configure SSH daemon with more secure settings recommended by Slicehost. The \
    will be configured to run on the port configured in Capistrano's "ssh_options". \
    This defaults to the standard SSH port 22. You can change this by setting \
    ssh_options[:port] = 3000. Note that this change will not take affect until \
    reload the SSH service with `cap ssh:reload`.

    See "SSH config" section on \
    http://articles.slicehost.com/2008/4/25/ubuntu-hardy-setup-page-1
  DESC
  task :configure_sshd, :roles => :gateway do
    put render("sshd_config", binding), "sshd_config"
    sudo "mv sshd_config /etc/ssh/sshd_config"
  end
end

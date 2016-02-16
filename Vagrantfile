VAGRANTFILE_API_VERSION ||= "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

	# Use the Scotch Box https://box.scotch.io/
	config.vm.box = "scotch/box"

	# Create a private network
	config.vm.network "private_network", ip: "192.168.10.11"

	# Share directory with the VM via NFS
	config.vm.synced_folder "/Users/[user]/Sites/my-site", "/var/www/my-site"

	# Add public key for SSH access
	config.vm.provision "shell" do |s|
		ssh_pub_key = File.readlines("#{Dir.home}/.ssh/id_rsa.pub").first.strip
		s.inline = <<-SHELL
			echo #{ssh_pub_key} >> /home/vagrant/.ssh/authorized_keys
			echo #{ssh_pub_key} >> /root/.ssh/authorized_keys
		SHELL
	end

	# Run shell script provisioning on first box boot
	config.vm.provision :shell, path: "vagrant-provision.sh"

	# Run a script at every boot
	config.vm.provision :shell, path: "vagrant-start.sh", run: "always", privileged: true

end

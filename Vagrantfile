require 'yaml'

yamlConfig = YAML.load_file("scripts/vagrantConfig.yaml")

VAGRANTFILE_API_VERSION ||= "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

	# Use the Scotch Box https://box.scotch.io/
	config.vm.box = "scotch/box"

	# Create a private network
	config.vm.network "private_network", ip: yamlConfig["ipAddress"]

	# Share directory with the VM via NFS
	config.vm.synced_folder yamlConfig["syncDir"], "/var/www/development"

	# Add public key for SSH access
	config.vm.provision "shell" do |s|
		ssh_pub_key = File.readlines("#{Dir.home}/.ssh/id_rsa.pub").first.strip
		s.inline = <<-SHELL
			echo #{ssh_pub_key} >> /home/vagrant/.ssh/authorized_keys
			echo #{ssh_pub_key} >> /root/.ssh/authorized_keys
		SHELL
	end

	config.vm.provider :virtualbox do |v|
		# Set the timesync threshold to 5 seconds, instead of the default 20 minutes, and set timesync to run automatically upon wake.
		v.customize ["guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/--timesync-set-threshold", "5000"]
		v.customize ["guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/--timesync-set-start"]
		v.customize ["guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/--timesync-set-on-restore", "1"]
	end

	# Run shell script provisioning on first box boot
	config.vm.provision :shell, path: "scripts/vagrantProvision.sh"

	# Run a script at every boot
	config.vm.provision :shell, path: "scripts/vagrantStart.sh", run: "always", privileged: true

end

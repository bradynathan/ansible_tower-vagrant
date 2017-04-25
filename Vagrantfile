VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
	config.vm.define "tower" do |tower|
		config.ssh.insert_key = false
		#tower.vm.box = "http://vms.ansible.com/ansible-tower-2.4.5-virtualbox.box"
		tower.vm.box = "centos/7"
		config.vm.network "private_network", ip: "192.168.50.15"
		config.vm.network :forwarded_port, guest: 22, host: 2327, id: "ssh"
		tower.vm.provider :virtualbox do |vb|
			vb.customize ["modifyvm", :id, "--memory", 2048]
		end
		config.vm.provision "shell", path: "install_ansible.sh"
	end
end

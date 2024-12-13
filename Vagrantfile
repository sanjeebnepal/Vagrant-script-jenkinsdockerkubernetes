VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    config.vm.define "dockervm" do |vm2|
        vm2.vm.box = "generic/debian12"
        vm2.vm.hostname = "docker"
        vm2.ssh.insert_key = false
        vm2.vm.network :private_network, ip: "192.168.56.4"
        vm2.vm.provision "shell", privileged: true, path: "script-docker.sh"
        vm2.vm.provider "virtualbox" do |v|
          v.memory = 2048
          v.cpus = 2
          v.customize ["modifyvm", :id, "--nictype1", "virtio"]
        end
    end

    config.vm.define "jenkinsvm" do |vm1|
      vm1.vm.box = "generic/debian12"
      vm1.vm.hostname = "jenkinsvm"
      vm1.ssh.insert_key = false
      vm1.vm.synced_folder "jenkins-config", "/home/vagrant/jenkins-config", owner: "vagrant", group: "vagrant"
      vm1.vm.network :private_network, ip: "192.168.56.3"
      vm1.vm.provision "shell", privileged: true, path: "script-jenkins.sh"
      vm1.vm.provision "shell", privileged: true, path: "ssh-setup.sh"
      vm1.vm.provider "virtualbox" do |v|
        v.memory = 2048
        v.cpus = 2
        v.customize ["modifyvm", :id, "--nictype1", "virtio"]
      end
  end
    
end
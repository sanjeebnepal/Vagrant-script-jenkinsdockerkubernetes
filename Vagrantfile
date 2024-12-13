VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # Second virtual machine configuration
  config.vm.define "labvm2" do |vm2|
    vm2.vm.box = "generic/debian12"
    vm2.vm.hostname = "controlnode"
    vm2.ssh.insert_key = false
    vm2.vm.network :private_network, ip: "192.168.10.134"
    vm2.vm.provision "shell", privileged: true, path: "script-docker.sh"
    vm2.vm.provider "vmware_desktop" do |v|
      v.allowlist_verified = true
      v.gui = false
      v.vmx["memsize"] = "2048"
      v.vmx["numvcpus"] = "2"
      end
  end

  config.vm.define "labvm3" do |vm3|
    vm3.vm.box = "generic/debian12"
    vm3.vm.hostname = "workernode1"
    vm3.ssh.insert_key = false
    vm3.vm.network :private_network, ip: "192.168.10.137"
    vm3.vm.provision "shell", privileged: true, path: "script-docker.sh"
    vm3.vm.provider "vmware_desktop" do |v|
      v.allowlist_verified = true
      v.gui = false
      v.vmx["memsize"] = "2048"
      v.vmx["numvcpus"] = "2"
      end
  end

  config.vm.define "labvm4" do |vm4|
    vm4.vm.box = "generic/debian12"
    vm4.vm.hostname = "workernode2"
    vm4.ssh.insert_key = false
    vm4.vm.network :private_network, ip: "192.168.10.138"
    vm4.vm.provision "shell", privileged: true, path: "script-docker.sh"
    vm4.vm.provider "vmware_desktop" do |v|
      v.allowlist_verified = true
      v.gui = false
      v.vmx["memsize"] = "2048"
      v.vmx["numvcpus"] = "2"
      end
  end

  # First virtual machine configuration
  config.vm.define "labvm1" do |vm1|
    vm1.vm.box = "generic/debian12"
    vm1.vm.hostname = "jenkinsvm"
    vm1.ssh.insert_key = false
    vm1.vm.synced_folder "jenkins-config", "/home/vagrant/jenkins-config", owner: "vagrant", group: "vagrant"
    vm1.vm.network :private_network, ip: "192.168.10.128"
    vm1.vm.provision "shell", privileged: true, path: "script-jenkins.sh"
    vm1.vm.provision "shell", privileged: true, path: "ssh-setup.sh"
    vm1.vm.provider "vmware_desktop" do |v|
      v.allowlist_verified = true
      v.gui = false
      v.vmx["memsize"] = "2048"
      v.vmx["numvcpus"] = "2"
    end
  end
  # config.vm.define "rocky" do |vm3|
  #   vm3.vm.box = "rockylinux/9"
  #   vm3.vm.hostname = "rocky"
  #   vm3.ssh.insert_key = false
  #   # vm3.vm.network :private_network, ip: "192.168.219.136"
  #   vm3.vm.provider "vmware_desktop" do |v|
  #     v.allowlist_verified = true
  #     v.gui = false
  #     v.vmx["memsize"] = "2048"
  #     v.vmx["numvcpus"] = "2"
  #     end
  # end

  # config.vm.define "rhel" do |vm4|
  #   vm4.vm.box = "generic/rhel9"
  #   vm4.vm.hostname = "rhel"
  #   vm4.ssh.insert_key = false
  #   # vm4.vm.network :private_network, ip: "192.168.219.136"
  #   vm4.vm.provider "vmware_desktop" do |v|
  #     v.allowlist_verified = true
  #     v.gui = false
  #     v.vmx["memsize"] = "2048"
  #     v.vmx["numvcpus"] = "2"
  #     end
  # end

end

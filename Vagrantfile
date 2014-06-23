# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "centos-6.5-x86_64"

  config.vm.define "master" do |master|
    master.vm.box = "ubuntu-12.04-server-x86_64"
    master.vm.host_name = "puppet01.ubelix.unibe.ch"
    master.vm.network "private_network", ip: "192.168.10.30"
    master.vm.network "forwarded_port", guest: 443, host: 8843
    master.vm.provider "virtualbox" do |vb|
      vb.name = "puppet01.ubelix.unibe.ch"
      vb.customize ["modifyvm", :id, "--name", "puppet01"]
      vb.customize ["modifyvm", :id, "--memory", "2048"]
      vb.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/vagrant-root", "1"]
    end
    master.vm.provision "shell", path: "bootstrap_master.sh", args: "3600"
  end

  (1..4).each do |index|
    config.vm.define "node0#{index}" do |node|
      node.vm.host_name = "node0#{index}.ubelix.unibe.ch"
      node.vm.network "private_network", ip: "192.168.10.3#{index}"
      node.vm.provider "virtualbox" do |vb|
        vb.name = "node0#{index}"
        vb.customize ["modifyvm", :id, "--name", "node0#{index}"]
        vb.customize ["modifyvm", :id, "--memory", "512"]
        vb.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/vagrant-root", "1"]
      end
      node.vm.provision "shell", path: "bootstrap_node.sh"
    end
  end
end


# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "centos-6.5-x86_64"

  config.vm.define "master" do |master|
    master.vm.host_name = "puppet01.ubelix.unibe.ch"
    master.vm.network "private_network", ip: "192.168.10.30"
    master.vm.network "forwarded_port", guest: 443, host: 8843
    master.vm.provider "virtualbox" do |vb|
      vb.name = "puppet01.ubelix.unibe.ch"
      vb.customize ["modifyvm", :id, "--name", "puppet01"]
      vb.customize ["modifyvm", :id, "--memory", "2048"]
      vb.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/vagrant-root", "1"]
    end
    master.vm.provision :hosts
    # args: <pe-pkg-version> <pe-pkg-platform> <console-session-timeout>
    master.vm.provision "shell", path: "bin/bootstrap_master.sh", args: "3.3.1 el-6-x86_64 3600"
  end

  config.vm.define "gridadmin" do |gridadmin|
    gridadmin.vm.host_name = "gridadmin01.ubelix.unibe.ch"
    gridadmin.vm.network "private_network", ip: "192.168.10.40"
    gridadmin.vm.provider "virtualbox" do |vb|
      vb.name = "gridadmin01.ubelix.unibe.ch"
      vb.customize ["modifyvm", :id, "--name", "gridadmin01"]
      vb.customize ["modifyvm", :id, "--memory", "2048"]
      vb.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/vagrant-root", "1"]
    end
    gridadmin.vm.provision :hosts
    # args: <pe-pkg-version> <pe-pkg-platform> <console-session-timeout>
    gridadmin.vm.provision "shell", path: "bin/bootstrap_node.sh", args: "3.3.1 el-6-x86_64 3600"
  end

  config.vm.define "grid" do |grid|
    grid.vm.host_name = "grid02.ubelix.unibe.ch"
    grid.vm.network "private_network", ip: "192.168.10.41"
    grid.vm.provider "virtualbox" do |vb|
      vb.name = "grid02.ubelix.unibe.ch"
      vb.customize ["modifyvm", :id, "--name", "grid02"]
      vb.customize ["modifyvm", :id, "--memory", "2048"]
      vb.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/vagrant-root", "1"]
    end
    grid.vm.provision :hosts
    # args: <pe-pkg-version> <pe-pkg-platform> <console-session-timeout>
    grid.vm.provision "shell", path: "bin/bootstrap_node.sh", args: "3.3.1 el-6-x86_64 3600"
  end


  (1..2).each do |index|
    config.vm.define "fnode0#{index}" do |node|
      node.vm.host_name = "fnode0#{index}.ubelix.unibe.ch"
      node.vm.network "private_network", ip: "192.168.10.5#{index}"
      node.vm.provider "virtualbox" do |vb|
        vb.name = "fnode0#{index}"
        vb.customize ["modifyvm", :id, "--name", "fnode0#{index}"]
        vb.customize ["modifyvm", :id, "--memory", "512"]
        vb.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/vagrant-root", "1"]
      end
      node.vm.provision :hosts
      node.vm.provision "shell", path: "bin/bootstrap_node.sh"
    end
  end

  (1..2).each do |index|
    config.vm.define "hnode0#{index}" do |node|
      node.vm.host_name = "hnode0#{index}.ubelix.unibe.ch"
      node.vm.network "private_network", ip: "192.168.10.6#{index}"
      node.vm.provider "virtualbox" do |vb|
        vb.name = "hnode0#{index}"
        vb.customize ["modifyvm", :id, "--name", "hnode0#{index}"]
        vb.customize ["modifyvm", :id, "--memory", "512"]
        vb.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/vagrant-root", "1"]
      end
      node.vm.provision :hosts
      node.vm.provision "shell", path: "bin/bootstrap_node.sh"
    end
  end

end


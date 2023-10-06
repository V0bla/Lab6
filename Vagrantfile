# -*- mode: ruby -*- 
# vi: set ft=ruby : vsa
  Vagrant.configure("2") do |config| 
    config.vm.box = "centos/8" 
    config.vm.box_version = "2011.0" 
    config.vm.provider "virtualbox" do |v| 
    v.memory = 256 
    v.cpus = 1 
  end
  config.vm.define "lab6" do |lab6| 
    lab6.vm.network "private_network", type: "dhcp" 
    lab6.vm.hostname = "lab6"
    lab6.vm.provision "shell" , path: "script.sh"
    lab6.vm.provision "shell", inline: <<-SHELL
      yum install -y redhat-lsb-core wget rpmdevtools rpm-build createrepo yum-utils gcc
    SHELL
  end 
end   
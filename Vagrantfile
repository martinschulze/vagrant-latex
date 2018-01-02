# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu_1604"

  config.vm.define "latex" do |latex|
  end

  config.vm.provider "virtualbox" do |v|
    v.customize ["modifyvm", :id, "--memory", "4096"]
    v.customize ["modifyvm", :id, "--vram", "128"]

    v.name = "Latex2"
    v.customize ["modifyvm", :id, "--groups", "/Coding"]
    v.gui = true
  end
  config.vm.synced_folder "./data", "/var/vagrant_data"

  config.vm.provision "shell", inline: <<-SHELL
    mkdir -p /etc/puppet
    sudo touch /etc/puppet/hiera.yaml
    sudo DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" upgrade
    sudo apt-get update
    sudo apt-get dist-upgrade -y
    sudo apt-get install -y xubuntu-desktop
    sudo apt-get install -f
    sudo apt-get install -y language-pack-de-base
    sudo apt-get install -y puppet
  SHELL

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "manifests"
    puppet.manifest_file  = "latex.pp"
    puppet.module_path = "modules"
  end

end

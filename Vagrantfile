# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.
  
  config.vm.define "xenial" do |xenial|
  
  	# Every Vagrant virtual environment requires a box to build off of.
 	xenial.vm.box = "ubuntu/xenial64"
 	
  	# xenial.vm.hostname = "cdavng"
 	
 	xenial.vm.provider "virtualbox" do |vb|
		vb.name = "Jekyll"
	end
 	
 	xenial.vm.synced_folder ".", "/vagrant"
  
	xenial.vm.provision "shell", inline: "grep ubuntu-xenial /etc/hosts -q || sudo echo '127.0.0.1 ubuntu-xenial' >> /etc/hosts"
	xenial.vm.provision "shell", inline: "sudo apt-get --no-install-recommends install virtualbox-guest-utils python jekyll -y"
	
	xenial.vm.network "forwarded_port", guest: 4000, host: 4000
  	
  
  end

end

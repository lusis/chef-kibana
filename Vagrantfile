# -*- mode: ruby -*-
# vi: set ft=ruby :


Vagrant.require_plugin "vagrant-berkshelf"
Vagrant.require_plugin "vagrant-omnibus"

Vagrant.configure("2") do |config|

  # Berkshelf plugin configuration
  config.berkshelf.enabled = true

  # Omnibus plugin configuration
  config.omnibus.chef_version = :latest

  config.vm.provision :chef_solo do |chef|
    chef.json = 
      {
        kibana: { 
          webserver_listen: "0.0.0.0"
        }
      }
    chef.run_list = [ "recipe[apt::default]", "recipe[kibana::default]" ]
  end

  # Ubuntu 12.04 Config
  config.vm.define :ubuntu1204 do |ubuntu1204|
    ubuntu1204.vm.hostname = "ubuntu1204"
    ubuntu1204.vm.box = "opscode-ubuntu-12.04"
    ubuntu1204.vm.box_url = "https://opscode-vm-bento.s3.amazonaws.com/vagrant/opscode_ubuntu-12.04_provisionerless.box"
  end

  # Ubuntu 13.04 Config
  config.vm.define :ubuntu1304 do |ubuntu1304|
    ubuntu1304.vm.hostname = "ubuntu1304"
    ubuntu1304.vm.box = "opscode-ubuntu-13.04"
    ubuntu1304.vm.box_url = "https://opscode-vm-bento.s3.amazonaws.com/vagrant/opscode_ubuntu-13.04_provisionerless.box"
  end

  config.vm.provider :virtualbox do |vb|
    vb.customize ['modifyvm', :id, '--memory', '1024']
  end
  config.vm.network "private_network", ip: "33.33.33.88"

end

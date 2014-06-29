# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|
  config.vm.hostname = 'kibana'
  config.vm.box = 'ubuntu-12.04'
  config.vm.box_url = "http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_#{config.vm.box}_chef-provisionerless.box"
  config.omnibus.chef_version = 'latest'
  config.berkshelf.enabled = true

  config.vm.provision :chef_solo do |chef|
    chef.json = {
    }

    chef.run_list = [
      'recipe[kibana::default]'
    ]
  end
end

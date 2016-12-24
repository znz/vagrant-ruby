# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = '2'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.define 'jessie64', primary: true do |vm|
    vm.vm.box = 'debian/contrib-jessie64'
    vm.vm.hostname = 'ruby-jessie64'
    if Vagrant.has_plugin?('vagrant-cachier')
      vm.cache.scope = :box
    end
  end

  config.vm.define 'precise64', autostart: false do |vm|
    vm.vm.box = 'ubuntu/precise64'
    vm.vm.hostname = 'ruby-precise64'
    if Vagrant.has_plugin?('vagrant-cachier')
      vm.cache.scope = :box
    end
  end

  config.vm.define 'trusty64', autostart: false do |vm|
    vm.vm.box = 'ubuntu/trusty64'
    vm.vm.hostname = 'ruby-trusty64'
    if Vagrant.has_plugin?('vagrant-cachier')
      vm.cache.scope = :box
    end
  end

  config.vm.define 'xenial64', autostart: false do |vm|
    vm.vm.box = 'bento/ubuntu-16.04'
    vm.vm.hostname = 'ruby-xenial64'
    if Vagrant.has_plugin?('vagrant-cachier')
      vm.cache.scope = :box
      vm.cache.synced_folder_opts = {
        owner: '_apt',
        group: '_apt',
        mount_options: ['dmode=777', 'fmode=666']
      }
    end
  end

  config.vm.define 'yakkety64', autostart: false do |vm|
    vm.vm.box = 'boxcutter/ubuntu1610'
    vm.vm.hostname = 'ruby-yakkety64'
    if Vagrant.has_plugin?('vagrant-cachier')
      vm.cache.scope = :box
      vm.cache.synced_folder_opts = {
        owner: '_apt',
      }
    end
  end

  config.vm.provider 'virtualbox' do |vb|
    vb.memory = 1024
    vb.cpus = 2
    vb.customize ['modifyvm', :id, '--nictype1', 'virtio']
    vb.customize [
      'modifyvm', :id,
      '--hwvirtex', 'on',
      '--nestedpaging', 'on',
      '--largepages', 'on',
      '--ioapic', 'on',
      '--pae', 'on',
      '--paravirtprovider', 'kvm',
    ]
  end

  config.vm.provision 'ansible' do |ansible|
    ansible.playbook = 'provision/playbook.yml'
    unless ENV['VM_SKIP_GALAXY']
      ansible.galaxy_role_file = 'provision/requirements.yml'
    end
    ansible.verbose = ENV['VM_ANSIBLE_VERBOSE']
  end
end

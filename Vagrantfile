# -*- mode: ruby -*-
# vi: set ft=ruby :

ENV['VAGRANT_NO_PARALLEL'] = 'yes'

Vagrant.configure(2) do |config|

  config.vm.provision "shell", inline: <<-SHELL
  echo "Start"
  sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config && systemctl restart sshd
  cat >>/etc/hosts<<EOF
  172.16.16.100   control.example.com    control
  172.16.16.101   node1.example.com    node1
  172.16.16.102   node2.example.com    node2
EOF
  yum install epel-release -y
  yum install ansible curl sshpass git -y
  ssh-keygen -t rsa -N '' -f /home/vagrant/.ssh/ansible
  chown -R vagrant. /home/vagrant/.ssh
  cat >>/home/vagrant/.ssh/config<<EOF
  Host node1
    HostName node1.example.com 
    User vagrant
    IdentityFile ~/.ssh/ansible
  Host node2
    HostName node2.example.com
    User vagrant
    IdentityFile ~/.ssh/ansible
EOF
chmod 600 /home/vagrant/.ssh/config
chown vagrant /home/vagrant/.ssh/config
SHELL

  config.vm.define "control" do |node|
  
    node.vm.box               = "centos/8"
    node.vm.box_check_update  = false
    # node.vm.box_version       = "3.3.0"
    node.vm.hostname          = "control.example.com"

    node.vm.network "private_network", ip: "172.16.16.100"
    
  
    node.vm.provider :virtualbox do |v|
      v.name    = "control"
      v.memory  = 512
      v.cpus    =  1
    end
  
    node.vm.provider :libvirt do |v|
      v.memory  = 512
      v.nested  = true
      v.cpus    = 1
    end
  
    
  
  end

  
  NodeCount = 2

  (1..NodeCount).each do |i|

    config.vm.define "node#{i}" do |node|

      node.vm.box               = "centos/8"
      node.vm.box_check_update  = false
    #   node.vm.box_version       = "3.3.0"
      node.vm.hostname          = "node#{i}.example.com"

      node.vm.network "private_network", ip: "172.16.16.10#{i}"

      node.vm.provider :virtualbox do |v|
        v.name    = "node#{i}"
        v.memory  = 512
        v.cpus    = 1
      end

      node.vm.provider :libvirt do |v|
        v.memory  = 512
        v.nested  = true
        v.cpus    = 1
      end

      node.vm.provision "shell", path: "bootstrap_kworker.sh"
    end

  end

end

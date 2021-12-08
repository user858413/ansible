#!/bin/bash

echo "[TASK] Enable password authentication " 

sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config && systemctl restart sshd

echo "[TASK] Update /etc/hosts file"
cat >>/etc/hosts<<EOF
172.16.16.100   control.example.com    control
172.16.16.101   node1.example.com    node1
172.16.16.102   node2.example.com    node2
EOF

echo "[TASK 1] copy ssh"
dnf install epel-release -y
dnf install sshpass -y >/dev/null 2>&1
sshpass -p "vagrant" scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no control.example.com:/home/vagrant/.ssh/ansible.pub /home/vagrant/.ssh/authorized_keys 2>/dev/null

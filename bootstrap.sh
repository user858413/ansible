echo "[TASK] Enable password authentication " 

sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config && systemctl restart sshd

echo "[TASK] Update /etc/hosts file"
cat >>/etc/hosts<<EOF
172.16.16.100   control.example.com    control
172.16.16.101   node1.example.com    node1
172.16.16.102   node2.example.com    node2
EOF

echo "[TASK] Install Ansible"

yum install epel-release -y
# yum install ansible curl git -y


echo "[TASK] Create ssh key"
ssh-keygen -t rsa -N '' -f /home/vagrant/.ssh/id_rsa
chown -R vagrant. /home/vagrant/.ssh

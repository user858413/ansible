# task1

```
git clone https://github.com/user858413/ansible.git
cd ansible/task1
ansible-playbook httpd.yaml
ansible-playbook httpd_remove.yaml
ansible-playbook grub_change.yaml
```
# task2

```
cd ansible/task2
ansible-playbook users.yaml --vault-password-file a_password_file

пароль пользователей 
Alice - pass1
Bob - pass2
Carol - pass3
```
# task3

cd ansible/task3

### Запустить все роли

```
ansible-playbook main.yaml
```

### Запустить роли по тегу
```
ansible-playbook main.yaml -t httpd
ansible-playbook main.yaml -t vsftpd
```
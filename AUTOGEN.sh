#!/bin/bash
read -p "Enter password for all your nodes $pass: " pass
if [ -f server.txt ]; then
for server in $(cat server.txt); do
rm -f ~/.ssh/id_rsa.pub && rm -f ~/.ssh/id_rsa
ssh-keygen -b 4096 -f ~/.ssh/id_rsa -N ""
sshpass -p $pass ssh-copy-id -o StrictHostKeyChecking=no root@$server
echo 'SSH key copied to ' $server ' successfully!'
done
else
echo 'No server.txt file'
fi

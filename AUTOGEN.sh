#!/bin/bash
#Pre-Reqs: check if sshpass is installed
  if yum list installed "sshpass" >/dev/null 2>&1; then
    echo 'shpass is already installed skipping sshpass installation.'
  else
    echo 'Installing sshpass - Please wait!'
    yum -y install sshpass
  fi
#Start generating sshkey and copying it to each node
if yum list installed "sshpass" >/dev/null 2>&1; then
  read -p "Enter password for all your nodes $pass: " pass
  rm -f ~/.ssh/id_rsa.pub && rm -f ~/.ssh/id_rsa
  ssh-keygen -b 4096 -f ~/.ssh/id_rsa -N ""
  if [ -f server.txt ]; then
  for server in $(cat server.txt); do
  sshpass -p $pass ssh-copy-id -o StrictHostKeyChecking=no root@$server
  echo 'copied to ' $server ' successfully'
  done
  else
  echo 'No server.txt file'
  fi
else
  echo 'sshpass not detected. exiting...'
fi

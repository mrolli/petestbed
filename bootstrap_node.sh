#!/usr/bin/env bash

hash yum 2>/dev/null && ISEL=1 || ISEL = 0

# Put the hosts file in place
grep "node" /etc/hosts >/dev/null 2>&1
if [ $? -eq 0 ]; then
  echo "Hosts file already patched."
else
  echo "Patching hosts file"
  cat /vagrant/hosts.snippet >> /etc/hosts
fi

# Install git
if hash git 2>/dev/null; then
  echo "Git already installed."
else
  echo -n "Installing Git."
  if [ $ISEL -eq 1 ]; then
    yum -y install git >/dev/null 2>&1
  else
    apt-get -y install git >/dev/null 2>&1
  fi
fi

# Register the node at the puppet master.
if [ -x /opt/puppet/bin/puppet ]; then
  echo "Puppet agent already installed."
else
  echo "Installing puppet and registering to puppet master."
  curl -k https://puppet01.ubelix.unibe.ch:8140/packages/current/install.bash 2>/dev/null | bash
fi

echo "Provisioning done. Have fun!"

exit 0


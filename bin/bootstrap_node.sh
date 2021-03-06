#!/usr/bin/env bash

hash yum 2>/dev/null && ISEL=1 || ISEL = 0

# Install git
if hash git 2>/dev/null; then
  echo "Git already installed."
else
  echo -n "Installing Git."
  if [ $ISEL -eq 1 ]; then
    service iptables stop
    chkconfig iptables off
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
  if [ -x /opt/puppet/bin/puppet ]; then
    echo "Puppet agent installation succeeded."
  else
    echo "Puppet agent installation failed."
  fi
fi

echo "Provisioning done. Have fun!"

exit 0


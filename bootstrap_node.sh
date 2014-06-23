#!/usr/bin/env bash

hash yum 2>/dev/null && ISEL=1 || ISEL = 0

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

echo "Provisioning done. Have fun!"

exit 0


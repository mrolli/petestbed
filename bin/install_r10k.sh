#!/usr/bin/env bash

# Install Zack's puppet module to install and setup R10k
puppet module install zack-r10k --version 1.0.2 --ignore-requirements --verbose || exit 1

# Setup the R10k environments directories
mkdir -p /etc/puppetlabs/puppet/environments

# Actually install R10K using puppet
puppet apply /vagrant/bin/r10k-installation.pp --verbose
echo "R10K is now setup"

exit 0


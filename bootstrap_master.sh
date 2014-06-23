#!/usr/bin/env bash

SESSION_LIFETIME=$1

hash yum 2>/dev/null && ISEL=1 || ISEL=0

# Put the hosts file in place
cat /vagrant/hosts.snippet >> /etc/hosts

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

# Install puppet master
if hash puppet 2>/dev/null; then
  echo "Puppet Enterprise already installed and setup."
else
  echo "Installing Puppet Master"
  OLDDIR=$PWD
  if [ $ISEL -eq 1 ]; then
    cd /vagrant/puppet-enterprise/puppet-enterprise-3.2.3-el-6-x86_64/
  else
    cd /vagrant/puppet-enterprise/puppet-enterprise-3.2.3-ubuntu-12.04-amd64
  fi
  ./puppet-enterprise-installer -a ../pe_ubelix_answerfile
  cd $OLDDIR;
fi

# Add some additional platform using the Rake API
# @see http://docs.puppetlabs.com/pe/latest/console_rake_api.html
# If platform already availabe the task gets skipped.
if [ -f /opt/staging/pe_repo/puppet-enterprise-3.2.3-el-6-x86_64-agent.tar.gz ]; then
  echo "Agent support for el6-6-x86_64 already available."
else
  echo "Adding platform support for EL6-x86_64"
  /opt/puppet/bin/rake -f /opt/puppet/share/puppet-dashboard/Rakefile RAILS_ENV=production nodeclass:add["pe_repo::platform::el_6_x86_64","skip"] 2>/dev/null
  /opt/puppet/bin/rake -f /opt/puppet/share/puppet-dashboard/Rakefile RAILS_ENV=production node:addclass["puppet01.ubelix.unibe.ch","pe_repo::platform::el_6_x86_64"] 2>/dev/null
  /opt/puppet/bin/puppet agent -t
  echo "Done adding platform support for EL6-x86_64"
fi

if [ -f /opt/staging/pe_repo/puppet-enterprise-3.2.3-ubuntu-12.04-amd64-agent.tar.gz ]; then
  echo "Agent support for ubuntu-12.04-amd64 already available."
else
  echo "Adding platform support for Ubuntu-12.04-amd64"
  /opt/puppet/bin/rake -f /opt/puppet/share/puppet-dashboard/Rakefile RAILS_ENV=production nodeclass:add["pe_repo::platform::ubuntu_1204_amd64","skip"] 2>/dev/null
  /opt/puppet/bin/rake -f /opt/puppet/share/puppet-dashboard/Rakefile RAILS_ENV=production node:addclass["puppet01.ubelix.unibe.ch","pe_repo::platform::ubuntu_1204_amd64"] 2>/dev/null
  /opt/puppet/bin/puppet agent -t
  echo "Done adding platform support for Ubuntu-12.04-amd64"
fi

#if [ -f /opt/staging/pe_repo/puppet-enterprise-3.2.3-ubuntu-12.04-amd64-agent.tar.gz ]; then
#  echo "Agent support for ubuntu-12.04-amd64 already available."
#else
#  echo "Adding platform support for Ubuntu-14.04-amd64"
#  /opt/puppet/bin/rake -f /opt/puppet/share/puppet-dashboard/Rakefile RAILS_ENV=production nodeclass:add["pe_repo::platform::ubuntu_1404_amd64","skip"] 2>/dev/null
#  /opt/puppet/bin/rake -f /opt/puppet/share/puppet-dashboard/Rakefile RAILS_ENV=production node:addclass["puppet01.ubelix.unibe.ch","pe_repo::platform::ubuntu_1404_amd64"] 2>/dev/null
#fi

# Increase session liftime to a nonhurting value.
grep "lifetime: ${SESSION_LIFETIME}" /etc/puppetlabs/rubycas-server/config.yml >/dev/null 2>&1
if [ $? -eq 0 ]; then
  echo "Session lifetime alreday increased."
else
  echo "Tweaking session lifetime."
  sed -i "s/session_lifetime: 1200/session_lifetime: ${SESSION_LIFETIME}/" /etc/puppetlabs/rubycas-server/config.yml
  sed -i "s/session_timeout: 1200/session_timeout: ${SESSION_LIFETIME}/" /etc/puppetlabs/console-auth/cas_client_config.yml
  service pe-httpd restart
  service pe-puppet-dashboard-workers restart
fi

echo "Provisioning done. Have fun!"

exit 0


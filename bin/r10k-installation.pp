class { 'r10k':
  version           => '1.2.1',
  sources           => {
    'puppet' => {
      'remote'  => 'ssh://git@idstash.backend.unibe.ch:7999/ubelix/puppet-repository.git',
      'basedir' => "${::settings::confdir}/environments",
      'prefix'  => false,
    },
    'hiera'  => {
      'remote'  => 'ssh://git@idstash.backend.unibe.ch:7999/ubelix/hiera-environment.git',
      'basedir' => "${::settings::confdir}/hiera",
      'prefix'  => false,
    }
  },
  purgedirs         => ["${::settings::confdir}/environments"],
  manage_modulepath => true,
  modulepath        => "${::settings::confdir}/environments/\$environment/modules:/opt/puppet/share/puppet/modules",
}


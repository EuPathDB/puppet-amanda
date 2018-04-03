class amanda::client (
  $hosts,
  ) {

  include xinetd

  package { [ 'amanda_enterprise-backup_client',
              'amanda_enterprise-extensions-client' ]:
    ensure => installed,
  }

  file { '/etc/amanda':
    ensure  => 'directory',
    owner   => 'amandabackup',
    group   => 'disk',
    require => Package['amanda_enterprise-backup_client'],
  }

  file { '/etc/amanda/amanda-client.conf':
    ensure  => file,
    owner   => 'amandabackup',
    group   => 'disk',
    mode    => '0600',
    content => template('amanda/amanda-client.conf.erb'),
    require => File['/etc/amanda'],
  }

  file { '/var/lib/amanda/.amandahosts':
    ensure  => file,
    owner   => 'amandabackup',
    group   => 'disk',
    mode    => '0600',
    content => $hosts,
    require => Package['amanda_enterprise-backup_client'],
  }

}

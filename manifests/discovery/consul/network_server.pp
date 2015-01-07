#
class profile::discovery::consul::network_server (
) {
  consul::service { 'neutron-server':
    port    => 9696,
    require => Service['neutron-server']
  }

  profile::discovery::consul::datadep { 'neutronmysqldep':
    key       => 'mysql_Address',
    badvalues => ['127.0.0.1'],
    before    => [Class['::neutron::server']]
  }

  # todo patch this in-module
  Neutron_config['database/connection'] ~> Exec<| title == 'neutron-db-sync' |>

  profile::discovery::consul::datadep { 'neutronkeystonedep':
    key    => 'keystone_Address',
    before => [Class['::neutron::server::notifications', 'neutron::server']]
  }

  profile::discovery::consul::datadep { 'neutronnovadep':
    key    => 'nova-api_Address',
    before => [Class['::neutron::server::notifications']]
  }

}

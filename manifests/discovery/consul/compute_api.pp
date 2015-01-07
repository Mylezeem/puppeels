#
class profile::discovery::consul::compute_api (
) {
  consul::service { 'nova-api':
    port    => 8774,
    require => Service['nova-api'],
  }
  consul::service { 'nova-api-ec2':
    port    => 8773,
    require => Service['nova-api'],
  }
  consul::service { 'nova-api-metadata':
    port    => 8775,
    require => Service['nova-api'],
  }

  profile::discovery::consul::datadep { 'novakeystonedep':
    key    => 'keystone_Address',
    before => [Class['::nova::api', '::nova::network::neutron']]
  }

  profile::discovery::consul::datadep { 'novaglancedep':
    key    => 'glance-api_Address',
    before => [Class['::nova']]
  }

  profile::discovery::consul::datadep { 'novaneutrondep':
    key    => 'neutron-server_Address',
    before => []
  }

  profile::discovery::consul::datadep { 'novadbdep':
    key       => 'mysql_Address',
    badvalues => ['127.0.0.1'],
    before    => [Class['::nova']]
  }

  profile::discovery::consul::datadep { 'novarabbitmqdep':
    key    => 'rabbitmq_Address',
    before => [Class['::nova']]
  }

}

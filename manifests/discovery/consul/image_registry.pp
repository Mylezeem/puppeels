#
class profile::discovery::consul::image_registry (
) {
  consul::service { 'glance-registry':
    port    => 9191,
  }

  profile::discovery::consul::datadep { 'glanceregmysqldep':
    key       => 'mysql_Address',
    badvalues => ['127.0.0.1'],
    before    => [Class['::glance::registry']]
  }

  profile::discovery::consul::datadep { 'glanceregkeystonedep':
    key       => 'keystone_Address',
    before    => [Class['::glance::registry']]
  }
}

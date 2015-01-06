#
class profile::discovery::consul::image_api (
) {
  consul::service { 'glance-api':
    port    => 9292,
  }

  profile::discovery::consul::datadep { 'glanceapimysqldep':
    key       => 'mysql_Address',
    badvalues => ['127.0.0.1'],
    before    => [Class['::glance::api']]
  }

  profile::discovery::consul::datadep { 'glanceapikeystonedep':
    key       => 'keystone_Address',
    before    => [Class['::glance::api']]
  }

  profile::discovery::consul::datadep { 'glanceapiregistrydep':
    key       => 'glance-registry_Address',
    before    => [Class['::glance::api']]
  }
}

#
class profile::discovery::consul::identity (
) {
  consul::service { 'keystone':
    port    => 5000,
    require => Service['keystone']
  }

  profile::discovery::consul::datadep { 'keystonemysqldep':
    key       => 'mysql_Address',
    badvalues => ['127.0.0.1'],
    before    => [Class['::keystone']]
  }

  profile::discovery::consul::datadep { 'authkeystonedep':
    key    => 'keystone_Address',
    before => []
  }

  profile::discovery::consul::identity_shard { 'identity_shard': }
}

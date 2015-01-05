#
class profile::discovery::consul::identity (
) {
  consul::service { 'keystone':
    port    => 5000,
  }

  profile::discovery::consul::datadep { 'keystonemysqldep':
    key    => 'mysql_Address',
    before => [Class['::keystone']]
  }

  profile::discovery::consul::datadep { 'authkeystonedep':
    key    => 'keystone_Address',
    before => []
  }
}

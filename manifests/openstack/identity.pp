class profile::openstack::identity (
  $ceilometer_enabled = true,
  $cinder_enabled     = true,
  $glance_enabled     = true,
  $neutron_enabled    = true,
  $nova_enabled       = true,
  $swift_enabled      = true,
  $trove_enabled      = true,
  $manage_firewall    = true,
  $firewall_extras    = {}
) {

  include ::keystone
  include ::keystone::roles::admin
  include ::keystone::endpoint
  include ::keystone::cron::token_flush

  if $swift_enabled {
    include ::swift::keystone::auth
    include ::swift::keystone::dispersion

    Profile::discovery::consul::datadep <| title == 'authkeystonedep' |> {
      before +> Class['::swift::keystone::auth']
    }
  }

  if $ceilometer_enabled {
    include ::ceilometer::keystone::auth

    Profile::discovery::consul::datadep <| title == 'authkeystonedep' |> {
      before +> Class['::ceilometer::keystone::auth']
    }
  }

  if $nova_enabled {
    include ::nova::keystone::auth

    Profile::discovery::consul::datadep <| title == 'authkeystonedep' |> {
      before +> Class['::nova::keystone::auth']
    }
  }

  if $neutron_enabled {
    include ::neutron::keystone::auth

    Profile::discovery::consul::datadep <| title == 'authkeystonedep' |> {
      before +> Class['::neutron::keystone::auth']
    }
  }

  if $cinder_enabled {
    include ::cinder::keystone::auth

    Profile::discovery::consul::datadep <| title == 'authkeystonedep' |> {
      before +> Class['::cinder::keystone::auth']
    }
  }

  if $glance_enabled {
    include ::glance::keystone::auth

    Profile::discovery::consul::datadep <| title == 'authkeystonedep' |> {
      before +> Class['::glance::keystone::auth']
    }
  }

  if $trove_enabled {
    include ::trove::keystone::auth

    Profile::discovery::consul::datadep <| title == 'authkeystonedep' |> {
      before +> Class['::trove::keystone::auth']
    }
  }

  if $manage_firewall {
    profile::firewall::rule { '228 keystone accept tcp':
      port   => 5000,
      extras => $firewall_extras
    }
    profile::firewall::rule { '228 keystone-admin accept tcp':
      port   => 35357,
      extras => $firewall_extras
    }
  }

  Profile::Discovery::Consul <||> {
    services +> 'profile::discovery::consul::identity'
  }
}

class profile::openstack::identity (
  $ceilometer_enabled = true,
  $cinder_enabled     = true,
  $glance_enabled     = true,
  $neutron_enabled    = true,
  $nova_enabled       = true,
  $swift_enabled      = true,
  $trove_enabled      = true,
  $manage_firewall    = true,
  $firewall_extras    = {},
  $discover_endpoints = false
) {

  include ::keystone
  include ::keystone::roles::admin
  include ::keystone::endpoint
  include ::keystone::cron::token_flush

  if $swift_enabled {
    include ::swift::keystone::dispersion

    if $discover_endpoints {

      Profile::Discovery::Consul::Identity_shard <||> {
        c_array +> ['swiftkeyauthdep', {'key' => 'swift_Address',
                                      'include' => '::swift::keystone::auth'}]
      }

    } else {
      include ::swift::keystone::auth
    }
  }

  if $ceilometer_enabled {
    if $discover_endpoints {

      Profile::Discovery::Consul::Identity_shard <||> {
        c_array +> ['ceilokeyauthdep', {'key' => 'ceilometer_Address', 'include' => '::ceilometer::keystone::auth'}]
      }

    } else {
      include ::ceilometer::keystone::auth
    }
  }

  if $nova_enabled {
    if $discover_endpoints {

      Profile::Discovery::Consul::Identity_shard <||> {
        c_array +> ['novakeyauthdep', {'key' => 'nova-api_Address', 'badvalues' => ['127.0.0.1'],
                                       'include' => '::nova::keystone::auth'}]
      }

    } else {
      include ::nova::keystone::auth
    }
  }

  if $neutron_enabled {
    if $discover_endpoints {

      Profile::Discovery::Consul::Identity_shard <||> {
        c_array +> ['neutronkeyauthdep', {'key' => 'neutron-server_Address', 'badvalues' => ['127.0.0.1'],
                                          'include' => '::neutron::keystone::auth'}]
      }

    } else {
      include ::neutron::keystone::auth
    }
  }

  if $cinder_enabled {
    if $discover_endpoints {

      Profile::Discovery::Consul::Identity_shard <||> {
        c_array +> ['cinderkeyauthdep', {'key' => 'cinder-api',
                                         'include' => '::cinder::keystone::auth'}]
      }

    } else {
      include ::cinder::keystone::auth
    }
  }

  if $glance_enabled {
    if $discover_endpoints {

      Profile::Discovery::Consul::Identity_shard <||> {
        c_array +> ['glancekeyauthdep', {'key' => 'glance-api_Address',
                                         'include' => '::glance::keystone::auth'}]
      }

    } else {
      include ::glance::keystone::auth
    }
  }

  if $trove_enabled {
    if $discover_endpoints {

      Profile::Discovery::Consul::Identity_shard <||> {
        c_array +> ['trovekeyauthdep', {'key' => 'trove-api_Address',
                                        'include' => '::trove::keystone::auth'}]
      }

    } else {
      include ::trove::keystone::auth
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

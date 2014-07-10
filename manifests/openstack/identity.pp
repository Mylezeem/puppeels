class profile::openstack::identity (
  $ceilometer_enabled = true,
  $cinder_enabled     = true,
  $glance_enabled     = true,
  $neutron_enabled    = true,
  $nova_enabled       = true,
  $swift_enabled      = true,
  $trove_enabled      = true,
) {

  include ::keystone
  include ::keystone::roles::admin
  include ::keystone::endpoint
  include ::keystone::cron::token_flush

  if $swift_enabled {
    include ::swift::keystone::auth
    include ::swift::keystone::dispersion
  }

  if $ceilometer_enabled {
    include ::ceilometer::keystone::auth
  }

  if $nova_enabled {
    include ::nova::keystone::auth
  }

  if $neutron_enabled {
    include ::neutron::keystone::auth
  }

  if $cinder_enabled {
    include ::cinder::keystone::auth
  }

  if $glance_enabled {
    include ::glance::keystone::auth
  }

  if $trove_enabled {
    include ::trove::keystone::auth
  }


}

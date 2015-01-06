class profile::openstack::network(
  $l2_driver = 'ovs',
  $plugin    = 'ml2'
){
  include ::neutron
  include "::neutron::plugins::${plugin}"

  if $plugin == 'ml2' {
    include "::neutron::agents::ml2::${l2_driver}"
  } else {
    include "::neutron::agents::${plugin}"
  }

  Profile::Discovery::Consul <||> {
    services +> 'profile::discovery::consul::network'
  }
}

class profile::openstack::network(
  $l2_driver = 'ovs'
){
  include ::neutron
  include ::neutron::agents::ml2::$l2_driver
  include ::neutron::plugins::ml2
}

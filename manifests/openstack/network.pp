class profile::openstack::network {
  include ::neutron
  include ::neutron::agent::ovs
  include ::neutron::plugins::ml2
}

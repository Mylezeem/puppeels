class profile::openstack::network::l3 {
  include profile::openstack::network

  include ::neutron::agents::l3
  include ::neutron::agents::metering
}

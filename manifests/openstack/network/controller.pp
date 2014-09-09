class profile::openstack::network::controller {
  include profile::openstack::network

  include ::neutron::server
  include ::neutron::server::notifications
}

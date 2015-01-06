class profile::openstack::network::metadata {
  include profile::openstack::network
  include ::neutron::agents::metadata

  Profile::Discovery::Consul <||> {
    services +> 'profile::discovery::consul::network_metadata'
  }
}

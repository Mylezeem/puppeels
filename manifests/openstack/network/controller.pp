class profile::openstack::network::controller(
  $manage_firewall = true,
  $firewall_extras = {}
) {
  include profile::openstack::network

  include ::neutron::server
  include ::neutron::server::notifications
  if $manage_firewall {
    profile::firewall::rule { '210 neutron-server accept tcp':
      port   => 9696,
      extras => $extras
    }
  }
  Profile::Discovery::Consul <||> {
    services +> 'profile::discovery::consul::network_server'
  }
}

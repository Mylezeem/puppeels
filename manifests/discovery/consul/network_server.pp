#
class profile::discovery::consul::network_server (
) {
  consul::service { 'neutron-server':
    port    => 9696,
  }
}

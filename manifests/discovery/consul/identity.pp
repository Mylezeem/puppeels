#
class profile::discovery::consul::identity (
) {
  consul::service { 'keystone':
    port    => 5000,
  }
}

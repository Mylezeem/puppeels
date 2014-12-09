#
class profile::discovery::consul::image_api (
) {
  consul::service { 'glance-api':
    port    => 9292,
  }
}

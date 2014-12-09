#
class profile::discovery::consul::rabbitmq (
) {
  consul::service { 'rabbitmq':
    port    => 5672,
  }
}

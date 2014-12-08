#
class profile::discovery::consul::mariadb (
) {
  consul::service { 'mysql':
    port    => 3306,
  }
}

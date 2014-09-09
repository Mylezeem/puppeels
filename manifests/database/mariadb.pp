#
# Author: Yanis Guenane <yguenane@gmail.com>
# License: ApacheV2
#
# Puppet module :
#   * yguenane/mariadbrepo
#   * puppetlabs/mysql
#
class profile::database::mariadb (
  $client_enabled = true,
) {
  include profile::base

  include ::mariadbrepo
  include ::mysql::server

  if $client_enabled {
    include ::mysql::client
  }
}

#
# Author: Yanis Guenane <yguenane@gmail.com>
# License: ApacheV2
#
# Puppet module :
#   * yguenane/mariadbrepo
#   * puppetlabs/mysql
#
class profile::database::mariadb (
  $client_enabled  = true,
  $manage_repo     = true,
  $manage_firewall = true,
  $firewall_extras = {}
) {

  if $manage_repo {
    include ::mariadbrepo
  }

  include ::mysql::server

  if $client_enabled {
    include ::mysql::client
  }

  if $manage_firewall {
    profile::firewall::rule { '200 mysql accept tcp':
      port   => 3306,
      extras => $firewall_extras
    }
  }
}

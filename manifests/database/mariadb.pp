#
# Author: Yanis Guenane <yguenane@gmail.com>
# License: ApacheV2
#
# Puppet module :
#   * yguenane/mariadbrepo
#   * puppetlabs/mysql
#
class profile::database::mariadb {
  include profile::base

  include ::mariadbrepo
  include ::mysql::server
}

#
# Author: Yanis Guenane <yguenane@gmail.com>
# License: ApacheV2
#
# Puppet module :
#   * thomasvandoren/redis
#
class profile::database::redis (
  $instances = {},
) {

  include profile::base

  include ::redis
  create_resources('redis::instance', $instances)
}

#
# Author: Yanis Guenane <yguenane@gmail.com>
# License: ApacheV2
#
# Puppet module :
#   mod 'maestrodev/wget'
#   mod' puppetlabs/gcc'
#
class profile::database::redis (
  $instances = {},
) {

  include ::redis
  create_resources('redis::instance', $instances)
}

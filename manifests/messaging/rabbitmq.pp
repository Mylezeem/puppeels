#
# Author: Yanis Guenane <yguenane@gmail.com>
# License: ApacheV2
#
# Puppet module :
#   * puppetlabs/rabbitmq
#
class profile::messaging::rabbitmq (
  $users            = {},
  $vhosts           = {},
  $exchanges        = {},
  $user_permissions = {},
  $plugins          = {},
) {

  include profile::base

  include ::rabbitmq
  create_resources('rabbitmq_user', $users)
  create_resources('rabbitmq_vhost', $vhosts)
  create_resources('rabbitmq_exchange', $exchanges)
  create_resources('rabbitmq_user_permissions', $user_permissions)
  create_resources('rabbitmq_plugin', $plugins)

}

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
  $manage_firewall  = true,
  $firewall_extras  = {}
) {

  Class['rabbitmq'] -> Rabbitmq_vhost <<| |>>
  Class['rabbitmq'] -> Rabbitmq_user <<| |>>
  Class['rabbitmq'] -> Rabbitmq_user_permissions <<| |>>
  Class['rabbitmq'] -> Rabbitmq_exchange <<| |>>
  Class['rabbitmq'] -> Rabbitmq_plugin <<| |>>

  include ::rabbitmq
  create_resources('rabbitmq_user', $users)
  create_resources('rabbitmq_vhost', $vhosts)
  create_resources('rabbitmq_exchange', $exchanges)
  create_resources('rabbitmq_user_permissions', $user_permissions)
  create_resources('rabbitmq_plugin', $plugins)

  if $manage_firewall {
    profile::firewall::rule { '201 rabbitmq accept tcp':
      port   => 5672,
      extras => $firewall_extras
    }
  }
}

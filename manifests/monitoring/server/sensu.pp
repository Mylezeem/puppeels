#
# Author: Yanis Guenane <yguenane@gmail.com>
# License: ApacheV2
#
# Puppet module :
#   mod 'sensu/sensu'
#   mod 'puppetlabs/apache'
#   mod 'puppetlabs/rabbitmq'
#   mod 'thomasvandoren/redis'
#
class profile::monitoring::server::sensu (
  $checks                    = {},
  $handlers                  = {},
  $plugins                   = {},
  $proxy_dashboard           = true,
  $dashboard_servername      = 'monitor.example.com',
  $vhost_configuration       = {},
  $manage_rabbitmq           = true,
  $rabbitmq_user             = 'sensu',
  $rabbitmq_password         = undef,
  $rabbitmq_vhost            = '/sensu',
  $rabbitmq_user_permissions = {'read_permission' => '.*', 'write_permission' => '.*', 'configure_permission' => '.*'},
  $manage_redis              = true,
) {

  # TODO (spredzy): Find a nicer way to deal with dependencies
  Service['rabbitmq-server'] -> Class['sensu::package']
  Service['redis-6379'] -> Service['sensu-api'] -> Service['sensu-server']

  include profile::base
  include profile::monitoring::agent::sensu

  $user_permissions = {"${rabbitmq_user}@${rabbitmq_vhost}" => $rabbitmq_user_permissions}
  $vhost = {"${dashboard_servername}" => $vhost_configuration}

  if $manage_redis {
    include ::redis
  }

  if $manage_rabbitmq {
    include ::rabbitmq

    rabbitmq_user { $rabbitmq_user :
      password => $rabbitmq_password,
      require  => Class['rabbitmq'],
    }
    rabbitmq_vhost { $rabbitmq_vhost :
      ensure  => present,
      require => Class['rabbitmq'],
    }

    create_resources('rabbitmq_user_permissions', $user_permissions)
  }

  if $proxy_dashboard {
    include ::apache
    create_resources('apache::vhost', $vhost)
  }

  create_resources('sensu::check', $checks)
  create_resources('sensu::handler', $handlers)
  create_resources('sensu::plugin', $plugins)

}


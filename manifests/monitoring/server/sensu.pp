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
  $manage_redis              = true,
) {

  # TODO (spredzy): Find a nicer way to deal with dependencies
  Service['rabbitmq-server'] -> Class['sensu::package']
  Service['redis-6379'] -> Service['sensu-api'] -> Service['sensu-server']

  include profile::base
  include profile::monitoring::agent::sensu

  if $manage_redis {
    include profile::database::redis
  }

  if $manage_rabbitmq {
    include profile::messaging::rabbitmq
  }

  if $proxy_dashboard {
    include profile::webserver::apache
  }

  create_resources('sensu::check', $checks)
  create_resources('sensu::handler', $handlers)
  create_resources('sensu::plugin', $plugins)

}


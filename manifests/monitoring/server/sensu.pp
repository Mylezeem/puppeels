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
  $rabbitmq_user             = 'sensu',
  $rabbitmq_password         = 'rabbitpassword',
  $rabbitmq_vhost            = '/sensu',
  $uchiwa_ip                 = $::ipaddress,
  $proxy_dashboard           = true,
  $vhost_configuration       = {},
  $manage_rabbitmq           = true,
  $manage_redis              = true,
) {

  @@rabbitmq_user { $rabbitmq_user :
    password => $rabbitmq_password,
  }
  @@rabbitmq_vhost { $rabbitmq_vhost :
    ensure  => present,
  }
  @@rabbitmq_user_permissions { "${rabbitmq_user}@${rabbitmq_vhost}" :
    configure_permission => '.*',
    read_permission      => '.*',
    write_permission     => '.*',
  }

  $rabbitmq_user_realized = query_nodes("Rabbitmq_user['${rabbitmq_user}']")

  if size($rabbitmq_user_realized) >= 1 {

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
      create_resources('apache::vhost', $vhost_configuration)
    }

    create_resources('sensu::check', $checks)
    create_resources('sensu::handler', $handlers)
    create_resources('@@sensu::plugin', $plugins)

    include ::uchiwa
    uchiwa::api { 'Uchiwa' :
      host => $uchiwa_ip,
    }

  }

}


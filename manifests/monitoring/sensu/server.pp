#
# Author: Yanis Guenane <yguenane@gmail.com>
# License: ApacheV2
#
# Puppet module :
#   mod 'sensu/sensu'
#   mod 'puppetlabs/stdlib'
#   mod 'puppetlabs/concat'
#   mod 'puppetlabs/apache'
#   mod 'maestrodev/wget'
#   mod 'puppetlabs/gcc'
#   mod 'thomasvandoren/redis'
#   mod 'puppetlabs/apt'
#   mod 'nanliu/staging'
#   mod 'puppetlabs/rabbitmq'
#   mod 'richardc/datacat'
#   mod 'richardc/datacat'
#   mod 'pauloconnor/uchiwa'
#
class profile::monitoring::sensu::server (
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

    include profile::monitoring::agent::sensu

  if $manage_redis {
    include profile::database::redis
    Service['redis'] -> Service['sensu-api'] -> Service['sensu-server']
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


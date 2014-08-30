#
# Author: Yanis Guenane <yguenane@gmail.com>
# License: ApacheV2
#
# Puppet module :
#   mod 'sbadia/gitlab'
#
class profile::application::gitlab (
  $manage_redis = true,
  $manage_db    = 'pgsql',
  $proxy        = 'nginx',
) {

  include profile::base
  include ::gitlab

  if $manage_redis {
    include profile::database::redis
  }

  case $manage_db {
    'mysql': { include profile::database::mariadb }
    'pgsql': { include profile::database::postgresql }
    default: { }
  }

  case $proxy {
    'apache': { include profile::webserserver::apache }
    'nginx':  { include ::nginx }
    default:  { }
  }

}

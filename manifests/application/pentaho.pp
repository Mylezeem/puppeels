#
# Author: Yanis Guenane <yguenane@gmail.com>
# License: ApacheV2
#
# Puppet module :
#   mod 'yguenane/pentaho'
#
class profile::application::pentaho (
  $manage_db = false,
  $proxy     = false,
) {

  Class['profile::webserver::tomcat'] -> Class['pentaho']

  include profile::base
  include profile::webserver::tomcat

  include ::pentaho

  if $manage_db {
    Class['pentaho::database'] -> Class['pentaho']
    include ::pentaho::database
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

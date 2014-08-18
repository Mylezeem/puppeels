#
# Author: Yanis Guenane <yguenane@gmail.com>
# License: ApacheV2
#
# Puppet module :
#
class profile::application::mediawiki (
  $mediawiki_vhost  = {},
) {

  include profile::base
  include profile::database::mariadb
  include profile::webserver::apache
  create_resources('apache::vhost', $mediawiki_vhost)

  mysql_database {'mediawiki' :
    ensure  => 'present',
    charset => 'utf8',
    collate => 'utf8_swedish_ci',
    require => Service['mysql'],
  } ->
  mysql_user { 'mediawiki@127.0.0.1' :
    ensure => present,
  } ->
  mysql_grant { 'mediawiki@127.0.0.1/mediawiki.*' :
    ensure     => present,
    options    => ['GRANT'],
    privileges => ['ALL'],
    table      => 'mediawiki.*',
    user       => 'mediawiki@127.0.0.1',
  }

  package { 'mediawiki119' :
    ensure  => present,
    require => Class['epel'],
  }

}

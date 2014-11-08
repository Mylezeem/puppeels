#
# Author: Yanis Guenane <yguenane@gmail.com>
# License: ApacheV2
#
# Puppet module :
#   mod 'arioch/keepalived'
#
class profile::highavailability::keepalived (
  $keepalived_vrrp_instances = {},
  $keepalived_vrrp_scripts   = {},
  $ip_nonlocal_bind          = true,
) {

  include profile::base

  include ::keepalived
  create_resources('keepalived::vrrp::script', $keepalived_vrrp_scripts)
  create_resources('keepalived::vrrp::instance', $keepalived_vrrp_instances)

  $allow_nonlocal_bind = bool2num($ip_nonlocal_bind)
  sysctl { 'net.ipv4.ip_nonlocal_bind' :
    ensure => present,
    value  => "${allow_nonlocal_bind}",
  }

}

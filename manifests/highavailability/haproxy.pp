#
# Author: Yanis Guenane <yguenane@gmail.com>
# License: ApacheV2
#
# Puppet module :
#   mod 'puppetlabs/haproxy'
#   mod 'arioch/keepalived'
#
class profile::highavailability::haproxy (
  $keepalived_enable         = false,
  $keepalived_vrrp_instances = {},
  $keepalived_vrrp_scripts   = {},
  $haproxy_listens           = {},
  $haproxy_balancermembers   = {},
  $ip_nonlocal_bind          = true,
) {

  include profile::base

  if $keepalived_enable {
    include ::keepalived
    create_resources('keepalived::vrrp::script', $keepalived_vrrp_scripts)
    create_resources('keepalived::vrrp::instance', $keepalived_vrrp_instances)
  }

  include ::haproxy
  create_resources('haproxy::listen', $haproxy_listens)
  create_resources('haproxy::balancermember', $haproxy_balancermembers)

  $allow_nonlocal_bind = bool2num($ip_nonlocal_bind)
  sysctl { 'net.ipv4.ip_nonlocal_bind' :
    ensure => present,
    value  => "${allow_nonlocal_bind}",
  }

}

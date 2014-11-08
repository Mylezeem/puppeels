#
# Author: Yanis Guenane <yguenane@gmail.com>
# License: ApacheV2
#
# Puppet module :
#   mod 'puppetlabs/haproxy'
#   mod 'arioch/keepalived'
#
class profile::highavailability::loadbalancing::haproxy (
  $haproxy_listens           = {},
  $haproxy_balancermembers   = {},
) {

  include profile::base

  include ::haproxy
  create_resources('haproxy::listen', $haproxy_listens)
  create_resources('haproxy::balancermember', $haproxy_balancermembers)

}

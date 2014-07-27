#
# Author: Yanis Guenane <yguenane@gmail.com>
# License: ApacheV2
#
# Puppet module :
#   * puppetlabs/haproxy
#   * arioch/keepalived
#
class profile::highavailability::haproxy (
  $keepalived_enable         = false,
  $keepalived_vrrp_instances = {},
  $keepalived_vrrp_scripts   = {},
  $haproxy_listens           = {},
) {

  include profile::base

  if $keepalived_enable {
    include ::keepalived
    create_resources('keepalived::vrrp::script', $keepalived_vrrp_scripts)
    create_resources('keepalived::vrrp::instance', $keepalived_vrrp_instances)
  }

  include ::haproxy
  create_resources('haproxy::listen', $haproxy_listens)

}

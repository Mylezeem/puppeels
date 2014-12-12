#
# Author: Yanis Guenane <yguenane@gmail.com>
# License: ApacheV2
#
# Puppet module :
#
class profile::base::base (
  $hosts_hash    = false,
  $fqdn_iface    = false,
  $fqdn_hostname = false,
  $fqdn_domain   = false
) {

  if $fqdn_iface {
    $fqdn_address = getvar("::ipaddress_${fqdn_iface}")
  }

  if ! $fqdn_hostname {
    $_hostname = $::hostname
  }

  if ! $fqdn_domain {
    $_domain = $::domain
  }

  file { '/etc/hosts':
    ensure => present,
    owner  => root,
    group  => root,
    content => template('profiles/hosts.erb')
  }
}

#
# Author: Yanis Guenane <yguenane@gmail.com>
# License: ApacheV2
#
# Puppet module :
#   mod 'saz/ssh'
#   mod 'saz/sudo'
#   mod 'puppetlabs/ntp'
#   mod 'stahnma/epel'
#
class profile::base::common (
  $manage_augeasproviders = false,
  $manage_epel            = false,
  $manage_accounts        = false,
  $manage_logging         = undef,
  $manage_monitoring      = undef,
  $manage_ssh             = false,
  $manage_ntp             = false,
  $manage_sudo            = false,
  $manage_authconfig      = false,
  $manage_firewall        = false,
  $common_packages        = [],
  $common_packages_ensure = 'installed',
  $common_classes         = [],
) {
  include $common_classes

  if $manage_augeasproviders {
    include ::augeasproviders
  }

  if $manage_accounts {
    include ::account::accounts
  }

  if $manage_epel {
    include ::epel
  }

  if $manage_logging {
    include "profile::logging::${manage_logging}::agent"
  }

  if $manage_monitoring {
    include "profile::monitoring::${manage_monitoring}::agent"
  }

  if $manage_ssh {
    include ::ssh::client
    include ::ssh::server
  }

  if $manage_ntp {
    include ::ntp
  }

  if $manage_sudo {
    include ::sudo
    include ::sudo::configs
  }

  if $manage_authconfig {
    include ::authconfig
  }

  if $manage_firewall {
    include ::firewall
    include ::profile::firewall::pre
    include ::profile::firewall::post
  }

  if $common_packages {
    package { $common_packages:
      ensure => $common_packages_ensure
    }
  }

}

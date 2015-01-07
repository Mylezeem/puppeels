#
# Author: Yanis Guenane <yguenane@gmail.com>
# License: ApacheV2
#
# Puppet module :
#   mod 'saz/ssh'
#   mod 'saz/sudo'
#   mod 'puppetlabs/ntp'
#
class profile::base::base (
  $manage_augeasproviders  = true,
  $manage_epel             = true,
  $manage_accounts         = true,
  $manage_logging          = 'fluentd',
  $manage_monitoring       = 'sensu',
  $manage_ssh              = true,
  $manage_ntp              = true,
  $manage_sudo             = true,
  $manage_authconfig       = true,
  $manage_firewall         = true,
  $base_packages           = [],
  $package_ensure          = 'installed',
  $base_classes            = [],
) {
  include $base_classes

  if $manage_augeasproviders {
    include ::augeasproviders
  }

  if $manage_accounts {
    include profile::base::accounts
  }

  if $manage_epel {
    include epel
  }

  if $manage_logging {
    include "profile::logging::${manage_logging}::agent"
  }

  if $manage_monitoring {
    include "profile::monitoring::${manage_monitoring}::agent"
  }

  if $manage_ssh {
    include ::ssh
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

  if $base_packages {
    package { $base_packages:
      ensure => $package_ensure
    }
  }

}

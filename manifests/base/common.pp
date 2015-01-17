#
# Author: Yanis Guenane <yguenane@gmail.com>
# License: ApacheV2
#
# Puppet module :
#   mod 'saz/ssh'
#   mod 'saz/sudo'
#   mod 'puppetlabs/ntp'
#
class profile::base::common (
  $manage_augeasproviders  = true,
  $manage_epel             = true,
  $manage_accounts         = true,
  $manage_logging          = 'fluentd',
  $manage_monitoring       = 'sensu',
  $manage_sshd             = true,
  $manage_ntp              = true,
  $manage_sudo             = true,
  $manage_authconfig       = true,
  $manage_firewall         = true,
  $common_packages         = [],
  $common_packages_ensure  = 'installed',
  $common_classes          = [],
) {
  include $common_classes

  if $manage_augeasproviders {
    include ::augeasproviders
  }

  if $manage_accounts {
    include account::accounts
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

  if $manage_sshd {
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
  }

  if $common_packages {
    package { $common_packages:
      ensure => $common_packages_ensure
    }
  }

}

#
# Author: Yanis Guenane <yguenane@gmail.com>
# License: ApacheV2
#
# Puppet module :
#   mod 'puppetlabs/stdlib'
#   mod 'herculesteam/augeasproviders'
#   mod 'herculesteam/augeasproviders_apache'
#   mod 'herculesteam/augeasproviders_base'
#   mod 'herculesteam/augeasproviders_grub'
#   mod 'herculesteam/augeasproviders_mounttab'
#   mod 'herculesteam/augeasproviders_nagios'
#   mod 'herculesteam/augeasproviders_pam'
#   mod 'herculesteam/augeasproviders_postgresql'
#   mod 'herculesteam/augeasproviders_puppet'
#   mod 'herculesteam/augeasproviders_shellvar'
#   mod 'herculesteam/augeasproviders_ssh'
#   mod 'herculesteam/augeasproviders_sysctl'
#   mod 'herculesteam/augeasproviders_syslog'
#   mod 'stahnma/epel'
#   mod 'account',
#     :git => 'https://github.com/Mylezeem/puppet-account.git',
#     :ref => 'multiple_accounts'
#   mod 'puppetlabs/ntp'
#   mod 'saz/sudo'
#   mod 'saz/ssh'
#   mod 'yguenane/authconfig'
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
    include ::augeasproviders::instances
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

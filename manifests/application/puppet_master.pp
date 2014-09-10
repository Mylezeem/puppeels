#
# Author: Yanis Guenane <yguenane@gmail.com>
# License: ApacheV2
#
# Puppet module :
#   * puppetlabs/puppetdb
#   * zack/r10k
#   * puppetlabs/inifile
#
class profile::application::puppet_master (
  $puppetconf_path      = '/etc/puppet/puppet.conf',
  $puppetdb_enable      = false,
  $r10k_enable          = false,
  $main_configuration   = {},
  $agent_configuration  = {},
  $master_configuration = {},
) {

  include profile::base

  if $r10k_enable {
    include ::r10k
  }

  if $puppetdb_enable {
    include ::puppetdb::master::config
  }

  create_resources('ini_setting', $main_configuration, { 'section' => 'main', 'path' => $puppetconf_path })
  create_resources('ini_setting', $agent_configuration, { 'section' => 'agent', 'path' => $puppetconf_path })
  create_resources('ini_setting', $master_configuration, { 'section' => 'master', 'path' => $puppetconf_path })

}

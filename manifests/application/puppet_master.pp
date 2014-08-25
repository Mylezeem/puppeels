#
# Author: Yanis Guenane <yguenane@gmail.com>
# License: ApacheV2
#
# Puppet module :
#   * puppetlabs/puppetdb
#   * zack/r10k
#
class profile::application::puppet_master (
  $puppetdb_enable = false,
) {
  include profile::base

  include ::puppet
  include ::r10k

  if $puppetdb_enable {
    include ::puppetdb::master::config
  }

}

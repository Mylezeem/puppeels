#
# Author: Yanis Guenane <yguenane@gmail.com>
# License: ApacheV2
#
# Puppet module :
#   * puppetlabs/puppetdb
#   * zack/r10k
#
class profile::application::puppet_master {
  include profile::base

  include ::puppetdb::master::config
  include ::r10k
}

#
# Author: Yanis Guenane <yguenane@gmail.com>
# License: ApacheV2
#
# Puppet module :
#   * theforeman/foreman
#
class profile::application::foreman {
  include profile::base

  include ::r10k
  include ::tftp
  include ::puppet
  include ::foreman
  include ::foreman_proxy
}

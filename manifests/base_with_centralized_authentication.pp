#
# Author: Yanis Guenane <yguenane@gmail.com>
# License: ApacheV2
#
# Puppet module :
#   mod 'saz/ssh'
#   mod 'saz/sudo'
#   mod 'yguenane/authconfig'
#
class profile::base_with_centralized_authentication {
  include profile::base_repositories_el

  include ::ssh::server
  include ::ntp
  include ::sudo
  include ::sudo::configs
  include ::authconfig
}

#
#
#
#
#
class profile::base_with_centralized_authentication {
  include profile::base_repositories_el

  include ::ssh::server
  include ::ntp
  include ::sudo
  include ::sudo::configs
  include ::authconfig
}

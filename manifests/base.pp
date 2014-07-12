#
#
#
#
#
class profile::base {
  include profile::base_repositories_el
  include profile::accounts
  include profile::logging::agent::fluentd

  include ::ssh::server
  include ::ntp
  include ::sudo
  include ::sudo::configs
}

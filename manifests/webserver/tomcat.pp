#
# Author: Yanis Guenane <yguenane@gmail.com>
# License: ApacheV2
#
# Puppet module :
#   * puppetlabs/tomcat
#   * puppetlabs/java
#   * yguenane/jpackage
#
class profile::webserver::tomcat (
  $install_jpackage  = false,
  $instances         = {},
  $services          = {},
  $wars              = {},
  $entries_config    = {},
  $servers_config    = {},
  $connectors_config = {},
  $engines_config    = {},
  $hosts_config      = {},
  $services_config   = {},
  $valves_config     = {},
) {

  Tomcat::Instance <| |> -> Tomcat::Config::Entry <| |> -> Tomcat::Setenv::Entry <| |> -> Tomcat::Service <| |> -> Tomcat::War <| |>

  include profile::base

  if $install_jpackage {
    include ::jpackage
  }

  include ::java
  include ::tomcat

  create_resources('tomcat::instance', $instances)
  create_resources('tomcat::service', $services)
  create_resources('tomcat::war', $wars)
  create_resources('tomcat::config::entry', $entries_config)
  create_resources('tomcat::config::server', $servers_config)
  create_resources('tomcat::config::server::connector', $connectors_config)
  create_resources('tomcat::config::server::engine', $engines_config)
  create_resources('tomcat::config::server::host', $hosts_config)
  create_resources('tomcat::config::server::service', $services_config)
  create_resources('tomcat::config::server::valve', $valves_config)
  
}

class profile::openstack::dashboard(
  $manage_firewall = true,
  $firewall_extras = {},
) {
  include ::horizon

  if $manage_firewall {
    profile::firewall::rule { '235 openstack-dashboard accept tcp':
      port   => [80,443],
      extras => $firewall_extras
    }
  }
}

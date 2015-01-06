#
class profile::discovery::consul::network_metadata (
) {
  profile::discovery::consul::datadep { 'neutronmetakeydep':
    key    => 'keystone_Address',
    before => [Class['::neutron::agents::metadata']]
  }

  profile::discovery::consul::datadep { 'neutronmetanovadep':
    key    => 'nova-api_Address',
    before => [Class['::neutron::agents::metadata']]
  }
}

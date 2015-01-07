#
class profile::discovery::consul::network (
) {
  profile::discovery::consul::datadep { 'neutronrabbitmqdep':
    key    => 'rabbitmq_Address',
    before => [Class['::neutron']]
  }
}

class profile::openstack::compute::hypervisor (
  $hypervisor_type = 'libvirt', # Possible value libvirt, vmware, xenserver
  $manage_telemetry = true
) {
  include ::profile::openstack::compute
  include ::profile::openstack::network
  include ::nova::compute
  include ::nova::compute::neutron
  include ::nova::compute::spice

  if $hypervisor_type in ['libvirt', 'vmware', 'xenserver'] {
    include "::nova::compute::${hypervisor_type}"
  } else {
    fail("Invalid hypervisor_type selected: ${hypervisor_type}")
  }

  if $manage_telemetry {
    include ::profile::openstack::telemetry
    include ::ceilometer::agent::compute
  }
}

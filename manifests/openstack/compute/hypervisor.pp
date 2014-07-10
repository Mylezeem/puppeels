class profile::openstack::compute::hypervisor (
  $hypervisor_type = 'libvirt', # Possible value libvirt, vmware, xenserver
) {
  include ::profile::openstack::compute
  include ::profile::openstack::telemetry
  include ::profile::openstack::network
  include ::nova::compute
  include ::nova::compute::spice
  include ::nova::compute::${hypervisor_type}
  include ::ceilometer::agent::compute
}

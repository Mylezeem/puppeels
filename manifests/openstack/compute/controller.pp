class profile::openstack::compute::controller {

  warning('This class is deprecated. You should use profile::openstack::compute::api,scheduler,conductor,consoleauth,consoleproxy,cert classes')

  include ::profile::openstack::compute
  include ::profile::openstack::compute::cert
  include ::profile::openstack::compute::conductor
  include ::profile::openstack::compute::consoleauth
  include ::profile::openstack::compute::schedule
  include ::profile::openstack::compute::api
  include ::profile::openstack::compute::consoleproxy

}

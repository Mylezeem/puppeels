class profile::openstack::spof {
} (
  include ::pacemaker
  include ::pacemaker::corosync
  include ::pacemaker::stonith
)

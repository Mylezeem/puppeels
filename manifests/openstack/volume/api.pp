class profile::openstack::volume::api {
  include profile::openstack::volume

  include ::cinder::api
  include ::cinder::glance

}

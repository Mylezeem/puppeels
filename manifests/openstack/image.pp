class profile::openstack::image(
  $registry_enabled = true,
) {

  include ::cloud::image::api

  if $registry_enabled {
    include ::cloud::image::registry
  }

}

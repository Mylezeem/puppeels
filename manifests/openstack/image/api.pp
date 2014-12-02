class profile::openstack::image::api(
  $backend        = 'rbd',
  $manage_pruner  = true,
  $manage_cleaner = true
) {

  include ::glance::api
  if $backend and $backend in ['cinder', 'file', 'rbd', 'swift', 'vsphere'] {
    include "::glance::backend::${backend}"
  } else {
    fail('Invalid glance backend selected, choose from cinder, file, rbd, swift, vsphere')
  }

  if $manage_cleaner {
    include ::glance::cache::cleaner
  }

  if $manage_pruner {
    include ::glance::cache::pruner
  }

}

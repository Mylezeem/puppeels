class profile::openstack::image::api(
  $backend = 'rbd'
) {

  include ::glance::api
  if $backend and $backend in ['cinder', 'file', 'rbd', 'swift', 'vsphere'] {
    include ::glance::backend::$backend
  } else {
    fail('Invalid glance backend selected, choose from cinder, file, rbd, swift, vsphere')
  }
  include ::glance::cache::cleaner
  include ::glance::cache::pruner
}

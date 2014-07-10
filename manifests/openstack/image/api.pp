class profile::openstack::image::api {
  include ::glance::api
  include ::glance::backend::rbd
  include ::glance::cache::cleaner
  include ::glance::cache::pruner
}

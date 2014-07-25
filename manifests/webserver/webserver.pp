#
# Author: Yanis Guenane <yguenane@gmail.com>
# License: ApacheV2
#
# Puppet module :
#   * puppetlabs/apache
#
class profile::webserver::apache (
  $dev_enable       = false,
  $mods_enable      = [],
  $vhost_definition = {},
) {

  include profile::base
 
  include ::apache

  if $dev_enable {
    include ::apache::dev
  }

  if !empty($mods_enable) {
    $modules = prefix($mods_enable, '::apache::mod::')
    class { $modules : }
  }

  create_resources('::apache::vhost', $vhost_definition)

}

#
# Author: Yanis Guenane <yguenane@gmail.com>
# License: ApacheV2
#
# Puppet module :
#   * yguenane/postgresqlrepo
#   * puppetlabs/postgresql
#
class profile::database::postgresql (
  $contrib_enable = true,
  $devel_enable   = false,
  $postgis_enable = false,
  $java_enable    = false,
  $perl_enable    = false,
  $python_enable  = false,
  $plperl_enable  = false,
) {

  include profile::base

  include ::postgresqlrepo
  include ::postgresql::globals
  include ::postgresql::server

  if $contrib_enable {
    include ::postgresql::server::contrib
  }

  if $devel_enable {
    include ::postgresql::server::devel
  }

  if $postgis_enable {
    include ::postgresql::server::postgis
  }

  if $plperl_enable {
    include ::postgresql::server::plperl
  }

  if $perl_enable {
    include ::postgresql::lib::perl
  }

  if $java_enable {
    include ::postgresql::lib::java
  }

  if $python_enable {
    include ::postgresql::lib::python
  }

}

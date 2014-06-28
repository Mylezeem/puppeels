#
# Author: Yanis Guenane <yguenane@gmail.com>
# License: ApacheV2
#
# Puppet module :
#   * yguenane/postgresqlrepo
#   * puppetlabs/postgresql
#
class profile::database::postgresql {
  include profile::base

  include ::postgresqlrepo
  include ::postgresql::globals
  include ::postgresql::server
  include ::postgresql::server::contrib
  include ::postgresql::server::plperl
  include ::postgresql::lib::java
  include ::postgresql::lib::python
}

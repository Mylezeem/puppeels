#
# Author: Yanis Guenane <yguenane@gmail.com>
# License: ApacheV2
#
# Puppet module :
#   * puppetlabs/mongodb
#
class profile::database::mongodb::mongod (
  $replsets  = {},
  $users     = {},
  $databases = {},
) {

  include ::mongodb::globals
  include ::mongodb::server
  create_resources('mongodb_replset', $replsets)
  create_resources('mongodb_user', $users)
  create_resources('mongodb_database', $databases)
}


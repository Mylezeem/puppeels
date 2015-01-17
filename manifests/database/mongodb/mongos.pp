#
# Author: Yanis Guenane <yguenane@gmail.com>
# License: ApacheV2
#
# Puppet module :
#   * puppetlabs/mongodb
#
class profile::database::mongodb::mongos (
  $shards = {},
) {

  include ::mongodb::globals
  include ::mongodb::mongos
  create_resources('mongodb_shard', $shards)
}


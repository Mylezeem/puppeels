#
# Author: Yanis Guenane <yguenane@gmail.com>
# License: ApacheV2
#
# Puppet module :
#   * puppetlabs/puppetdb
#
class profile::application::puppetdb_server {

  include ::puppetdb::server
}

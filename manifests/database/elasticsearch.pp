#
# Author: Michael Chapman
# License: ApacheV2
#
# Puppet module :
#   * elasticsearch/elasticsearch
#
class profile::database::elasticsearch::server (
  $instances = {}
) {

  include profile::base
  include ::java
  include ::elasticsearch
  create_resources('elasticsearch::instance', $instances)
}

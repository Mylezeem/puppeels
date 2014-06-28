#
# Author: Yanis Guenane <yguenane@gmail.com>
# License: ApacheV2
#
# Puppet module :
#   * srf/fluentd
#   * elasticsearch/elasticsearch
#
class profile::logging::server::fluentd (
) {

  include profile::base
  include profile::logging::agent::fluentd
  include ::java
  include ::elasticsearch

}

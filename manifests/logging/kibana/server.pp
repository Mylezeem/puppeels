#
# Author: Michael Chapman
# License: ApacheV2
#
class profile::logging::kibana::server (
) {
  include profile::base
  include ::kibana3
  include ::apache
}

# Author Michael Chapman <woppin@gmail.com>
# License: ApacheV2
#
# This is a thin wrapper to allow use of collection and
# appends, which removes the need to select a discovery provider
# each time we add an option.
#
define profile::discovery::consul(
  $services = []
) {
  include $services 
}


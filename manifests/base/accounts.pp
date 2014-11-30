#
# Author: Yanis Guenane <yguenane@gmail.com>
# License: ApacheV2
#
# Puppet module :
#   * https://github.com/Mylezeem/puppet-account
#
class profile::base::accounts (
  $accounts = undef,
) {
  validate_hash($accounts)
  create_resources('account', $accounts)
}

#
#
#
#
class profile::accounts (
  $accounts = undef,
) {
  validate_hash($accounts)
  create_resources('account', $accounts)
}

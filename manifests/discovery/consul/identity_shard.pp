#
define profile::discovery::consul::identity_shard (
  $c_array = []
) {
  validate_array($c_array)
  $_array = flatten($c_array)
  $_hash = hash($_array)
  create_resources('profile::discovery::consul::datadep', $_hash)
}

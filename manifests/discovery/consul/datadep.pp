#
define profile::discovery::consul::datadep (
  $key,
  $before = []
) {

  $_key = hiera($key, false)


  if ! $_key {
    $fail = true
  } else {
    $fail = false
  }

  $_name = join($before, '_')
  runtime_fail { "${_name}_req_${key}":
    fail    => $fail,
    message => "${before} requires ${key}",
    before  => $before
  }
}

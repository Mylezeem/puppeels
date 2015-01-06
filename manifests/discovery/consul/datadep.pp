#
define profile::discovery::consul::datadep (
  $key,
  $before    = [],
  $badvalues = []
) {

  $_key = hiera($key, false)

  if ! $_key or member($badvalues, $_key){
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

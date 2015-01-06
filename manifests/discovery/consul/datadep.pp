#
define profile::discovery::consul::datadep (
  $key,
  $before    = [],
  $badvalues = [],
) {

  $_key = hiera($key, false)

  if ! $_key or member($badvalues, $_key){
    $fail = true
  } else {
    $fail = false
  }

  runtime_fail { $title:
    fail    => $fail,
    message => "${title}: ${before} requires ${key}",
    before  => $before
  }
}

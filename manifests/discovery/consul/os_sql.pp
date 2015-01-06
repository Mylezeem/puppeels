#
class profile::discovery::consul::os_sql (
) {

  profile::discovery::consul::datadep { 'dbmysqldep':
    key       => 'mysql_Address',
    badvalues => ['127.0.0.1'],
    before    => []
  }

}

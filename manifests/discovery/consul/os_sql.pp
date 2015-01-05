#
class profile::discovery::consul::os_sql (
) {

  profile::discovery::consul::datadep { 'dbmysqldep':
    key    => 'mysql_Address',
    before => []
  }

}

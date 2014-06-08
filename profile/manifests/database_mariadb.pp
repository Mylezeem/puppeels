#
#
#
#
class profile::database_mariadb {
  include profile::base

  include ::mariadbrepo
  include ::mysql::server
}

#
# Author: Yanis Guenane <yguenane@gmail.com>
# License: ApacheV2
#
# Puppet module :
#   mod 'mediawiki',
#     :git => 'https://github.com/Mylezeem/puppet-mediawiki.git',
#     :ref => 'master'
#
class profile::application::mediawiki (
  $wikis  = {},
) {

  include profile::base
  create_resources('mediawiki::wiki', $wikis)

}

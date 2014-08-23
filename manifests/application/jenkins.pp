#
# Author: Yanis Guenane <yguenane@gmail.com>
# License: ApacheV2
#
# Puppet module :
#   mod 'rtyler/jenkins'
#   mod 'puppetlabs/java'
#   mod 'puppetlabs/apt'
#   mod 'darin/zypprepo'
#
class profile::application::jenkins (
  $install_jjb   = false,
  $jenkins_home  = '/var/lib/jenkins',
  $war_source    = 'http://mirrors.jenkins-ci.org/war-stable/latest/jenkins.war',
  $version       = 'lastest',
  $catalina_base = '/var/lib/tomcat',
  $proxy         = true,
  $proxy_vhost   = {},
) {

  include profile::base
  include profile::webserver::tomcat

  file { $jenkins_home :
    ensure  => directory,
    owner   => 'tomcat',
    group   => 'tomcat',
    mode    => '0755',
    require => Group['tomcat'],
  }
    
  tomcat::setenv::entry { 'JENKINS_HOME' :
    value => $jenkins_home,
  }

  tomcat::war { 'jenkins.war' :
    war_source    => $war_source,
    catalina_base => $catalina_base,
  }

  if $install_jjb {
    include ::jenkins_job_builder
  }

  if $proxy {
    include ::apache
    create_resource('apache::vhost', $proxy_vhost)
  }

}

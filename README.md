Puppeels
========

A list of (reusable) Puppet profiles.

Those profiles aims to get the best out of the role profile paradigm.
It is meant to be used with hiera. Profiles themselves tend to have really few or none parameters.
With hiera, one directly specifies parameters for the underlying classes.

A set of example on how to use those profiles is availabe on the [puppeels-example](https://github.com/Mylezeem/puppeels-example) repository.

###Current Profiles

#### Application

* [Foreman](http://theforeman.org/)
* [Jenkins](http://jenkins-ci.org/)
* [MediaWiki](http://www.mediawiki.org/)
* [PuppetDB](http://docs.puppetlabs.com/puppetdb/)

#### Database

* [MariaDB](http://mariadb.org)
* [PostgreSQL](http://www.postgresql.org)

#### Webserver

* [Apache](http://httpd.apache.org)
* [Tomcat](http://tomcat.apache.org)

#### High Availability

* [HAProxy](http://www.haproxy.org) + [KeepAlived](http://www.keepalived.org)

#### Monitoring

* [Sensu](http://sensuapp.org)

#### Logging

* [Fluentd](http://www.fluentd.org)


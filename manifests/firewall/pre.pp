#
# Copyright (C) 2014 eNovance SAS <licensing@enovance.com>
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may
# not use this file except in compliance with the License. You may obtain
# a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations
# under the License.
#
# == Class: profile::firewall::pre
#
class profile::firewall::pre(
  $established_firewall_settings = {},
  $icmp_firewall_settings        = {},
  $loopback_firewall_settings    = {},
  $ssh_firewall_settings         = {},
  $manage_ssh                    = true,
){

  # ensure the correct packages are installed
  include firewall

  # defaults 'pre' rules
  cloud::firewall::rule{ '000 accept related established rules':
    proto  => 'all',
    state  => ['RELATED', 'ESTABLISHED'],
    extras => $firewall_settings,
  }

  cloud::firewall::rule{ '001 accept all icmp':
    proto  => 'icmp',
    extras => $firewall_settings,
  }

  cloud::firewall::rule{ '002 accept all to lo interface':
    proto   => 'all',
    iniface => 'lo',
    extras  => $firewall_settings,
  }

  if $manage_ssh {
    cloud::firewall::rule{ '003 accept ssh':
      port   => '22',
      extras => $firewall_settings,
    }
  }
}

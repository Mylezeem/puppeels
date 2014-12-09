#
class profile::discovery::consul::compute_api (
) {
  consul::service { 'nova-api':
    port    => 8774,
  }
  consul::service { 'nova-api-ec2':
    port    => 8773,
  }
  consul::service { 'nova-api-metadata':
    port    => 8775,
  }
}

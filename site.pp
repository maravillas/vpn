# /etc/puppet/manifests/site.pp

node default {
  include openvpn
  include firewall
  include sysctl::base

  openvpn::server {
    'server-name':
      country      => '',
      province     => '',
      city         => '',
      organization => '',
      email        => '',
      server       => '?.?.?.? 255.255.255.0',
  }

  openvpn::client {
    'client':
      server => 'server-name',
  }

  openvpn::client_specific_config {
    'client':
      server => 'server-name',
      redirect_gateway => true,
      dhcp_options => ['DNS 8.8.8.8']
  }

  firewall { '100 VPN routing':
    chain    => 'POSTROUTING',
    jump     => 'MASQUERADE',
    proto    => 'all',
    outiface => "eth0",
    source   => '?.?.?.?/24',
    table    => 'nat',
  }

  sysctl { 'net.ipv4.ip_forward': value => '1' }
 }

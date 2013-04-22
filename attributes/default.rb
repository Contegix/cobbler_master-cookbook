# All defaults are aimed at a default vagrant config
default['cobbler_master']['server'] = '33.33.33.10'
# attributes used to configure dhcpd
default['cobbler_master']['dhcpd']['subnet'] = '33.33.33.0'
default['cobbler_master']['dhcpd']['routers'] = '33.33.33.1'
default['cobbler_master']['dhcpd']['dns'] = '33.33.33.1'
default['cobbler_master']['dhcpd']['range_start'] = '33.33.33.100'
default['cobbler_master']['dhcpd']['range_end'] = '33.33.33.255'



#
# Cookbook Name:: cobbler_master
# Recipe:: default
#
# Copyright (C) 2013 Opsmatic
# 
# All rights reserved - Do Not Redistribute
#
 
%w{cobbler cobbler-web debmirror isc-dhcp-server}.each do |pkg|
	package pkg
end

service "isc-dhcp-server" do
	action :start
end

service "cobbler" do
	action :nothing
	notifies :run, "execute[cobbler sync]", :immediate
end
execute "cobbler sync" do
	command "sleep 5; cobbler sync"
	action :nothing
end

cookbook_file "/etc/cobbler/users.digest" do
	mode "0600"
	source "users.digest"
	notifies :restart, "service[cobbler]", :delayed
end

template "/etc/cobbler/settings" do
	mode "0644"
	source "settings.erb"
	notifies :restart, "service[cobbler]", :immediate
end

template "/etc/cobbler/dhcp.template" do
	source "dhcp.template.erb"
	mode "0744"
	variables(node['cobbler_master']['dhcpd'])
	notifies :restart, "service[cobbler]", :immediate
	notifies :restart, "service[isc-dhcp-server]", :immediate
end

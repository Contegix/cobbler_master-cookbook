#
# Cookbook Name:: cobbler-master-cookbook
# Recipe:: default
#
# Copyright (C) 2013 Opsmatic
# 
# All rights reserved - Do Not Redistribute
#
 
%w{cobbler cobbler-web debmirror}.each do |pkg|
	package pkg
end

cookbook_file "/etc/cobbler/users.digest" do
	source "users.digest"
end

template "/etc/cobbler/settings" do
	source "settings.erb"
end


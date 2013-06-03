f = "ubuntu-12.04.2-server-amd64.iso"

if !`cobbler distro list`.strip().split(/\s/).map{|x| x.strip()}.include?("ubuntu1204-x86_64")
	remote_file "/tmp/#{f}" do
		source "http://releases.ubuntu.com/precise/#{f}"
		checksum "63b7c9474398295355f01f57a1657405ae85b1c21953c6c996bbb6374f07e3aa"
	end
	directory "/ubuntu1204" do
		mode "0755"
		action :create
		not_if {File.exists?("/ubuntu1204")}
	end

	execute "mount -o loop /tmp/#{f} /ubuntu1204" do
		only_if {Dir["/ubuntu1204/*"].empty?}
	end
	execute "cobbler import --name=ubuntu1204 --arch=x86_64 --path=/ubuntu1204 --breed=ubuntu"
	
	execute "addprofile" do
		command "cobbler profile edit --name=ubuntu1204-x86_64 --kickstart=/var/lib/cobbler/kickstarts/ubuntu1204.preseed"
		action :nothing
		notifies :run, "execute[cobbler sync]", :delayed
	end

	template "/var/lib/cobbler/kickstarts/ubuntu1204.preseed" do
		mode "0644"
		source "ubuntu-preseed.erb"
		notifies :run, "execute[addprofile]"
	end

	execute "cobbler sync" do
		action :nothing
	end
else
	Chef::Log.warn("ubuntu1204 distro already installed, please remove it if you want to reinstall it for some reason using cobbler distro remove")
end

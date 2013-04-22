# cobbler_master

A cookbook for creating a [Cobbler](http://www.cobblerd.org/) master server and setting up repos

# Requirements

`apt` cookbook

Only tested on Ubuntu 12.04

# Usage

Nothing special - set up the attributes to your liking and go to town!

## Bonus: virtualboxes all the way down

The cookbook is set up with a `Vagrantfile` which, in conjunction with vagrant berkshelf plugin, makes it trivial to create a vagrant provisioned with these recipes.

Once the `cobbler_master` vagrant is up and running, create another virtualbox with a network adapter set to the same Host-only network Vagrant uses (on my machine this is `vboxnet0` with the `33.33.33.0` subnet).

When your new virutalbox boots, it should get a `33.33.33.xxx` IP via DHCP and pxeboot to a menu of Cobbler profiles (if you provision with the `ubuntu-precise` recipe, which is the default in the Vagrantfile, an option to install ubuntu 12.04 will already be there)

The nicest part is that this cookbook sets cobbler up to act as a mirror (on your local, host-only network), so the installation when pxebooting is very fast.

# Attributes

The attributes file contains attributes used to set up DHCP. You should see how they're used in `templates/default/dhcp.template.erb`. Explaining these variables is beyond the scope of this README, but they are basic DHCP configuration values.

# Recipes

* `default` - install and configure a cobbler server
* `ubuntu-precise` - add a profile and http mirror for installing Ubuntu 12.04 LTS

# Author

Author:: Mikhail Panchenko <m@mihasya.com>

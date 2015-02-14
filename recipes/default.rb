#
# Cookbook Name:: chef-sugar-rackspace
# Recipe:: default
#
# Copyright 2015, Jim Rosser <jarosser06@gmail.com>
#

gem_version = run_context.cookbook_collection[cookbook_name].metadata.version

chef_gem('chef-sugar-rackspace') do
  version gem_version
  action :nothing
end.run_action(:install)

require 'chef/sugar/rackspace'

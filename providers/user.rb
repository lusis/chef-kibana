# Encoding: utf-8
# Cookbook Name:: kibana
# Provider:: user
# Author:: John E. Vincent
# Author:: Paul Czarkowski
# License:: Apache 2.0
#
# Copyright 2014, John E. Vincent

require 'chef/mixin/shell_out'
require 'chef/mixin/language'
include Chef::Mixin::ShellOut

use_inline_resources

def load_current_resource
  @user = new_resource.user
  @group = new_resource.group || @user
  @home = new_resource.home || "/home/#{@user}"
end

action :remove do

  user @user do
    home @home
    action :remove
  end

  group @group do
    members @user
    action :remove
  end
end

action :create do

  user @user do
    home @home
    system true
    action :create
    manage_home true
  end

  group @group do
    members @user
    append true
    system true
  end
end

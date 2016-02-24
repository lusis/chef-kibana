# Encoding: utf-8
# Cookbook Name:: kibana
# Resource/Provider:: user
# Author:: John E. Vincent
# Author:: Paul Czarkowski
# License:: Apache 2.0
#
# Copyright 2014, John E. Vincent

class Chef
  class Resource::KibanaUser < ChefCompat::Resource
    provides :kibana_user
    default_action(:create)
    property(:user, String, name_property: true)
    property(:group, String)
    property(:home, String)
  end

  class Provider::KibanaUser < Chef::Provider::LWRPBase # ~FC057, ~FC058
    provides :kibana_user
    include Chef::DSL::Recipe # required under chef 12, see poise/poise #8

    action :remove do
      user = new_resource.user
      group = new_resource.group || new_resource.user
      home = new_resource.home || "/home/#{user}"

      converge_by("remove resource #{new_resource.name}") do
        user user do
          home home
          action :remove
        end

        group group do
          members user
          action :remove
        end
      end
    end

    action :create do
      user = new_resource.user
      group = new_resource.group || new_resource.user
      home = new_resource.home || "/home/#{user}"
      converge_by("create resource #{new_resource.name}") do
        user user do
          home home
          system true
          action :create
          manage_home true
        end

        group group do
          members user
          append true
          system true
        end
      end
    end
  end
end

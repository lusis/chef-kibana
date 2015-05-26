# Encoding: utf-8
# Cookbook Name:: kibana
# Resource/Provider:: user
# Author:: John E. Vincent
# Author:: Paul Czarkowski
# License:: Apache 2.0
#
# Copyright 2014, John E. Vincent

require 'poise'

class Chef
  class Resource::KibanaUser < Resource
    include Poise
    actions(:create, :remove)
    attribute(:user, kind_of: String, name_attribute: true)
    attribute(:group, kind_of: String)
    attribute(:home, kind_of: String)
  end

  class Provider::KibanaUser < Provider
    include Poise
    include Chef::DSL::Recipe # required under chef 12, see poise/poise #8

    def action_remove
      user = new_resource.user
      group = new_resource.group || new_resource.user
      home = new_resource.home || "/home/#{user}"

      converge_by("remove resource #{new_resource.name}") do
        notifying_block do
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
    end

    def action_create
      user = new_resource.user
      group = new_resource.group || new_resource.user
      home = new_resource.home || "/home/#{user}"
      converge_by("create resource #{new_resource.name}") do
        notifying_block do
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
end

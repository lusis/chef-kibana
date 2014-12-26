# Encoding: utf-8
# Cookbook Name:: kibana
# Resource:: install
# Author:: John E. Vincent
# Author:: Paul Czarkowski
# Copyright 2014, John E. Vincent
# License:: Apache 2.0


actions :enable, :start, :restart, :reload, :stop

default_action :enable if defined?(default_action)

attribute :name, kind_of: String, name_attribute: true
attribute :user, kind_of: String
attribute :group, kind_of: String

attribute :service_name, kind_of: String
attribute :command, kind_of: String
attribute :args, kind_of: Array
attribute :description, kind_of: String
attribute :template_cookbook, kind_of: String
attribute :run_template_name, kind_of: String
attribute :log_template_name, kind_of: String

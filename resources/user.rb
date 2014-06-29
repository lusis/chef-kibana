# Encoding: utf-8
# Cookbook Name:: kibana
# Resource:: user
# Author:: John E. Vincent
# Author:: Paul Czarkowski
# Copyright 2014, John E. Vincent
# License:: Apache 2.0

actions :create, :remove

default_action :create if defined?(default_action)

attribute :user, kind_of: String, name_attribute: true
attribute :group, kind_of: String
attribute :home, kind_of: String

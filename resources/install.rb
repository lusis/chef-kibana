# Encoding: utf-8
# Cookbook Name:: kibana
# Resource:: install
# Author:: John E. Vincent
# Author:: Paul Czarkowski
# Copyright 2014, John E. Vincent
# License:: Apache 2.0

actions :create, :remove

default_action :create if defined?(default_action)

attribute :name, kind_of: String, name_attribute: true
attribute :user, kind_of: String, default: 'kibana'
attribute :group, kind_of: String, default: 'kibana'
attribute :install_dir, kind_of: String, default: '/opt/kibana'
attribute :install_type, kind_of: String, default: 'file'
attribute :git_branch, kind_of: String, default: node['kibana']['git']['branch']
attribute :git_url, kind_of: String, default: node['kibana']['git']['url']
attribute :git_type, kind_of: String, default: node['kibana']['git']['type']
attribute :file_type, kind_of: String, default: node['kibana']['file']['type']
attribute :file_url, kind_of: String, default: node['kibana']['file']['url']
attribute :version, kind_of: String, default: node['kibana']['version']
attribute :file_checksum, kind_of: String, default: node['kibana']['file']['checksum']

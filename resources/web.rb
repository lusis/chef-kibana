# Encoding: utf-8
# Cookbook Name:: kibana
# Resource:: web
# Author:: John E. Vincent
# Author:: Paul Czarkowski
# Copyright 2014, John E. Vincent
# License:: Apache 2.0

actions :create, :remove

default_action :create if defined?(default_action)

attribute :name, kind_of: String, name_attribute: true
attribute :type, kind_of: String, default: 'nginx'
attribute :template_cookbook, kind_of: String, default: 'kibana'
attribute :template, kind_of: String
attribute :server_name, kind_of: String, default: 'kibana.localhost'
attribute :server_aliases, kind_of: Array, default: ['kibana']
attribute :listen_address, kind_of: String, default: '0.0.0.0'
attribute :listen_port, kind_of: String, default: '80'
attribute :es_server, kind_of: String, default: '127.0.0.1'
attribute :es_port, kind_of: String, default: '9200'
attribute :es_scheme, kind_of: String, default: 'http://'
attribute :version, kind_of: String, default: node['kibana']['version']
attribute :default_site_enabled, kind_of: [TrueClass, FalseClass], default: false
attribute :docroot, kind_of: String, default: '/opt/kibana/current/kibana'
attribute :kibana_port, kind_of: Integer, default: '5601'

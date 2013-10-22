#
# Cookbook Name:: kibana
# Recipe:: apache
#
# Copyright 2013, John E. Vincent
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#


node.set['apache2']['default_site_enabled'] = node['kibana']['apache']['enable_default_site']

include_recipe "apache2"
include_recipe "apache2::mod_dir"
include_recipe "apache2::mod_proxy"
include_recipe "apache2::mod_proxy_http"

web_app "#{node['kibana']['webserver_hostname']}-#{node['kibana']['webserver_port']}" do
  cookbook       node['kibana']['apache']['template_cookbook']
  docroot        node['kibana']['installdir']
  template       node['kibana']['apache']['template']
  es_server      node['kibana']['es_server']
  es_port        node['kibana']['es_port']
  server_name    node['kibana']['webserver_hostname']
  server_aliases node['kibana']['webserver_aliases']
  kibana_dir     node['kibana']['installdir']
  listen_address node['kibana']['webserver_listen']
  listen_port    node['kibana']['webserver_port']
end

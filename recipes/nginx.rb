#
# Cookbook Name:: kibana
# Recipe:: nginx
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


node.set['nginx']['default_site_enabled'] = node['kibana']['nginx']['enable_default_site']
node.set['nginx']['install_method'] = node['kibana']['nginx']['install_method']

include_recipe "nginx"

template "#{node['nginx']['dir']}/sites-available/kibana" do
  source node['kibana']['nginx']['template']
  cookbook node['kibana']['nginx']['template_cookbook']
  notifies :reload, "service[nginx]"
  variables(
    :es_server        => node['kibana']['es_server'],
    :es_port          => node['kibana']['es_port'],
    :server_name      => node['kibana']['webserver_hostname'],
    :server_aliases   => node['kibana']['webserver_aliases'],
    :kibana_dir       => node['kibana']['web_dir'],
    :listen_address   => node['kibana']['webserver_listen'],
    :listen_port      => node['kibana']['webserver_port'],
    :es_scheme        => node['kibana']['es_scheme']
  )
end

nginx_site "kibana"

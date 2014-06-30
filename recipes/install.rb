#
# Cookbook Name:: kibana
# Recipe:: default
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

unless Chef::Config[:solo]
  es_server_results = search(:node, "roles:#{node['kibana']['es_role']} AND chef_environment:#{node.chef_environment}")
  unless es_server_results.empty?
    node.set['kibana']['es_server'] = es_server_results[0]['ipaddress']
  end
end

if node['kibana']['user'].empty?
  if !node['kibana']['webserver'].empty?
    webserver = node['kibana']['webserver']
    kibana_user = node[webserver]['user']
  else
    kibana_user = 'nobody'
  end
else
  kibana_user kibana_user do
    name kibana_user
    group kibana_user
    home node['kibana']['install_dir']
    action :create
  end
end

kibana_install 'kibana' do
  user kibana_user
  group kibana_user
  install_dir node['kibana']['install_dir']
  install_type node['kibana']['install_type']
  action :create
end

template "#{node['kibana']['install_dir']}/current/config.js" do
  source node['kibana']['config_template']
  cookbook node['kibana']['config_cookbook']
  mode '0750'
  user kibana_user
end

link "#{node['kibana']['install_dir']}/current/app/dashboards/default.json" do
  to 'logstash.json'
  only_if { !File.symlink?("#{node['kibana']['install_dir']}/current/app/dashboards/default.json") }
end

unless node['kibana']['webserver'].empty?
  kibana_web 'kibana' do
    type node['kibana']['webserver']
    docroot "#{node['kibana']['install_dir']}/current"
    es_server = node['kibana']['es_server']
  end
end

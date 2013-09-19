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

include_recipe "git"

unless Chef::Config[:solo]
  es_server_results = search(:node, "roles:#{node['kibana']['es_role']} AND chef_environment:#{node.chef_environment}")
  unless es_server_results.empty?
    node.set['kibana']['es_server'] = es_server_results[0]['ipaddress']
  end
end

if node['kibana']['user'].empty?
  webserver = node['kibana']['webserver']
  kibana_user = "#{node[webserver]['user']}"
else
  kibana_user = node['kibana']['user']
end

directory node['kibana']['install_dir'] do
  owner kibana_user
  mode "0755"
end

case  node['kibana']['install_type']
  when "repo"
    git "#{node['kibana']['install_dir']}/#{node['kibana']['repo_branch']}" do
      repository node['kibana']['repo_url']
      reference node['kibana']['repo_branch']
      action :sync
      user kibana_user
    end
    link "#{node['kibana']['install_dir']}/current" do
      to "#{node['kibana']['install_dir']}/#{node['kibana']['repo_branch']}"
    end
    node.set['kibana']['source_dir'] = "#{node['kibana']['install_dir']}/current/src"
  when "zipfile"
    ark 'kibana' do
       url node['kibana']['zipfile_url']
       path node['kibana']['install_path']
       checksum  node['kibana']['zipfile_checksum']
       owner kibana_user
       action :put
    end
    node.set['kibana']['source_dir'] = node['kibana']['install_dir']
end

template "#{node['kibana']['source_dir']}/config.js" do
  source node['kibana']['config_template']
  cookbook node['kibana']['config_cookbook']
  mode "0750"
  user kibana_user
end

link "#{node['kibana']['source_dir']}/app/dashboards/default.json" do
  to "logstash.json"
  only_if { !File::symlink?("#{node['kibana']['source_dir']}/app/dashboards/default.json") }
end

include_recipe "kibana::#{node['kibana']['webserver']}"

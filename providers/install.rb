# Encoding: utf-8
# Cookbook Name:: kibana
# Provider:: install
# Author:: John E. Vincent
# Author:: Paul Czarkowski
# License:: Apache 2.0
#
# Copyright 2014, John E. Vincent

require 'chef/mixin/shell_out'
require 'chef/mixin/language'
include Chef::Mixin::ShellOut

use_inline_resources

def load_current_resource
  @kibana_resource = new_resource.clone
end

action :remove do
  kb_args = kibana_resources

  directory kb_args[:install_dir] do
    recursive true
    action :delete
  end
end

action :create do
  kb_args = kibana_resources

  directory kb_args[:install_dir] do
    recursive true
    owner kb_args[:user]
    group kb_args[:group]
    mode '0755'
  end

  case  kb_args[:install_type]
  when 'git'
    @run_context.include_recipe 'git::default'
    git "#{kb_args[:install_dir]}/#{kb_args[:git_branch]}" do
      repository kb_args[:git_url]
      reference kb_args[:git_branch]
      action kb_args[:git_type].to_sym
      user kb_args[:user]
    end

    link "#{kb_args[:install_dir]}/current" do
      to "#{kb_args[:install_dir]}/#{kb_args[:git_branch]}/src"
    end
    node.set['kibana'][kb_args[:name]]['web_dir'] = "#{kb_args[:install_dir]}/current/src"

  when 'file'
    @run_context.include_recipe 'libarchive::default'
    temp_file = "kibana_#{kb_args[:name]}_#{kb_args[:version]}_#{kb_args[:name]}.tar.gz"
    temp_path = Chef::Config[:file_cache_path]
    case kb_args[:file_type]
    when 'tgz', 'zip'
      remote_file "#{temp_path}/#{temp_file}" do
        checksum lazy { kb_args[:file_checksum] }
        source kb_args[:file_url]
        action [:create]
      end

      libarchive_file temp_file do
        path "#{temp_path}/#{temp_file}"
        extract_to kb_args[:install_dir]
        owner kb_args[:user]
        action [:extract]
      end

      link "#{kb_args[:install_dir]}/current" do
        to "#{kb_args[:install_dir]}/kibana-#{kb_args[:version]}"
      end

      node.set['kibana'][kb_args[:name]]['web_dir'] = "#{kb_args[:install_dir]}/current"
      node.save unless Chef::Config[:solo]
    end
  end

end

private

def kibana_resources
  kb = {
    name: new_resource.name,
    user: new_resource.user,
    group: new_resource.group,
    install_dir: new_resource.install_dir,
    install_type: new_resource.install_type,
    git_branch: new_resource.git_branch,
    git_url: new_resource.git_url,
    git_type: new_resource.git_type,
    file_type: new_resource.file_type,
    file_url: new_resource.file_url,
    version: new_resource.version,
    file_checksum: new_resource.file_checksum
  }
  kb
end

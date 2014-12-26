# Encoding: utf-8
# Cookbook Name:: logstash
# Provider:: service
# Author:: John E. Vincent
# License:: Apache 2.0
#
# Copyright 2014, John E. Vincent

require 'chef/mixin/shell_out'
require 'chef/mixin/language'
include Chef::Mixin::ShellOut

def load_current_resource
  @name = new_resource.instance
  @basedir = Logstash.get_attribute_or_default(node, @instance, 'basedir')
  @templates_cookbook = new_resource.templates_cookbook || Logstash.get_attribute_or_default(node, @instance, 'service_templates_cookbook')
  @service_name = new_resource.service_name || "logstash_#{@instance}"
  @home = "#{@basedir}/#{@instance}"
  @method = new_resource.method || Logstash.get_attribute_or_default(node, @instance, 'init_method')
  @command = new_resource.command || "#{@home}/bin/logstash"
  @user = new_resource.user || Logstash.get_attribute_or_default(node, @instance, 'user')
  @group = new_resource.group || Logstash.get_attribute_or_default(node, @instance, 'group')
  @log_file = Logstash.get_attribute_or_default(node, @instance, 'log_file')
  @max_heap = Logstash.get_attribute_or_default(node, @instance, 'xmx')
  @min_heap = Logstash.get_attribute_or_default(node, @instance, 'xms')
  @gc_opts = Logstash.get_attribute_or_default(node, @instance, 'gc_opts')
  @ipv4_only = Logstash.get_attribute_or_default(node, @instance, 'ipv4_only')
  @java_opts = Logstash.get_attribute_or_default(node, @instance, 'java_opts')
  @description = new_resource.description || @service_name
  @chdir = @home
  @workers =  Logstash.get_attribute_or_default(node, @instance, 'workers')
  @debug =  Logstash.get_attribute_or_default(node, @instance, 'debug')
  @install_type = Logstash.get_attribute_or_default(node, @instance, 'install_type')
  @supervisor_gid = Logstash.get_attribute_or_default(node, @instance, 'supervisor_gid')
  @runit_run_template_name = Logstash.get_attribute_or_default(node, @instance, 'runit_run_template_name')
  @runit_log_template_name = Logstash.get_attribute_or_default(node, @instance, 'runit_log_template_name')
  @nofile_soft = Logstash.get_attribute_or_default(node, @instance, 'limit_nofile_soft')
  @nofile_hard = Logstash.get_attribute_or_default(node, @instance, 'limit_nofile_hard')
end

action :restart do
  new_resource.updated_by_last_action(service_action(:restart))
end

action :start do
  new_resource.updated_by_last_action(service_action(:start))
end

action :stop do
  new_resource.updated_by_last_action(service_action(:stop))
end

action :reload do
  new_resource.updated_by_last_action(service_action(:reload))
end

action :enable do
  svc = svc_vars
  Chef::Log.info("Using init method #{svc[:method]} for #{svc[:service_name]}")
    @run_context.include_recipe 'runit::default'
    ri = runit_service svc[:service_name] do
      options(
                name: svc[:name],
                home: svc[:home],
                max_heap: svc[:max_heap],
                min_heap: svc[:min_heap],
                gc_opts: svc[:gc_opts],
                java_opts: svc[:java_opts],
                ipv4_only: svc[:ipv4_only],
                debug: svc[:debug],
                log_file: svc[:log_file],
                workers: svc[:workers],
                install_type: svc[:install_type],
                supervisor_gid: svc[:supervisor_gid],
                user: svc[:user],
                web_address: svc[:web_address],
                web_port: svc[:web_port]
      )
      cookbook  svc[:templates_cookbook]
      run_template_name svc[:runit_run_template_name]
      log_template_name svc[:runit_log_template_name]
    end
    new_resource.updated_by_last_action(ri.updated_by_last_action?)
end

private

def default_args
  svc = svc_vars
  args      = ['agent', '-f', "#{svc[:home]}/etc/conf.d/"]
  args.concat ['-vv'] if svc[:debug]
  args.concat ['-l', "#{svc[:home]}/log/#{svc[:log_file]}"] if svc[:log_file]
  args.concat ['-w', svc[:workers].to_s] if svc[:workers]
  args
end

def service_action(action)
  svc = svc_vars
  @run_context.include_recipe 'runit::default'
  sv = runit_service svc[:service_name]
  sv.run_action(action)
  sv.updated_by_last_action?
end

def svc_vars
  svc = {
    name: @instance,
    service_name: @service_name,
    home: @home,
    method: @method,
    command: @command,
    description: @description,
    chdir: @chdir,
    user: @user,
    group: @group,
    log_file: @log_file,
    max_heap: @max_heap,
    min_heap: @min_heap,
    java_opts: @java_opts,
    ipv4_only: @ipv4_only,
    workers: @workers,
    debug: @debug,
    supervisor_gid: @supervisor_gid,
    templates_cookbook: @templates_cookbook,
    runit_run_template_name: @runit_run_template_name,
    runit_log_template_name: @runit_log_template_name,
    nofile_soft: @nofile_soft,
    nofile_hard: @nofile_hard
  }
  svc
end

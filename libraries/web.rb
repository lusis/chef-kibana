# Encoding: utf-8
# Cookbook Name:: kibana
# Resource/Provider:: web
# Author:: John E. Vincent
# Author:: Paul Czarkowski
# License:: Apache 2.0
#
# Copyright 2014, John E. Vincent

require 'poise'

class Chef
  class Resource::KibanaWeb < Resource
    include Poise

    actions(:create, :remove)

    attribute(:name, kind_of: String, name_attribute: true)
    attribute(:type, kind_of: String, default: 'nginx')
    attribute(:template_cookbook, kind_of: String, default: 'kibana_lwrp')
    attribute(:template, kind_of: String)
    attribute(:server_name, kind_of: String, default: 'kibana.localhost')
    attribute(:server_aliases, kind_of: Array, default: ['kibana'])
    attribute(:listen_address, kind_of: String, default: '0.0.0.0')
    attribute(:listen_port, kind_of: String, default: '80')
    attribute(:es_server, kind_of: String, default: '127.0.0.1')
    attribute(:es_port, kind_of: String, default: '9200')
    attribute(:es_scheme, kind_of: String, default: 'http://')
    attribute(:version, kind_of: String, default: lazy { node['kibana']['version'] })
    attribute(:default_site_enabled, kind_of: [TrueClass, FalseClass], default: false)
    attribute(:docroot, kind_of: String, default: '/opt/kibana/current/kibana')
    attribute(:kibana_port, kind_of: Integer, default: '5601')
  end

  class Provider::KibanaWeb < Provider
    include Poise
    include Chef::DSL::Recipe # required under chef 12, see poise/poise #8

    def action_create
      converge_by("create resource #{new_resource.name}") do
        notifying_block do
          resources = kibana_resources

          case resources[:type]
          when 'apache'
            node.set['apache']['default_site_enabled'] = resources[:default_site_enabled]

            node.set['apache']['listen_ports'] = [] unless resources[:default_site_enabled]
            node.set['apache']['listen_ports'] << resources[:listen_port]

            %w(apache2 apache2::mod_dir apache2::mod_proxy apache2::mod_proxy_http).each do |recipe|
              @run_context.include_recipe recipe
            end

            wa = web_app resources[:name] do
              cookbook resources[:template_cookbook]
              docroot resources[:docroot]
              template resources[:template]
              es_server resources[:es_server]
              es_port resources[:es_port]
              server_name resources[:server_name]
              server_aliases resources[:server_aliases]
              kibana_dir resources[:docroot]
              listen_address resources[:listen_address]
              listen_port resources[:listen_port]
              es_scheme resources[:es_scheme]
            end

          when 'nginx'
            node.set['nginx']['default_site_enabled'] = resources[:default_site_enabled]
            node.set['nginx']['install_method'] = node['kibana']['nginx']['install_method']
            @run_context.include_recipe 'nginx'

            template "#{node['nginx']['dir']}/sites-available/#{resources[:name]}" do
              source resources[:template]
              cookbook resources[:template_cookbook]
              notifies :reload, 'service[nginx]'
              variables(
                es_server: resources[:es_server],
                es_port: resources[:es_port],
                server_name: resources[:server_name],
                server_aliases: resources[:server_aliases],
                kibana_dir: resources[:docroot],
                listen_address: resources[:listen_address],
                listen_port: resources[:listen_port],
                es_scheme: resources[:es_scheme],
                kibana_port: resources[:kibana_port]
              )
            end
            nginx_site resources[:name]
          when ''
            # do nothing
          else
            Chef::Application.fatal!("Unknown type: #{resources[:type]}")
          end # end case
        end # end notifying_block
      end # end converge by
    end # end def

    def action_remove
      converge_by("remove resource #{new_resource.name}") do
        notifying_block do
          # Normal Chef recipe code goes here
        end
      end
    end

    private

    def kibana_resources
      kb = {
        name: new_resource.name,
        type: new_resource.type,
        template_cookbook: new_resource.template_cookbook,
        docroot: new_resource.docroot,
        template: new_resource.template || "kibana-#{new_resource.type}.conf.erb",
        server_name: new_resource.server_name,
        server_aliases: new_resource.server_aliases,
        listen_address: new_resource.listen_address,
        listen_port: new_resource.listen_port,
        es_server: new_resource.es_server,
        es_port: new_resource.es_port,
        es_scheme: new_resource.es_scheme,
        default_site_enabled: new_resource.default_site_enabled,
        version: new_resource.version,
        kibana_port: new_resource.kibana_port
      }
      kb
    end
  end
end

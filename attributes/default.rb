# The method used to install kibana.  `git` will clone the git repo,
# `file` will download from elasticsearch.org
# git is not really supported since the move to java based server.
default['kibana']['install_type'] = 'file' # git | file
default['kibana']['version'] = '4.0.0-linux-x64' # must match version number of kibana being installed

# Values to use for git method of installation
default['kibana']['git']['url'] = 'https://github.com/elasticsearch/kibana'
default['kibana']['git']['branch'] = 'v3.1.2'
default['kibana']['git']['type'] = 'sync' # checkout | sync
default['kibana']['git']['config'] = 'kibana/config.js' # relative path of config file
default['kibana']['git']['config_template'] = 'config.js.erb' # template to use for config
default['kibana']['git']['config_template_cookbook'] = 'kibana_lwrp' # cookbook containing config template

# Values to use for file method of installation
default['kibana']['file']['type'] = 'tgz' # zip | tgz

default['kibana']['file']['url'] = 'https://download.elasticsearch.org/kibana/kibana/kibana-4.0.0-linux-x64.tar.gz'
default['kibana']['file']['checksum'] = nil # sha256 ( shasum -a 256 FILENAME )
default['kibana']['file']['config'] = 'config/kibana.yml' # relative path of config file
default['kibana']['file']['config_template'] = 'kibana.yml.erb' # template to use for config
default['kibana']['file']['config_template_cookbook'] = 'kibana_lwrp' # cookbook containing config template

# Kibana Java Web Server
default['kibana']['java_webserver_port'] = 5601

# this is only used by the recipe.  if you use the LWRPs
# (which you should) then install java from your own recipe.
default['kibana']['install_java'] = true

# Which webserver to use, and webserver options.
default['kibana']['webserver'] = 'nginx' # nginx or apache
default['kibana']['webserver_hostname'] = node.name
default['kibana']['webserver_aliases'] = [node['ipaddress']]
default['kibana']['webserver_listen'] = node['ipaddress']
default['kibana']['webserver_port'] = 80
default['kibana']['webserver_scheme'] = 'http://'

# parent directory of install_dir.  This is required because of the `file` method.
default['kibana']['install_path'] = '/opt'

# the actual installation directory of kibana. If using the `file` method this should be left as is.
default['kibana']['install_dir'] = "#{node['kibana']['install_path']}/kibana"

# used to configure proxy information for the webserver to proxy ES calls.
default['kibana']['es_server'] = '127.0.0.1'
default['kibana']['es_port'] = '9200'
default['kibana']['es_role'] = 'elasticsearch_server'
default['kibana']['es_scheme'] = 'http://'

# user to install kibana files as.  if left blank will use the default webserver user.
default['kibana']['user'] = 'kibana'

# config template location and variables.
default['kibana']['config']['kibana_index']  = 'kibana-int'
default['kibana']['config']['panel_names']   =  %w(histogram map pie table filtering timepicker text fields hits dashcontrol column derivequeries trends bettermap query terms)
default['kibana']['config']['default_route'] = '/dashboard/file/logstash.json'
# include quote inside this next variable if not using window.location style variables...
# e.g.  = "'http://elasticsearch.example.com:9200'"
default['kibana']['config']['elasticsearch'] = "window.location.protocol+\"//\"+window.location.hostname+\":\"+window.location.port"

# nginx variables
default['kibana']['nginx']['install_method'] = 'package'
default['kibana']['nginx']['template'] = 'kibana-nginx.conf.erb'
default['kibana']['nginx']['template_cookbook'] = 'kibana_lwrp'
default['kibana']['nginx']['enable_default_site'] = false
default['kibana']['nginx']['install_method'] = 'package'

# Apache variables.
default['kibana']['apache']['template'] = 'kibana-apache.conf.erb'
default['kibana']['apache']['template_cookbook'] = 'kibana_lwrp'
default['kibana']['apache']['enable_default_site'] = false

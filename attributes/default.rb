# The method used to install kibana.  `git` will clone the git repo,
# `file` will download from elasticsearch.org
default['kibana']['install_type'] = 'file' # git | file

# Values to use for git method of installation
default['kibana']['git']['url'] = 'https://github.com/elasticsearch/kibana'
default['kibana']['git']['branch'] = 'master'
default['kibana']['git']['type'] = 'sync' # checkout | sync

# Values to use for file method of installation
default['kibana']['file']['type'] = 'tgz' # zip | tgz
default['kibana']['file']['url'] = 'https://download.elasticsearch.org/kibana/kibana/kibana-3.1.0.tar.gz'
default['kibana']['file']['version'] = '3.1.0' # must match version number of above
default['kibana']['file']['checksum'] = '059a4b6b507b9ff771901d12035e499b0e8d1cae7d9e5284633e19da6c294e07' # sha256 ( shasum -a 256 FILENAME )

# Which webserver to use, and webserver options.
default['kibana']['webserver'] = 'nginx' # nginx or apache
default['kibana']['webserver_hostname'] = node.name
default['kibana']['webserver_aliases'] = [node.ipaddress]
default['kibana']['webserver_listen'] = node.ipaddress
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
default['kibana']['user'] = ''

# config template location and variables.
default['kibana']['config_template'] = 'config.js.erb'
default['kibana']['config_cookbook'] = 'kibana'
default['kibana']['config']['kibana_index']  = 'kibana-int'
default['kibana']['config']['panel_names']   =  %w(histogram map pie table filtering timepicker text fields hits dashcontrol column derivequeries trends bettermap query terms)
default['kibana']['config']['default_route'] = '/dashboard/file/logstash.json'
# include quote inside this next variable if not using window.location style variables...
# e.g.  = "'http://elasticsearch.example.com:9200'"
default['kibana']['config']['elasticsearch'] = "window.location.protocol+\"//\"+window.location.hostname+\":\"+window.location.port"

# Enables legacy mode for people upgrading from ealier version of cookbook.
default['kibana']['legacy_mode'] = false

kibana Cookbook
===============
A stand-alone cookbook for Kibana3

Requirements
------------
- apt
- yum
- apache2
- nginx
- git


Attributes
----------
As with most cookbooks I write, this one is hopefully flexible enough to be wrapped by allowing you to override as much as possible

#### kibana::default

- `node['kibana']['repo']` - The git repo to use for Kibana3
- `node['kibana']['branch']` - The sha or branch name to use
- `node['kibana']['webserver']` - Which webserver to use: apache or nginx
- `node['kibana']['installdir']` - The directory to checkout into. A `current` symlink will be created in this directory as well.
- `node['kibana']['es_server']` - The ipaddress or hostname of your elasticsearch server
- `node['kibana']['es_port']` - The port of your elasticsearch server's http interface
- `node['kibana']['es_role']` - **unused** eventually for wiring up discovery of your elasticsearch server
- `node['kibana']['user']` - The user who will own the files from the git checkout. (default: the web server user)
- `node['kibana']['config_template']` - The template to use for kibana's `config.js`
- `node['kibana']['config_cookbook']` - The cookbook that contains said config template
- `node['kibana']['webserver_hostname']` - The primary vhost the web server will use for kibana
- `node['kibana']['webserver_aliases']` - Array of any secondary hostnames that are valid vhosts
- `node['kibana']['webserver_listen']` - The ip address the web server will listen on
- `node['kibana']['webserver_port']` - The port the webserver will listen on

#### kibana::nginx

- `node['kibana']['nginx']['template']` - The template file to use for the nginx site configuration
- `node['kibana']['nginx']['template_cookbook']` - The cookbook containing said template
- `node['kibana']['nginx']['enable_default_site']` - Should we disable the nginx default site (default: true)

#### kibana::apache

- `node['kibana']['apache']['template']` - The template file to use for the apache site configuration
- `node['kibana']['apache']['template_cookbook']` - The cookbook containing said template
- `node['kibana']['apache']['enable_default_site']` - Should we disable the apache default site (default: true)

Usage
-----
#### kibana::default
The default recipe will:

- install kibana3 from `master` into `/opt/kibana/master` and create a symlink called `current` in the same directory to `master`
- install `nginx` and serve the kibana application

If you wish to swap `apache` for `nginx`, simply set `node['kibana']['webserver']` to `apache` in a role/environment/node somewhere.

Both cookbooks, by default, will configure the appropriate proxy to your ElasticSearch server such that you don't have to expose it to the world.

**NOTE**
There is **NO** security enabled by default on any of the content being served.
If you would like to modify the `nginx` or `apache` parameters, you should:

- create your own cookbook i.e. `my-kibana`
- copy the template for the webserver you wish to use to your cookbook
- modify the template as you see fit (add auth, setup ssl)
- use the appropriate webserver template attributes to point to your cookbook and template

Contributing
------------
- Fork the repository on Github
- Create a named feature branch (like `add_component_x`)
- Write you change
- Write tests for your change (if applicable)
- Run the tests, ensuring they all pass
- Submit a Pull Request using Github

License and Authors
-------------------
Primary author:

- John E. Vincent <lusis.org+github.com@gmail.com>

Contributors:

- Jeff Hubbard (@lord2800)
- @mouadino
- Ben P (@benwtr)
- Chris Ferry (@chrisferry)
- Ian Neubert (@ianneub)
- kellam (@klamontagne)
- Paul Czarkowski (@paulczar)

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

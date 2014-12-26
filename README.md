Kibana Library Cookbook
===============

A library cookbook for installing kibana 4.

If you wish to install Kibana3 try using the '1.3.x' releases of the cookbook.

This is a library cookbook,  you can use you included `kibana_lwrp::install` recipe to install kibana, but it is more likely to be really useful for you to call the LWRPs directly from your own cookbook.  You can use the `kibana_lwrp::install` recipe as a guide and customize to your needs. 

This cookbook is tested and works well with the `logstash` and the `elasticsearch` cookbooks found on the chef community site.

Attributes
----------
As with most cookbooks I write, this one is hopefully flexible enough to be wrapped by allowing you to override as much as possible

See `attributes/*.rb` for attributes ( documented inline )

Usage
-----
#### kibana_lwrp::default

The default recipe does nothing except for allow access to the LWRPs.

#### kibana_lwrp::install

This is designed to be an example recipe to show you how you might write a wrapper cookbook.   However it should be usable for a 
simple install of kibana.

- install kibana4 `/opt/kibana/XXXX` and create a symlink called `current` in the same directory.
- install `nginx` and serve the kibana application

If you wish to swap `apache` for `nginx`, simply set `node['kibana']['webserver']` to `apache` in a role/environment/node somewhere.

If you don't want this cookbook to handle the webserver config simply set `node['kibana']['webserver']` to `''` in a role/environment/node somewhere.
Please note that in this case you have to set `node['kibana']['user']`.

Both cookbooks, by default, will configure the appropriate proxy to your ElasticSearch server such that you don't have to expose it to the world.

**NOTE**
There is **NO** security enabled by default on any of the content being served.
If you would like to modify the `nginx` or `apache` parameters, you should:

- create your own cookbook i.e. `my-kibana`
- copy the template for the webserver you wish to use to your cookbook
- modify the template as you see fit (add auth, setup ssl)
- use the appropriate webserver template attributes to point to your cookbook and template

#### kibana::examples

examples of using the LWRPs.  Don't use this directly.

Testing
-------
#### kitchen


```
$ bundle install
$ bundle exec berks install
$ bundle exec rake style spec # spec and style checks
$ bundle exec rake kitchen # integration testing
```


Contributing
------------
- Fork the repository on Github
- Create a named feature branch (like `add_component_x`)
- Write you change
- Write tests for your change (if applicable)
- Run the tests, ensuring they all pass
-- `bundle exec strainer test`
- Submit a Pull Request using Github

License and Authors
-------------------
Primary authors:

- John E. Vincent <lusis.org+github.com@gmail.com>
- Paul Czarkowski <username.taken@gmail.com>

Contributors:

- Jeff Hubbard (@lord2800)
- @mouadino
- Ben P (@benwtr)
- Chris Ferry (@chrisferry)
- Ian Neubert (@ianneub)
- kellam (@klamontagne)

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

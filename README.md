kibana Cookbook
===============

A stand-alone cookbook for Kibana3.

This is a library cookbook,  you can use you included `kibana::install` recipe to install kibana, or you can call the LWRPs directly.

If you are upgrading from the previous (< 1.3) cookbook you can set `node['kibana']['legacy_mode'] = true` which should continue working.   This will be removed at some point and you'll be expected to use it as a library cookbook.

This cookbook is tested and works well with the `logstash` and the `elasticsearch` cookbooks found on the chef community site.

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

See `attributes/*.rb` for attributes ( documented inline )

Usage
-----
#### kibana::default

The default recipe does nothing except for allow access to the LWRPs unless `legacy_mode` is turned on in which case it attempts to install kibana
in the old fashioned way.

#### kibana::install

This is designed to be an example recipe to show you how you might write a wrapper cookbook.   However it should be usable for a 
simple install of kibana.

- install kibana3 from `master` into `/opt/kibana/master` and create a symlink called `current` in the same directory to `master`
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

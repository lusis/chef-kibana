# CHANGELOG for kibana

This file is used to list changes made in each version of kibana.

## 2.0.4
* fix tests
* support kibana 4 official

## 2.0.2
* revert use inline resources

## 2.0.0
* change cookbook name to kibana_lwrp
* support kibana 4 beta

## 1.4.1
* bugfix - could not update kibana because of remote_file name

## 1.4.0
* initial support for kibana4
* removed support for kibana3 ( use 1.3.x releases )

## 1.3.2:
* mostly bugfixes

## 1.3.0:
* big rewrite to act as library cookbook.
* not sure if it will be backwards compat yet.

## 1.2.1:
* proxy backend healthcheck
* update proxy templates to match kibana master
* changed config.js template to pull from attributes

## 1.2.0:

* Add ability to choose install type of either git repo or zipfile
* Add web_dir attribute to handle kibana location for different install types
* Add attributes for http scheme for both webserver and es, helpful if they're managed outside of this cookbook.
* Some Attribute namespace cleanup,  read through carefully if upgrading.
?????? * Update config.js to newer format

## 1.1.5

* Added Strainer test suite
* Allow installing kibana without a webserver
* Boolean Attribute kibana['git']['checkout'] to allow default git behavior to be checkout rather than sync.


## 1.1.4

* Update configuration to use proxy_pass setup by cookbook

## 1.1.3

* Rename dist to src symlink as per latest kibana folder structure change

## 1.1.2

* Update config.js.erb to be the same as the new config.js source from kibana

## 1.1.1

* Fixed previous symlink of whole repository, now it only symlinks the dist directory

## 1.1.0

* Changed paths in default recipe for kibana source to the new kibana directory structure

## 1.0.0:

* Initial release of kibana



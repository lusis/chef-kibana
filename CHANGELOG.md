# CHANGELOG for kibana

This file is used to list changes made in each version of kibana.

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



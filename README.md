# chef-radicale

[![Build Status](https://travis-ci.org/cmur2/chef-radicale.png)](https://travis-ci.org/cmur2/chef-radicale)

## Description

Installs [Radicale](http://radicale.org/) (a complete CalDAV and CardDAV server) via pip (and therefore python and pip) and configures it from `node['radicale']`.

## Usage

Use `recipe[radicale::default]` for installing and configuring Radicale including a Debian init script and logging setup. The default configuration with no attributes set should produce a running Radicale. Advanced setups with authentication and custom rules are supported as well as logrotate support.

No support for SSL key and cert handling yet, use a proxy or write an issue.

No support for installing [additionally needed modules](http://radicale.org/user_documentation/#idid50) yet.

## Requirements

### Platform

It should work on all systems providing Python and pip.

For supported Chef/Ruby version see [Travis](https://travis-ci.org/cmur2/chef-radicale).

## Recipes

### default

The Radicale [main configuration](http://radicale.org/user_documentation/#idid39) will be generated to INI format from `node['radicale']['config']` and ships with settings for an example server that *you should change* for production use.

The Radicale [authentication configuration](http://radicale.org/user_documentation/#idid44) happens in the `[auth]` section of the main configuration and is transformed in the same manner. *Special feature*: if you specify a username->password or username->passwordhash mapping in ´node['radicale']['users']´ a htpasswd file will automatically be created at `node['radicale']['config']['auth']['htpasswd_filename']` (which defaults to /opt/radicale/users) containing those. You have to declare at least one user for this file to be created.

The Radicale [rights configuration](http://radicale.org/user_documentation/#idid45) happens in the `[rights]` section of the main configuration and is transformed in the same manner. *Special feature*: if you specify a hash with the necessary [rights information](http://radicale.org/user_documentation/#idid45) a rights file will automatically be created at `node['radicale']['config']['rights']['file']` (which defaults to /opt/radicale/rights) containing those. You have to declare at least one rights section for this file to be created.

The Radicale [logging configuration](http://radicale.org/user_documentation/#idid40) will be generated to INI format from `node['radicale']['logging']` and ships with sane production settings that *you should not change*. These default settings are required for logrotate support.

### logrotate

Adds a Radicale specific logrotate configuration when logrotate cookbook is found. No attributes needed.

## Example configuration

*todo*

## License

chef-radicale is licensed under the Apache License, Version 2.0. See LICENSE for more information.

Vagrant config
==============

Just a bunch of configs I find useful.

#### symfony3-php7

Name says it all: Ubuntu based LAMP stack, with PHP7. Added scripts for composer installation and Symfony deployment.

#### lamp-php7

Ubuntu based LAMP, with PHP7

#### lamp

Ubuntu based regular LAMP stack




XDEBUG SETUP
============

NetBeans
--------

1. Go to: Project > Run Configuration > Advanced

2. Set Debug URL to Default (same as project URL on "run configuration")

3. Path mapping: map server path (path on virtual machine) to project folder on
host computer. With Vagrant, server path: /vagrant, project path: { absolute path to NetBeans project }

Virtual Machine
---------------

Key settings for XDebug in php.ini:

* xdebug.remote_enable = 1
* xdebug.remote_connect_back = 1

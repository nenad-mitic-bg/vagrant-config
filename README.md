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
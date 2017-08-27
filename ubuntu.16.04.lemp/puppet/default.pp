
exec {'apt-update':
    command => '/usr/bin/sudo /usr/bin/apt update'
}

package {['nginx', 'php7.0', 'php7.0-mysql', 'php7.0-gd', 'php7.0-bz2', 'php7.0-xml', 'php7.0-cli', 'php7.0-phpdbg', 'php7.0-common', 'php7.0-intl', 'php7.0-curl', 'php7.0-json', 'php7.0-readline', 'php7.0-zip', 'php7.0-mbstring', 'php7.0-mcrypt', 'php-xdebug', 'php-common', 'php-fpm']:
    ensure => latest,
    require => Exec['apt-update']
}

package {'mysql-server':
    ensure => latest,
    require => Exec['apt-update']
}

package {'git':
    ensure => latest
}

service {'mysql':
  ensure => running,
  require => Package['mysql-server']
}

#file {'phpconf-apache':
#    path => '/etc/php/7.0/apache2/php.ini',
#    source => '/vagrant/puppet/assets/php7-apache.ini',
#    notify => Service['apache2'],
#    require => Package['php7.0', 'apache2', 'libapache2-mod-php7.0']
#}

file {'phpconf-cli':
    path => '/etc/php/7.0/cli/php.ini',
    source => '/vagrant/puppet/assets/php7-cli.ini',
    require => Package['php7.0-cli']
}

#exec {'apache-mod-rewrite':
#    command => '/usr/sbin/a2enmod rewrite',
#    notify => Service['apache2'],
#    require => Package['apache2']
#}

exec {'create-db':
    command => '/usr/bin/mysql -u root < /vagrant/puppet/assets/database.sql',
    require => [Package['mysql-server'], Service['mysql']]
}

#exec {'apache-disable-default-site':
#    command => '/usr/sbin/a2dissite 000-default',
#    notify => Service['apache2'],
#    require => Package['apache2']
#}

#file {'apache-dev-site':
#    path => '/etc/apache2/sites-enabled/dev.conf',
#    source => '/vagrant/puppet/assets/apache-dev.conf',
#    notify => Service['apache2'],
#    require => Package['apache2']
#}

#exec {'phpmyadmin-fetch':
#    command => '/usr/bin/wget -q https://files.phpmyadmin.net/phpMyAdmin/4.6.5.2/phpMyAdmin-4.6.5.2-all-languages.tar.gz',
#    creates => '/home/vagrant/phpMyAdmin-4.6.5.2-all-languages.tar.gz'
#}

#exec {'phpmyadmin-extract':
#    command => '/bin/tar -zxvf phpMyAdmin-4.6.5.2-all-languages.tar.gz && /bin/mv phpMyAdmin-4.6.5.2-all-languages phpmyadmin',
#    creates => '/home/vagrant/phpmyadmin',
#    require => Exec['phpmyadmin-fetch']
#}

#file {'phpmyadmin-conf':
#    path => '/home/ubuntu/phpmyadmin/config.inc.php',
#    source => '/vagrant/puppet/assets/phpmyadmin-config.inc.php',
#    require => Exec['phpmyadmin-extract']
#}

#file {'apache-phpmyadmin':
#    path => '/etc/apache2/conf-enabled/phpmyadmin.conf',
#    source => '/vagrant/puppet/assets/apache-phpmyadmin.conf',
#    notify => Service['apache2'],
#    require => Package['apache2']
#}

exec {'swap-setup':
    command => '/usr/bin/sudo /bin/sh /vagrant/puppet/assets/swap.sh'
}
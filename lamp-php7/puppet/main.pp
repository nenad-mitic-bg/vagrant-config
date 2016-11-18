
package {'dos2unix':
    ensure => latest
}

file {'assets':
    path => '/home/vagrant/assets',
    ensure => directory,
    recurse => true,
    source => '/vagrant/puppet/assets'
}

exec {'prepare-assets':
    command => '/usr/bin/dos2unix /home/vagrant/assets/*',
    require => [File['assets'], Package['dos2unix']]
}

exec {'group-add-adm':
    command => '/usr/bin/sudo /usr/sbin/usermod -a -G adm vagrant'
}

exec {'php7-repo':
    command => '/usr/bin/sudo /usr/bin/add-apt-repository -y ppa:ondrej/php && /usr/bin/sudo /usr/bin/apt-get update'
}

exec {'apt-update':
    command => '/usr/bin/sudo /usr/bin/apt-get update'
}

package {['php7.0', 'php7.0-apcu', 'php7.0-cli', 'php7.0-common', 'php7.0-curl', 'php7.0-gd', 'php7.0-imagick', 'php7.0-intl', 'php7.0-json', 'php7.0-mbstring', 'php7.0-mcrypt', 'php7.0-mysql', 'php7.0-sqlite', 'php7.0-xdebug', 'php7.0-xml', 'php7.0-zip']:
    ensure => latest,
    require => Exec['php7-repo']
}

package {'apache2':
    ensure => latest,
    require => Package['php7.0']
}

package {'libapache2-mod-php7.0':
    ensure => latest,
    require => [Package['apache2'], Package['php7.0']]
}

package {'mysql-server':
    ensure => latest,
    require => Exec['apt-update']
}

package {'git':
    ensure => latest
}

service {'apache2':
  ensure => running,
  require => Package['apache2']
}

service {'mysql':
  ensure => running,
  require => Package['mysql-server']
}

file {'apache-envvars':
    path => '/etc/apache2/envvars',
    source => '/home/vagrant/assets/apache2-envvars',
    notify => Service['apache2'],
    require => [Package['apache2'], Exec['prepare-assets']]
}

file {'php7-apache':
    path => '/etc/php/7.0/apache2/php.ini',
    source => '/home/vagrant/assets/php7-apache.ini',
    notify => Service['apache2'],
    require => [Package['php7.0'], Exec['prepare-assets']]
}

file {'php7-cli':
    path => '/etc/php/7.0/cli/php.ini',
    source => '/home/vagrant/assets/php7-cli.ini',
    require => [Package['php7.0-cli'], Exec['prepare-assets']]
}

exec {'apache-mod-rewrite':
    command => '/usr/sbin/a2enmod rewrite',
    notify => Service['apache2'],
    require => Package['apache2']
}

exec {'create-db':
    command => '/usr/bin/mysql -u root < /home/vagrant/assets/database.sql',
    require => [Package['mysql-server'], Service['mysql'], Exec['prepare-assets']]
}

exec {'apache-disable-default-site':
    command => '/usr/sbin/a2dissite 000-default',
    notify => Service['apache2'],
    require => Package['apache2']
}

file {'apache-dev-site':
    path => '/etc/apache2/sites-enabled/dev.conf',
    source => '/home/vagrant/assets/apache-dev.conf',
    notify => Service['apache2'],
    require => [Package['apache2'], Exec['prepare-assets']]
}

exec {'phpmyadmin-fetch':
    command => '/usr/bin/wget -q https://files.phpmyadmin.net/phpMyAdmin/4.6.3/phpMyAdmin-4.6.3-all-languages.tar.gz',
    creates => '/home/vagrant/phpMyAdmin-4.6.3-all-languages.tar.gz'
}

exec {'phpmyadmin-extract':
    command => '/bin/tar -zxvf phpMyAdmin-4.6.3-all-languages.tar.gz',
    creates => '/home/vagrant/phpMyAdmin-4.6.3-all-languages',
    require => Exec['phpmyadmin-fetch']
}

file {'phpmyadmin-conf':
    path => '/home/vagrant/phpMyAdmin-4.6.3-all-languages/config.inc.php',
    source => '/home/vagrant/assets/phpmyadmin-config.inc.php',
    require => [Exec['phpmyadmin-extract'], Exec['prepare-assets']]
}

file {'apache-phpmyadmin':
    path => '/etc/apache2/conf-enabled/phpmyadmin.conf',
    source => '/home/vagrant/assets/apache-phpmyadmin.conf',
    notify => Service['apache2'],
    require => [Package['apache2'], Exec['prepare-assets']]
}

exec {'swap-setup':
    command => '/usr/bin/sudo /bin/sh /home/vagrant/assets/swap.sh',
    require => Exec['prepare-assets']
}

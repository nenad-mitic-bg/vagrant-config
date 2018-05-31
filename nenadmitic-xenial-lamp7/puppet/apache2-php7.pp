
exec {'apt-update':
    command => '/usr/bin/sudo /usr/bin/apt-get update'
}

package {'git':
    ensure => latest
}

service {'apache2':
  ensure => running
}

service {'mysql':
  ensure => running
}

exec {'apache-mod-rewrite':
    command => '/usr/sbin/a2enmod rewrite',
    notify => Service['apache2']
}

exec {'create-db':
    command => '/usr/bin/mysql -u root < /vagrant/puppet/assets/symfony.sql',
    require => Service['mysql']
}

exec {'apache-disable-default-site':
    command => '/usr/sbin/a2dissite 000-default',
    notify => Service['apache2']
}

file {'apache-sf-site':
    path => '/etc/apache2/sites-enabled/sf.conf',
    source => '/vagrant/puppet/assets/apache-sf.conf',
    notify => Service['apache2']
}

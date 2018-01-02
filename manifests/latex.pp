File { owner => 0, group => 0, mode => 0644 }

group {'sudo':
 ensure => present,
}

file { '/etc/motd':
 content => "Welcome to the orpsoc2 DSL hacking VM.\nProvisioned by Martin Schulze.\n"
}

exec { 'apt-get update' :
  command => '/usr/bin/apt-get update'
}

Exec[ 'apt-get update' ] -> Package <| |>

Package {
  ensure => latest
}

user {'martin':
 comment    => 'Martin Schulze',
 ensure     => present,
 home       => '/home/martin',
 shell      => '/bin/bash',
 groups     => ['sudo'],
 managehome => true,
 password   => '',
}

file { '/home/martin/Desktop':
 ensure  => directory,
 owner   => 'martin',
 group   => 'martin',
 mode    => '0755',
 require => User['martin'], 
}

file { '/home/martin/Desktop/texstudio.desktop':
 ensure  => present,
 source  => '/usr/share/applications/texstudio.desktop',
 owner   => 'martin',
 group   => 'martin',
 mode    => '0755',
 require => [ User['martin'], File['/home/martin/Desktop'], Package['texstudio'], ],
}

file { '/home/martin/Desktop/commands.txt':
 ensure  => present,
 source  => '/vagrant/data/commands.txt',
 owner   => 'martin',
 group   => 'martin',
 mode    => '0644',
 require => [ User['martin'], File['/home/martin/Desktop'], ],
}

file { '/home/martin/.ssh':
 ensure  => directory,
 require => User['martin'],
 owner   => 'martin',
 group   => 'martin',
 mode    => '0755',
}

#file { '/home/martin/.ssh/id_rsa':
# ensure  => present,
# require => File['/home/martin/.ssh'],
# source  => '/vagrant/data/id_rsa',
# owner   => 'martin',
# group   => 'martin',
# mode    => '0600',
#}

#file { '/home/martin/.ssh/id_rsa.pub':
# ensure  => present,
# require => File['/home/martin/.ssh'],
# source  => '/vagrant/data/id_rsa.pub',
# owner   => 'martin',
# group   => 'martin',
# mode    => '0600',
#}

#file { '/home/martin/.ssh/config':
# ensure  => present,
# require => File['/home/martin/.ssh'],
# source  => '/vagrant/data/config',
# owner   => 'martin',
# group   => 'martin',
# mode    => '0600',
#}

# Packages:
package { 'openjdk-8-jdk':
 ensure => installed,
}

package { 'git':
 ensure => present,
}

package { 'subversion' :
 ensure   => latest,
}

# Fixes for Ubuntu 16.04:
package { 'ibus':
 ensure => purged,
}

exec { "/bin/echo '\nunset SSH_AUTH_SOCK' >> '/home/martin/.bashrc'":
 unless  => "/bin/grep -qFx 'unset SSH_AUTH_SOCK' '/home/martin/.bashrc'",
 require => [ User['martin'], ],
}

# Localization:  
package { 'language-pack-de':
 ensure => present,
 require => File[ '/home/martin/Desktop/texstudio.desktop' ],
}

package {'language-pack-gnome-de':
 ensure => present,
 require => File[ '/home/martin/Desktop/texstudio.desktop' ],
}

file { '/etc/default/locale':
 ensure  => present,
 content => "LANG=\"de_DE.UTF-8\"\n",
 require => File[ '/home/martin/Desktop/texstudio.desktop' ],
}

class { 'timezone':
 timezone => 'Europe/Berlin',
 ensure   => present,
}

file { '/etc/default/keyboard' :
 ensure  => present,
 content => "XKBMODEL=\"pc105\"\nXKBLAYOUT=\"de\"\nXKBVARIANT=\"nodeadkeys\"\nXKBOPTIONS=\"\"\n",
 
}

# LaTeX:
package { 'texstudio' :
 ensure   => latest,
 require => Package[ 'texlive-full' ],
}

package { 'texlive-full' :
 ensure => present,
}

package { 'python-pygments' :
 ensure => latest,
}
package { 'jabref' : 
 ensure => latest,
}

augeas { 'augeas_test' :
 context => '/files/etc/default/apport',
 changes => 'set enabled 0',
}

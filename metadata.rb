name 'pnp4nagios'
maintainer 'Bigpoint GmbH'
maintainer_email 'sebgrewe@bigpoint.net'
license 'Apache 2.0'
description 'Install and configures pnp4nagios for Icinga/Nagios'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           "0.2.0"

recipe 'rrdcached', 'Install and configures a simple default rrdcache installation.'
recipe 'rrdcached::_dependencies', 'Installs required software.'
recipe 'rrdcached::_install_rhel', 'Installs pnp4nagios on RHEL based systems.'
recipe 'rrdcached::_install_debian', 'Installs pnp4nagios on Debian based systems.'
recipe 'rrdcached::_add_repositories_rhel', 'Installs pnp4nagios on RHEL based systems.'
recipe 'rrdcached::_add_repositories_debian', 'Installs pnp4nagios on Debian based systems.'
recipe 'rrdcached::_configure', 'Configures pnp4nagios for both RHEL and Debian.'

supports 'rhel'
supports 'centos'
supports 'debian'

# Default settings used in configuration options below
attribute 'pnp4nagios/version',
  :display_name => 'pnp4nagios version',
  :description => 'Version to be installed, only used for Debian backports right now.',
  :default => '0.6.19-1~debmon60+2'

attribute 'pnp4nagios/config/rrdbase',
  :display_name => 'pnp4nagios Perfdata Path',
  :description => 'Base path where pnp4nagios will place performance data rrd graphs.',
  :default => '/var/lib/pnp4nagios/perfdata/'

attribute 'pnp4nagios/htpasswd/file',
  :display_name => 'pnp4nagios authentication',
  :description => 'htpasswd file used by pnp4nagios virtual host for authentication.',
  :default => '/etc/pnp4nagios/htpasswd.users'

attribute 'pnp4nagios/setup',
  :display_name => 'pnp4nagios default setup',
  :description => 'Various configuration settings, please see attributes file for details.',
  :default => 'See attributes file.'

depends 'apt'
depends 'apt'
depends 'apt'
depends 'yum'
depends 'yum-epel'
depends 'apache2'

suggests 'icinga'

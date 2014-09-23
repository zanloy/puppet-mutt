# == Class: mutt
#
# Full description of class mutt here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { mutt:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Zan Loy <zan.loy@gmail.com>
#
# === Copyright
#
# Copyright 2014 Zan Loy
#
class mutt (
  $hostname         = undef,
  $folder           = $mutt::params::folder,
  $mbox             = $mutt::params::mbox,
  $mbox_type        = $mutt::params::mbox_type,
  $alias_file       = $mutt::params::alias_file,
  $certificate_file = $mutt::params::certificate_file,
  $delete           = $mutt::params::delete,
  $history_file     = $mutt::params::history_file,
  $package          = $mutt::params::package,
  $config_file      = $mutt::params::config_file,
) inherits mutt::params {

  package { $package:
    ensure => present,
  }

  file { $config_file:
    ensure => file,
    owner => 'root',
    group => 'root',
    mode => '0644',
  }

  define setline {
    $key = $name
    $regex = "^${key}"

    file_line { "${key}_line":
      path => $path,
      line => "${key} ${value}",
      match => $regex,
    }
  }

  $options = {
    'alias_file' => { value => $alias_file },
  }
  $defaults = {
    path => $config_file,
  }
  create_resources(setline, $options, $defaults)

  ## Puppet rides on ruby but can't handle ruby .each blocks... shameful.
  #setline { $config_file:
  #  key => 'alias_file',
  #  value => $alias_file
  #}

}

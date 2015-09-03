# View README.md for full documentation
#
# === Authors
#
# Zan Loy <zan.loy@gmail.com>
#
# === Copyright
#
# Copyright 2014
#
class mutt (
  $alias_file       = $mutt::params::alias_file,
  $certificate_file = $mutt::params::certificate_file,
  $config_file      = $mutt::params::config_file,
  $date_format      = $mutt::params::date_format,
  $delete           = $mutt::params::delete,
  $folder           = $mutt::params::folder,
  $history_file     = $mutt::params::history_file,
  $hostname         = undef,
  $index_format     = $mutt::params::index_format,
  $mbox             = $mutt::params::mbox,
  $mbox_type        = $mutt::params::mbox_type,
  $package          = $mutt::params::package,
  $sidebar          = $mutt::params::sidebar,
) inherits mutt::params {

  # Parameter validation
  if is_bool($sidebar) == false { fail('sidebar must be a boolean') }

  package { $package:
    ensure => present,
  }

  file { $config_file:
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Package[$package],
  }

  $options = {
    'alias_file' => {
      line => "set alias_file=${alias_file}",
      match => 'set alias_file=.*',
    },
    'certificate_file' => {
      line => "set certificate_file=${certificate_file}",
      match => 'set certificate_file=.*',
    },
    'date_format' => {
      line => "set date_format=\"${date_format}\"",
      match => 'set date_format=.*',
    },
    'delete' => {
      line => "set delete=${delete}",
      match => 'set delete=.*',
    },
    'folder' => {
      line => "set folder=${folder}",
      match => 'set folder=.*',
    },
    'history_file' => {
      line => "set history_file=${history_file}",
      match => 'set history_file=.*',
    },
    'index_format' => {
      line => "set index_format=\"${index_format}\"",
      match => 'set index_format=.*',
    },
    'mbox' => {
      line => "set mbox=${mbox}",
      match => 'set mbox=.*',
    },
    'mbox_type' => {
      line => "set mbox_type=${mbox_type}",
      match => 'set mbox_type=.*',
    },
  }

  create_resources(file_line, $options, { 'path' => $config_file, 'require' => File[$config_file] })

  if $hostname != undef {
    file_line { 'hostname':
      path    => $config_file,
      line    => "set hostname=${hostname}",
      match   => 'set hostname=.*',
      require => File[$config_file],
    }
  }

  if $package == 'mutt-patched' and $sidebar == false {
    file_line { 'sidebar':
      path => $config_file,
      line => 'set sidebar_visible=no',
      match => 'set sidebar_visible=.*',
      require => File[$config_file],
    }
  }
}

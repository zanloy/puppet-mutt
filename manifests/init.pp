# == Class: mutt
#
# Installs and configures mutt email client.
#
# === Parameters
#
# [*alias_file*]
#   String. Location of your alias file.
#   Default: '~/.mutt/muttrc'
#
# [*certificate_file*]
#   String. Location of your ca certificates file.
#   Default: '~/.mutt/certificates'
#
# [*config_file*]
#   String. Location of your global mutt config file.
#   Note: Do not change this unless mutt has been compiled to look for the
#         config file elsewhere. Otherwise it just won't read the config
#         at all.
#   Default: '/etc/Muttrc'
#
# [*date_format*]
#   String. Date format to use. Takes standard printf style arguments.
#   Default: If undef then we use the package defaults.
#
# [*delete*]
#   String. What mutt will do when deleting files on exit.
#   Default: 'ask-yes'
#   Valid Options: 'no', 'yes', 'ask-yes'
#
# [*folder*]
#   String. The location of your mbox (or maildir) folder. Should be in home.
#   Default: '~/mail'
#
# [*history_file*]
#   String. The location of your history file.
#   Default: '~/.mutt/history'
#
# [*hostname*]
#   String. The hostname to use in From: in emails sent with mutt.
#   Default: If undef then mutt uses your hostname (not fqdn).
#
# [*index_format*]
#   String. The printf style format for displaying email information in the
#           mailbox view.
#   Default: If undef then we use mutt default.
#
# [*mbox*]
#   String. The location of your mbox.
#   Note: This should be the same as your $folder in 90% of cases.
#   Default: $folder
#
# [*mbox_type*]
#   String. The method of saving your emails to the disk.
#   Note: http://www.linuxmail.info/mbox-maildir-mail-storage-formats/
#   Default: mbox
#
# [*package*]
#   String. The name of the mutt package to install.
#   Default: mutt
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
  $alias_file       = 'UNSET',
  $certificate_file = 'UNSET',
  $config_file      = 'UNSET',
  $date_format      = 'UNSET',
  $delete           = 'UNSET',
  $folder           = 'UNSET',
  $history_file     = 'UNSET',
  $hostname         = 'UNSET',
  $index_format     = 'UNSET',
  $mbox             = 'UNSET',
  $mbox_type        = 'UNSET',
  $package          = 'UNSET',
) {

  include mutt::params

  $alias_file_real = $alias_file ? {
    'UNSET' => $mutt::params::alias_file,
    default => $alias_file,
  }

  $certificate_file_real = $certificate_file ? {
    'UNSET' => $mutt::params::certificate_file,
    default => $certificate_file,
  }

  $config_file_real = $config_file ? {
    'UNSET' => $mutt::params::config_file,
    default => $config_file,
  }

  $date_format_real = $date_format ? {
    'UNSET' => $mutt::params::date_format,
    default => $date_format,
  }

  $delete_real = $delete ? {
    'UNSET' => $mutt::params::delete,
    default => $delete,
  }

  $folder_real = $folder ? {
    'UNSET' => $mutt::params::folder,
    default => $folder,
  }

  $history_file_real = $history_file ? {
    'UNSET' => $mutt::params::history_file,
    default => $history_file,
  }

  $hostname_real = $hostname ? {
    'UNSET' => undef,
    default => $hostname,
  }

  $index_format_real = $index_format ? {
    'UNSET' => $mutt::params::index_format,
    default => $index_format,
  }

  $mbox_real = $mbox ? {
    'UNSET' => $mutt::params::mbox,
    default => $mbox,
  }

  $mbox_type_real = $mbox_type ? {
    'UNSET' => $mutt::params::mbox_type,
    default => $mbox_type,
  }

  $package_real = $package ? {
    'UNSET' => $mutt::params::package,
    default => $package,
  }

  # END VARIABLE PARSING

  package { $package_real:
    ensure => present,
  }

  file { $config_file_real:
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Package[$package_real],
  }

  $options = {
    'alias_file' => {
      line => "set alias_file=${alias_file_real}",
      match => 'set alias_file=.*',
    },
    'certificate_file' => {
      line => "set certificate_file=${certificate_file_real}",
      match => 'set certificate_file=.*',
    },
    'date_format' => {
      line => "set date_format=${date_format_real}",
      match => 'set date_format=.*',
    },
    'delete' => {
      line => "set delete=${delete_real}",
      match => 'set delete=.*',
    },
    'folder' => {
      line => "set folder=${folder_real}",
      match => 'set folder=.*',
    },
    'history_file' => {
      line => "set history_file=${history_file_real}",
      match => 'set history_file=.*',
    },
    'index_format' => {
      line => "set index_format=${index_format_real}",
      match => 'set index_format=.*',
    },
    'mbox' => {
      line => "set mbox=${mbox_real}",
      match => 'set mbox=.*',
    },
    'mbox_type' => {
      line => "set mbox_type=${mbox_type_real}",
      match => 'set mbox_type=.*',
    },
  }

  create_resources(file_line, $options, { 'path' => $config_file_real })

  if $hostname_real != undef {
    file_line { 'hostname':
      path  => $config_file_real,
      line  => "set hostname=${hostname_real}",
      match => 'set hostname=.*',
    }
  }
}

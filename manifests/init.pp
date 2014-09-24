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
  $alias_file       = $mutt::params::alias_file,
  $certificate_file = $mutt::params::certificate_file,
  $config_file      = $mutt::params::config_file,
  $date_format      = undef,
  $delete           = $mutt::params::delete,
  $folder           = $mutt::params::folder,
  $history_file     = $mutt::params::history_file,
  $hostname         = undef,
  $index_format     = undef,
  $mbox             = $mutt::params::mbox,
  $mbox_type        = $mutt::params::mbox_type,
  $package          = $mutt::params::package,
) inherits mutt::params {

  package { $package:
    ensure => present,
  }

  file { $config_file:
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => 0644,
    require => Package[$package],
  }

  define setline ($path, $key=$name, $value) {
    $regex = "^set ${key}="

    if $value {
      file_line { "${key}_line":
        path => $path,
        line => "set ${key}='${value}'",
        match => $regex,
      }
    }
  }

  $options = {
    'alias_file'        => { value => $alias_file },
    'certificate_file'  => { value => $certificate_file },
    'date_format'       => { value => $date_format },
    'delete'            => { value => $delete },
    'folder'            => { value => $folder },
    'history_file'      => { value => $history_file },
    'hostname'          => { value => $hostname },
    'index_format'      => { value => $index_format },
    'mbox'              => { value => $mbox },
    'mbox_type'         => { value => $mbox_type },
  }

  create_resources(setline, $options, { 'path' => $config_file })

}

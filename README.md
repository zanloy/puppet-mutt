# puppet-mutt [![Build Status](https://travis-ci.org/zanloy/puppet-mutt.svg?branch=master)](https://travis-ci.org/zanloy/puppet-mutt)

#### Table of Contents

1. [Overview](#overview)
2. [Usage](#usage)
3. [Parameters](#parameters)
4. [Reference](#reference)
5. [Limitations](#limitations)

## Overview

This module installs and configure mutt email client.

## Usage

Simple installation with default options:

```
include ::mutt
```

Using maildir in ~/.maildir

```
class { 'mutt':
  folder => '~/.maildir',
  mbox_type => 'maildir',
}
```

Using system CA files for signature verification:

```
class { 'mutt':
  certificate_file => '/etc/certs'
}
```

## Parameters

* alias_file
  * String. Location of your alias file.
  * Default: '~/.mutt/muttrc'

* certificate_file
  * String. Location of your ca certificates file.
  * Default: '~/.mutt/certificates'

* config_file
  * String. Location of your global mutt config file.
  * Note: Do not change this unless mutt has been compiled to look for the
          config file elsewhere. Otherwise it just will not read the config
          file at all.
  * Default: '/etc/Muttrc'

* date_format
  * String. Date format to use. Takes standard printf style arguments.
  * Default: If undef then we use the package defaults.

* delete
  * String. What mutt will do when deleting files on exit.
  * Default: 'ask-yes'
  * Valid Options: 'no', 'yes', 'ask-yes'

* folder
  * String. The location of your mbox (or maildir) folder. Should be in home.
  * Default: '~/mail'

* history_file
  * String. The location of your history file.
  * Default: '~/.mutt/history'

* hostname
  * String. The hostname to use in From: in emails sent with mutt.
  * Default: If undef then mutt uses your hostname (not fqdn).

* index_format
  * String. The printf style format for displaying email information in the
    mailbox view.
  * Default: If undef then we use mutt default.

* mbox
  * String. The location of your mbox.
  * Note: This should be the same as your $folder in 90% of cases.
  * Default: $folder

* mbox_type
  * String. The method of saving your emails to the disk.
  * Note: http://www.linuxmail.info/mbox-maildir-mail-storage-formats/
  * Default: mbox

* package
  * String. The name of the mutt package to install.
  * Default: mutt

## Reference

Defines only two resources: Package['mutt'] and File['/etc/Muttrc'].

## Limitations

This has been tested on RHEL 6.5 and Ubuntu 14.04 and has been found to work.

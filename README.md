# mutt

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)

## Overview

This module installs and configure mutt email client.

## Usage

Simple installation with default options:

    include mutt

Using maildir in ~/.maildir

    class { 'mutt':
      folder => '~/.maildir',
      mbox_type => 'maildir',
    }

Using system CA files for signature verification:

    class { 'mutt':
      certificate_file => '/etc/certs'
    }

## Reference

Defines only two resources: Package['mutt'] and File['/etc/Muttrc'].

## Limitations

This has been tested on RHEL 6.5 and Ubuntu 14.04 and has been found to work.

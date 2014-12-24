# This class contains the default values for class::mutt
class mutt::params {

  $alias_file = '~/.mutt/muttrc'
  $certificate_file = '~/.mutt/certificates'
  $date_format = '!%a, %b %d, %Y at %I:%M:%S%p %Z'
  $delete = 'ask-yes'
  $folder = '~/mail'
  $history_file = '~/.mutt/history'
  $index_format = '%4C %Z %{%b %d} %-15.15L (%4l) %s'
  $mbox = $folder
  $mbox_type = 'mbox'

  # os specific changes?
  $package = 'mutt'
  $config_file = '/etc/Muttrc'

}

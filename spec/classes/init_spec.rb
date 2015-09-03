require 'spec_helper'

osfamilies = {
  'ArchLinux' => { package: 'extra/mutt' },
  'Debian' => { package: 'mutt-patched' },
  'RedHat' => { package: 'mutt' },
}
config_file = '/etc/Muttrc'

describe 'mutt' do
  osfamilies.each do |osfamily, values|
    context "on #{osfamily}" do
      let(:facts) { { osfamily: osfamily } }
      context 'installs mutt package' do
        it { should contain_package(values[:package]) }
      end
      context 'installs config_file with default values' do
        it { should contain_file(config_file)}
        it do
          should contain_file_line('alias_file')
            .with_path(config_file)
            .with_line('set alias_file=~/.mutt/muttrc')
            .that_requires("File[#{config_file}]")
        end
        it do
          should contain_file_line('certificate_file')
            .with_path(config_file)
            .with_line('set certificate_file=~/.mutt/certificates')
            .that_requires("File[#{config_file}]")
        end
        it do
          should contain_file_line('date_format')
            .with_path(config_file)
            .with_line('set date_format="!%a, %b %d, %Y at %I:%M:%S%p %Z"')
            .that_requires("File[#{config_file}]")
        end
        it do
          should contain_file_line('delete')
            .with_path(config_file)
            .with_line('set delete=ask-yes')
            .that_requires("File[#{config_file}]")
        end
        it do
          should contain_file_line('folder')
            .with_path(config_file)
            .with_line('set folder=~/mail')
            .that_requires("File[#{config_file}]")
        end
        it do
          should_not contain_file_line('hostname')
            .with_path(config_file)
            .with_line(/^set hostname=.*$/)
            .that_requires("File[#{config_file}]")
        end
        it do
          should contain_file_line('index_format')
            .with_path(config_file)
            .with_line('set index_format="%4C %Z %{%b %d} %-15.15L (%4l) %s"')
            .that_requires("File[#{config_file}]")
        end
        it do
          should contain_file_line('mbox')
            .with_path(config_file)
            .with_line('set mbox=~/mail')
            .that_requires("File[#{config_file}]")
        end
        it do
          should contain_file_line('mbox_type')
            .with_path(config_file)
            .with_line('set mbox_type=mbox')
            .that_requires("File[#{config_file}]")
        end
      end
      context 'with custom parameters' do
        let(:params) {
          {
            alias_file: '/alias_file',
            certificate_file: '/certificate_file',
            date_format: '!%a',
            delete: 'yes',
            folder: '/mail',
            hostname: 'example',
            index_format: '%4C',
            mbox: '/mail',
            mbox_type: 'maildir'
          }
        }
        it do
          should contain_file_line('alias_file')
            .with_path(config_file)
            .with_line('set alias_file=/alias_file')
            .that_requires("File[#{config_file}]")
        end
        it do
          should contain_file_line('certificate_file')
            .with_path(config_file)
            .with_line('set certificate_file=/certificate_file')
            .that_requires("File[#{config_file}]")
        end
        it do
          should contain_file_line('date_format')
            .with_path(config_file)
            .with_line('set date_format="!%a"')
            .that_requires("File[#{config_file}]")
        end
        it do
          should contain_file_line('delete')
            .with_path(config_file)
            .with_line('set delete=yes')
            .that_requires("File[#{config_file}]")
        end
        it do
          should contain_file_line('folder')
            .with_path(config_file)
            .with_line('set folder=/mail')
            .that_requires("File[#{config_file}]")
        end
        it do
          should contain_file_line('hostname')
            .with_path(config_file)
            .with_line('set hostname=example')
            .that_requires("File[#{config_file}]")
        end
        it do
          should contain_file_line('index_format')
            .with_path(config_file)
            .with_line('set index_format="%4C"')
            .that_requires("File[#{config_file}]")
        end
        it do
          should contain_file_line('mbox')
            .with_path(config_file)
            .with_line('set mbox=/mail')
            .that_requires("File[#{config_file}]")
        end
        it do
          should contain_file_line('mbox_type')
            .with_path(config_file)
            .with_line('set mbox_type=maildir')
            .that_requires("File[#{config_file}]")
        end
      end
      if osfamily == 'Debian'
        context 'removes sidebar' do
          it do
            should contain_file_line('sidebar')
              .with_path(config_file)
              .with_line('set sidebar_visible=no')
              .that_requires("File[#{config_file}]")
          end
        end
      end
    end #context on osfamily
  end #osfamilies.each
end #describe

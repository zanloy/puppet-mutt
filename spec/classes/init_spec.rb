require 'spec_helper'

describe 'mutt' do
  context 'with defaults for all parameters' do
    it { should contain_package('mutt')}
    it { should contain_file('/etc/Muttrc')}
    it do
      should contain_file_line('alias_file')
        .with_line('set alias_file=~/.mutt/muttrc')
    end
    it do
      should contain_file_line('certificate_file')
        .with_line('set certificate_file=~/.mutt/certificates')
    end
    it do
      should contain_file_line('date_format')
        .with_line('set date_format=!%a, %b %d, %Y at %I:%M:%S%p %Z')
    end
    it do
      should contain_file_line('delete')
        .with_line('set delete=ask-yes')
    end
    it do
      should contain_file_line('folder')
        .with_line('set folder=~/mail')
    end
    it do
      should_not contain_file_line('hostname')
        .with_line(/^set hostname=.*$/)
    end
    it do
      should contain_file_line('index_format')
      .with_line('set index_format=%4C %Z %{%b %d} %-15.15L (%4l) %s')
    end
    it do
      should contain_file_line('mbox')
      .with_line('set mbox=~/mail')
    end
    it do
      should contain_file_line('mbox_type')
      .with_line('set mbox_type=mbox')
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
        .with_line('set alias_file=/alias_file')
    end
    it do
      should contain_file_line('certificate_file')
        .with_line('set certificate_file=/certificate_file')
    end
    it do
      should contain_file_line('date_format')
        .with_line('set date_format=!%a')
    end
    it do
      should contain_file_line('delete')
        .with_line('set delete=yes')
    end
    it do
      should contain_file_line('folder')
        .with_line('set folder=/mail')
    end
    it do
      should contain_file_line('hostname')
        .with_line('set hostname=example')
    end
    it do
      should contain_file_line('index_format')
        .with_line('set index_format=%4C')
    end
    it do
      should contain_file_line('mbox')
        .with_line('set mbox=/mail')
    end
    it do
      should contain_file_line('mbox_type')
        .with_line('set mbox_type=maildir')
    end
  end
end

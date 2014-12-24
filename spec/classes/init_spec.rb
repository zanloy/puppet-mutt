require 'spec_helper'

describe 'mutt' do
  context 'with defaults for all parameters' do
    it { should contain_package('mutt')}
    it { should contain_file('/etc/Muttrc')}
  end
end

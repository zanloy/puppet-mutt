require 'spec_helper'
describe 'mutt' do

  context 'with defaults for all parameters' do
    it { should contain_class('mutt') }
  end
end

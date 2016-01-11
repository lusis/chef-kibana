# Encoding: utf-8
require 'spec_helper'

describe 'nginx' do
  describe service('nginx') do
    it { should be_enabled }
    it { should be_running }
  end
  describe port(80) do
    it { should be_listening }
  end
end

describe 'kibana' do
  describe file('/opt/kibana') do
    it { should be_directory }
  end

  describe command('wget -qO- http://localhost:80/app/kibana') do
    its(:stdout) { should match(/the kibana you know and love/) }
  end
end

# Encoding: utf-8
require 'rspec/expectations'
require 'chefspec'
require 'chefspec/berkshelf'
require 'chef/application'

require_relative 'support/matchers'

::LOG_LEVEL = :fatal
::UBUNTU_OPTS = {
  platform: 'ubuntu',
  version: '12.04',
  log_level: ::LOG_LEVEL
}
::CHEFSPEC_OPTS = {
  log_level: ::LOG_LEVEL
}

shared_context 'stubs-common' do
  before do
    Chef::Application.stub(:fatal!).and_return('fatal')
  end
end

shared_examples 'example' do
  #  it 'does not include example recipe by default' do
  #    expect(chef_run).not_to include_recipe('example::default')
  #  end
end

at_exit { ChefSpec::Coverage.report! }

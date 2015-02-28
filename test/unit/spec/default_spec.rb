# Encoding: utf-8

require_relative 'spec_helper'

describe 'kibana_lwrp::default' do
  describe 'ubuntu' do
    let(:runner) { ChefSpec::ServerRunner.new(::UBUNTU_OPTS) }
    let(:node) { runner.node }
    let(:chef_run) do
      # runner.node.set['logstash'] ...
      runner.node.set['kibana']['legacy_mode'] = 'false'
      runner.node.automatic['memory']['total'] = '1024kB'
      runner.converge(described_recipe)
    end
    include_context 'stubs-common'

    it 'literally does nothing because its a lazy no good recipe.' do
    end
  end
end

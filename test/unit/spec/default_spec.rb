# Encoding: utf-8

require_relative 'spec_helper'

describe 'kibana::default' do
  describe 'ubuntu' do
    let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

    it 'literally does nothing because its a lazy no good recipe.' do
    end

  end
end

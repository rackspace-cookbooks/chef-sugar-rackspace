require 'spec_helper'

describe Chef::Sugar::Rackconnect do
  fake_node = {
    'rackspace' => {}
  }

  let(:node)  { fake_node }

  context 'when the ohai plugin is not found' do
    it '#rackconnected? raises an error' do
      expect { described_class.rackconnected?(node) }.to raise_error(RuntimeError)
    end
  end

  context 'when rackconnected' do
    before do
      node['rackspace'] = {
        'rackconnect' => {
          'enabled' => true
        }
      }
    end
    it '#rackconnected? returns true' do
      expect(described_class.rackconnected?(node)).to eq(true)
    end
  end

  context 'when not rackconnected' do
    before do
      node['rackspace'] = {
        'rackconnect' => {
          'enabled' => false
        }
      }
    end
    it '#rackconnected? returns false' do
      expect(described_class.rackconnected?(node)).to eq(false)
    end
  end
end

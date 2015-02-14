require 'spec_helper'

describe Chef::Sugar::IP do

  fake_node = {
    'cloud' => {
      'public_ipv4' => '23.253.110.230',
      'local_ipv4' => '10.208.164.3',
      'provider' => 'rackspace'
    },
    'rackspace' => {},
    'ipaddress' => '23.253.110.230'
  }

  fake_other = {
    'cloud' => {
      'public_ipv4' => '23.253.110.240',
      'local_ipv4' => '10.208.160.3',
      'provider' => 'rackspace'
    },
    'rackspace' => {},
    'ipaddress' => '23.253.110.240'
  }

  let(:node)  { fake_node }
  let(:other) { fake_other }

  context 'when not on a cloud network' do
    it '#best_rackspace_ip_for returns the service net ip address' do
      expect(described_class.best_rackspace_ip_for(node, other)).to eq(other['cloud']['local_ipv4'])
    end

    it '#cloud_network_ip returns empty string' do
      expect(described_class.cloud_network_ip(node)).to eq('')
    end
  end

  context 'when on different cloud networks' do
    before do
      node['rackspace']['private_networks'] = [{
            'ips' => [{ 'ip' => '192.168.10.2' }],
            'label' => 'myprivatenet1'
          }]

      other['rackspace']['private_networks'] = [{
          'ips' => [{ 'ip' => '192.168.12.4' }],
          'label' => 'myprivatenet2'
        }]
    end
    it '#best_rackspace_ip_for returns the service net ip address' do
      expect(described_class.best_rackspace_ip_for(node, other)).to eq(other['cloud']['local_ipv4'])
    end

    it '#cloud_network_ip returns the ip address from the cloud network' do
      expect(described_class.cloud_network_ip(node)).to eq('192.168.10.2')
    end
  end

  context 'when on the same cloud network' do
    before do
      node['rackspace']['private_networks'] = [{
           'ips' => [{ 'ip' => '192.168.10.2' }],
           'label' => 'myprivatenet1'
        }]

      other['rackspace']['private_networks'] = [{
          'ips' => [{ 'ip' => '192.168.10.4' }],
          'label' => 'myprivatenet1'
        }]
    end
    it '#best_rackspace_ip_for returns other\'s cloud network ip address' do
      expect(described_class.best_rackspace_ip_for(node, other)).to eq('192.168.10.4')
    end
  end
end

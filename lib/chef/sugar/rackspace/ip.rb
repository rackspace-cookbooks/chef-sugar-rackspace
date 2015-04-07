require 'chef/sugar'

class Chef
  module Sugar
    module IP
      extend self

      ## Returns the cloud network ip for the node,
      ## if no label is passed and more than one cloud
      ## network is attached it will pop the first off
      ## the array
      def cloud_network_ip(node, label = nil)
        networks = cloud_networks(node)
        return '' if networks.empty?

        net = nil
        if label.nil?
          net = networks[networks.flatten.first]
        else
          net = networks[label]
        end

        ## Return the first ip address in ips
        net['ips'].first['ip']
      end

      def best_rackspace_ip_for(node, other)
        node_clnet = cloud_networks(node)
        fail 'no cloud networks found for this node' if node_clnet.empty?

        other_clnet = cloud_networks(other)
        fail 'no cloud networks found for other node' if other_clnet.empty?

        ip = nil
        node_clnet.each_key do |node_label|
          other_clnet.each_key do |other_label|
            if node_label == other_label
              ip = other_clnet[node_label]['ips'].first['ip']
            end
          end
        end

        # Couldn't locate a matching cloud network, falling through
        fail 'could not locate a matching cloud network' if ip.nil?

        return ip
      rescue
        best_ip_for(node, other)
      end

      def cloud_networks(node)
        networks = {}
        return networks unless node.key? 'rackspace'
        if node['rackspace'].key? 'private_networks'
          private_networks = node['rackspace']['private_networks']

          unless private_networks.nil? || private_networks.empty?
            private_networks.each do |net|
              networks[net['label']] = net
            end
          end
        end

        networks
      end
    end

    module DSL
      def cloud_network_ip(label = nil)
        Chef::Sugar::IP.cloud_network_ip(node, label)
      end

      def cloud_networks
        Chef::Sugar::IP.cloud_networks(node)
      end

      def best_rackspace_ip_for(other)
        Chef::Sugar::IP.best_rackspace_ip_for(node, other)
      end
    end
  end
end

require 'chef/sugar'

class Chef
  module Sugar
    module Rackconnect
      extend self

      def rackconnect_v2?(node)
        return false unless node.key? 'rackspace'
        if node['rackspace'].key? 'rackconnect'
          return node['rackspace']['rackconnect']['enabled']
        else
          return false
        end
      end

      def rackconnected?(node)
        rackconnect_v2?(node)
      end
    end

    module DSL
      def rackconnected?
        Chef::Sugar::Rackconnect.rackconnected?(node)
      end

      def rackconnect_v2?
        Chef::Sugar::Rackconnect.rackconnect_v2?(node)
      end
    end
  end
end

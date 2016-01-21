require 'chef/sugar'

class Chef
  module Sugar
    module Rackconnect
      extend self

      def rackconnect_v2?(node)
        node['rackspace']['rackconnect']['version'] == 2
      end

      def rackconnect_v3?(node)
        node['rackspace']['rackconnect']['version'] == 3
      end

      def rackconnected?(node)
        return true if
          node['rackspace'] &&
          node['rackspace']['rackconnect'] &&
          node['rackspace']['rackconnect']['enabled']
        false
      end
    end

    module DSL
      def rackconnected?
        Chef::Sugar::Rackconnect.rackconnected?(node)
      end

      def rackconnect_v2?
        Chef::Sugar::Rackconnect.rackconnect_v2?(node)
      end

      def rackconnect_v3?
        Chef::Sugar::Rackconnect.rackconnect_v3?(node)
      end
    end
  end
end

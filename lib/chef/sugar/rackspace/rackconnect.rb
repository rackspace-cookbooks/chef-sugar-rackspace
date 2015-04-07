require 'chef/sugar'

class Chef
  module Sugar
    module Rackconnect
      extend self

      def rackconnected?(node)
        return false unless node.key? 'rackspace'
        if node['rackspace'].key? 'rackconnect'
          return node['rackspace']['rackconnect']['enabled']
        else
          fail 'must have rackconnect ohai plugin installed'
        end
      end
    end

    module DSL
      def rackconnected?
        Chef::Sugar::Rackconnect.rackconnected?(node)
      end
    end
  end
end

module Finalizable
  module Example
    # Example module for method_added
    module AModuleHasMethodAdded
      def self.included(klass)
        klass.extend(ClassMethods)
      end
      # Class methods
      module ClassMethods
        @@added_methods = []
        def method_added(method_name)
          @@added_methods.push(method_name)
        end

        def added_methods
          @@added_methods
        end
      end
    end
  end
end

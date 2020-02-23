module Finalizable
  module Example
    # Parent class for testing
    class ParentClass
      include ::Finalizable
      final :final_method_defined_in_parent_class
      somewhat_final :somewhat_final_method_defined_in_parent_class

      def final_method_defined_in_parent_class
        :return_value_from_parent_class
      end

      def somewhat_final_method_defined_in_parent_class
        :return_value_from_parent_class
      end

      def overridable_method_defined_in_parent_class
        :return_value_from_parent_class
      end
    end
  end
end

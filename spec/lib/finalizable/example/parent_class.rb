module Finalizable
  module Example
    # Parent class for testing
    class ParentClass
      include ::Finalizable
      final :first_method_defined_in_parent_class
      somewhat_final :second_method_defined_in_parent_class

      def first_method_defined_in_parent_class
        :return_value_from_parent_class
      end

      def second_method_defined_in_parent_class
        :return_value_from_parent_class
      end

      def third_method_defined_in_parent_class
        :return_value_from_parent_class
      end
    end
  end
end

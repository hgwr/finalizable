module Finalizable
  module Example
    # This class is allowed to partially override.
    class AClassSomeMethodsAreNotAllowedOverriding < ParentClass
      def first_method_defined_in_parent_class
        :return_value_from_subclass
      end

      def second_method_defined_in_parent_class
        :return_value_from_subclass
      end

      def third_method_defined_in_parent_class
        :return_value_from_subclass
      end

      def a_method_defined_in_sub_class
        :return_value_from_subclass
      end
    end
  end
end

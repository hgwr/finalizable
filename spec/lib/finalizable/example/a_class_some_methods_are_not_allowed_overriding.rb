module Finalizable
  module Example
    # This class is allowed to partially override. Just be warned.
    class AClassSomeMethodsAreNotAllowedOverriding < ParentClass
      def somewhat_final_method_defined_in_parent_class
        :return_value_from_subclass
      end

      def overridable_method_defined_in_parent_class
        :return_value_from_subclass
      end

      def a_method_defined_in_sub_class
        :return_value_from_subclass
      end
    end
  end
end

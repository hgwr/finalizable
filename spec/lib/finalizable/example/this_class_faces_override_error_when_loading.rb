module Finalizable
  module Example
    # This class faces override error when loading time not runtime.
    class ThisClassFacesOverrideErrorWhenLoading < ParentClass
      def final_method_defined_in_grand_parent_class
        :return_value_from_subclass
      end

      def final_method_defined_in_parent_class
        :return_value_from_subclass
      end
    end
  end
end

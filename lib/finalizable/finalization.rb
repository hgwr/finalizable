module Finalizable
  # Finalizable Error class
  class OverrideError < StandardError; end

  # Class methods
  module Finalization
    @@final_methods = {}
    @@somewhat_final_methods = {}

    def final(*names)
      @@final_methods[self] = names
    end

    def somewhat_final(*names)
      @@somewhat_final_methods[self] = names
    end

    def method_added(method_name)
      prevent_override?(method_name)
    end

    def prevent_override?(method_name)
      raise_error_if_prohibited_methods_are_overridden(method_name)
      warn_if_prohibited_methods_are_overridden(method_name)
    end

    def raise_error_if_prohibited_methods_are_overridden(method_name)
      @@final_methods.each do |class_name, final_methods|
        ancestors = self.ancestors.dup
        ancestors.shift # remove myself from the list
        if ancestors.include?(class_name) && final_methods.include?(method_name)
          raise Finalizable::OverrideError, "Child class '#{self}' should not override parent class method '#{class_name}.#{method_name}'."
        end
      end
    end

    def warn_if_prohibited_methods_are_overridden(method_name)
      @@somewhat_final_methods.each do |class_name, final_methods|
        ancestors = self.ancestors.dup
        ancestors.shift # remove myself from the list
        if ancestors.include?(class_name) && final_methods.include?(method_name)
          warn "WARNING: Child class '#{self}' should not override parent class method '#{class_name}.#{method_name}'."
        end
      end
    end
  end
end

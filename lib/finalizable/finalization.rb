require 'pry-byebug'
module Finalizable
  # Finalizable Error class
  class OverrideError < StandardError; end

  # Class methods
  module Finalization
    @@final_methods = {}
    @@somewhat_final_methods = {}

    def final(*names)
      @@final_methods[self] = names
      @@final_methods
    end

    def somewhat_final(*names)
      @@somewhat_final_methods[self] = names
      @@somewhat_final_methods
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
          raise Finalizable::OverrideError.new("Child class '#{self}' should not override parent class method '#{class_name}.#{method_name}'.")
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

    def find_overridden_class(ancestors, method_name)
      ancestors.find { |klass| dose_klass_have_the_method?(klass, method_name) }
    end

    def dose_klass_have_the_method?(klass, method_name)
      klass.instance_methods.include?(method_name)
    end
  end
end

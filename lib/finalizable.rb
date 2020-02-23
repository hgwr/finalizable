require 'finalizable/version'
require 'finalizable/class_methods'

# Finalizable module
module Finalizable
  # Finalizable Error class
  class Error < StandardError; end

  def self.included(klass)
    klass.extend(ClassMethods)
  end
end

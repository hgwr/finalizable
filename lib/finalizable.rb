require 'finalizable/version'
require 'finalizable/finalization'

# Finalizable module
module Finalizable
  def self.included(klass)
    klass.extend(Finalization)
  end
end

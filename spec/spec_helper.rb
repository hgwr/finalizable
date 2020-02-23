require 'bundler/setup'
require 'finalizable'
require 'lib/finalizable/example/parent_class'

module Finalizable
  # Test data recorder
  class TestData
    class << self
      def override_error_occured_in_loading_test(occured)
        @error_occured = occured
      end
      attr_reader :error_occured
    end
  end
end

begin
  require 'lib/finalizable/example/a_class_some_methods_are_not_allowed_overriding'
rescue Finalizable::OverrideError => e
  Finalizable::TestData.override_error_occured_in_loading_test(e)
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

require 'bundler/setup'
require 'finalizable'
require 'lib/finalizable/example/parent_class'

module Finalizable
  # Test data recorder
  class TestData
    class << self
      @occured_error = nil
      @warning_message = nil
      attr_accessor :occured_error, :warning_message
    end
  end
end

begin
  require 'lib/finalizable/example/this_class_faces_override_error_when_loading'
rescue Finalizable::OverrideError => e
  Finalizable::TestData.occured_error = e
end

@original_stderr = $stderr
$stderr = StringIO.new
require 'lib/finalizable/example/a_class_some_methods_are_not_allowed_overriding'
$stderr.rewind
Finalizable::TestData.warning_message = $stderr.string.chomp
$stderr = @original_stderr

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

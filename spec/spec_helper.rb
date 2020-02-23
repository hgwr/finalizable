require "bundler/setup"
require "finalizable"
require "finalizable/example/parent_class"
require "finalizable/example/a_class_allowed_to_override"
require "finalizable/example/a_class_some_methods_are_not_allowed_overriding"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

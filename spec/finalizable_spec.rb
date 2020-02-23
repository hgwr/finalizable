require 'spec_helper'

RSpec.describe Finalizable do
  it "has a version number" do
    expect(Finalizable::VERSION).not_to be nil
  end

  context "It's ok normal inheritance occurred" do
    let!(:parent) { Finalizable::Example::ParentClass.new }
    let!(:override_instance) { Finalizable::Example::AClassAllowedToOverride.new }

    it "is necessary that parent class instance returns their return value." do
      expect(parent.first_method_defined_in_parent_class).to eq(:return_value_from_parent_class)
      expect(parent.second_method_defined_in_parent_class).to eq(:return_value_from_parent_class)
      expect(parent.third_method_defined_in_parent_class).to eq(:return_value_from_parent_class)
    end
  end
end

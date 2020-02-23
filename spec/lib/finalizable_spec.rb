RSpec.describe Finalizable do
  it 'has a version number' do
    expect(Finalizable::VERSION).not_to be nil
  end

  let!(:parent) { Finalizable::Example::ParentClass.new }
  let!(:subclass) { Finalizable::Example::AClassSomeMethodsAreNotAllowedOverriding.new }

  it 'is sure that parent class instance methods return their own return value.' do
    parent_class_instance_methods = %i(first_method_defined_in_parent_class
                                       second_method_defined_in_parent_class
                                       third_method_defined_in_parent_class)
    expect((parent.public_methods & parent_class_instance_methods).any?).to be_truthy
    expect(parent.first_method_defined_in_parent_class).to eq(:return_value_from_parent_class)
    expect(parent.second_method_defined_in_parent_class).to eq(:return_value_from_parent_class)
    expect(parent.third_method_defined_in_parent_class).to eq(:return_value_from_parent_class)
  end

  it 'should be that the subclass returns their own value.' do
    expect(subclass.third_method_defined_in_parent_class).to eq(:return_value_from_subclass)
    expect(subclass.a_method_defined_in_sub_class).to eq(:return_value_from_subclass)
  end

  it 'should be raised an error when overriding a prohibited method' do
    expect { Finalizable::TestData.error_occured }.to be_truthy
  end

  it 'should be warned when overriding a somewhat prohibited method' do
    expect(subclass.second_method_defined_in_parent_class).to eq(:return_value_from_subclass)
  end
end

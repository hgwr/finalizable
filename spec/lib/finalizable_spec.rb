RSpec.describe Finalizable do
  it 'has a version number' do
    expect(Finalizable::VERSION).not_to be nil
  end

  let!(:grand_parent) { Finalizable::Example::GrandParentClass.new }
  let!(:parent) { Finalizable::Example::ParentClass.new }
  let!(:subclass) { Finalizable::Example::AClassSomeMethodsAreNotAllowedOverriding.new }
  let!(:rescued_subclass) { Finalizable::Example::ThisClassFacesOverrideErrorWhenLoading.new }

  it 'is sure that parent class instance methods return their own return value.' do
    parent_class_instance_methods = %i(final_method_defined_in_parent_class
                                       somewhat_final_method_defined_in_parent_class
                                       overridable_method_defined_in_parent_class)
    expect((parent_class_instance_methods - parent.public_methods).empty?).to be_truthy
    expect(parent.final_method_defined_in_parent_class).to eq(:return_value_from_parent_class)
    expect(parent.somewhat_final_method_defined_in_parent_class).to eq(:return_value_from_parent_class)
    expect(parent.overridable_method_defined_in_parent_class).to eq(:return_value_from_parent_class)
  end

  it 'should be that the subclass returns their own value.' do
    expect(subclass.overridable_method_defined_in_parent_class).to eq(:return_value_from_subclass)
    expect(subclass.a_method_defined_in_sub_class).to eq(:return_value_from_subclass)
  end

  it 'should be that overriding a prohibited method causes raising an error when loading time not runtime' do
    expect(Finalizable::TestSensor.occured_error).to be_a Finalizable::OverrideError
  end

  it 'should be loaded a class that has overriding issues because we caught the exception in the spec_helper.rb' do
    expect(defined? Finalizable::Example::ThisClassFacesOverrideErrorWhenLoading).to be_truthy
    expect(rescued_subclass.final_method_defined_in_parent_class).to eq(:return_value_from_parent_class)
  end

  it 'should be warned when overriding a somewhat prohibited method' do
    expect(subclass.somewhat_final_method_defined_in_parent_class).to eq(:return_value_from_subclass)
    correct_warning_message = "\
WARNING: Child class 'Finalizable::Example::AClassSomeMethodsAreNotAllowedOverriding' \
should not override parent class method \
'Finalizable::Example::ParentClass.somewhat_final_method_defined_in_parent_class'.\n\
WARNING: Child class 'Finalizable::Example::OverridingSomewhatFinalMethodInGrandParent' \
should not override parent class method \
'Finalizable::Example::GrandParentClass.somewhat_final_method_defined_in_grand_parent_class'."
    expect(Finalizable::TestSensor.warning_message).to eq(correct_warning_message)
  end

  it 'should not prevent method_added in another module' do
    added_methods_on_parent_class = %i(
      final_method_defined_in_grand_parent_class
      somewhat_final_method_defined_in_grand_parent_class
      overridable_method_defined_in_grand_parent_class
      final_method_defined_in_parent_class
      somewhat_final_method_defined_in_parent_class
      overridable_method_defined_in_parent_class
      final_method_defined_in_grand_parent_class
      somewhat_final_method_defined_in_parent_class
      overridable_method_defined_in_parent_class
      a_method_defined_in_sub_class
      somewhat_final_method_defined_in_grand_parent_class
      a_method_defined_in_sub_class
    ).sort
    expect(Finalizable::Example::ParentClass.added_methods.sort).to eq(added_methods_on_parent_class)
  end
end

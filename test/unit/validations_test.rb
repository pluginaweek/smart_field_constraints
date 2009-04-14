require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class ModelWithoutLengthValidationsTest < ActiveSupport::TestCase
  def test_should_not_have_any_constraints
    assert User.smart_length_constraints.empty?
  end
end

class ModelWithLengthValidationsTest < ActiveSupport::TestCase
  def test_should_not_track_constraint_for_minimum
    User.validates_length_of :name, :minimum => 1
    assert_nil User.smart_length_constraints['name']
  end
  
  def test_should_track_constraint_for_within
    User.validates_length_of :name, :within => 1..10
    assert_equal 10, User.smart_length_constraints['name']
  end
  
  def test_should_track_constraint_for_in
    User.validates_length_of :name, :in => 1..10
    assert_equal 10, User.smart_length_constraints['name']
  end
  
  def test_should_track_constraint_for_maximum
    User.validates_length_of :name, :maximum => 10
    assert_equal 10, User.smart_length_constraints['name']
  end
  
  def test_should_track_validation_for_is
    User.validates_length_of :name, :is => 10
    assert_equal 10, User.smart_length_constraints['name']
  end
  
  def teardown
    User.class_eval do
      ActiveRecord::Validations::VALIDATIONS.each do |validation|
        instance_variable_set("@#{validation}_callbacks", nil)
      end
    end
    
    User.smart_length_constraints.clear
  end
end

class ModelWithSizeValidationsTest < ActiveSupport::TestCase
  def test_should_track_constraints
    User.validates_size_of :name, :maximum => 10
    assert_equal 10, User.smart_length_constraints['name']
  end
  
  def teardown
    User.class_eval do
      ActiveRecord::Validations::VALIDATIONS.each do |validation|
        instance_variable_set("@#{validation}_callbacks", nil)
      end
    end
    
    User.smart_length_constraints.clear
  end
end

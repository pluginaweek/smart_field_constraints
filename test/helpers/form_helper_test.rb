require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class FormHelperWithoutConstraintsTest < ActionView::TestCase
  tests ActionView::Helpers::FormHelper
  
  def setup
    @user = User.new
  end
  
  def test_should_not_add_maxlength_for_text_field
    assert_equal '<input id="user_biography" name="user[biography]" size="30" type="text" />', text_field(:user, :biography)
  end
  
  def test_should_not_add_maxlength_for_password_field
    assert_equal '<input id="user_biography" name="user[biography]" size="30" type="password" />', password_field(:user, :biography)
  end
end

class FormHelperWithValidationConstraintsTest < ActionView::TestCase
  tests ActionView::Helpers::FormHelper
  
  def setup
    User.validates_length_of :biography, :maximum => 120
    User.validates_length_of :password, :maximum => 14
    
    @user = User.new
  end
  
  def test_should_not_add_maxlength_for_text_area
    assert_equal '<textarea cols="40" id="user_biography" name="user[biography]" rows="20"></textarea>', text_area(:user, :biography)
  end
  
  def test_should_not_add_maxlength_for_hidden_field
    assert_equal '<input id="user_password" name="user[password]" type="hidden" />', hidden_field(:user, :password)
  end
  
  def test_should_add_maxlength_for_password_field
    assert_equal '<input id="user_password" maxlength="14" name="user[password]" size="30" type="password" />', password_field(:user, :password)
  end
  
  def test_should_add_maxlength_for_text_field
    assert_equal '<input id="user_biography" maxlength="120" name="user[biography]" size="30" type="text" />', text_field(:user, :biography)
  end
  
  def test_should_allow_maxlength_to_be_overridden
    assert_equal '<input id="user_biography" maxlength="100" name="user[biography]" size="100" type="text" />', text_field(:user, :biography, :maxlength => 100)
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

class FormHelperWithColumnConstraintsTest < ActionView::TestCase
  tests ActionView::Helpers::FormHelper
  
  def setup
    @user = User.new
  end
  
  def test_should_not_add_maxlength_for_text_area
    assert_equal '<textarea cols="40" id="user_login" name="user[login]" rows="20"></textarea>', text_area(:user, :login)
  end
  
  def test_should_not_add_maxlength_for_hidden_field
    assert_equal '<input id="user_password" name="user[password]" type="hidden" />', hidden_field(:user, :password)
  end
  
  def test_should_add_maxlength_for_password_field
    assert_equal '<input id="user_password" maxlength="16" name="user[password]" size="30" type="password" />', password_field(:user, :password)
  end
  
  def test_should_add_maxlength_for_text_field
    assert_equal '<input id="user_login" maxlength="12" name="user[login]" size="30" type="text" />', text_field(:user, :login)
  end
  
  def test_should_allow_maxlength_to_be_overridden
    assert_equal '<input id="user_login" maxlength="100" name="user[login]" size="100" type="text" />', text_field(:user, :login, :maxlength => 100)
  end
end

class FormHelperForModelNotTrackedTest < ActionView::TestCase
  tests ActionView::Helpers::FormHelper
  
  def setup
    @tag = Tag.new
  end
  
  def test_should_add_maxlength_based_on_column_constraints
    assert_equal '<input id="tag_name" maxlength="100" name="tag[name]" size="30" type="text" />', text_field(:tag, :name)
  end
end

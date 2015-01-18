require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest


  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, user: { name:  "",
                               email: "user@invalid",
                               password:              "foo",
                               password_confirmation: "bar" }
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
  end

  test "valid signup information with account activation" do
    admin = users(:michael)
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, user: { name:  "Example",
                               surname: "User",
                               pesel: "93032213997",
                               email: "user@example.com",
                               password:              "password",
                               password_confirmation: "password" }
    end
    user = assigns(:user)
    assert_not user.activated?
    # Try to log in before activation.
    log_in_as(user)
    assert_not is_logged_in?
    # Activated
    log_in_as(admin)
    get edit_account_activation_path(user)
    assert user.reload.activated?
    log_in_as(user)
    follow_redirect!
    assert is_logged_in?
  end
end
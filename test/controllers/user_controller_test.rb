require 'test_helper'

class UserControllerTest < ActionDispatch::IntegrationTest
  # Test that a user can be created using the user fixture and devise
  test 'should create user' do
    assert_difference('User.count') do
      post user_registration_path, params: { user: { email: 'example@example.com',
                                                     password: 'password', 
                                                     password_confirmation: 'password', 
                                                     first_name: 'John',
                                                     last_name: 'Doe' } }
    end
    assert_redirected_to root_path
  end

  # Test the user log-in using the fixture.yml user and devise helper
  test 'should log in user' do
    sign_in users(:john)
    get root_path
    assert_response :success
  end
end

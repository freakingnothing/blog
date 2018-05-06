require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "nickname should not be valid" do
    user = User.new(nickname: '1')
    assert_not user.valid?
  end

  test "nickname should be valid" do
    user = User.new(nickname: 'test', 
                    email: 'test@email.com', 
                    password: '123456', 
                    password_confirmation: '123456')
    assert user.valid?
  end

  test "user should have confirmation_token" do
    user = User.create(nickname: 'test',
                       email: 'test@email.com',
                       password: '123456',
                       password_confirmation: '123456')
    assert_not_nil user.confirmation_token
  end
end

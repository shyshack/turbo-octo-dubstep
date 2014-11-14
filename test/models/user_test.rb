require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup 
    @user = User.new(name: "Example user", email: "user@example.com",
                     password: "rabarbar", password_confirmation: "rabarbar")
  end
  
  test "should be valid" do 
    assert @user.valid?
  end
  
  test "name should be present" do 
    @user.name = "   "
    assert_not @user.valid?
  end
  
  test "name should not be too long" do 
    @user.name = "a" * 51
    assert_not @user.valid?
  end
  
  test "email should be present" do 
    @user.email = "    "
    assert_not @user.valid?
  end
  
  test "email should not be too long" do
    @user.email = "a" * 256
    assert_not @user.valid?
  end
  
  test "valid email should be accepted" do 
    valid_emails = %w[valid@email.com THE_ugliest@user.com bonnie+clyde@zombo.com]
    valid_emails.each do |valid_email|
      @user.email = valid_email
      assert @user.valid?, "#{valid_email.inspect} should be valid"
    end
  end

  test "invalid email should be rejected" do
    invalid_emails = %w[invalid.email $@com invalid@second@email.com wtf@a*b.com]
    invalid_emails.each do |invalid_email|
      @user.email = invalid_email
      assert_not @user.valid?, "#{invalid_email.inspect} should be rejected"
    end
  end
  
  test "email address should be unique" do 
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end
  
  test "password should be at least 6 charactesr long" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end
end

require 'test_helper'

class UserTest < ActiveSupport::TestCase

  setup do
    @user = User.new(name: 'Toby', email: 'toby@ex.com', password: 'Abc123!', password_confirmation: 'Abc123!')
  end

  test 'User must not be empty' do
    user = User.new

    assert user.invalid?
    assert user.errors[:name].any?
    assert user.errors[:email].any?
  end

  test 'name cant be too long' do
    @user.name = 's' * 51
    assert @user.invalid?
  end

  test 'email cant be too long' do
    @user.email = 'e' * 256 + '@ex.com'
    assert @user.invalid?
  end

  test 'password cant be empty' do
    @user.password = nil
    assert @user.invalid?
  end

  test 'password needs to be strong' do
    @user.password = 'abc123'
    assert @user.invalid?
  end

  test 'email validation should accept valid addresses' do
    valid_addresses = %w[use@example.com USER@foo.COM A_re32@foo.ex.or first.esw@jes.com ale+bob@cws.c]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test 'email address should be unique' do
    other_user = @user.dup
    other_user.email = @user.email.upcase
    @user.save
    assert_not other_user.valid?
  end

  test 'email should be saved as lower-case' do
    email = 'ThisIsATest@eXamPle.COM'
    @user.email = email
    @user.save
    assert_equal email.downcase, @user.reload.email
  end

  test 'password and confirmation should match' do
    @user.password_confirmation = '123qwe!'
    assert @user.invalid?
  end
end

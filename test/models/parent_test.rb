require 'test_helper'

class ParentTest < ActiveSupport::TestCase

  setup do
    @parent = Parent.new(first_name: 'Tony',
                         last_name: 'Tran',
                         email: 'tony@ex.com',
                         address: '123 Street',
                         home_phone_number: '123-123-1234',
                         registration_cart: registration_carts(:one),
                         user: users(:travis))
  end

  test 'Parents must not be empty' do
    parent = Parent.new

    assert parent.invalid?
    assert parent.errors[:registration_cart].any?
    assert parent.errors[:user].any?
    assert parent.errors[:first_name].any?
    assert parent.errors[:last_name].any?
    assert parent.errors[:email].any?
    assert parent.errors[:address].any?
    assert parent.errors[:home_phone_number].any?
  end

  test 'saving valid parent' do
    assert @parent.valid?
  end

  test 'first name cant be too long' do
    @parent.first_name = 's' * 21
    assert @parent.invalid?
  end

  test 'last name cant be too long' do
    @parent.last_name = 's' * 21
    assert @parent.invalid?
  end

  test 'address cant be too long' do
    @parent.address = 'ab' * 81
    assert @parent.invalid?
  end

  test 'email cant be too long' do
    @parent.email = 'e' * 256 + '@ex.com'
    assert @parent.invalid?
  end

  test 'at least one phone number supplied or error' do
    @parent.home_phone_number = nil
    @parent.at_least_one_phone_number_should_be_provided
    assert_not @parent.errors.empty?
  end

  test 'email validation should accept valid addresses' do
    valid_addresses = %w[use@example.com USER@foo.COM A_re32@foo.ex.or first.esw@jes.com ale+bob@cws.c]
    valid_addresses.each do |valid_address|
      @parent.email = valid_address
      assert @parent.valid?, "#{valid_address.inspect} should be valid"
    end
  end
end

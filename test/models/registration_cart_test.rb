require 'test_helper'

class RegistrationCartTest < ActiveSupport::TestCase
  setup do
    @registration_cart = RegistrationCart.new(user: users(:travis))
  end

  test 'Registration carts must not be empty' do
    registration_cart = RegistrationCart.new

    assert registration_cart.invalid?
    assert registration_cart.errors[:user].any?
  end

  test 'saving valid registration cart' do
    assert @registration_cart.valid?
  end
end

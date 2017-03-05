require 'test_helper'

class RegistrationCartsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @registration_cart = registration_carts(:one)
  end

  test "should get index" do
    get registration_carts_url
    assert_response :success
  end

  test "should get new" do
    get new_registration_cart_url
    assert_response :success
  end

  test "should create registration_cart" do
    assert_difference('RegistrationCart.count') do
      post registration_carts_url, params: { registration_cart: {  } }
    end

    assert_redirected_to registration_cart_url(RegistrationCart.last)
  end

  test "should show registration_cart" do
    get registration_cart_url(@registration_cart)
    assert_response :success
  end

  test "should get edit" do
    get edit_registration_cart_url(@registration_cart)
    assert_response :success
  end

  test "should update registration_cart" do
    patch registration_cart_url(@registration_cart), params: { registration_cart: {  } }
    assert_redirected_to registration_cart_url(@registration_cart)
  end

  test "should destroy registration_cart" do
    assert_difference('RegistrationCart.count', -1) do
      delete registration_cart_url(@registration_cart)
    end

    assert_redirected_to registration_carts_url
  end
end

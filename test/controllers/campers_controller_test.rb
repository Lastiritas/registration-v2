require 'test_helper'

class CampersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @camper = campers(:one)
  end

  test "should get index" do
    get campers_url
    assert_response :success
  end

  test "should get new" do
    get new_camper_url
    assert_response :success
  end

  test "should create camper" do
    assert_difference('Camper.count') do
      post campers_url, params: { camper: { address: @camper.address, birth_date: @camper.birth_date, camp_session_id: camp_sessions(:teen).id, first_name: @camper.first_name, gender: @camper.gender, last_name: @camper.last_name, registration_cart_id: @camper.registration_cart_id } }
    end

    assert_redirected_to camper_url(Camper.last)
  end

  test "should show camper" do
    get camper_url(@camper)
    assert_response :success
  end

  test "should get edit" do
    get edit_camper_url(@camper)
    assert_response :success
  end

  test "should update camper" do
    patch camper_url(@camper), params: { camper: { address: @camper.address, birth_date: @camper.birth_date, camp_session_id: @camper.camp_session_id, first_name: @camper.first_name, gender: @camper.gender, last_name: @camper.last_name, registration_cart_id: @camper.registration_cart_id } }
    assert_redirected_to camper_url(@camper)
  end

  test "should destroy camper" do
    assert_difference('Camper.count', -1) do
      delete camper_url(@camper)
    end

    assert_redirected_to campers_url
  end
end

require 'test_helper'

class CampSessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @camp_session = camp_sessions(:senior)
  end

  test "should get index" do
    get camp_sessions_url
    assert_response :success
  end

  test "should get new" do
    get new_camp_session_url
    assert_response :success
  end

  test "should create camp_session" do
    assert_difference('CampSession.count') do
      post camp_sessions_url, params: { camp_session: { capacity: @camp_session.capacity, enabled: @camp_session.enabled, end_date: @camp_session.end_date, fee: @camp_session.fee, gender: @camp_session.gender, maximum_age: @camp_session.maximum_age, minimum_age: @camp_session.minimum_age, name: @camp_session.name, remaining: @camp_session.remaining, start_date: @camp_session.start_date, year: @camp_session.year } }
    end

    assert_redirected_to camp_session_url(CampSession.last)
  end

  test "should show camp_session" do
    get camp_session_url(@camp_session)
    assert_response :success
  end

  test "should get edit" do
    get edit_camp_session_url(@camp_session)
    assert_response :success
  end

  test "should update camp_session" do
    patch camp_session_url(@camp_session), params: { camp_session: { capacity: @camp_session.capacity, enabled: @camp_session.enabled, end_date: @camp_session.end_date, fee: @camp_session.fee, gender: @camp_session.gender, maximum_age: @camp_session.maximum_age, minimum_age: @camp_session.minimum_age, name: @camp_session.name, remaining: @camp_session.remaining, start_date: @camp_session.start_date, year: @camp_session.year } }
    assert_redirected_to camp_session_url(@camp_session)
  end

  test "should destroy camp_session" do
    assert_difference('CampSession.count', -1) do
      delete camp_session_url(@camp_session)
    end

    assert_redirected_to camp_sessions_url
  end
end

require 'test_helper'

class ParentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @parent = parents(:one)
  end

  test "should get index" do
    get parents_url
    assert_response :success
  end

  test "should get new" do
    get new_parent_url
    assert_response :success
  end

  test "should create parent" do
    assert_difference('Parent.count') do
      post parents_url, params: { parent: { address: @parent.address, cell_phone_number: @parent.cell_phone_number, email: @parent.email, first_name: @parent.first_name, home_phone_number: @parent.home_phone_number, last_name: @parent.last_name, work_phone_number: @parent.work_phone_number } }
    end

    assert_redirected_to parent_url(Parent.last)
  end

  test "should show parent" do
    get parent_url(@parent)
    assert_response :success
  end

  test "should get edit" do
    get edit_parent_url(@parent)
    assert_response :success
  end

  test "should update parent" do
    patch parent_url(@parent), params: { parent: { address: @parent.address, cell_phone_number: @parent.cell_phone_number, email: @parent.email, first_name: @parent.first_name, home_phone_number: @parent.home_phone_number, last_name: @parent.last_name, work_phone_number: @parent.work_phone_number } }
    assert_redirected_to parent_url(@parent)
  end

  test "should destroy parent" do
    assert_difference('Parent.count', -1) do
      delete parent_url(@parent)
    end

    assert_redirected_to parents_url
  end
end

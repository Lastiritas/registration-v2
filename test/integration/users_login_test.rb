require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  fixtures :users

  test 'login with invalid information' do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: '', password: '' } }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test 'login with valid information' do
    @user = users(:travis)
    get login_path
    post login_path, params: { session: { email:    @user.email,
                                          password: @user.password } }
    #follow_redirect!
    assert_template 'parents/index'
    assert_select 'a[href=?]', login_path, count: 0
    assert_select 'a[href=?]', logout_path
    assert_select 'a[href=?]', user_path(@user)
  end
end
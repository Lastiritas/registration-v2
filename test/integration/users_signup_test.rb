require 'test_helper'

class UserSignupTest < ActionDispatch::IntegrationTest

  test 'invalid signup info' do
    get '/users/new'
    assert_response :success
=begin
    assert_no_difference 'User.count' do
      post '/users/new', params: {user: {name: '', email: 'us@us', password: 'avd', password_confirmation: 'wes'}}
    end
    assert_template 'users/new'
=end
  end
end
require 'test_helper'

class CampSessionTest < ActiveSupport::TestCase
  fixtures :camp_sessions

  test "Camp sessions must not be empty" do
    camp_session = CampSession.new
    assert camp_session.invalid?
    assert camp_session.errors[:name].any?
    assert camp_session.errors[:capacity].any?
    assert camp_session.errors[:start_date].any?
    assert camp_session.errors[:end_date].any?
    assert camp_session.errors[:remaining].any?
    assert camp_session.errors[:gender].any?
    assert camp_session.errors[:fee].any?
    assert camp_session.errors[:minimum_age].any?
    assert camp_session.errors[:maximum_age].any?
  end

  test "Fee should be a positive number" do
    camp_session = CampSession.new(
        name: 'Team Camp',
        capacity: 25,
        start_date: '2017-02-21 21:50:41',
        end_date: '2017-02-21 21:50:41',
        remaining: 20,
        gender: 1,
        minimum_age: 10,
        maximum_age: 12
    )

    camp_session.fee = -1
    assert camp_session.invalid?
    assert_equal ['must be greater than or equal to 0.01'], camp_session.errors[:fee]

    camp_session.fee = 0
    assert camp_session.invalid?
    assert_equal ['must be greater than or equal to 0.01'], camp_session.errors[:fee]

    camp_session.fee = 1
    assert camp_session.valid?
  end
end

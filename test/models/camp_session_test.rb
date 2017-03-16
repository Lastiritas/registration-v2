require 'test_helper'

class CampSessionTest < ActiveSupport::TestCase

  test 'Camp sessions must not be empty' do
    camp_session = CampSession.new

    assert camp_session.invalid?
    assert camp_session.errors[:name].any?
    assert camp_session.errors[:capacity].any?
    assert camp_session.errors[:start_date].any?
    assert camp_session.errors[:end_date].any?
    assert camp_session.errors[:remaining].any?
    assert camp_session.errors[:gender].any?
    assert camp_session.errors[:year].any?
    assert camp_session.errors[:fee].any?
    assert camp_session.errors[:minimum_age].any?
    assert camp_session.errors[:maximum_age].any?
  end

  test 'Fee should be a positive number' do
    camp_session = CampSession.new(
        name: 'Teen Camp',
        capacity: 25,
        start_date: '2017-02-21 21:50:41',
        end_date: '2017-02-21 21:50:41',
        remaining: 20,
        year: 2017,
        gender: :Female,
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

  test 'gender should be a valid enum' do
    camp_session = CampSession.new(
        name: 'Teen Camp',
        capacity: 25,
        start_date: '2017-12-12',
        end_date: '2017-12-13',
        remaining: 20,
        year: 2017,
        minimum_age: 10,
        maximum_age: 15,
        fee: 12
    )

    assert_raise ArgumentError do
      camp_session.gender = :Unknown
      assert camp_session.invalid?
    end

    camp_session.gender = :not_defined
    assert camp_session.valid?

    camp_session.gender = :Male
    assert camp_session.valid?

    camp_session.gender = :Female
    assert camp_session.valid?

    camp_session.gender = :Both
    assert camp_session.valid?
  end

  test 'supplying right info should return true' do
    birth_date = Date.new(2004,02,02)
    gender = :Male

    assert CampSession.session_valid_for_camper?(birth_date, camp_sessions(:teen).id, gender)
  end

  test 'get future date should work properly' do
    birth_date = Date.new(2004,02,02)
    expected_age = 13
    assert CampSession.getFutureAge(camp_sessions(:teen), birth_date) == expected_age
  end

  test 'selecting a close date as the event should return age 0' do
    birth_date = Date.new(2017,01,01)
    expected_age = 0
    assert CampSession.getFutureAge(camp_sessions(:teen), birth_date) == expected_age
  end

  test 'asserting for age between range should return true' do
    birth_date = Date.new(2004,02,02)
    assert CampSession.age_between_range?(camp_sessions(:teen), birth_date)
  end

  test 'asserting outside of range age should return false' do
    birth_date = Date.new(2005,02,02)
    assert_not CampSession.age_between_range?(camp_sessions(:teen), birth_date)
  end
end

require 'test_helper'

class CamperTest < ActiveSupport::TestCase

  setup do
    @camper = Camper.new(first_name: 'Tony',
                         last_name: 'Tran',
                         gender: :Male,
                         address: '123 Street',
                         birth_date: '2004-02-02',
                         camp_session: camp_sessions(:teen),
                         registration_cart: registration_carts(:one),
                         parent: parents(:tommy),
                         user: users(:travis))
  end

  test 'Campers must not be empty' do
    camper = Camper.new

    assert camper.invalid?
    assert camper.errors[:camp_session].any?
    assert camper.errors[:registration_cart].any?
    assert camper.errors[:parent].any?
    assert camper.errors[:user].any?
    assert camper.errors[:first_name].any?
    assert camper.errors[:last_name].any?
    assert camper.errors[:gender].any?
    assert camper.errors[:address].any?
    assert camper.errors[:birth_date].any?
  end

  test 'saving valid camper' do
    assert @camper.valid?
  end

  test 'gender should be a valid enum' do

    assert_raise ArgumentError do
      @camper.gender = :Unknown
      assert @camper.invalid?
    end

    @camper.gender = :not_defined
    assert @camper.valid?

    @camper.gender = :Male
    assert @camper.valid?

    @camper.gender = :Female
    assert @camper.valid?

    @camper.gender = :Both
    assert @camper.valid?
  end
end

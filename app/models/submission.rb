class Submission < ApplicationRecord
  has_many :camper_submissions, autosave: true
  belongs_to :parent

  def add_campers_and_parent_from_registration_cart(registration_cart)
    add_campers_from_registration_cart(registration_cart)
    add_parent_from_registration_cart(registration_cart.parent)
  end

  def add_campers_from_registration_cart(registration_cart)
    registration_cart.campers.each do |camper|
      camper.registration_cart_id = nil
      camper_submissions.build(camper: camper, camp_session: camper.camp_session)
    end
  end

  def add_parent_from_registration_cart(parent_from_cart)
    puts parent_from_cart.inspect
    parent_from_cart.registration_cart_id = nil
    self.parent = parent_from_cart
  end
end

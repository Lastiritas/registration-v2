class Submission < ApplicationRecord
  has_many :camper_submissions, autosave: true
  belongs_to :parent
  belongs_to :user

  def add_campers_and_parent_from_registration_cart(registration_cart, user)
    self.user = user
    self.email = registration_cart.parent.email
    add_campers_from_registration_cart(registration_cart)
    add_parent_from_registration_cart(registration_cart)
  end

  def add_campers_from_registration_cart(registration_cart)
    registration_cart.campers.each do |camper|
      camper.registration_cart_id = nil
      camper_submissions.build(camper: camper, camp_session: camper.camp_session)
    end
    registration_cart.campers.clear
  end

  def add_parent_from_registration_cart(registration_cart)
    registration_cart.parent.registration_cart_id = nil
    self.parent = registration_cart.parent
    registration_cart.parent = nil
    registration_cart.save(:validate => false)
  end
end

class Camper < ApplicationRecord
  enum gender: [:male, :female]
  belongs_to :camp_session
  belongs_to :registration_cart
  belongs_to :parent
  belongs_to :user
  has_many :camper_submissions

  validates :camp_session_id, :registration_cart_id, :first_name, :last_name, :gender, :address, :birth_date, presence: true

  def total_price
    camp_session.fee + 3
  end
end

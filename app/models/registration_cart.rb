class RegistrationCart < ApplicationRecord
  has_many :campers
  has_one :parent
  belongs_to :user

  def total_price
    campers.to_a.sum { |camper| camper.total_price }
  end

  def admin_fee
    campers.count * 3
  end
end

class Parent < ApplicationRecord
  belongs_to :registration_cart
  belongs_to :user
  has_many :campers
  has_many :submissions
  validates :first_name, :last_name, :address, :email, presence: true
  validates :first_name, :last_name, length: { maximum: 20}
  validates :address, length: { maximum: 80 }
  validates :email, :home_phone_number, :cell_phone_number, :work_phone_number, length: {maximum: 40}
  validate :at_least_one_phone_number_should_be_provided

  def at_least_one_phone_number_should_be_provided
    if !home_phone_number.present? and !cell_phone_number.present? and !work_phone_number.present?
      errors.add(:home_phone_number, 'At least one phone number should be provided')
    end
  end
end

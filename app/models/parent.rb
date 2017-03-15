class Parent < ApplicationRecord
  belongs_to :registration_cart
  belongs_to :user
  has_many :campers
  has_many :submissions
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :first_name, :last_name, :address, presence: true
  validates :first_name, :last_name, length: { maximum: 20}
  validates :address, length: { maximum: 80 }
  validates :email, :home_phone_number, :cell_phone_number, :work_phone_number, length: {maximum: 40}
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
  validate :at_least_one_phone_number_should_be_provided

  def at_least_one_phone_number_should_be_provided
    if !home_phone_number.present? and !cell_phone_number.present? and !work_phone_number.present?
      errors.add(:home_phone_number, 'At least one phone number should be provided')
    end
  end
end

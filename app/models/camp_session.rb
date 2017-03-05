class CampSession < ApplicationRecord
  has_many :campers
  has_many :camper_submissions
  before_destroy :ensure_not_referenced_by_any_camper
  validates :name, :capacity, :start_date, :end_date, :remaining, :gender, :fee, :minimum_age, :maximum_age, presence: true
  validates :fee, numericality: {greater_than_or_equal_to: 0.01}

  def self.session_valid_for_camper?(birth_date, camp_session_id)
    if birth_date.nil? or camp_session_id.nil? or camp_session_id == 0
      return false
    end

    camp_session = CampSession.find(camp_session_id)

    !camp_session.nil? and self.age_between_range?(camp_session, birth_date)
  end

  # Returns true if the given age is between minimum_age and maximum_age
  def self.age_between_range?(session, birth_date)
    puts '----------------------------------------------------------'
    puts session.inspect
    puts birth_date
    age = self.getFutureAge(session, birth_date)
    session.minimum_age <= age and session.maximum_age >= age
  end

  # Returns the age the camper will have on the day of the camp session.
  def self.getFutureAge(session, birth_date)
    month = (session.start_date.year * 12 + session.start_date.month) - (birth_date.year * 12 + birth_date.month)
    month.divmod(12).first
  end

  private
    def ensure_not_referenced_by_any_camper
      unless campers.empty?
        errors.add(:base, 'Campers are associated with the camp session, you cannot delete this session')
        throw :abort
      end
    end
end

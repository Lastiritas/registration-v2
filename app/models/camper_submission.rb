class CamperSubmission < ApplicationRecord
  belongs_to :submission
  belongs_to :camper
  belongs_to :camp_session
end

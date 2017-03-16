require 'test_helper'

class CamperSubmissionTest < ActiveSupport::TestCase

  setup do
    @camper_submission = CamperSubmission.new(camper: campers(:joe), camp_session: camp_sessions(:teen), submission: submissions(:one))
  end

  test 'Camper submissions must not be empty' do
    camper_submission = CamperSubmission.new

    assert camper_submission.invalid?
    assert camper_submission.errors[:camper].any?
    assert camper_submission.errors[:camp_session].any?
    assert camper_submission.errors[:submission].any?
  end

  test 'saving valid submission' do
    assert @camper_submission.valid?
  end
end

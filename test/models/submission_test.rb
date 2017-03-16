require 'test_helper'

class SubmissionTest < ActiveSupport::TestCase

  setup do
    @submission = Submission.new(parent: parents(:tommy), user: users(:travis))
  end

  test 'Submissions must not be empty' do
    submission = Submission.new

    assert submission.invalid?
    assert submission.errors[:parent].any?
    assert submission.errors[:user].any?
  end

  test 'saving valid submission' do
    assert @submission.valid?
  end
end

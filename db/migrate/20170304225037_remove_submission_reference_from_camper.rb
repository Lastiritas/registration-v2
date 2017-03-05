class RemoveSubmissionReferenceFromCamper < ActiveRecord::Migration[5.0]
  def change
    remove_reference(:campers, :submission, index: true, foreign_key: true)
  end
end

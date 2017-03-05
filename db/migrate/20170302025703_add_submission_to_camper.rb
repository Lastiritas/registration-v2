class AddSubmissionToCamper < ActiveRecord::Migration[5.0]
  def change
    add_reference :campers, :submission, foreign_key: true
  end
end

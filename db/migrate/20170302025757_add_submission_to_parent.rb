class AddSubmissionToParent < ActiveRecord::Migration[5.0]
  def change
    add_reference :parents, :submission, foreign_key: true
  end
end

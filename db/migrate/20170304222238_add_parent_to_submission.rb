class AddParentToSubmission < ActiveRecord::Migration[5.0]
  def change
    remove_reference(:parents, :submission, index: true, foreign_key: true)
    add_reference :submissions, :parent, foreign_key: true
  end
end

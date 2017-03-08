class AddCreatedByToParents < ActiveRecord::Migration[5.0]
  def change
    add_reference :parents, :user, foreign_key: true
    add_reference :campers, :user, foreign_key: true
    add_reference :submissions, :user, foreign_key: true
    add_reference :registration_carts, :user, foreign_key: true
  end
end

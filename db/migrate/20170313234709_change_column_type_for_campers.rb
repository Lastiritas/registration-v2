class ChangeColumnTypeForCampers < ActiveRecord::Migration[5.0]
  def change
    remove_column :campers, :gender
    add_column :campers, :gender, :integer
  end
end

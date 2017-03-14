class ChangeColumnTypeForCampers < ActiveRecord::Migration[5.0]
  def change
    change_column(:campers, :gender, :integer)
  end
end

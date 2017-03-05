class GenderChangeToString < ActiveRecord::Migration[5.0]
  def change
    change_column(:campers, :gender, :string)
  end
end

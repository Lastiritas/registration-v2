class CreateSubmissions < ActiveRecord::Migration[5.0]
  def change
    create_table :submissions do |t|
      t.string :charge_id
      t.decimal :amount_paid, precision: 8, scale: 2

      t.timestamps
    end
  end
end

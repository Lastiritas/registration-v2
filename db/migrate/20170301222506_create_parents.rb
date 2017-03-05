class CreateParents < ActiveRecord::Migration[5.0]
  def change
    create_table :parents do |t|
      t.belongs_to :registration_cart, foreign_key: true
      t.string :first_name
      t.string :last_name
      t.text :address
      t.string :email
      t.string :home_phone_number
      t.string :cell_phone_number
      t.string :work_phone_number

      t.timestamps
    end

    add_reference :campers, :parent, index: true
    add_foreign_key :campers, :parents
  end
end

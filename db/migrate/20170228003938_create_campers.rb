class CreateCampers < ActiveRecord::Migration[5.0]
  def change
    create_table :campers do |t|
      t.references :camp_session, foreign_key: true
      t.belongs_to :registration_cart, foreign_key: true
      t.string :first_name
      t.string :last_name
      t.integer :gender
      t.text :address
      t.datetime :birth_date

      t.timestamps
    end


  end
end

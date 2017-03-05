class CreateRegistrationCarts < ActiveRecord::Migration[5.0]
  def change
    create_table :registration_carts do |t|

      t.timestamps
    end
  end
end

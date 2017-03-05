class CreateCampSessions < ActiveRecord::Migration[5.0]
  def change
    create_table :camp_sessions do |t|
      t.string :name
      t.integer :capacity
      t.datetime :start_date
      t.datetime :end_date
      t.integer :year
      t.integer :remaining
      t.integer :gender
      t.decimal :fee, precision: 8, scale: 2
      t.integer :minimum_age
      t.integer :maximum_age
      t.boolean :enabled

      t.timestamps
    end
  end
end

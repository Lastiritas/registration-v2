class CreateCamperSubmissions < ActiveRecord::Migration[5.0]
  def change
    create_table :camper_submissions do |t|
      t.references :submission, foreign_key: true
      t.references :camp_session, foreign_key: true
      t.belongs_to :camper, foreign_key: true

      t.timestamps
    end
  end
end

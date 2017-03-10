class AddEmailToSubmissions < ActiveRecord::Migration[5.0]
  def change
    add_column :submissions, :email, :string
  end
end

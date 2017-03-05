json.extract! parent, :id, :first_name, :last_name, :address, :email, :home_phone_number, :cell_phone_number, :work_phone_number, :created_at, :updated_at
json.url parent_url(parent, format: :json)

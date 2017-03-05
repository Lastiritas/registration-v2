json.extract! camper, :id, :camp_session_id, :registration_cart_id, :first_name, :last_name, :gender, :address, :birth_date, :created_at, :updated_at
json.url camper_url(camper, format: :json)

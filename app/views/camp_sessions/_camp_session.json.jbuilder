json.extract! camp_session, :id, :name, :capacity, :start_date, :end_date, :year, :remaining, :gender, :fee, :minimum_age, :maximum_age, :enabled, :created_at, :updated_at
json.url camp_session_url(camp_session, format: :json)

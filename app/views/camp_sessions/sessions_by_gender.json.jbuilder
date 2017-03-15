json.camp_sessions @camp_sessions do |camp_session|
  json.camp_session_id camp_session.id
  json.name camp_session.name
  json.ages "#{camp_session.minimum_age}-#{camp_session.maximum_age}"
  json.dates getMonthDate(camp_session.start_date, camp_session.end_date)
  json.price number_to_currency(camp_session.fee)
end
=begin
Rails.configuration.stripe = {
    :publishable_key => ENV['PUBLISHABLE_KEY'],
    :secret_key      => ENV['SECRET_KEY']
}
=end

Rails.configuration.stripe = {
    :publishable_key => "public_credentials",
    :secret_key      => "private_credentials"
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
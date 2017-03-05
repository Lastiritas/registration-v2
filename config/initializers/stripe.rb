=begin
Rails.configuration.stripe = {
    :publishable_key => ENV['PUBLISHABLE_KEY'],
    :secret_key      => ENV['SECRET_KEY']
}
=end

Rails.configuration.stripe = {
    :publishable_key => "pk_test_dlNeTfvT8PmCpOLgIiO9xT9f",
    :secret_key      => "sk_test_IPKqjPyo44NfQR7VBZa1bTmd"
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
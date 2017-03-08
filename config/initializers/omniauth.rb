OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '842431794560-24bag5b9kvq90erngmf6ecni4v5jnt50.apps.googleusercontent.com',
           'XOsY6sjyEW5jU4bvkBy6vct_', {client_options: {ssl: {ca_file: Rails.root.join('cacert.pem').to_s}}}
  provider :facebook, '1884975548449326',
           '3818b5f69efa8dc434b9eae973b4100e', {:client_options => {:ssl => {:ca_file => Rails.root.join("cacert.pem").to_s}}}
end
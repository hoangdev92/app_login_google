Rails.application.configure do
  config.available_email_domains = ENV['AVAILABLE_EMAIL_DOMAINS'].split('|')
  config.available_languages = ENV['AVAILABLE_LANGUAGES'].split('|')
  config.owner_emails = ENV['OWNER_EMAILS'].split('|')
  config.responses = config_for(:responses)
  config.settings = config_for(:settings)
end

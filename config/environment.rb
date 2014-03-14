# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Depot::Application.initialize!
Depot::Application.configure do
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address:  "smtp.gmail.com",
    port:     "587",
    domain:   "googlemail.com",
    user_name: "stavros.foreman@googlemail.com",
    password: "htcdl58t",
    enable_starttls_auto: true
  }
end
  
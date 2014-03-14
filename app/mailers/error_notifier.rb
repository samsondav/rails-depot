class ErrorNotifier < ActionMailer::Base
  default from: "admin@depot.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.error_notifier.error_occured.subject
  #
  
  def error_occurred(error)
    @error = error
    mail to: "seivadmas@gmail.com", subject: "Danger, Will Robinson"
  end
end

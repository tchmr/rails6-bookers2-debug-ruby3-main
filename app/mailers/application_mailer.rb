class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.credentials.google[:user_id]
  layout 'mailer'
end

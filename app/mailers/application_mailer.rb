class ApplicationMailer < ActionMailer::Base
  default from: 'confirm@evanbarger.com'
  layout 'mailer'
end

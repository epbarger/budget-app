class ApplicationMailer < ActionMailer::Base
  default from: 'confirm@budget-app-test.herokuapp.com'
  layout 'mailer'
end

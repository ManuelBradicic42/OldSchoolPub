class ApplicationMailer < ActionMailer::Base
  default to: 'info@oldschoolpub.com', from: "info@oldschoolpub.com"
  layout 'mailer'
end

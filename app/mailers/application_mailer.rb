class ApplicationMailer < ActionMailer::Base
  default from: 'Scoutaround <notifications@scoutaround.org>'
  layout 'mailer'
end

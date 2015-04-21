# Базовый класс для отправки сообщений электронной почты.
class ApplicationMailer < ActionMailer::Base
  default from: ASM_EMAIL
  layout 'mailer'
end

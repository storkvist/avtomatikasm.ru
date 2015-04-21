# Базовый класс для отправки сообщений электронной почты.
class ApplicationMailer < ActionMailer::Base
  default from: 'info@avtomatikasm.ru'
  layout 'mailer'
end

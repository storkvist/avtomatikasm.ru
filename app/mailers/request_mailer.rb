class RequestMailer < ApplicationMailer
  def request_email(parts)
    @parts = parts
    mail(to: 'storkvist@storkvist.net', subject: 'Новое сообщение с сайта!')
  end
end

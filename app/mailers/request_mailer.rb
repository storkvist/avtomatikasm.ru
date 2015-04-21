# Класс для отправки сообщения с сайта.
class RequestMailer < ApplicationMailer
  # Отправка сообщения с сайта.
  #
  # @param [Hash] parts Поля, заполненные пользователем на странице «Контакты».
  def request_email(parts)
    @parts = parts
    mail(to: 'storkvist@storkvist.net', subject: 'Новое сообщение с сайта!')
  end
end

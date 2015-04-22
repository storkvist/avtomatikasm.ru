# Класс для отправки сообщения с сайта.
class RequestMailer < ApplicationMailer
  add_template_helper(RequestFormsHelper)

  # Отправка сообщения с сайта.
  #
  # @param [Hash] parts Поля, заполненные пользователем на странице «Контакты».
  def send_message(parts)
    @parts = parts
    mail(from: parts[:email], to: ASM_EMAIL, subject: 'Новое сообщение с сайта!')
  end
end

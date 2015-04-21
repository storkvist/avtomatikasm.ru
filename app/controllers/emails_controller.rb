# Контроллер для работы с электронной почтой. Например, для отправки сообщений с сайта.
class EmailsController < ApplicationController
  # Отправка сообщения через форму на сайте.
  def send_email
    RequestMailer.send_message(resource_params).deliver_later

    redirect_to '/kontakty', notice: 'Ваше сообщение отправлено. Очень скоро мы свяжемся с вами.'
  end

  private

  def resource_params
    params.permit(
      :first_name, :last_name, :organization, :email, :city, :phone, { topics: [] }, :comments
    )
  end
end

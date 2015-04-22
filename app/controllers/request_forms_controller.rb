# Контроллер для работы с электронной почтой. Например, для отправки сообщений с сайта.
class RequestFormsController < ApplicationController
  def create
    @request_form = RequestForm.new(params)

    if @request_form.submit
      redirect_to '/kontakty', notice: 'Ваше сообщение отправлено. Очень скоро мы свяжемся с вами.'
    else
      parameters = params.extract!(:request_form)
      parameters[:validate] = true

      redirect_to "/kontakty?#{parameters.to_param}"
    end
  end

  # Отправка сообщения через форму на сайте.
  # def send_email
  #   RequestMailer.send_message(resource_params).deliver_later
  #
  #   redirect_to '/kontakty', notice: 'Ваше сообщение отправлено. Очень скоро мы свяжемся с вами.'
  # end
  #
  # private
  #
  # def resource_params
  #   params.permit(
  #     :first_name, :last_name, :organization, :email, :city, :phone, { topics: [] }, :comments
  #   )
  # end
end

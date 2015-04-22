# Контроллер для работы с электронной почтой. Например, для отправки сообщений с сайта.
class RequestFormsController < ApplicationController
  # Отправка сообщения с сайта.
  #
  # @return [void]
  def create
    @request_form = RequestForm.new(params)

    if @request_form.submit
      redirect_to '/kontakty', notice: 'Ваше сообщение отправлено. Очень скоро мы свяжемся с вами.'
    else
      parameters = params.extract!(:request_form)

      # Наличие параметра :validate влияет на то, будет ли проверяться форма
      # при начальной загрузке данных.
      parameters[:validate] = true

      redirect_to "/kontakty?#{parameters.to_param}"
    end
  end
end

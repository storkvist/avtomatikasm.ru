# Модуль с хэлперами для представлений, связанных с работой с электронной почты.
module EmailsHelper
  # Хэлпер преобразует поля, заполняемые пользователем на странице «Контакты» в осмысленный текст,
  # который затем вставляется в письмо, отправляемое с сайта.
  #
  # @param [Hash] parts Поля, заполненные пользователем на странице «Контакты».
  # @return [String]
  def request_email_text(parts)
    comment = parts[:comments] ? "<p>Комментарий к запросу: <em>#{parts[:comments]}</em></p>" : ''

    "<p>#{line_with_name(parts)}</p>" \
    '<p>Заказчик указал, что его интересуют следующие темы: ' \
    "#{parts[:topics].map { |s| "#{Unicode.downcase(s[0, 1])}#{s[1..-1]}" }.join(', ')}.</p>" \
    "#{comment}" \
    "<p>Телефон для связи — <strong>#{parts[:phone]}</strong>, " \
    "электронная почта — <a href='mailto:#{parts[:email]}'>#{parts[:email]}</a>.</p>"
  end

  private

  # Генерация первой строчки письма с сообщением с сайта: имя и фамилия пользователя, организация
  # и город.
  #
  # @param [Hash] parts Поля, заполненные пользователем на странице «Контакты».
  # @return [String]
  def line_with_name(parts)
    text = []
    text << parts[:first_name]
    text << parts[:last_name]

    text << "из компании #{parts[:organization]}" if parts[:organization]
    text << "(#{parts[:city]})" if parts[:city]

    text << 'отправил новый запрос через сайт.'

    text.join(' ')
  end
end

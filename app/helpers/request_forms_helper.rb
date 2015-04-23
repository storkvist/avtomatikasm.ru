# Модуль с хэлперами для представлений, связанных с отправкой сообщения с сайта.
module RequestFormsHelper
  # Хэлпер преобразует поля, заполняемые пользователем на странице «Контакты» в осмысленный текст,
  # который затем вставляется в письмо, отправляемое с сайта.
  #
  # @param [Hash] parts Поля, заполненные пользователем на странице «Контакты».
  #
  # @return [String]
  def request_email_text(parts)
    comment = if parts[:comments].present?
                "<p>Комментарий к запросу: <em>#{parts[:comments]}</em></p>\n"
              else
                ''
              end

    "<p>#{line_with_name(parts)}</p>\n" \
    '<p>Заказчик указал, что его интересуют следующие темы: ' \
    "#{parts[:topics].map { |s| "#{Unicode.downcase(s[0, 1])}#{s[1..-1]}" }.join(', ')}.</p>\n" \
    "#{comment}<p>Телефон для связи — <strong>#{parts[:phone]}</strong>, " \
    "электронная почта — <a href='mailto:#{parts[:email]}'>#{parts[:email]}</a>.</p>"
  end

  private

  # Генерация первой строчки письма с сообщением с сайта: имя и фамилия пользователя, организация
  # и город.
  #
  # @param [Hash] parts Поля, заполненные пользователем на странице «Контакты».
  #
  # @return [String]
  def line_with_name(parts)
    text = []
    text << parts[:first_name]
    text << parts[:last_name]

    text << "из компании #{parts[:organization]}" if parts[:organization].present?
    text << "(#{parts[:city]})" if parts[:city].present?

    text << 'отправил новый запрос через сайт.'

    text.join(' ')
  end
end

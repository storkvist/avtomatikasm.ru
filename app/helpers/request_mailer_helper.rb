module RequestMailerHelper
  def request_email_text(parts)
    text = []
    text << parts[:first_name]
    text << parts[:last_name]

    text << "из компании #{parts[:organization]}" if parts[:organization]
    text << "(#{parts[:city]})" if parts[:city]

    text << 'отправил новый запрос через сайт.'

    comment = "<p>Комментарий к запросу: <em>#{parts[:comments]}</em></p>" || ''

    "<p>#{text.join(' ')}</p>" \
    "<p>Заказчик указал, что его интересуют следующие темы: " \
    "#{parts[:topics].map { |s| "#{Unicode::downcase(s[0, 1])}#{s[1..-1]}" }.join(', ')}.</p>" \
    "#{comment}" \
    "<p>Телефон для связи — <strong>#{parts[:phone]}</strong>, " \
    "электронная почта — <a href='mailto:#{parts[:email]}'>#{parts[:email]}</a>.</p>"
  end
end

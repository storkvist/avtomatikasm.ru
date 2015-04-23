require 'rails_helper.rb'

RSpec.describe RequestMailer do
  describe 'при отправке сообщения с сайта' do
    def full_request_parts
      {
        first_name: 'First Name',
        last_name: 'Last Name',
        organization: 'Organization',
        email: 'Email',
        city: 'City',
        phone: 'Phone',
        topics: %w(Topic1 Topic2),
        comments: 'Comments.'
      }
    end

    let(:html_part) do
      "<!DOCTYPE html>\n" \
      "<html>\n" \
      "<head>\n" \
      "  <meta content='text/html; charset=UTF-8' http-equiv='Content-Type' />\n" \
      "</head>\n" \
      "<body>\n" \
      "<h1>С сайта получен новый запрос.</h1>\n" \
      "\n" \
      '<p>First Name Last Name из компании Organization (City) ' \
      "отправил новый запрос через сайт.</p>\n" \
      "<p>Заказчик указал, что его интересуют следующие темы: topic1, topic2.</p>\n" \
      "<p>Комментарий к запросу: <em>Comments.</em></p>\n" \
      '<p>Телефон для связи — <strong>Phone</strong>, ' \
      "электронная почта — <a href='mailto:Email'>Email</a>.</p>\n\n" \
      "</body>\n" \
      "</html>\n"
    end

    let(:text_part) do
      "С сайта получен новый запрос.\n" \
      "===============================================\n" \
      "\n" \
      "First Name Last Name из компании Organization (City) отправил новый запрос через сайт.\n" \
      "\n\n" \
      "Заказчик указал, что его интересуют следующие темы: topic1, topic2.\n" \
      "\n\n" \
      "Комментарий к запросу: Comments.\n" \
      "\n\n" \
      "Телефон для связи — Phone, электронная почта — Email.\n" \
      "\n\n\n"
    end

    it 'отправляется сообщение' do
      email = RequestMailer.send_message(full_request_parts).deliver_now

      expect(ActionMailer::Base.deliveries.size).to be >= 1

      expect(email.from).to eql([full_request_parts[:email]])
      expect(email.to).to eql([ASM_EMAIL])
      expect(email.subject).to eql('Новое сообщение с сайта!')

      expect(email.html_part.body.to_s).to eql(html_part)
      expect(email.text_part.body.to_s).to eql(text_part)
    end

    it 'в сообщении не указывается организация, если её не указали' do
      email = RequestMailer.send_message(full_request_parts.except(:organization)).deliver_now

      organization = full_request_parts[:organization]
      expect(email.html_part.body.to_s).not_to include(organization)
      expect(email.text_part.body.to_s).not_to include(organization)
    end

    it 'в сообщении не указывается город, если он не указан' do
      email = RequestMailer.send_message(full_request_parts.except(:city)).deliver_now

      city = full_request_parts[:city]
      expect(email.html_part.body.to_s).not_to include(city)
      expect(email.text_part.body.to_s).not_to include(city)
    end

    it 'в сообщении не указывается коментарий, если он не указан' do
      email = RequestMailer.send_message(full_request_parts.except(:comments)).deliver_now

      comments = full_request_parts[:comments]
      expect(email.html_part.body.to_s).not_to include(comments)
      expect(email.text_part.body.to_s).not_to include(comments)
    end
  end
end

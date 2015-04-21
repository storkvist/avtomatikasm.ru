require 'test_helper'

class RequestMailerTest < ActionMailer::TestCase
  def full_parts
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

  test 'отправляется сообщение с сайта при введении верных данных' do
    email = RequestMailer.send_message(full_parts).deliver_now

    refute_empty ActionMailer::Base.deliveries

    assert_equal email.from, [full_parts[:email]]
    assert_equal email.to, [ASM_EMAIL]
    assert_equal email.subject, 'Новое сообщение с сайта!'

    assert_equal email.html_part.body.to_s, read_fixture('request.html.txt').join
    assert_equal email.text_part.body.to_s, read_fixture('request.text.txt').join
  end

  test 'при не указанной организации название организации не отправляется' do
    email = RequestMailer.send_message(full_parts.except(:organization)).deliver_now

    assert_not(email.html_part.body.to_s.include?("из компании #{full_parts[:organization]}"))
    assert_not(email.text_part.body.to_s.include?("из компании #{full_parts[:organization]}"))
  end

  test 'при не указанном городе название города не отправляется' do
    email = RequestMailer.send_message(full_parts.except(:city)).deliver_now

    assert_not(email.html_part.body.to_s.include?("(#{full_parts[:city]})"))
    assert_not(email.text_part.body.to_s.include?("(#{full_parts[:city]})"))
  end

  test 'при не указанном комментарии к запросу комментарий к запросу не отправляется' do
    email = RequestMailer.send_message(full_parts.except(:comments)).deliver_now

    assert_not(email.html_part.body.to_s.include?('Комментарий к запросу'))
    assert_not(email.text_part.body.to_s.include?('Комментарий к запросу'))
  end
end

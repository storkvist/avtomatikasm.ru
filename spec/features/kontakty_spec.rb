require 'rails_helper'

RSpec.describe 'Страница «Контакты»', type: :feature do
  it 'При указании верных данных сообщение отправляется' do
    visit '/kontakty'

    expect(page).not_to have_selector('.request_form_first_name .error',
                                      text: 'не может быть пустым')
    expect(page).not_to have_selector('.request_form_last_name .error',
                                      text: 'не может быть пустым')
    expect(page).not_to have_selector('.request_form_email .error', text: 'не может быть пустым')
    expect(page).not_to have_selector('.request_form_phone .error', text: 'не может быть пустым')
    expect(page).not_to have_selector('.request_form_topics .error', text: 'не может быть пустым')

    fill_in 'Имя', with: 'Иван'
    fill_in 'Фамилия', with: 'Иванов'
    fill_in 'Электронная почта', with: 'ivan@ivanov.ru'
    fill_in 'Телефон', with: '+79261234567'
    find(:css, '.request_form_topics input[value="Пожарная сигнализация"]').set(true)
    click_button 'Отправить сообщение'

    expect(page).to have_text('Ваше сообщение отправлено. Очень скоро мы свяжемся с вами.')
  end

  it 'При незаполненных полях сообщение не отправляется' do
    visit '/kontakty'
    click_button 'Отправить сообщение'

    expect(page).to have_text('При отправке вашего сообщения возникли некоторые ошибки:')

    expect(page).to have_selector('.request_form_first_name .error', text: 'не может быть пустым')
    expect(page).to have_selector('.request_form_last_name .error', text: 'не может быть пустым')
    expect(page).to have_selector('.request_form_email .error', text: 'не может быть пустым')
    expect(page).to have_selector('.request_form_phone .error', text: 'не может быть пустым')
    expect(page).to have_selector('.request_form_topics .error', text: 'не может быть пустым')
  end

  it 'При попытке отправить неверные данные то, что введено пользователем, сохраняется' do
    visit '/kontakty'

    fill_in 'Имя', with: 'Иван'
    fill_in 'Фамилия', with: 'Иванов'
    fill_in 'Организация', with: 'ООО «Рога и копыта»'
    fill_in 'Электронная почта', with: 'неправильный адрес электронной почты'
    fill_in 'Город', with: 'Москва'
    fill_in 'Телефон', with: '+79261234567'
    find(:css, '.request_form_topics input[value="Пожарная сигнализация"]').set(true)
    fill_in 'Дополнительная информация', with: 'Комментарий к запросу. Комментарий к запросу.'
    click_button 'Отправить сообщение'

    expect(page).to have_text('При отправке вашего сообщения возникли некоторые ошибки:')
    expect(page).to have_selector('.request_form_email .error',
                                  text: 'не является электронной почтой')

    expect(page).to have_field('request_form[first_name]', with: 'Иван')
    expect(page).to have_field('request_form[last_name]', with: 'Иванов')
    expect(page).to have_field('request_form[organization]', with: 'ООО «Рога и копыта»')
    expect(page).to have_field('request_form[email]', with: 'неправильный адрес электронной почты')
    expect(page).to have_field('request_form[city]', with: 'Москва')
    expect(page).to have_field('request_form[phone]', with: '+79261234567')
    expect(find(:css, '.request_form_topics input[value="Пожарная сигнализация"]')).to be_checked
    expect(page).to have_field('request_form[comments]',
                               with: 'Комментарий к запросу. Комментарий к запросу.')
  end
end

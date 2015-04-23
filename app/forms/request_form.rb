# Форма для отправки сообщения с сайта.
#
# @attr [String] first_name Имя.
# @attr [String] last_name Фамилия.
# @attr [String] organization Организация.
# @attr [String] email Электронная почта.
# @attr [String] city Город.
# @attr [String] phone Телефон.
# @attr [Array<String>] topics Список услуг.
# @attr [String] comments Текст сообщения.
class RequestForm
  include ActiveModel::Model

  # Список атрибутов, которыми обладает форма.
  ATTRIBUTES = [:first_name, :last_name, :organization, :email, :city, :phone, :topics, :comments]

  attr_accessor(*ATTRIBUTES)

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, email: true
  validates :phone, presence: true
  validates :topics, presence: true

  # Конструктор формы.
  #
  # Инициализирует форму начальными значениями. При переданном параметре :validate выполняет
  # валидацию формы, чтобы она «заполнилась» сообщениями об ошибках.
  #
  # @param [Hash] params Начальные данные для формы.
  #
  # @return [RequestForm]
  def initialize(params)
    params[:request_form] ||= {}
    params[:request_form][:topics] ||= []

    ATTRIBUTES.each do |attribute|
      send("#{attribute}=", params[:request_form][attribute])
    end

    params[:request_form][:topics].reject!(&:blank?)

    valid? if params[:validate]
  end

  # Отправка сообщения с сайта.
  #
  # @return [Boolean] Результат отправки сообщения.
  def submit
    if valid?
      RequestMailer.send_message(parts).deliver_later
      true
    else
      false
    end
  end

  private

  def parts
    ATTRIBUTES.map { |attribute| { attribute => send(attribute.to_s) } }.reduce(:merge)
  end
end

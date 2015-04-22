class RequestForm
  include ActiveModel::Model

  ATTRIBUTES = [:first_name, :last_name, :organization, :email, :city, :phone, :topics, :comments]

  attr_accessor *ATTRIBUTES

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, email: true
  validates :phone, presence: true
  validate :topics_should_present

  def initialize(params)
    params[:request_form] ||= {}
    params[:request_form][:topics] ||= []

    ATTRIBUTES.each do |attribute|
      send("#{attribute}=", params[:request_form][attribute])
    end

    params[:request_form][:topics].reject! { |element| element.blank? }

    valid? if params[:validate]
  end

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

  def topics_should_present
    errors.add(:topics, 'должно быть что-то выбрано') if @topics.empty?
  end
end

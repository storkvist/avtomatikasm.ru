# Валидатор того, что в данных содержится адрес электронной почты.
class EmailValidator < ActiveModel::EachValidator
  # Проверка данных на то, что они являются адресом электронной почты.
  #
  # @param record Объект, содержащий проверяемые данные.
  # @param [Symbol] attribute Поле, содержащее в себе проверяемые данные.
  # @param value Проверяемые данные.
  #
  # @return [void]
  def validate_each(record, attribute, value)
    return if value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

    record.errors[attribute] << (options[:message] || 'не является электронной почтой')
  end
end

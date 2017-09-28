class PostalFormatValidator < ActiveModel::EachValidator
  def validate_each(object, attribute, value)
    unless value =~ /^[0-9]{3}-[0-9]{4}$/i || value == nil || value == ''
      object.errors.add(attribute, :postal_format, options)
    end
  end
end

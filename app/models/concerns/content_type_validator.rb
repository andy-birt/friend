class ContentTypeValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return unless value.attached?
    record.errors[attribute] << "File is not an image." unless %w(image/jpg image/jpeg image/png).include?(value.content_type)
  end
end
class SizeRangeValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return unless value.attached?
    record.errors[attribute] << "Photo must be less than 5 mb." if value.byte_size > 5.megabytes
  end
end
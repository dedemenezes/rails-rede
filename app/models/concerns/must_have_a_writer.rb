class MustHaveAWriter < ActiveModel::Validator
  def validate(record)
    return if record.current_writer_type.present?

    record.errors.add(:writer, :blank)
  end
end

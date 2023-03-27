class MustHaveAWriter < ActiveModel::Validator
  def validate(record)
    binding.break
    unless record.current_writer_type.present?
      record.errors.add :writer, "can't be blank"
    end
  end
end

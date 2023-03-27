class MustHaveAWriter < ActiveModel::Validator
  def validate(record)
    unless record.current_writer_type.present?
      record.errors.add :writer, "Project, Observatory or Methodology must be writer"
    end
  end
end

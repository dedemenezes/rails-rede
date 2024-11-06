module SetTags
  def self.tagging(instance, params)
    model_name_as_symbol = extract_model_name(instance)
    return unless params[model_name_as_symbol][:tag_ids].present?

    ids = sanitize_and_remove_blanks(params)
    # tag_names = params[model_name_as_symbol][:tag_ids].select { |id| id.match?(/[a-zA-Z]/) }
    # ids.delete('')
    # removed_taggings = instance.taggings.reject { |tagging| ids.include? tagging.tag.id.to_s }

    instance.taggings.each(&:destroy)
    tags = ids.map { |id| Tag.find(id) }
    counter = 0
    tags.map do |tag|
      tagging = Tagging.create tag:, taggable: instance
      tagging.update!(visible: true) if counter < 2
      counter += 1
    end
  end

  def self.extract_model_name(instance)
    instance.model_name.to_s.downcase.parameterize.gsub('-', '_').to_sym
  end

  def self.sanitize_and_remove_blanks(params)
    params[model_name_as_symbol][:tag_ids].grep_v(/[a-zA-Z]/).compact_blank
  end
end

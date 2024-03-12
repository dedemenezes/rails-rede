module SetTags
  def self.tagging(instance, params)
    tags = []
    model_name_as_symbol = instance.model_name.to_s.downcase.parameterize.gsub('-', '_').to_sym
    return unless params[model_name_as_symbol][:tag_ids].present?

    ids = params[model_name_as_symbol][:tag_ids].grep_v(/[a-zA-Z]/)
    # tag_names = params[model_name_as_symbol][:tag_ids].select { |id| id.match?(/[a-zA-Z]/) }
    # ids.delete('')
    removed_taggings = instance.taggings.reject { |tagging| ids.include? tagging.tag.id.to_s }
    removed_taggings.each(&:destroy)
    # tags = tag_names.map { |name| Tag.create(name:) }
    tags << Tag.where(id: ids)
    tags = tags.flatten
    tags.map do |tag|
      Tagging.create tag:, taggable: instance
    end
  end
end

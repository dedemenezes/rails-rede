module Featureable
  extend ActiveSupport::Concern

  included do
    before_save :ensure_featured_exclusivity
    after_save :demote_previous_main_featured
    after_save :promote_latest_featured_if_main_featured_removed
  end

  private

  def ensure_featured_exclusivity
    self.featured = false if main_featured
  end

  def demote_previous_main_featured
    return unless saved_change_to_main_featured? && main_featured

    Article.where.not(id: id).where(main_featured: true).update_all(main_featured: false)
  end

  def promote_latest_featured_if_main_featured_removed
    return unless saved_change_to_main_featured? && !main_featured

    latest = Article.where(featured: true).order(featured_at: :desc).first
    latest&.update!(main_featured: true)
  end
end

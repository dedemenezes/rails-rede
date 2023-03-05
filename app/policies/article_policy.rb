class ArticlePolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      Article.count.positive? ? scope.all : false
    end
  end

  def show?
    true
  end

end

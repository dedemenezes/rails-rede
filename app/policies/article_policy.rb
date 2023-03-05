class ArticlePolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.only_published
    end
  end

  def show?
    true
  end

end

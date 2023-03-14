class GalleryPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.published
    end
  end

  def show?
    record.published
  end

  def destroy?
    user.admin?
  end
end

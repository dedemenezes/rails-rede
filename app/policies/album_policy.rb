class AlbumPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

  def new?
    user.admin?
  end

  def update?
    user.admin?
  end

  def show?
    true
  end

  def destroy?
    user.admin?
  end
end

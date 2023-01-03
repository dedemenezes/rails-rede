class Dashboard::ProjectPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

  def show?
    admin?
  end

  def new?
    create?
  end

  def edit?
    update?
  end

  def update?
    admin?
  end

  def create?
    admin?
  end

  def admin?
    user.admin?
  end
end

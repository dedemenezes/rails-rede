class MethodologyPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      user&.admin? ? scope.all : scope.published
    end
  end

  def show?
    true
  end

  def new?
    create?
  end

  def create?
    false
  end

  def edit?
    user.admin?
  end

  def destroy?
    false
  end
end

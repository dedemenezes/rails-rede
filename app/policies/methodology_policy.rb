class MethodologyPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
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

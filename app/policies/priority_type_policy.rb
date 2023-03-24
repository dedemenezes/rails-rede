class PriorityTypePolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def new?
    admin?
  end

  def destroy?
    new?
  end

  def admin?
    user.admin?
  end
end

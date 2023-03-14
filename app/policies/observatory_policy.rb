class ObservatoryPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.includes(:conflict_type, :priority_type).where(published: true)
    end
  end

  def show?
    record.published
  end

  def destroy?
    user.admin?
  end
end

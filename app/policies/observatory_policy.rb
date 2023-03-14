class ObservatoryPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.includes(:conflict_type, :priority_type, banner_attachment: :blob).where(published: true)
    end
  end

  def show?
    record.published
  end

  def destroy?
    user.admin?
  end
end

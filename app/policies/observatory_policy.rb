class ObservatoryPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.includes(:conflict_type, :priority_subjects, banner_attachment: :blob).where(published: true)
    end
  end

  def new?
    user&.admin?
  end

  def show?
    true
  end

  def destroy?
    user.admin?
  end
end

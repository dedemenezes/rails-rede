class ProjectPolicy < Dashboard::UserPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def show?
    false
  end

  def destroy?
    false
  end
  def edit?
    true
  end
end

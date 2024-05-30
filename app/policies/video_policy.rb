class VideoPolicy < Dashboard::UserPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      user&.admin? ? scope.all : scope.published
    end
  end

  def show?
    false
  end
end

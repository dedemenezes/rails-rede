class Dashboard::UserPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def index?
    home?
  end

  def new?
    home?
  end

  def create?
    home?
  end

  def destroy?
    home?
  end

  def home?
    user.admin?
  end
end

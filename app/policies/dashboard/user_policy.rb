module Dashboard
  class UserPolicy < ApplicationPolicy
    class Scope < Scope
      # NOTE: Be explicit about which records you allow access to!
      def resolve
        scope.all if user.admin?
      end
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

    def edit?
      home?
    end

    def update?
      home?
    end

    def home?
      user.admin?
    end
  end
end

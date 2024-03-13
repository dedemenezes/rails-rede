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

    def show?
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

    def update_banner?
      home?
    end

    def home?
      user.admin?
    end

    def imagens?
      home?
    end

    def documentos?
      home?
    end

    def edit_document?
      home?
    end
  end
end

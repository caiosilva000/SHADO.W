class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def create?
      user.senior?
    end
  end
end

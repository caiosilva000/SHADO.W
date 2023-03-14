class ChatRoomPolicy < ApplicationPolicy
  class Scope < Scope
    def create?
      user.senior?
    end

    def destroy?
      record.owner == user
    end
  end
end

class RoomPolicy < ApplicationPolicy
  def create?
    user.user? || user.admin?
  end

  def destroy?
    user.profile == record.profile
  end
end
class MessagePolicy < ApplicationPolicy
  def create?
    !user.profile.blocked?
  end
end
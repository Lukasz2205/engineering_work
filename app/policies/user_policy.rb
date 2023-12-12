class UserPolicy < ApplicationPolicy
  def is_admin?
    user.admin?
  end

  def blocked?
    user.profile.blocked?
  end
end
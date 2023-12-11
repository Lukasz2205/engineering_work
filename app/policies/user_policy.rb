class UserPolicy < ApplicationPolicy
  def is_admin?
    user.admin?
  end
end
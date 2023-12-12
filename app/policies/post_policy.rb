class PostPolicy < ApplicationPolicy
  def show?
    user_or_admin?
  end

  def create?
    user_or_admin? && !blocked?
  end
  def destroy?
    user.profile == record.profile || user.admin?
  end

  private

  def user_or_admin?
    user.user? || user.admin?
  end

  def blocked?
    user.profile.blocked?
  end
end
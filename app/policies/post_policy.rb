class PostPolicy < ApplicationPolicy
  def show?
    user_or_admin?
  end

  def create?
    user_or_admin? && !blocked?
  end
  def destroy?
    owner_or_admin?
  end

  def owner_admin?
    owner_or_admin?
  end

  private

  def owner_or_admin?
    user.profile == record.profile || user.admin?
  end
  def user_or_admin?
    user.user? || user.admin?
  end

  def blocked?
    user.profile.blocked?
  end
end
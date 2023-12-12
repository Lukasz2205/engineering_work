class CommentPolicy < ApplicationPolicy
  def owner_admin?
    owner_or_admin?
  end

  private

  def owner_or_admin?
    user.profile == record.profile || user.admin?
  end
end
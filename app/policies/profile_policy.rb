class ProfilePolicy < ApplicationPolicy
  def edit?
    user == record.user
  end
  def update?
    user == record.user
  end

  def own_profile?
    user == record.user
  end

  def block?
    user.admin?
  end

  def unblock?
    user.admin?
  end
end
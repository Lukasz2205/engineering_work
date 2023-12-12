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
    self_and_admin
  end

  def unblock?
    self_and_admin
  end

  private

  def self_and_admin
    record != user.profile && user.admin?
  end
end
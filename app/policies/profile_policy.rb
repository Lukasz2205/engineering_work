class ProfilePolicy < ApplicationPolicy
  attr_reader :user

  def initialize(user, record)
    super
  end

  def edit?
    user == record.user
  end
  def update?
    user == record.user
  end
end
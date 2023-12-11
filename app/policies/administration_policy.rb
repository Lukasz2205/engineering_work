class AdministrationPolicy < ApplicationPolicy
  attr_reader :user
  def initialize(user)
    @user = user
  end
  def is_admin?
   user.role == 'admin'
  end
end
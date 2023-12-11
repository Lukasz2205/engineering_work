class PostPolicy < ApplicationPolicy

  def show?
    user_or_admin?
  end
  def create?
    user_or_admin?
  end

  def update?
    user_or_admin?
  end

  def destroy
    user_or_admin?
  end

  private

  def user_or_admin?
    user.role == 'user' || user.role == 'admin'
  end

end
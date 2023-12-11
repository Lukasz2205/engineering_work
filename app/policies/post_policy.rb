class PostPolicy
  attr_reader :user, :post

  def create?
    user.user?
  end
end
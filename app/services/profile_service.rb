class ProfileService
  def initialize(profile)
    @profile = profile
  end

  def get_likes
    likeables = @profile.likes.where(likeable_type: 'Post').pluck(:likeable_id)
    Post.where(id: likeables)
  end

  def get_comments
    @profile.comments
  end
end

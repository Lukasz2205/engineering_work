class ProfileLikedPostsService
  def initialize(profile)
    @profile = profile
  end

  def get_likes
    likeables = @profile.likes.where(likeable_type: 'Post').pluck(:likeable_id)
    posts = Post.where(id: likeables)
    posts
  end
end

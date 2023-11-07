class ProfileService
  def initialize(profile)
    @profile = profile
  end

  def get_likes
    liked_posts = @profile.likes.where(likeable_type: 'Post').pluck(:likeable_id)
    liked_comments = @profile.likes.where(likeable_type: 'Comment').pluck(:likeable_id)
    posts = Post.where(id: liked_posts).order(' created_at DESC')
    posts += Comment.where(id: liked_comments).order(' created_at DESC')
    posts
  end

  def get_comments
    @profile.comments.order(' created_at DESC')
  end
end

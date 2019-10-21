module AddFiltersAndAccessDateToBlogPostsController

  def index
    @posts = @posts.to_a
    @recent_post = @posts.shift
    super
  end

  def show
    @post.accesses.create
    # popularity = ::Refinery::Blog::PostAccess.popularity.map(&:post_id)
    @popular_posts = ::Refinery::Blog::Post.live.
                # order("idx(array[#{popularity.join(',')}]::integer[], refinery_blog_posts.id)").
                newest_first.
                page(params[:page]).limit(4).to_a
    @siebar_popular_posts = @popular_posts.take(3)
    super
  end

  # def most_popular
  #   render action: "index"
  # end

  protected

  # def find_all_blog_posts
  #   case action_name
  #   when "most_popular"
  #     popularity = ::Refinery::Blog::PostAccess.popularity.map(&:post_id)
  #     # Calling newest_first after ordering by popularity is because we want it
  #     # to fall back to sorting normally where a post hasn't been accessed in the last
  #     # 6 months.
  #     # Uses the psql extension "intarray", enabled in the migration for PostAccess.
  #     @posts = ::Refinery::Blog::Post.live.includes(:translations, :comments, :categories).
  #                 order("idx(array[#{popularity.join(',')}]::integer[], refinery_blog_posts.id)").
  #                 newest_first.
  #                 page(params[:page]).to_a
  #     @recent_post = @posts.shift
  #   else
  #     super
  #   end
  # end

end

::Refinery::Blog::PostsController.prepend AddFiltersAndAccessDateToBlogPostsController

module AddSignupFinder
  class Signup
    def self.call(_params)
      Refinery::Page.find_by link_url: "/signup"
    end
  end
end

Refinery::PagesController::Finders.prepend AddSignupFinder


Refinery::PagesController.class_eval do
  before_action :find_recent_blog_posts,
                :find_recent_podcasts, only: [:home]

  protected

  def find_recent_blog_posts
    # popularity = ::Refinery::Blog::PostAccess.popularity.map(&:post_id)
    @posts = ::Refinery::Blog::Post.live.includes(:translations, :comments, :categories).
                # order("idx(array[#{popularity.join(',')}]::integer[], refinery_blog_posts.id)").
                newest_first.
                page(params[:page]).limit(5).to_a
    @recent_post = @posts.shift
  end

  def find_recent_podcasts
    @recent_podcasts = Refinery::Podcasts::Podcast.published.order("published_at ASC").limit(5)
  end
end

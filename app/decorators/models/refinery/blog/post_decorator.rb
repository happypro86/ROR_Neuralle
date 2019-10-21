module Refinery
  module Blog
    Post.has_many :accesses, class_name: "::Refinery::Blog::PostAccess"
  end
end

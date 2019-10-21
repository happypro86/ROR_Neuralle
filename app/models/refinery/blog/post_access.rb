require "refinery/core/base_model"

module Refinery
  module Blog
    class PostAccess < ::Refinery::Core::BaseModel
      def self.popularity
        select("post_id, COUNT(post_id) AS accesses_count")
          .group(:post_id)
          .order("accesses_count DESC")
      end
    end
  end
end

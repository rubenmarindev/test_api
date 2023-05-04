class PostsSearchService
  def self.search(posts, query_param)
    posts_ids = Rails.cache.fetch("", expires_in: 1.hours) do
      posts.where("title like '%#{query_param}%'").map(&:id)
    end

    posts.where(id: posts_ids)
  end
end

class PostsSearchService
  def self.search(posts, query_param)
    posts.where("title like '%#{query_param}%'")
  end
end

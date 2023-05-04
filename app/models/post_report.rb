class PostReport < Struct.new(:word_count, :word_histogram)
  def self.generate(post)
    #word_count
    post.content.split.map { |word| word.gsub(/\W/, '') }.count
    #word_histogram
    calculate_histogram(post)
  end

  private

  def self.calculate_histogram(post)
    (post.
       content.
       split.
       map { |word| word.gsub(/\W/, '') }.
       map(&:downcase).
       group_by { |word| word }.
       transform_values(&:size))
  end
end

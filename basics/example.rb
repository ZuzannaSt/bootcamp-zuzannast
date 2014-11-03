class Article

attr_reader :title
attr_reader :body
attr_reader :author
attr_reader :created_at
attr_accessor :likes
attr_accessor :dislikes

  def title
    @title
  end

  def body
    @body
  end

  def author
    @author
  end

  def created_at
    @created_at
  end

  def likes(value)
    @likes = value
  end

  def dislikes(value)
    @dislikes = value
  end

end
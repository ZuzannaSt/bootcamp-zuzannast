class Article
  attr_reader :title, :body, :author, :created_at
  attr_accessor :likes, :dislikes, :points, :votes

  def initialize(title, body, author=nil)
    @title = title
    @body = body
    @author = author

    @created_at = Time.now
    @likes = 0
    @dislikes = 0
  end

  def like!
    self.likes += 1
  end

  def dislike!
    self.dislikes += 1
  end

  def points
    @points = likes - dislikes
  end

  def votes
    @votes = likes + dislikes
  end

  def long_lines   
    body.lines.select { |line| line.length > 80 }
  end

  def length
    @body.length
  end

  def truncate(limit)
    limit = limit - 3
    if body.length > limit
      body.slice!(limit..body.length)
      body << ('...')
    else
      body
    end
  end

  def contain?(value)
    if !!@body.match(value) 
      true
    else
      false
    end
  end
end


class ArticlesFileSystem
  def initialize
  end
end
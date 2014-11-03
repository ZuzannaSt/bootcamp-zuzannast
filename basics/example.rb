class Article
  attr_reader :title, :body, :author, :created_at
  attr_accessor :likes, :dislikes, :points, :votes

  def initialize(title, body, author=nil)
  	@title = "New OSX"
  	@body = "Some text about new OSX"
  	@author = author

  	@created_at = Time.now
  	@likes = 0
    @dislikes = 0
  end

  def like!
  	@likes += 1
  end

  def dislike!
  	@dislikes += 1
  end

  def points
  	@points = @likes - @dislikes
  end

  def votes
  	@votes = @likes + @dislikes
  end
end
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
  	self.likes += 1
  end

  def dislike!
  	self.dislikes += 1
  end

  def points
  	@points = @likes - @dislikes
  end

  def votes
  	@votes = @likes + @dislikes
  end

  def long_lines   
    long_line = []

    body.lines.each do |line|
      if line.length > 80
        line
      end
    end
  end

  def length
    @body.length
  end

  def truncate(limit)
  	if @body.length > limit
      @body.truncate
  	end
  end

  def contain?(value)
    true
  end

end
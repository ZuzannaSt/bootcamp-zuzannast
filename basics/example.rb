class Article
  attr_reader :title, :body, :author, :created_at
  attr_accessor :likes, :dislikes

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
    likes - dislikes
  end

  def votes
    likes + dislikes
  end

  def long_lines
    body.lines.select { |line| line.length > 80 }
  end

  def length
    @body.length
  end

  def truncate(limit)
    if length > limit
      body.slice(0, limit - 3) + "..."
    else
      body
    end
  end

  def contain?(value)
    !!@body.match(value)
  end
end

class ArticlesFileSystem
  def initialize(dir)
    @dir = dir
  end

  def save(articles)
    articles.each do |article|
      file_name = article.title.downcase.gsub(' ', '_')
      path = @dir + '/' + file_name + '.article'
      file_body = [article.author, article.likes, article.dislikes, article.body].join('||')
      File.open(path, "w+") { |f| f.write(file_body) }
    end
  end

  def load
    articles = []
    Dir.glob(@dir + "/*.article").each do |file|
      file_name = file.split('.')[0]
      file_name = file_name.split('/')[1]
      file_name = file_name.gsub('_',' ').capitalize
      author, likes, dislikes, body = File.open(file).read.split('||', 4)
      likes = likes.to_i
      dislikes = dislikes.to_i
      article = Article.new(file_name, body, author)

      likes.times {article.like!}
      dislikes.times {article.dislike!}

      articles << article
    end
    articles
  end
end

class WebPage
class NoArticlesFound < StandardError; end
  attr_reader :articles, :articles_file_system

  def initialize(dir = '/')
    @articles_file_system = ArticlesFileSystem.new(dir)
    @articles = []
    load
  end

  def load
    @articles = articles_file_system.load
  end

  def save(articles)
    articles_file_system.save(articles)
  end

  def new_article(title, body, author)
    article = Article.new(title, body, author)
    @articles << article
  end

  def longest_articles
    articles.sort_by{ |article| article.length }.reverse
  end

  def best_articles
    articles.sort_by{ |article| article.points }.reverse
  end

  def worst_articles
    articles.sort_by{ |article| article.points }
  end

  def best_article
    raise WebPage::NoArticlesFound if articles.empty?
    articles.max_by{ |article| article.points }
  end

  def worst_article
    raise WebPage::NoArticlesFound if articles.empty?
    articles.min_by{ |article| article.points }
  end

  def most_controversial_articles
    articles.sort_by{ |article| article.votes }.reverse
  end
end

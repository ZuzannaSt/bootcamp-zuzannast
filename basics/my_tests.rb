require 'minitest/autorun'
require './example'
require 'tmpdir'

class ArticleTest < Minitest::Test
  def setup
    @with_author = Article.new("Windows", "New Windows 10", "The Verge")
    @no_author = Article.new("OSX", "Yosemite updates")
    @short_line = "Short lines are short."
    @long_line = "Long lines are very long. Actually they are longer than 80 characters. And are very long."
    @long_article = Article.new("Long", "#{@short_line}\n#{@long_line}", "Author")
  end

  def test_initialization
    assert @with_author.author
    assert_in_delta Time.now.to_f, @with_author.created_at.to_f, 0.001
    assert_equal 0, @with_author.dislikes
    assert_equal 0, @with_author.likes
  end

  def test_initialization_with_anonymous_author
    assert_nil @no_author.author
    assert_in_delta Time.now.to_f, @no_author.created_at.to_f, 0.001
    assert_equal 0, @no_author.dislikes
    assert_equal 0, @no_author.likes
  end

  def test_liking
    3.times { @with_author.like! }
    assert_equal 3, @with_author.likes
  end

  def test_disliking
    3.times { @with_author.dislike! }
    assert_equal 3, @with_author.dislikes
  end

  def test_points
    6.times { @with_author.like! }
    2.times { @with_author.dislike! }
    assert_equal 4, @with_author.points
  end

  def test_long_lines
    assert_equal [@long_line], @long_article.long_lines
  end

  def test_truncate
    assert_equal "New Wind...", @with_author.truncate(11)
  end

  def test_truncate_when_limit_is_longer_then_body
    assert_equal "New Windows 10", @with_author.truncate(20)
  end

  def test_truncate_when_limit_is_same_as_body_length
    assert_equal "New Windows 10", @with_author.truncate(14)
  end

  def test_length
    assert_equal 14, @with_author.length
  end

  def test_votes
    6.times { @with_author.like! }
    4.times { @with_author.dislike! }
    assert_equal 10, @with_author.votes
  end

  def test_contain
    assert_equal true, @with_author.contain?("Windows")
  end
end

# class ArticlesFileSystemTest < Minitest::Test
#   def setup
#     @article1 = Article.new("Title1", "Body1", "Author1")
#     @article2 = Article.new("Title2", "Body2", "Author2")
#     @articles = [@article1, @article2]
#     @tmp_dir = Dir.mktmpdir
#     @file_system = ArticlesFileSystem.new(@tmp_dir)
#   end

#   def test_saving
#     saved = @file_system.save(@articles)
#     assert_equal "Author1", saved[0].author
#     assert_equal "Body2", saved[1].body
#   end

#   def test_loading
#     @articles = @file_system.load
#     assert_equal "Title1", @articles[0]
#     assert_equal "Body2", @articles[1].body
#   end
# end

class WebPageTest < Minitest::Test
  def setup
    @empty_article = Article.new(nil, nil)
    @full_article = Article.new("Title", "This is some body", "Author")
    @short_article = Article.new("Tit", "Body", "Author")
    @articles = [@empty_article, @full_article, @short_article]
    6.times { @full_article.like! }
    3.times { @short_article.like! }
  end

  def test_new_without_anything_to_load
    assert_nil @empty_article.title
    assert_nil @empty_article.body
    assert_nil @empty_article.author

  end

  def test_new_article
    assert @full_article.title
    assert @full_article.body
    assert @full_article.author
  end

  def test_longest_article
    assert_equal [@full_article, @short_article, @empty_article], @articles.longest_articles
  end

  def test_best_articles
    assert_equal [@full_article, @short_article, @empty_article], @articles.best_articles
  end

  def test_best_article
    assert_equal [@full_article], @articles.best_article
  end

  def test_best_article_exception_when_no_articles_can_be_found
    @articles = []
    @articles.best_article
    assert_not @articles.errors.empty?
  end

  def test_worst_articles
    assert_equal [@empty_article, @short_article, @full_article], @articles.worst_articles
  end

  def test_worst_article
    4.times { @empty_article.like! }
    assert_equal [@short_article], @articles.worst_article
  end

  def test_worst_article_exception_when_no_articles_can_be_found
    @articles = []
    @articles.worst_article
    assert_not @articles.errors.empty?
  end

  def test_most_controversial_articles
    5.times { @full_article.dislike! }
    4.times { @empty_article.dislike! }
    assert_equal [@full_article, @empty_article, @short_article], @articles.most_controversial_articles
  end

  def test_votes
    assert_equal 9, @articles.votes
  end

  def test_authors
    assert_equal ["Author"], @articles.authors
  end

  def test_authors_statistics
    assert_equal "'Author' => 2", @articles.authors_statistics
  end

  def test_best_author
    assert_equal "Author", @articles.best_author
  end

  def test_search
    assert_equal [@full_article], @articles.search("some")
  end
end

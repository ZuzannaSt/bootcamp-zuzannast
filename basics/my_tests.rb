require 'minitest/autorun'
require './example'

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

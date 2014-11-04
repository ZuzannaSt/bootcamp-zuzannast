require 'minitest/autorun'
require './example'

class ArticleTest < Minitest::Test
  def setup
    @with_author = Article.new("Windows", "New Windows 10", "The Verge")
    @no_author = Article.new("OSX", "Yosemite updates", nil)
  end

  def test_initialization
    6.times { assert(@with_author)}
    assert_in_delta(Time.now.to_f, @with_author.created_at.to_f, delta = 0.001)
    assert_equal(0, @with_author.dislikes)
    assert_equal(0, @with_author.likes)
  end

  def test_initialization_with_anonymous_author
    6.times { assert(@no_author)}
    assert_nil(@no_author.author)
    assert_in_delta(Time.now.to_f, @no_author.created_at.to_f, delta = 0.001)
    assert_equal(0, @no_author.dislikes)
    assert_equal(0, @no_author.likes)
  end

  def test_liking
    @with_author.like!
    assert_equal(1, @with_author.likes)
  end
 
  def test_disliking
    @with_author.dislike!
    assert_equal(1, @with_author.dislikes)
  end

  def test_points 
    assert_equal(0, @with_author.likes)
    assert_equal(0, @with_author.dislikes)
  end

  def test_long_lines
    assert_in_delta(0, @with_author.body.lines.length, delta = 80)
  end

  def test_truncate
    assert_equal(14, @with_author.body.length)
  end

  def test_truncate_when_limit_is_longer_then_body
    assert_equal(14, @with_author.body.length)
  end

  def test_truncate_when_limit_is_same_as_body_length
    assert_equal(14, @with_author.body.length)
  end

  def test_length
    assert_equal(14, @with_author.body.length)
  end

  def test_votes
    assert_equal(0, @with_author.likes)
    assert_equal(0, @with_author.likes)
  end

  def test_contain
    assert_match("New Windows 10", @with_author.body)
  end
end
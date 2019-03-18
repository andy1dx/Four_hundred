require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "title validation should trigger" do
    assert_not Article.new( body: 'text').save
  end
  test "title should save" do
    assert Article.new(title: 'Title 1', body: 'text', blog_id: 1 , status: '1').save
  end
end

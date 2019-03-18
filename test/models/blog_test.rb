require 'test_helper'

class BlogTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "blog validation trigger title" do
    assert_not Blog.new( description: 'text_data', url: 'url_name' ,username: 'username').save
  end
  test "blog should save" do
    assert Blog.new(title: 'Title 1', description: 'text_data', url: 'url_name' ,username: 'username', user_id: 1).save
  end
end

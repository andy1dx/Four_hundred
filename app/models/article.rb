class Article < ApplicationRecord
  belongs_to :blog
  has_many :comments
  has_many :likes

  validates :title, presence: true, length: {minimum: 5}
  validates :body, presence: true, length: {minimum: 40, maximum: 4000}

end

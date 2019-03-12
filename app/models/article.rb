class Article < ApplicationRecord
  belongs_to :blog

  validates :title, presence: true, length: {minimum: 5}
  validates :body, presence: true, length: {minimum: 40, maximum: 4000}

end

class Blog < ApplicationRecord
  belongs_to :user
  has_many :aricles

  validates :title, presence: true, length: {minimum: 5}
  validates :description, presence: true, length: {minimum: 5}
  validates :url, presence: true, uniqueness: true, length: {minimum: 5}
  validates :username, presence: true, uniqueness: true, length: {minimum: 5}
end

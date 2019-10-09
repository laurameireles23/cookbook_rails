class Album < ApplicationRecord
  belongs_to :recipes
  has_many_attached :images
end

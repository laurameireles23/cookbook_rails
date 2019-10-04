class Recipe < ApplicationRecord
  belongs_to :recipe_type
  belongs_to :user
  validates :title, :cuisine, :difficulty, :cook_time, 
            :ingredients, :cook_method, presence: true
  has_many :recipe_list_item
  has_many :list, through: :recipe_list_items

  def cook_time_minutes
    "#{cook_time} minutos"
  end
  
end

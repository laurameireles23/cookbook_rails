class RecipeType < ApplicationRecord
    validates :name, uniqueness: {message:'Nome deve ser único'}

    has_many :recipes

end

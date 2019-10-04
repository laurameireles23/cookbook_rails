class RecipeListItem < ApplicationRecord
  belongs_to :recipe
  belongs_to :list
  validates :recipe, uniqueness: {scope: :list_id, 
    message: "Essa receita já foi adicionada anteriormente"}
end

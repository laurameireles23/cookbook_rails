class List < ApplicationRecord
    validates :name, uniqueness: {message: "Já existe uma lista com esse nome"}
    belongs_to :user
    has_many :recipe_list_items
    has_many :recipe, through: :recipe_list_items
end
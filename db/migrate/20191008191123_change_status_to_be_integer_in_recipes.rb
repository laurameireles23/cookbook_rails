class ChangeStatusToBeIntegerInRecipes < ActiveRecord::Migration[5.2]
  def change
    change_column :recipes, :status, :integer, default:0
  end
end

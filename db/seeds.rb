# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create!(email: 'admin@admin.com', password: '123456', role: :admin)
type_sobremesa = RecipeType.create(name: 'Sobremesa')
type_principal = RecipeType.create(name: 'Prato principal')
type_entrada = RecipeType.create(name: 'Entrada')


Recipe.create(user: user, title: 'Bolo de cenoura', difficulty: 'Médio',
              recipe_type: type_sobremesa, cuisine: 'Brasileira',
              cook_time: 50,
              ingredients: 'Farinha, açucar, cenoura',
              cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
              status: :approved)
Recipe.create(user: user, title: 'Bolo de Brócolis', difficulty: 'Médio',
              recipe_type: type_sobremesa, cuisine: 'Brasileira',
              cook_time: 50, ingredients: 'Farinha, açucar, brócolis',
              cook_method: 'Cozinhe o brócolis, corte em pedaços pequenos, misture com o restante dos ingredientes',
              status: :approved)
Recipe.create(user: user, title: 'Torta de Cactus', difficulty: 'Médio',
              recipe_type: type_sobremesa, cuisine: 'Brasileira',
              cook_time: 50, ingredients: 'Farinha, açucar, cactus',
              cook_method: 'Descasque o cactu, corte em pedaços pequenos, misture com o restante dos ingredientes',
              status: :approved)
Recipe.create(user: user, title: 'Tapioca apimentada', difficulty: 'Dificil',
              recipe_type: type_sobremesa, cuisine: 'Baiana',
              cook_time: 50, ingredients: 'Farinha de tapioca, pimenta',
              cook_method: 'Hidrate a goma, prepare na frigideira a tapioca, encha de pimenta e sirva',
              status: :approved)
Recipe.create(user: user, title: 'Torta de abacate', difficulty: 'Médio',
              recipe_type: type_sobremesa, cuisine: 'Estranha',
              cook_time: 50, ingredients: 'Farinha, açucar, abacate',
              cook_method: 'Cozinhe o abacate, corte em pedaços pequenos, misture com o restante dos ingredientes',
              status: :pending)
Recipe.create(user: user, title: 'Feijoada', difficulty: 'Difícil',
              recipe_type: type_principal, cuisine: 'Japonesa',
              cook_time: 90,
              ingredients: 'Feijão, carnes, algas e arroz',
              cook_method: 'Misture o sushi com as carnes',
              status: :pending)


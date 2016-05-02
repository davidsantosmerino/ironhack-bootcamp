bacon_ingredient = Ingredient.create(name: 'bacon', calories: 250)
bacon_sandwich = Sandwich.create(name: 'Bacon sandwich', bread_type: 'regular')
bacon_sandwich.sandwich_ingredients.create(ingredient: bacon_ingredient)

bacon_ingredient = Ingredient.create(name: "bacon", calories: 250, amount: 0.5)
bacon_sandwich = Sandwich.create(name: "Bacon sandwich", bread_type: "regular")
bacon_sandwich.ingredients.push(bacon_ingredient)

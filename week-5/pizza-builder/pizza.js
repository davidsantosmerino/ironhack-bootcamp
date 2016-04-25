var PIZZA_PRICE_BASE = 10;

var Ingredient = function(active, id, name, price){
  this.active = active;
  this.id = id;
  this.name = name;
  this.price = price;
}

var ingredients = [
  new Ingredient(true, "pepperoni", "pepperoni", 1),
  new Ingredient(true, "mushrooms", "mushrooms", 1),
  new Ingredient(true, "green-peppers", "green peppers", 1),
  new Ingredient(false, "white-sauce", "white sauce", 3),
  new Ingredient(false, "gluten-free-crust", "gluten-free crust", 5),
];

var activateIngredient = function(ingredientId){
  result = $.grep(ingredients, function(ingredient){ return ingredient.id == ingredientId; });
  if (result.length > 0){
    result[0].active = !result[0].active;
    updateBill();
  }
}

var updateBill = function(){
  priceListElem = $('.panel.price ul');
  totalPriceElem = $('.panel.price strong');
  totalPrice = PIZZA_PRICE_BASE;
  priceListElem.empty();
  ingredients.forEach(function(ingredient){
    if(ingredient.active){
      ingredientLi = "<li>$" + ingredient.price + " " + ingredient.name + "</li>"
      priceListElem.append(ingredientLi);
      totalPrice += ingredient.price;
    }
  });
  totalPriceElem.text("$"+totalPrice);
}

$(document).ready(function(){
  $('.btn-pepperonni').on('click', function(){
    $('.pep').toggle();
    $(this).toggleClass('active');
    activateIngredient($(this).data("ingredient"));
  });
  $('.btn-mushrooms').on('click', function(){
    $('.mushroom').toggle();
    $(this).toggleClass('active');
    activateIngredient($(this).data("ingredient"));
  });
  $('.btn-green-peppers').on('click', function(){
    $('.green-pepper').toggle();
    $(this).toggleClass('active');
    activateIngredient($(this).data("ingredient"));
  });
  $('.btn-crust').on('click', function(){
    $('.crust').toggleClass('crust-gluten-free');
    $(this).toggleClass('active');
    activateIngredient($(this).data("ingredient"));
  });
  $('.btn-sauce').on('click', function(){
    $('.sauce').toggleClass('sauce-white');
    $(this).toggleClass('active');
    activateIngredient($(this).data("ingredient"));
  });

  updateBill();
});

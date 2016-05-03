(function(){
  window.SandwichrApp = window.SandwichrApp || {};

  var ELEMENTS = {
    sandwichElem: '.js-sandwich',
    addButtonElem: '.js-ingredients button'
  }

  var Sandwichr = function(){
    this.sandwichElem = $(ELEMENTS.sandwichElem);
    this.addButton = $(ELEMENTS.addButtonElem);
  }

  Sandwichr.prototype.init = function () {
    this.addListeners();
  }

  Sandwichr.prototype.addListeners = function () {
    var sandwichr = this;
    this.addButton.on('click', function(e){
      var sandwichId = sandwichr.sandwichElem.attr('data-sandwich-id');
      var ingredientId = $(e.currentTarget).attr('data-ingredient-id');
      sandwichr.addIngredient(sandwichId, ingredientId);
    })
  }

  Sandwichr.prototype.addIngredient = function (sandwichId, ingredientId) {
    var url = `/api/sandwiches/${sandwichId}/ingredients/add`;
    var data = {
      ingredient_id: ingredientId
    }
    $.post(url, data)
      .done(function(){
        location.reload();
      })
      .fail(function(e){
        console.log(e.responseText);
      });
  };

  window.SandwichrApp.Sandwichr = Sandwichr;

})();

(function () {
  window.PokemonApp = window.PokemonApp || {};

  PokemonApp.init = function () {
    var Pokedex = window.PokemonApp.Pokedex;
    var pokedex = new Pokedex();
    $('.js-show-pokemon').on('click', function (event) {
      var button = $(event.currentTarget);
      var url = button.data('pokemon-uri');
      pokedex.fetchPokemon(url);
    });
  }
})();

$(function () {
  PokemonApp.init();
})

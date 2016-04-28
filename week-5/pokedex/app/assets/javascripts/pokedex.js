(function () {

  window.PokemonApp = window.PokemonApp || {};

  var Pokedex = function () {
    this.pokemon = [];
  }

  window.PokemonApp.Pokedex = Pokedex;

  function privateStuff() {}

  Pokedex.prototype.fetchPokemon = function (url) {
    var pokedex = this;
    $.ajax({
      method: 'get',
      url: url,
      success: function (response) {
        var pokemon = new window.PokemonApp.Pokemon(response);
        pokedex.pokemon.push(pokemon);
        pokemon.render();
      }
    })
  }
})();

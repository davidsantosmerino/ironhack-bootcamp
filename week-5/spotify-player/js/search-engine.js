(function(){
  window.SpotifyApp = window.SpotifyApp || {};


  var SearchEngine = function(){
    var Player = window.SpotifyApp.Player;
    this.player = new Player();
  }

  SearchEngine.prototype.init = function(){
    this.addListeners();
    this.player.init();
  }

  SearchEngine.prototype.fetchTracks = function(query){
    var searchEngine = this;
    var url = `https://api.spotify.com/v1/search?type=track&query=${query}&limit=10`;
    $.get(url)
      .done(function(response){
        searchEngine.player.setPlayer(response);
      })
      .fail(function(error){
        console.error(error.responseJSON);
      });
  }

  SearchEngine.prototype.addListeners = function(){
    $('form.search').on('submit', function (e) {
      e.preventDefault();
      var query = $('#search-input').val();
      this.fetchTracks(query);
    }.bind(this));
  }

  window.SpotifyApp.SearchEngine = SearchEngine;
})();

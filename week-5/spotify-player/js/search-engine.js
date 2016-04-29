(function(){
  window.SpotifyApp = window.SpotifyApp || {};

  var RESULTS_LIMIT = 13;
  var ELEMENT = {
    form: 'form.search',
    searchInput: '#search-input',
    noResults: '.no-results'
  }

  var SearchEngine = function(){
    var Player = window.SpotifyApp.Player;
    this.player = new Player();
    this.form = $(ELEMENT.form);
    this.searchInput = $(ELEMENT.searchInput);
  }

  SearchEngine.prototype.init = function(){
    this.addListeners();
    this.player.init();
  }

  SearchEngine.prototype.fetchTracks = function(query){
    var searchEngine = this;
    var url = `https://api.spotify.com/v1/search?type=track&query=${query}&limit=${RESULTS_LIMIT}`;
    $.get(url)
      .done(function(response){
        searchEngine.hideNoResults();
        searchEngine.player.setPlayer(response);
      })
      .fail(function(error){
        this.showNoResults();
        console.error(error.responseJSON);
      });
  }

  SearchEngine.prototype.addListeners = function(){
    this.form.on('submit', function (e) {
      e.preventDefault();
      var query = this.searchInput.val();
      this.searchInput.val('');
      this.fetchTracks(query);
    }.bind(this));
  }

  SearchEngine.prototype.showNoResults = function(){
    $(ELEMENT.noResults).slideDown('down');
  }

  SearchEngine.prototype.hideNoResults = function(){
    $(ELEMENT.noResults).slideUp('down');
  }

  window.SpotifyApp.SearchEngine = SearchEngine;
})();

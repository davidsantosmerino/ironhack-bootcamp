(function(){
  window.SpotifyApp = window.SpotifyApp || {};

  var RESULTS_LIMIT = 13;
  var ELEMENT = {
    form: 'form.search',
    searchInput: '#search-input',
    welcome: '.welcome',
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
        setAppReady.bind(searchEngine)(response);
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

  SearchEngine.prototype.hideWelcome = function(){
    $(ELEMENT.welcome).slideUp('down');
  }

  function setAppReady(response){
    var searchEngine = this;
    var items = response.tracks.items;
    searchEngine.hideWelcome();
    if(items.length > 0)
      searchEngine.hideNoResults();
    else
      searchEngine.showNoResults();
    searchEngine.player.setPlayerReady(response);
  }

  window.SpotifyApp.SearchEngine = SearchEngine;
})();

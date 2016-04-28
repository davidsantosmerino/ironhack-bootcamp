(function(){
  window.SpotifyApp = window.SpotifyApp || {};


  var SearchEngine = function(){
    var Managers = window.SpotifyApp.Managers;
    var ArtistsManager = Managers.ArtistsManager;
    var AlbumsManager = Managers.AlbumsManager;
    var TracksManager = Managers.TracksManager;
    this.artistsManager = new ArtistsManager();
    this.albumsManager = new AlbumsManager();
    this.tracksManager = new TracksManager();
  }

  SearchEngine.prototype.init = function(){
    this.addListeners();
  }

  SearchEngine.prototype.fetchArtists = function(query){
    var url = `https://api.spotify.com/v1/search?type=artist&query=${query}`;
    $.get(url)
      .done(function(response){
        this.artistsManager.setArtists(response);
        this.artistsManager.render();
      }.bind(this))
      .fail(function(error){
        console.error(error.responseJSON);
      });
  }

  SearchEngine.prototype.fetchAlbums = function(artistId){
    var url = `https://api.spotify.com/v1/artists/${artistId}/albums`;
    $.get(url)
      .done(function(response){
        this.albumsManager.setAlbums(response);
        this.albumsManager.render();
      }.bind(this))
      .fail(function(error){
        console.error(error.responseJSON);
      });
  }

  SearchEngine.prototype.fetchTracks = function(albumId){
    var url = `https://api.spotify.com/v1/albums/${albumId}/tracks`;
    $.get(url)
      .done(function(response){
        this.tracksManager.setTracks(response);
        this.tracksManager.render();
      }.bind(this))
      .fail(function(error){
        console.error(error.responseJSON);
      });
  }

  SearchEngine.prototype.addListeners = function(){
    $('form.search').on('submit', function (e) {
      e.preventDefault();
      var query = $('#search-input').val();
      this.fetchArtists(query);
    }.bind(this));

    $('.results-container').on('click', '.artist' , function(e){
      var element = $(e.currentTarget);
      var artistId = element.attr('data-artist-id');
      this.fetchAlbums(artistId);
    }.bind(this));

    $('.row.albums').on('click', '.album' , function(e){
      var element = $(e.currentTarget);
      var albumId = element.attr('data-album-id');
      this.fetchTracks(albumId);
    }.bind(this));
  }

  window.SpotifyApp.SearchEngine = SearchEngine;
})();

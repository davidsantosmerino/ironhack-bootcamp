$(function () {

  var SpotifySearch = function(){
    this.artistsManager = new ArtistsManager();
    this.albumsManager = new AlbumsManager();
    this.tracksManager = new TracksManager();
  }

  SpotifySearch.prototype.fetchArtists = function(query){
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

  SpotifySearch.prototype.fetchAlbums = function(artistId){
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

  SpotifySearch.prototype.fetchTracks = function(albumId){
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

  SpotifySearch.prototype.addListeners = function(){
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

  var ArtistsManager = function(){
    this.artists = [];
  }

  ArtistsManager.prototype.setArtists = function(response){
    this.artists = response.artists.items;
  }

  ArtistsManager.prototype.render = function(){
    var resultsContainer = $('.results-container');
    resultsContainer.empty();
    this.artists.forEach(function(artist){
      var divElem = $('<div>').addClass('col-md-3 artist').attr('data-artist-id',artist.id);
      var nameElem = $('<p>').text(artist.name);
      divElem.append(nameElem);
      var imgWrapperElem = $('<div>').addClass('img-wrapper');
      if (artist.images.length > 0){
        var imgElem = $('<img>').attr('src', artist.images[0].url).addClass('img-responsive center-block');
        imgWrapperElem.append(imgElem);
      }
      divElem.append(imgWrapperElem);
      var captionElem = $('<div>').addClass('caption-wrapper');
      var popularityLabelElem = $('<span>').text('Popularity');
      captionElem.append(popularityLabelElem);
      var progressbarElem = $('<div class="progress-bar progress-bar-success" role="progressbar" aria-valuemin="0" aria-valuemax="100">');
      progressbarElem.attr('aria-valuenow', `'${artist.popularity}'`).css('width', `${artist.popularity}%`) ;
      var popularityElem = $('<div>').addClass('progress').append(progressbarElem);
      captionElem.append(popularityElem);
      divElem.append(captionElem);
      resultsContainer.append(divElem);
    });
  }

  var AlbumsManager = function(){
    this.albums = [];
  }

  AlbumsManager.prototype.setAlbums = function(response){
    this.albums = response.items;
  }

  AlbumsManager.prototype.render = function(){
    var albumsContainer = $('.albums.row');
    albumsContainer.empty();
    this.albums.forEach(function(album){
      var divElem = $('<div>').addClass('col-md-6').addClass('album').attr('data-album-id',album.id);
      var nameElem = $('<p>').text(album.name);
      divElem.append(nameElem);
      if (album.images.length > 0){
        var imgElem = $('<img>').attr('src', album.images[0].url);
        divElem.append(imgElem);
      }
      albumsContainer.append(divElem);
    });
    $('#albumsModal').modal();
  }

  var TracksManager = function(){
    this.tracks = [];
  }

  TracksManager.prototype.setTracks = function(response){
    this.tracks = response.items;
  }

  TracksManager.prototype.render = function(){
    var tracksContainer = $('.tracks.row');
    tracksContainer.empty();
    this.tracks.forEach(function(track){
      var divElem = $('<div>').addClass('col-md-6').addClass('track').attr('data-track-id',track.id);;
      var nameElem = $('<p>').text(track.name);
      divElem.append(nameElem);
      var previewElem = $('<audio controls>').attr('src', track.preview_url);
      divElem.append(previewElem);
      tracksContainer.append(divElem);
    });
    $('#tracksModal').modal();
  }

  var spotifySearch = new SpotifySearch();
  spotifySearch.addListeners();

});

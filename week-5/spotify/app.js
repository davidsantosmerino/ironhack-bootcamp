$(function () {

  var ArtistSearch = function(query){
    this.query = query;
    this.url = `https://api.spotify.com/v1/search?type=artist&query=${this.query}`;
    this.artists = [];
  }

  ArtistSearch.prototype.fetchArtists = function(){
    request = $.get(this.url)
      .done(function(result){
        this.artists = result.artists.items;
        this.render();
      }.bind(this))
      .fail(function(error){
        console.error(error.responseJSON);
      });
  }

  ArtistSearch.prototype.render = function(){
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
      var followersElem = $(`<i class="fa fa-star" aria-hidden="true"></i><span> ${artist.followers.total} followers</span>`);
      captionElem.append(followersElem);
      var progressbarElem = $('<div class="progress-bar progress-bar-success" role="progressbar" aria-valuemin="0" aria-valuemax="100">');
      progressbarElem.attr('aria-valuenow', `'${artist.popularity}'`).css('width', `${artist.popularity}%`).text('Popularity');
      var popularityElem = $('<div>').addClass('progress').append(progressbarElem);
      captionElem.append(popularityElem);
      divElem.append(captionElem);
      resultsContainer.append(divElem);
    });
  }

  var AlbumSearch = function(artistId){
    this.artistId = artistId;
    this.url = `https://api.spotify.com/v1/artists/${this.artistId}/albums`;
    this.albums = [];
  }

  AlbumSearch.prototype.fetchAlbums = function(){
    request = $.get(this.url)
      .done(function(result){
        this.albums = result.items;
        this.render();
      }.bind(this))
      .fail(function(error){
        console.error(error.responseJSON);
      });
  }

  AlbumSearch.prototype.render = function(){
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
    $('#albumsModal').modal()
  }

  var TrackSearch = function(albumId){
    this.albumId = albumId;
    this.url = `https://api.spotify.com/v1/albums/${this.albumId}/tracks`;
    this.tracks = [];
  }

  TrackSearch.prototype.fetchTracks = function(){
    request = $.get(this.url)
      .done(function(result){
        this.tracks = result.items;
        this.render();
      }.bind(this))
      .fail(function(error){
        console.error(error.responseJSON);
      });
  }

  TrackSearch.prototype.render = function(){
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

  $('form.search').on('submit', function (e) {
    e.preventDefault();
    var query = $('#search-input').val();
    var artistSearch = new ArtistSearch(query);
    artistSearch.fetchArtists();
  });

  $('body').on('click', '.artist' , function(e){
    var element = $(e.currentTarget);
    var artistId = element.attr('data-artist-id');
    var albumSearch = new AlbumSearch(artistId);
    albumSearch.fetchAlbums();
  });

  $('body').on('click', '.album' , function(e){
    var element = $(e.currentTarget);
    var albumId = element.attr('data-album-id');
    var trackSearch = new TrackSearch(albumId);
    trackSearch.fetchTracks();
  });

});

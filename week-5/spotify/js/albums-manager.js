(function(){
  window.SpotifyApp = window.SpotifyApp || {};
  window.SpotifyApp.Managers = window.SpotifyApp.Managers || {};

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

  window.SpotifyApp.Managers.AlbumsManager = AlbumsManager;
})();

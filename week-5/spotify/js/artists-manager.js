(function(){
  window.SpotifyApp = window.SpotifyApp || {};
  window.SpotifyApp.Managers = window.SpotifyApp.Managers || {};

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

  window.SpotifyApp.Managers.ArtistsManager = ArtistsManager;
})();

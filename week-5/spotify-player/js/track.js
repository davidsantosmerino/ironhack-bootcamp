(function(){
  window.SpotifyApp = window.SpotifyApp || {};
  window.SpotifyApp.Entities = window.SpotifyApp.Entities || {};


  var MISSING_COVER_URL = 'img/microphone.png';

  var Track = function(track){
    this.title = track.name;
    this.artist = parseArtistsNames(track.artists);
    this.cover = parseCoverUrl(track.album.images);
    this.audio = track.preview_url;
  }

  function parseArtistsNames(artists){
    var artistsNames = [];
    artists.forEach(function(artist){
      artistsNames.push(artist.name);
    });

    return artistsNames.join(', ');
  }

  function parseCoverUrl(images){
    return images.length > 0 ? images[0].url : MISSING_COVER_URL;
  }

  Track.prototype.render = function(){
    var trackWrapper = $('.track-wrapper');
    $('.js-title').text(this.title);
    $('.js-artist').text(this.artist);
    $('.js-cover').attr('src',this.cover);
    $('.js-player').attr('src',this.audio);
    trackWrapper.fadeIn();
  }

  window.SpotifyApp.Entities.Track = Track;
})();

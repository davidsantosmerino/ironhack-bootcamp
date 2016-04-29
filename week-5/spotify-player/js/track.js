(function(){
  window.SpotifyApp = window.SpotifyApp || {};
  window.SpotifyApp.Entities = window.SpotifyApp.Entities || {};

  var ELEMENT = {
    trackWrapper: '.track-wrapper',
    title: '.js-title',
    artist: '.js-artist',
    cover: '.js-cover',
    player: '.js-player'
  }
  var MISSING_COVER_URL = 'img/microphone.png';

  var Track = function(track){
    this.title = track.name;
    this.artist = parseArtistsNames(track.artists);
    this.cover = parseCoverUrl(track.album.images);
    this.audio = track.preview_url;
  }

  Track.prototype.render = function(){
    $(ELEMENT.trackWrapper).slideUp('slow', renderTransition.bind(this));
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

  function renderTransition(){
    var trackManager = this;
    $(ELEMENT.title).text(trackManager.title);
    $(ELEMENT.artist).text(trackManager.artist);
    $(ELEMENT.cover).attr('src',trackManager.cover);
    $(ELEMENT.player).attr('src',trackManager.audio);
    $(ELEMENT.trackWrapper).slideDown('slow');
  }

  window.SpotifyApp.Entities.Track = Track;
})();

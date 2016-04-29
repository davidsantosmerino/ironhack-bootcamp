(function(){

  var MISSING_COVER_URL = 'img/microphone.png';

  window.SpotifyApp = window.SpotifyApp || {};
  window.SpotifyApp.Managers = window.SpotifyApp.Managers || {};

  var Track = window.SpotifyApp.Entities.Track;

  var TrackManager = function(){
    this.tracks = [];
  }

  function enableAudioPlayer(){
    $('.btn-play').removeClass('disabled');
  }

  function disableAudioPlayer(){
    $('.btn-play').addClass('disabled');
  }

  TrackManager.prototype.tooglePlayer = function(){
    if(this.tracks[0].preview_url === null)
      disableAudioPlayer();
    else
      enableAudioPlayer();
  }

  TrackManager.prototype.setTrackManager = function(response){
    var taskManager = this;
    var items = response.tracks.items;
    items.forEach(function(item){
      var track = new Track(item);
      taskManager.tracks.push(track);
    });
  }

  TrackManager.prototype.render = function(){
    this.tooglePlayer();
    this.tracks.forEach(function(track){
      track.render();
    });
  }

  window.SpotifyApp.Managers.TrackManager = TrackManager;
})();

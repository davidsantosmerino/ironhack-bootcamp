(function(){

  var MISSING_COVER_URL = 'img/microphone.png';

  window.SpotifyApp = window.SpotifyApp || {};
  window.SpotifyApp.Managers = window.SpotifyApp.Managers || {};

  var Track = window.SpotifyApp.Entities.Track;

  var TrackManager = function(){
    this.tracks = [];
  }

  TrackManager.prototype.setTrackManager = function(response){
    this.tracks = [];
    var taskManager = this;
    var items = response.tracks.items;
    items.forEach(function(item){
      var track = new Track(item);
      taskManager.tracks.push(track);
    });
  }

  window.SpotifyApp.Managers.TrackManager = TrackManager;
})();

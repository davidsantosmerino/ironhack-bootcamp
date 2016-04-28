(function(){
  window.SpotifyApp = window.SpotifyApp || {};
  window.SpotifyApp.Managers = window.SpotifyApp.Managers || {};

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
      var divElem = $('<div>').addClass('col-md-6 track');
      divElem.attr('data-track-id',track.id);
      var nameElem = $('<p>').text(track.name);
      divElem.append(nameElem);
      var previewElem = $('<audio controls>').attr('src', track.preview_url);
      divElem.append(previewElem);
      tracksContainer.append(divElem);
    });
    $('#tracksModal').modal();
  }

  window.SpotifyApp.Managers.TracksManager = TracksManager;
})();

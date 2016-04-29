(function(){
  window.SpotifyApp = window.SpotifyApp || {};

  var CSS_CLASS = {
    play: 'fa-play-circle-o',
    pause: 'fa-pause-circle-o',
    active: 'active',
  }

  var ELEMENT = {
    playerBtn: '.js-btn-player',
    control: '.js-player',
    progress: '.seekbar progress',
    playlist: '.playlist-wrapper ul',
    trackWrapper: '.track-wrapper',
  }

  var Player = function(){
    var TrackManager = window.SpotifyApp.Managers.TrackManager;
    this.trackManager = new TrackManager();
    this.button = $(ELEMENT.playerBtn);
    this.control = $(ELEMENT.control);
    this.progress = $(ELEMENT.progress);
    this.playlist = $(ELEMENT.playlist);
  }

  Player.prototype.init = function(){
    this.addListeners();
  }

  Player.prototype.addListeners = function(){
    this.button.on('click', this.togglePlay.bind(this));
    this.control.on('timeupdate', updateProgress.bind(this));
    this.control.on('ended', this.resetStatus.bind(this));
    this.playlist.on('click','li', changeMainTrack.bind(this));
  }

  Player.prototype.resetStatus = function(){
    this.stop();
    resetProgress.bind(this.progress)();
  }

  Player.prototype.setPlayerReady = function(response) {
    this.trackManager.setTrackManager(response);
    if(this.trackManager.tracks.length > 0)
      this.fetchPlayer();
    else
      this.setNoResults();
  }

  Player.prototype.setNoResults = function(){
    $(ELEMENT.trackWrapper).hide();
    this.playlist.empty();
  }

  Player.prototype.fetchPlayer = function(){
    this.resetStatus();
    this.playlistRender();
    var firsTrack = $('.playlist-wrapper ul li:first-child');
    this.setMainTrack(firsTrack);
  }

  Player.prototype.togglePlay = function(){
    var bPlaying = this.button.hasClass(CSS_CLASS.pause);
    if(bPlaying)
      this.stop();
    else
      this.start();
  }

  Player.prototype.setMainTrack = function(trackElement) {
    var player = this;
    var trackManager = player.trackManager;
    player.resetStatus();
    resetActivePlaylistElements.bind(this.playlist)();
    var trackId = trackElement.attr('data-id');
    trackElement.addClass(CSS_CLASS.active);
    trackManager.tracks[trackId].render(trackId);
  }

  Player.prototype.playlistRender = function(){
    var tracks = this.trackManager.tracks;
    this.playlist.empty();
    var elements = [];
    tracks.forEach(function(track, index){
      var liElement = $('<li>');
      liElement.attr('data-id', index);
      var spanTitle = $('<span class="title">');
      spanTitle.text(track.title);
      var spanArtist= $('<span class="artist">');
      spanArtist.text(track.artist);
      liElement.append(spanTitle, spanArtist);
      elements.push(liElement);
    });
    this.playlist.append(elements);
  }

  Player.prototype.start = function(){
    this.control.trigger('play');
    setPauseIcon.bind(this.button)();
  }

  Player.prototype.stop = function(){
    this.control.trigger('pause');
    setPlayIcon.bind(this.button)();
  }

  function updateProgress(){
    var control = this.control;
    var progress = this.progress;
    var current = control.prop('currentTime');
    progress.prop('value', current);
  }

  function resetProgress(){
    var progress = this;
    progress.prop('value', 0);
  }

  function setPauseIcon(){
    var button = this;
    button.removeClass(CSS_CLASS.play);
    button.addClass(CSS_CLASS.pause);
  }

  function setPlayIcon(){
    var button = this;
    button.removeClass(CSS_CLASS.pause);
    button.addClass(CSS_CLASS.play);
  }

  function changeMainTrack(event) {
    var player = this;
    var trackElement = $(event.currentTarget);
    player.setMainTrack.bind(player)(trackElement);
  }

  function resetActivePlaylistElements() {
    var playlist = this;
    playlist.find('li').removeClass(CSS_CLASS.active);
  }

  window.SpotifyApp.Player = Player;
})();

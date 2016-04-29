(function(){
  window.SpotifyApp = window.SpotifyApp || {};

  var CSS_CLASS = {
    play: 'fa-play-circle-o',
    pause: 'fa-pause-circle-o'
  }

  var ELEMENT = {
    playerBtn: '.js-btn-player',
    control: '.js-player',
    progress: '.seekbar progress'
  }

  var Player = function(){
    var TrackManager = window.SpotifyApp.Managers.TrackManager;
    this.trackManager = new TrackManager();
    this.button = $(ELEMENT.playerBtn);
    this.control = $(ELEMENT.control);
    this.progress = $(ELEMENT.progress);
  }

  Player.prototype.init = function(){
    this.addListeners();
  }

  Player.prototype.addListeners = function(){
    this.button.on('click', this.togglePlay.bind(this));
    this.control.on('timeupdate', updateProgress.bind(this));
    this.control.on('ended', this.resetStatus.bind(this));
  }

  Player.prototype.resetStatus = function(){
    this.stop();
    resetProgress.bind(this.progress)();
  }

  Player.prototype.setPlayer = function(response){
    this.resetStatus();
    this.trackManager.setTrackManager(response);
    this.trackManager.render();
  }

  Player.prototype.togglePlay = function(){
    var bPlaying = this.button.hasClass(CSS_CLASS.pause);
    if(bPlaying)
      this.stop();
    else
      this.start();
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


  window.SpotifyApp.Player = Player;
})();
